import XCTest

@testable import VedikaSDK

/// Credential-routing hardening, ported from
/// `sdks/android/src/test/kotlin/io/vedika/sdk/CredentialRoutingTest.kt`
/// (itself ported from `sdks/flutter/test/credential_routing_test.dart`)
/// onto a minimal dependency-free loopback HTTP server
/// (`LoopbackHTTPServer.swift`). Five properties, same as both prior
/// suites:
///
///  1. Vastu verb dispatch: tables under `reference/` plus
///     `direction/declination` -> GET, everything else -> POST.
///  2. Every request is built with redirects refused.
///  3. An unfollowed 3xx surfaces as `VedikaApiError`, not a chased
///     redirect.
///  4. Real two-server test: the `Authorization` header — and any request
///     at all — never reaches the redirect target.
///  5. `baseURL` origin policy, including the `127.attacker.invalid` /
///     `127.example.com` spoof-host cases.
final class CredentialRoutingTests: XCTestCase {

    func testAssessmentRequestAndResponseTypesMatchCanonicalRuntimeShapes() {
        let request = VastuAssessmentsRequest(
            inputSource: "plan-derived",
            rooms: [VastuAssessmentsRequestRoomsItem(roomType: "kitchen", zone: "SE")],
            plotPolygon: [[0, 0], [10, 0], [10, 10]],
            doorXY: VastuPoint(x: 5, y: 0)
        )
        XCTAssertEqual(request.dictionary["inputSource"] as? String, "plan-derived")
        XCTAssertEqual(request.dictionary["doorXY"] as? [Double], [5, 0])

        let badge = VastuAssessmentBadgeEligibility(raw: [
            "inputSource": "plan-derived", "badge": NSNull(), "eligible": false,
            "variant": NSNull(), "reason": "insufficient evidence",
        ])
        XCTAssertEqual(badge.inputSource, "plan-derived")
        XCTAssertNil(badge.badge)
        XCTAssertFalse(badge.eligible)

        let data = VastuAssessmentData(raw: [:])
        let billed = VastuTypedResponse(success: true, data: data, raw: ["billing": ["charged": 1]])
        XCTAssertEqual(billed.billing["charged"] as? Int, 1)
        let unbilled = VastuAssessmentsResponse(success: true, data: data, raw: [:])
        XCTAssertNil(unbilled.billing)
    }

    func testTypedInventoryExposesEveryMountedLogicalOperationExactlyOnce() {
        let paths = VastuOperation.allCases.map(\.rawValue)
        XCTAssertEqual(paths.count, 93)
        XCTAssertEqual(Set(paths).count, 93)
        XCTAssertEqual(VastuOperation.assessments.rawValue, "assessments")
        XCTAssertEqual(VastuOperation.arTrueNorthCalibrate.rawValue, "ar/true-north-calibrate")
    }

    func testARResultTypesDecodeTheExactNestedDataContract() {
        let scan = VastuArScanQualityData(raw: [
            "grade": "A", "score": 96, "missingData": [String](), "warnings": [String](),
            "reScanSuggestions": [String](), "dimensions": [
                "pointCloudDensity": ["score": 98, "reason": "dense"],
                "polygonClosure": ["score": 97, "reason": "closed"],
                "compassConfidence": ["score": 96, "reason": "stable"],
                "gpsConfidence": ["score": 95, "reason": "fixed"],
                "roomsTagged": ["score": 94, "reason": "tagged"],
                "coverage": ["score": 93, "reason": "complete"],
            ], "acceptForAudit": true, "sources": ["scan"], "verified": true,
        ])
        XCTAssertEqual(scan.grade, "A")
        XCTAssertEqual(scan.dimensions.pointCloudDensity.score, 98)
        XCTAssertEqual(scan.dimensions.coverage.reason, "complete")

        let north = VastuArTrueNorthData(raw: [
            "input": [
                "lat": 28.61, "lon": 77.21, "datetime": "2026-08-24T12:00:00Z",
                "deviceHeadingAtSunDeg": 140.0,
            ],
            "sunAzimuthTrueDeg": 151.5, "solarElevationDeg": 62.0, "offsetDeg": 11.5,
            "headingCorrection": "add 11.5 degrees", "reliable": true,
            "reason": "solar fix", "sources": ["NOAA"], "verified": true,
        ])
        XCTAssertEqual(north.input.lat, 28.61)
        XCTAssertEqual(north.offsetDeg, 11.5)
        XCTAssertTrue(north.reliable)
        XCTAssertEqual(VastuContracts.arTrueNorthCalibrate.operation, .arTrueNorthCalibrate)
    }

