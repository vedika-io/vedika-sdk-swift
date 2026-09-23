import Foundation

/// Main client for the Vedika Intelligence API — Vastu surface.
///
/// Instantiate with your API key and call into `vastu`:
///
/// ```swift
/// let client = try VedikaClient(apiKey: "vk_live_...")
/// let score = try await client.vastu.vastuScore("overall", params: ["rooms": rooms])
/// ```
///
/// First deliverable scope: the Vastu
/// domain only, not the full 23-domain surface `sdks/flutter` covers. New
/// domains get their own `*Service` class alongside `VastuService`, exposed
/// as a new property here — this class's own shape (construction, origin
/// policy, `get`/`post` primitives, response handling) does not need to
/// change to add one.
public final class VedikaClient {
    private static let sdkVersion = "vedika-swift/1.0.0"

    /// Two extra attempts for network failures and 5xx responses. Either
    /// can follow a completed charge, so billed requests must retain their
    /// idempotency key. A rejected 4xx request is never retried.
    private static let maxRetries = 2

    private static let billedVastuGetPaths = Set(
        ["/v2/vastu/", "/v2/astrology/vastu/"].flatMap { prefix in
            [
                "reference/directions/8",
                "reference/directions/16",
                "reference/directions/32",
                "reference/mandala/9-zone",
                "reference/mandala/45-devatas",
                "reference/mandala/64-pada",
                "reference/defects/catalog",
                "reference/remedies/catalog",
                "reference/colors-by-zone",
                "reference/materials-by-zone",
                "reference/gate-obstructions",
                "direction/declination",
            ].map { prefix + $0 }
        }
    )

    /// Linear backoff base; attempt 0 waits this long, attempt 1 waits 2x, etc.
    private static let retryBackoffBaseSeconds: UInt64 = 250_000_000 // 250ms, in nanoseconds

    /// SDK configuration (API key, base URL, timeout).
    public let config: VedikaConfig

    /// Vastu Shastra: plot geometry, mandala projection, entrance/room/
    /// placement rules, compliance audits, scoring, and floor-plan
    /// generation.
    public private(set) lazy var vastu: VastuService = VastuService(client: self)

    /// The underlying `URLSession`. Redirect-following is refused via
    /// `RedirectRefusingDelegate` on purpose (credential-routing
    /// hardening): the platform default would re-send `Authorization` to
    /// whatever origin a 3xx response names, leaking the API key to a
    /// different host. With redirects refused, a 3xx comes back from
    /// `session.data(for:)` as an ordinary `HTTPURLResponse` (`300..399`)
    /// instead of being chased — `handleResponse` below turns that into a
    /// thrown `VedikaApiError` rather than a second request ever being
    /// sent. The key is provably never forwarded because there is no
    /// second request.
    private let session: URLSession
    private let redirectDelegate = RedirectRefusingDelegate()

    /// Creates a `VedikaClient`.
    ///
    /// - Throws: `VedikaConfigurationError` if `baseURL` fails the
    ///   credential-routing policy: official HTTPS or literal loopback HTTP only.
    ///   The legacy `allowInsecureHttp` flag cannot bypass this policy.
    ///   This check runs BEFORE the
    ///   `URLSession` is even built, so a rejected `baseURL` never gets the
    ///   chance to send a single request.
    public init(
        apiKey: String,
        baseURL: String = VedikaConfig.defaultBaseURL,
        timeout: TimeInterval = VedikaConfig.defaultTimeout,
        allowInsecureHttp: Bool = false
    ) throws {
        var trimmedBase = baseURL
        while trimmedBase.hasSuffix("/") {
            trimmedBase.removeLast()
        }
        try OriginPolicy.assertSafeBaseURL(trimmedBase, allowInsecureHttp: allowInsecureHttp)

        self.config = VedikaConfig(
            apiKey: apiKey,
            baseURL: trimmedBase,
            timeout: timeout,
            allowInsecureHttp: allowInsecureHttp
        )

        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.timeoutIntervalForRequest = timeout
        sessionConfig.timeoutIntervalForResource = timeout
        self.session = URLSession(
            configuration: sessionConfig,
            delegate: redirectDelegate,
            delegateQueue: nil
        )
    }

    deinit {
        // A `URLSession` created with an explicit delegate (rather than
        // `.shared`) retains that delegate and is never torn down on its
        // own — Apple's documented behavior. Invalidate it here so
        // `redirectDelegate` (and the session's internal state) don't leak
        // past this client's lifetime. Mirrors `VedikaClient.dispose()` in
        // `sdks/flutter/lib/src/client.dart`, which exists for the same
        // reason; OkHttp (Android) doesn't need an equivalent because its
        // client owns no such retained delegate reference.
        session.finishTasksAndInvalidate()
    }

    private func headers(idempotencyKey: String? = nil) -> [String: String] {
        var result = [
            "Authorization": "Bearer \(config.apiKey)",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-SDK": Self.sdkVersion,
        ]
        if let idempotencyKey {
            result["Idempotency-Key"] = idempotencyKey
        }
        return result
    }

