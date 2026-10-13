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
    private static let sdkVersion = "vedika-swift/1.4.0"

    /// Two extra attempts for network failures and 5xx responses. Either
    /// can follow a completed charge, so billed requests must retain their
    /// idempotency key. A rejected 4xx request is never retried.
    private static let maxRetries = 2

    /// Submits that charge per item and so must carry a caller-retained key: a batch and an async job.
    private static let retainedKeyPaths: Set<String> = [
        "/v2/vastu/assessments/batch", "/v2/astrology/vastu/assessments/batch",
        "/v2/vastu/jobs", "/v2/astrology/vastu/jobs",
    ]

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

    /// Header spelling per operation. The live spec names `X-Idempotency-Key` on
    /// `/api/v1/astrology/query` and `Idempotency-Key` on the Vastu operations.
    static func idempotencyHeaderName(for path: String) -> String {
        bareAPIPath(path) == "/api/v1/astrology/query" ? "X-Idempotency-Key" : "Idempotency-Key"
    }

    /// True for the paths where the client may attach a key the caller did not
    /// supply: the Vastu operations, which accept one, and the report-chat
    /// query. Anything else (the free `/sandbox` routes, unknown paths) gets a
    /// key only when the caller passes one, because a key sent to an operation
    /// that does not take it is answered 422 `IDEMPOTENCY_NOT_SUPPORTED`.
    static func acceptsAutomaticKey(_ path: String) -> Bool {
        let bare = bareAPIPath(path)
        return bare.hasPrefix("/v2/vastu/") || bare.hasPrefix("/v2/astrology/vastu/")
            || bare == "/api/v1/astrology/query"
    }

    private static func bareAPIPath(_ path: String) -> String {
        String(path.split(separator: "?", maxSplits: 1, omittingEmptySubsequences: false).first ?? "")
    }

    private static let idempotencyHeaderNames = ["Idempotency-Key", "X-Idempotency-Key"]

    /// Linear backoff base; attempt 0 waits this long, attempt 1 waits 2x, etc.
    private static let retryBackoffBaseSeconds: UInt64 = 250_000_000 // 250ms, in nanoseconds

    /// SDK configuration (API key, base URL, timeout).
    public let config: VedikaConfig

    /// Vastu Shastra: plot geometry, mandala projection, entrance/room/
    /// placement rules, compliance audits, scoring, and floor-plan
    /// generation.
    /// Stateless façade over this client; cheap to create on each access.
    public var vastu: VastuService { VastuService(client: self) }

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

    private func headers(idempotencyKey: String? = nil, path: String = "") -> [String: String] {
        var result = [
            "Authorization": "Bearer \(config.apiKey)",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-SDK": Self.sdkVersion,
        ]
        if let idempotencyKey {
            result[Self.idempotencyHeaderName(for: path)] = idempotencyKey
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
        let automatic = idempotencyKey == nil && Self.billedVastuGetPaths.contains(pathOnly)
        let key = idempotencyKey ?? (automatic ? UUID().uuidString : nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (name, value) in headers(idempotencyKey: key, path: path) {
            request.setValue(value, forHTTPHeaderField: name)
        }
        return try await execute(request, keyIsAutomatic: automatic)
    }

    /// Sends a POST request to the Vedika API.
    ///
    /// - Parameter idempotencyKey: every paid POST needs one so a
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
        if Self.retainedKeyPaths.contains(String(path.split(separator: "?", maxSplits: 1).first ?? "")) {
            guard let idempotencyKey, !idempotencyKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw VedikaApiError("A nonblank caller-retained Idempotency-Key is required")
            }
        }
        guard let url = URL(string: config.baseURL + path) else {
            throw VedikaApiError("Invalid path: \(path)")
        }
        // Scan save/retrieve/list/timelapse identify a retry by scanId or the
        // body's requestId and answer 422 to any retry header, so none is sent.
        let bodyIdentity = usesBodyIdentity(path)
        if bodyIdentity && idempotencyKey != nil {
            throw VedikaApiError("Scan operations use scanId or requestId in the body; do not pass an Idempotency-Key")
        }
        let automatic = !bodyIdentity && idempotencyKey == nil && Self.acceptsAutomaticKey(path)
        let key: String? = bodyIdentity ? nil : (idempotencyKey ?? (automatic ? UUID().uuidString : nil))
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (name, value) in headers(idempotencyKey: key, path: path) {
            request.setValue(value, forHTTPHeaderField: name)
        }
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        return try await execute(request, keyIsAutomatic: automatic)
    }

    /// Sends one PDF as `multipart/form-data` with the caller's retained key.
    /// Retries reuse the same request, so the same key, and cannot double-bill.
    func postPDFUpload(_ path: String, pdf: Data, filename: String, idempotencyKey: String) async throws -> [String: Any] {
        guard let url = URL(string: config.baseURL + path) else {
            throw VedikaApiError("Invalid path: \(path)")
        }
        let boundary = "vedika-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (name, value) in headers(idempotencyKey: idempotencyKey, path: path) {
            request.setValue(value, forHTTPHeaderField: name)
        }
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = VastuReportChat.multipartBody(pdf: pdf, filename: filename, boundary: boundary)
        return try await execute(request)
    }

    /// True when resending `request` cannot be billed twice: a read, a request
    /// carrying an idempotency key, or a scan operation whose identity is in the
    /// body. A keyless billed POST is never retried after a network error or a
    /// 5xx, because either can follow a completed charge.
    private func isReplaySafe(_ request: URLRequest) -> Bool {
        if request.httpMethod == "GET" { return true }
        let headers = request.allHTTPHeaderFields ?? [:]
        if Self.idempotencyHeaderNames.contains(where: { name in headers.keys.contains { $0.caseInsensitiveCompare(name) == .orderedSame } }) {
            return true
        }
        return usesBodyIdentity(request.url?.path ?? "")
    }

    /// Runs `request`, retrying transient failures (see `maxRetries`).
    /// Billed Vastu calls carry an `Idempotency-Key`, so a retry of the exact
    /// same `URLRequest` (same body, same key) cannot double-charge even if the
    /// first attempt reached the server before the network dropped the response.
    ///
    /// - Parameter keyIsAutomatic: the key was generated here, not supplied by
    ///   the caller. If the endpoint answers 422 `IDEMPOTENCY_NOT_SUPPORTED`
    ///   (no charge was attempted), the request is sent once more without the
    ///   key and without any automatic retry, since it is no longer replay-safe.
    ///   A caller's own key is never dropped: that case throws
    ///   `VedikaIdempotencyNotSupportedError`.
    private func execute(_ request: URLRequest, attempt: Int = 0, keyIsAutomatic: Bool = false) async throws -> [String: Any] {
        let replaySafe = isReplaySafe(request)
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            if attempt < Self.maxRetries && replaySafe {
                try? await Task.sleep(nanoseconds: Self.retryBackoffBaseSeconds * UInt64(attempt + 1))
                return try await execute(request, attempt: attempt + 1, keyIsAutomatic: keyIsAutomatic)
            }
            throw VedikaApiError("Network error: \(error.localizedDescription)")
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VedikaApiError("Invalid response (not HTTP)")
        }
        if httpResponse.statusCode == 422, keyIsAutomatic, Self.errorCode(in: data) == "IDEMPOTENCY_NOT_SUPPORTED" {
            var keyless = request
            for name in Self.idempotencyHeaderNames { keyless.setValue(nil, forHTTPHeaderField: name) }
            return try await execute(keyless, attempt: Self.maxRetries, keyIsAutomatic: false)
        }
        if httpResponse.statusCode >= 500 && attempt < Self.maxRetries && replaySafe {
            try? await Task.sleep(nanoseconds: Self.retryBackoffBaseSeconds * UInt64(attempt + 1))
            return try await execute(request, attempt: attempt + 1, keyIsAutomatic: keyIsAutomatic)
        }
        return try handleResponse(httpResponse, data: data)
    }

    private static func errorCode(in data: Data) -> String? {
        ((try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any])?["code"] as? String
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
        case 200..<300:  // job submit answers 202
            return body
        case 401:
            throw VedikaAuthError(body["error"] as? String ?? "Invalid API key", body: body)
        case 402:
            throw VedikaInsufficientCredits(
                body["error"] as? String ?? "Insufficient wallet balance", body: body)
        case 422 where body["code"] as? String == "IDEMPOTENCY_NOT_SUPPORTED":
            throw VedikaIdempotencyNotSupportedError(
                body["message"] as? String
                    ?? "This endpoint does not accept an idempotency key; call again without one",
                body: body)
        case 429:
            // The body `code` names the limiter that refused the call; the
            // rate-limit headers describe the per-minute limiter only, so
            // nothing is decided from them. This client never retries a 429.
            let bodyRetry = (body["retryAfter"] as? NSNumber)?.intValue
            let retryAfter = bodyRetry ?? response.value(forHTTPHeaderField: "Retry-After").flatMap(Int.init)
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

private let scanPrefixes = ["/v2/vastu/scans/", "/v2/astrology/vastu/scans/"]
private let bodyIdentityScanOps: Set<String> = ["save", "retrieve", "list", "delete", "timelapse"]

/// True for the scan operations whose retry identity lives in the JSON body.
func usesBodyIdentity(_ path: String) -> Bool {
    let bare = String(path.split(separator: "?", maxSplits: 1, omittingEmptySubsequences: false).first ?? "")
    return scanPrefixes.contains { bare.hasPrefix($0) && bodyIdentityScanOps.contains(String(bare.dropFirst($0.count))) }
}