    // The 11 GET-only reference tables + the GET+POST dual, from the Rust
    // router (VASTU_GET_REFERENCE_ROUTES + VASTU_DUAL_ROUTE in
    // vedika-v2/src/vastu.rs) — identical list to the Android/Flutter SDK
    // tests.
    private let getOps = [
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
    ]
    private let postOps = ["score/overall", "placement/borewell", "entrance/pada", "plan/analyze"]

    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    private func makeClient(baseURL: String? = nil, apiKey: String = "vk_test_x") throws
        -> VedikaClient
    {
        try VedikaClient(apiKey: apiKey, baseURL: baseURL ?? server.baseURL)
    }

    func testVastuVerbDispatchMatchesTheReferenceTablePlusDeclinationGetEverythingElsePost()
        async throws
    {
        for _ in 0..<(getOps.count + postOps.count) {
            server.enqueue(LoopbackHTTPServer.StubResponse())
        }
        let client = try makeClient()

        for op in getOps {
            _ = try await client.vastu.vastu(op, params: ["lat": 1, "lon": 2])
        }
        for op in postOps {
            _ = try await client.vastu.vastu(op, params: ["zone": "north"])
        }

        let requests = server.requests()
        XCTAssertEqual(requests.count, getOps.count + postOps.count)

        for (index, op) in getOps.enumerated() {
            let recorded = requests[index]
            XCTAssertEqual(recorded.method, "GET", op)
            let pathOnly =
                recorded.path.split(separator: "?", maxSplits: 1).first.map(String.init)
                ?? recorded.path
            XCTAssertEqual(pathOnly, "/v2/astrology/vastu/\(op)", op)
        }
        for (offset, op) in postOps.enumerated() {
            let recorded = requests[getOps.count + offset]
            XCTAssertEqual(recorded.method, "POST", op)
            XCTAssertEqual(recorded.path, "/v2/astrology/vastu/\(op)", op)
        }
    }

    func testBilledGetRetriesReuseOneKeyAndSeparateCallsUseNewKeys() async throws {
        let client = try makeClient()
        var keys = Set<String>()
        for prefix in ["/v2/vastu/", "/v2/astrology/vastu/"] {
            for op in getOps {
                server.enqueue(.init(status: 503, reason: "Unavailable"))
                server.enqueue(.init())
                server.enqueue(.init())
                let path = prefix + op
                let offset = server.requests().count
                _ = try await client.get(path, queryParams: ["lat": "1", "lon": "2"])
                _ = try await client.get(path, queryParams: ["lat": "1", "lon": "2"])
                let requests = Array(server.requests().dropFirst(offset))
                XCTAssertEqual(requests.count, 3, path)
                guard requests.count == 3 else { continue }
                let key = requests[0].headers.first { $0.key.lowercased() == "idempotency-key" }?.value
                let retryKey = requests[1].headers.first { $0.key.lowercased() == "idempotency-key" }?.value
                let nextKey = requests[2].headers.first { $0.key.lowercased() == "idempotency-key" }?.value
                XCTAssertNotNil(key, path)
                XCTAssertNotNil(nextKey, path)
                XCTAssertEqual(key, retryKey, path)
                XCTAssertEqual(requests[0].path, requests[1].path)
                if let key, let nextKey {
                    XCTAssertTrue(keys.insert(key).inserted)
                    XCTAssertTrue(keys.insert(nextKey).inserted)
                }
            }
        }
    }

    func testGetPreservesExplicitKeysAndExcludesUnbilledPaths() async throws {
        let client = try makeClient()
        server.enqueue(.init(status: 503, reason: "Unavailable"))
        server.enqueue(.init())
        _ = try await client.get("/v2/vastu/reference/directions/8", idempotencyKey: "caller-operation")
        XCTAssertEqual(server.requests().count, 2)
        for request in server.requests() {
            XCTAssertEqual(request.headers.first { $0.key.lowercased() == "idempotency-key" }?.value, "caller-operation")
        }
        for path in ["/v2/sandbox/vastu/reference/directions/8", "/v2/vastu/reference/unknown",
                     "/v2/vastu/score/overall", "/v2/astrology/planets"] {
            server.enqueue(.init())
            _ = try await client.get(path)
            XCTAssertNil(server.requests().last?.headers.first { $0.key.lowercased() == "idempotency-key" }?.value, path)
        }
    }