    /// Sends GET with one key per billed Vastu call, shared by its retries.
    @discardableResult
    func get(_ path: String, queryParams: [String: String] = [:], idempotencyKey: String? = nil) async throws -> [String: Any] {
        guard var components = URLComponents(string: config.baseURL + path) else {
            throw VedikaApiError("Invalid path: \(path)")
        }
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = components.url else {
            throw VedikaApiError("Invalid path: \(path)")
        }
        let pathOnly = String(path.split(separator: "?", maxSplits: 1).first ?? "")
        let key = idempotencyKey ?? (Self.billedVastuGetPaths.contains(pathOnly) ? UUID().uuidString : nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in headers(idempotencyKey: key) {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try await execute(request)
    }

    /// Sends a POST request to the Vedika API.
    ///
    /// - Parameter idempotencyKey: (b2c#32) every paid POST needs one so a
    ///   client-side retry after a LOST response (the request reached the
    ///   server and was billed, but the reply never made it back to the
    ///   phone) cannot create a duplicate charge — the server dedupes on
    ///   this key and returns the original result instead of billing again.
    ///   If the caller does not supply one, a fresh random UUID is generated
    ///   per logical call except for assessment batches, which require a
    ///   retained caller key. This client's own automatic retries (see
    ///   `execute`) are always safe by default; callers doing their OWN
    ///   outer retry (e.g. after a process restart) should pass the same
    ///   key explicitly to get that same safety across calls this client
    ///   can't see.
    @discardableResult
    func post(_ path: String, body: [String: Any], idempotencyKey: String? = nil) async throws -> [String: Any] {
        if ["/v2/vastu/assessments/batch", "/v2/astrology/vastu/assessments/batch"].contains(String(path.split(separator: "?", maxSplits: 1).first ?? "")) {
            guard let idempotencyKey, !idempotencyKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw VedikaApiError("A nonblank caller-retained Idempotency-Key is required")
            }
        }
        guard let url = URL(string: config.baseURL + path) else {
            throw VedikaApiError("Invalid path: \(path)")
        }
        let key = idempotencyKey ?? UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (key, value) in headers(idempotencyKey: key) {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        return try await execute(request)
    }

    /// Runs `request`, retrying transient failures (see `maxRetries`).
    /// Every POST and mounted billed Vastu GET carries an
    /// `Idempotency-Key` (see `post` and `get`), so a retry of the exact same
    /// `URLRequest` (same body, same key) cannot double-charge even if the
    /// first attempt's request actually reached the server before the
    /// network dropped the response.
    private func execute(_ request: URLRequest, attempt: Int = 0) async throws -> [String: Any] {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            if attempt < Self.maxRetries {
                try? await Task.sleep(nanoseconds: Self.retryBackoffBaseSeconds * UInt64(attempt + 1))
                return try await execute(request, attempt: attempt + 1)
            }
            throw VedikaApiError("Network error: \(error.localizedDescription)")
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VedikaApiError("Invalid response (not HTTP)")
        }
        if httpResponse.statusCode >= 500 && attempt < Self.maxRetries {
            try? await Task.sleep(nanoseconds: Self.retryBackoffBaseSeconds * UInt64(attempt + 1))
            return try await execute(request, attempt: attempt + 1)
        }
        return try handleResponse(httpResponse, data: data)
    }

    private func handleResponse(_ response: HTTPURLResponse, data: Data) throws -> [String: Any] {
        let body: [String: Any]
        if let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []),
            let parsed = jsonAny as? [String: Any]
        {
            body = parsed
        } else {
            body = ["error": String(data: data, encoding: .utf8) ?? ""]
        }

        switch response.statusCode {
        case 200:
            return body
        case 401:
            throw VedikaAuthError(body["error"] as? String ?? "Invalid API key", body: body)
        case 402:
            throw VedikaInsufficientCredits(
                body["error"] as? String ?? "Insufficient wallet balance", body: body)
        case 429:
            let retryAfter = response.value(forHTTPHeaderField: "Retry-After").flatMap(Int.init)
            throw VedikaRateLimitError(
                body["message"] as? String ?? "Rate limit exceeded",
                body: body,
                retryAfterSeconds: retryAfter
            )
        case 300..<400:
            // Credential-routing: redirects are refused (see
            // `RedirectRefusingDelegate`), so the API key is never forwarded
            // to the redirect destination. A 3xx from the API is unexpected
            // and surfaced as an error rather than chased.
            throw VedikaApiError(
                "Unexpected redirect (HTTP \(response.statusCode)) not followed; credentials "
                    + "were not forwarded. Check baseURL.",
                statusCode: response.statusCode,
                body: body
            )
        case 500...:
            throw VedikaServerError(
                body["error"] as? String ?? "Server error: \(response.statusCode)",
                statusCode: response.statusCode,
                body: body
            )
        default:
            throw VedikaApiError(
                body["error"] as? String ?? "API error: \(response.statusCode)",
                statusCode: response.statusCode,
                body: body
            )
        }
    }
}