    func testPublicVastuCallsRetainCallerReplayKeysAcrossClientRecreation() async throws {
        let calls: [(VastuService, String) async throws -> Void] = [
            { s, k in _ = try await s.vastu("score/overall", idempotencyKey: k) },
            { s, k in _ = try await s.vastu("reference/directions/8", idempotencyKey: k) },
            { s, k in _ = try await s.vastuOperation(VastuOperation.scoreOverall, idempotencyKey: k) },
            { s, k in _ = try await s.vastuOperation(VastuContracts.referenceDirections8, request: VastuNoRequest(), idempotencyKey: k) },
            { s, k in _ = try await s.vastuReference("reference/directions/8", idempotencyKey: k) },
            { s, k in _ = try await s.vastuMandalaProject("9-zone", params: [:], idempotencyKey: k) },
            { s, k in _ = try await s.vastuEntrancePada(VastuEntrancePadaRequest(plotPolygon: [], doorXY: [0, 0]), idempotencyKey: k) },
            { s, k in _ = try await s.vastuEntranceRecommend(VastuEntranceRecommendRequest(facing: "N"), idempotencyKey: k) },
            { s, k in _ = try await s.vastuArScanQuality(VastuArScanQualityRequest(), idempotencyKey: k) },
            { s, k in _ = try await s.vastuArTrueNorthCalibrate(VastuArTrueNorthCalibrateRequest(lat: 1, lon: 2, datetime: "2026-09-07T00:00:00Z", deviceHeadingAtSunDeg: 3), idempotencyKey: k) },
            { s, k in _ = try await s.vastuAssessments(VastuAssessmentsRequest(inputSource: "plan-derived"), idempotencyKey: k) },
            { s, k in _ = try await s.vastuRoom("kitchen", params: [:], idempotencyKey: k) },
            { s, k in _ = try await s.vastuPlacement("borewell", params: [:], idempotencyKey: k) },
            { s, k in _ = try await s.vastuAudit("floor-plan", params: [:], idempotencyKey: k) },
            { s, k in _ = try await s.vastuScore("overall", params: [:], idempotencyKey: k) },
            { s, k in _ = try await s.vastuPlanGenerate(VastuPlanGenerateRequest(plot: VastuPlanGenerateRequestPlot()), idempotencyKey: k) },
            { s, k in _ = try await s.vastuPlanFromRequirements(VastuPlanFromRequirementsRequest(plot: VastuPlanFromRequirementsRequestPlot()), idempotencyKey: k) },
            { s, k in _ = try await s.vastuDeclination(lat: 1, lon: 2, idempotencyKey: k) },
        ]
        for (index, call) in calls.enumerated() {
            let key = "saved-visit-\(index)"
            let offset = server.requests().count
            server.enqueue(.init(status: 503, reason: "Unavailable"))
            server.enqueue(.init())
            server.enqueue(.init())
            let firstClient = try makeClient()
            try await call(firstClient.vastu, key)
            let recreatedClient = try makeClient()
            try await call(recreatedClient.vastu, key)
            let attempts = Array(server.requests().dropFirst(offset))
            XCTAssertEqual(attempts.count, 3)
            let first = try XCTUnwrap(attempts.first)
            let expectedURL = try XCTUnwrap(URLComponents(string: first.path))
            let sortedQuery: (URLComponents) -> [URLQueryItem] = { url in
                (url.queryItems ?? []).sorted { ($0.name, $0.value ?? "") < ($1.name, $1.value ?? "") }
            }
            for attempt in attempts {
                XCTAssertEqual(attempt.headers.first { $0.key.lowercased() == "idempotency-key" }?.value, key, attempt.path)
                let actualURL = try XCTUnwrap(URLComponents(string: attempt.path))
                XCTAssertEqual(expectedURL.path, actualURL.path)
                XCTAssertEqual(sortedQuery(expectedURL), sortedQuery(actualURL))
                XCTAssertEqual(first.method, attempt.method)
            }
        }
    }

    func testEveryRequestDisablesRedirectFollowing() async throws {
        server.enqueue(LoopbackHTTPServer.StubResponse())
        let client = try makeClient(apiKey: "k")
        _ = try await client.vastu.vastuScore("overall", params: ["zone": "north"])
        XCTAssertEqual(server.requests().count, 1)
        // The behavioral proof that redirects are disabled is the next two
        // tests: a 3xx is surfaced as an error instead of being chased, and
        // a real redirect target is never contacted at all.
    }

    func testAnUnfollowed3xxSurfacesAsAnErrorNotAChasedRedirect() async throws {
        server.enqueue(.redirect(to: "http://evil.example/collect"))
        let client = try makeClient(apiKey: "k")
        do {
            _ = try await client.vastu.vastuScore("overall", params: ["zone": "north"])
            XCTFail("expected a VedikaApiError for the unfollowed 302")
        } catch let error as VedikaApiError {
            XCTAssertEqual(error.statusCode, 302)
        }
    }

    func testAPIKeyIsNeverForwardedAcrossARealCrossOriginRedirect() async throws {
        let collector = LoopbackHTTPServer()
        try collector.start()
        collector.enqueue(LoopbackHTTPServer.StubResponse())
        defer { collector.stop() }

        let redirector = LoopbackHTTPServer()
        try redirector.start()
        redirector.enqueue(.redirect(to: "\(collector.baseURL)/collect"))
        defer { redirector.stop() }

        let client = try VedikaClient(apiKey: "vk_test_secret", baseURL: redirector.baseURL)
        do {
            _ = try await client.vastu.vastuScore("overall", params: ["zone": "north"])
            XCTFail("expected the 302 to surface as an error, not resolve successfully")
        } catch is VedikaApiError {
            // Redirect refused -> the 302 surfaces as an error; expected.
        }

        // The redirect target must never have been reached AT ALL — not
        // "reached without the header," but never contacted, because there
        // is no second request once the redirect is refused.
        try await Task.sleep(nanoseconds: 300_000_000)
        XCTAssertEqual(collector.requests().count, 0, "collector must never receive a request")

        // Sanity check on the premise: the redirector — the client's own
        // configured origin — DID legitimately receive the Authorization
        // header (proving there was a real key to leak in the first place,
        // so the assertion above is meaningful and not vacuously true).
        XCTAssertEqual(redirector.requests().count, 1)
        XCTAssertEqual(
            redirector.requests().first?.headers["Authorization"], "Bearer vk_test_secret")
    }

    func testUntrustedFirstHopsFailWithoutExposingURLSecrets() {
        for origin in [
            "https://attacker.invalid", "https://api.vedika.io.attacker.invalid",
            "https://api.vedika.io:8443", "https://127.0.0.1:443",
            "http://api.vedika.io", "http://127.attacker.invalid",
            "https://api.vedika.io/path", "https://api.vedika.io/?key=SECRET_SENTINEL",
            "https://user:SECRET_SENTINEL@api.vedika.io", "https://api.vedika.io:bad",
            "https://[SECRET_SENTINEL", "ftp://SECRET_SENTINEL.invalid",
        ] {
            for optIn in [false, true] {
                XCTAssertThrowsError(try VedikaClient(apiKey: "vk_test", baseURL: origin, allowInsecureHttp: optIn), origin) { error in
                    XCTAssertFalse(String(describing: error).contains("SECRET_SENTINEL"))
                    XCTAssertFalse(String(reflecting: error).contains("SECRET_SENTINEL"))
                }
            }
        }
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "https://api.vedika.io:443/"))
        XCTAssertEqual(server.requests().count, 0)
    }

    func testBaseURLOriginPolicy() throws {
        // Official HTTPS origin allowed.
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "https://api.vedika.io"))
        // Loopback http allowed: numeric IPv4, literal localhost, IPv6 loopback.
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "http://127.0.0.1:8080"))
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "http://localhost:8080"))
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "http://LOCALHOST:8080"))
        XCTAssertNoThrow(try VedikaClient(apiKey: "k", baseURL: "http://[::1]:8080"))

        // Remote http rejected without opt-in.
        XCTAssertThrowsError(try VedikaClient(apiKey: "k", baseURL: "http://api.vedika.io"))

        // Spoof hosts that merely START with "127." as a DNS label (not an
        // IPv4 octet) are NOT loopback -> rejected. This is the adversarial
        // case a naive `host.hasPrefix("127.")` check would get wrong.
        XCTAssertThrowsError(
            try VedikaClient(apiKey: "k", baseURL: "http://127.attacker.invalid"))
        XCTAssertThrowsError(try VedikaClient(apiKey: "k", baseURL: "http://127.example.com"))

        // The legacy opt-in cannot bypass credential routing.
        XCTAssertThrowsError(
            try VedikaClient(
                apiKey: "k", baseURL: "http://api.vedika.io", allowInsecureHttp: true))

        // Unsupported scheme rejected.
        XCTAssertThrowsError(try VedikaClient(apiKey: "k", baseURL: "ftp://api.vedika.io"))

        // Malformed baseURL rejected.
        XCTAssertThrowsError(try VedikaClient(apiKey: "k", baseURL: "not a url"))
    }
}
