import Foundation
import XCTest

@testable import VedikaSDK

/// Error classification and idempotency-key policy, against a real loopback
/// socket. Mirrors `sdks/android/.../ErrorHandlingTest.kt`.
final class ErrorHandlingTests: XCTestCase {
    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    private func client() throws -> VedikaClient { try VedikaClient(apiKey: "vk_test_x", baseURL: server.baseURL) }

    private func header(_ wire: LoopbackHTTPServer.RecordedRequest, _ name: String) -> String? {
        wire.headers.first { $0.key.lowercased() == name.lowercased() }?.value
    }

    private func stub(_ status: Int, _ body: String, headers: [String: String] = [:]) -> LoopbackHTTPServer.StubResponse {
        var response = LoopbackHTTPServer.StubResponse(status: status, reason: "Stub", body: body)
        for (key, value) in headers { response.headers[key] = value }
        return response
    }

    func testInsufficientBalanceIsTypedAndNeverRetried() async throws {
        server.enqueue(stub(402, #"{"success":false,"error":"Insufficient balance","code":"INSUFFICIENT_BALANCE","wallet":{"required":0.5,"available":0.12,"deficit":0.38},"purchaseUrl":"https://vedika.io/dashboard/billing"}"#))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 402 must throw")
        } catch let error as VedikaInsufficientCredits {
            XCTAssertEqual(error.code, "INSUFFICIENT_BALANCE")
            XCTAssertEqual(error.required, 0.5)
            XCTAssertEqual(error.available, 0.12)
            XCTAssertEqual(error.deficit, 0.38)
            XCTAssertEqual(error.purchaseUrl, "https://vedika.io/dashboard/billing")
        }
        XCTAssertEqual(server.requests().count, 1)
    }

    func testInsufficientBalanceToleratesAMissingWalletBlock() async throws {
        server.enqueue(stub(402, #"{"error":"no funds"}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 402 must throw")
        } catch let error as VedikaInsufficientCredits {
            XCTAssertNil(error.required)
            XCTAssertNil(error.deficit)
        }
    }

    func testDailyLimitIsNotRetryableAndIgnoresRateLimitHeaders() async throws {
        server.enqueue(stub(
            429, #"{"success":false,"code":"DAILY_LIMIT_EXCEEDED","message":"Daily limit reached","retryAfter":3600,"upgradeUrl":"https://vedika.io/pricing"}"#,
            headers: ["x-ratelimit-remaining": "59", "Retry-After": "1"]))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 429 must throw")
        } catch let error as VedikaRateLimitError {
            XCTAssertTrue(error.isDailyLimit)
            XCTAssertFalse(error.isRetryable)
            XCTAssertEqual(error.upgradeUrl, "https://vedika.io/pricing")
        }
        XCTAssertEqual(server.requests().count, 1)
    }

    func testPerMinuteLimitCarriesRetryAfterFromTheBodyBeforeTheHeader() async throws {
        server.enqueue(stub(429, #"{"code":"RATE_LIMIT_EXCEEDED","retryAfter":7}"#, headers: ["Retry-After": "99"]))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 429 must throw")
        } catch let error as VedikaRateLimitError {
            XCTAssertTrue(error.isRetryable)
            XCTAssertEqual(error.retryAfterSeconds, 7)
        }
        server.enqueue(stub(429, #"{"code":"RATE_LIMITED"}"#, headers: ["Retry-After": "12"]))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 429 must throw")
        } catch let error as VedikaRateLimitError {
            XCTAssertEqual(error.retryAfterSeconds, 12)
        }
    }

    func testUnauthorizedIsNotRetried() async throws {
        server.enqueue(stub(401, #"{"error":"Invalid API key"}"#, headers: ["WWW-Authenticate": #"Bearer error="invalid_token""#]))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 401 must throw")
        } catch is VedikaAuthError {}
        XCTAssertEqual(server.requests().count, 1)
    }

    func testEvery2xxIsSuccess() async throws {
        for status in [201, 202] {
            server.enqueue(stub(status, #"{"success":true,"data":{"jobId":"x"}}"#))
            let body = try await client().get("/v2/astrology/vastu/jobs/vjob_0123456789abcdef0123456789abcdef")
            XCTAssertEqual(body["success"] as? Bool, true, "\(status)")
        }
    }

    func testAnAutomaticKeyRefusedAs422IsResentOnceWithoutIt() async throws {
        server.enqueue(stub(422, #"{"success":false,"code":"IDEMPOTENCY_NOT_SUPPORTED","message":"Remove the idempotency header and retry; no charge was attempted."}"#))
        server.enqueue(stub(200, #"{"success":true,"data":{"ok":true}}"#))
        let result = try await client().vastu.vastuScore("overall", params: [:])
        XCTAssertEqual(result["success"] as? Bool, true)
        let wires = server.requests()
        XCTAssertEqual(wires.count, 2)
        XCTAssertNotNil(header(wires[0], "Idempotency-Key"))
        XCTAssertNil(header(wires[1], "Idempotency-Key"))
        XCTAssertNil(header(wires[1], "X-Idempotency-Key"))
    }

    func testAKeylessResendIsNotRetriedAfterAServerError() async throws {
        server.enqueue(stub(422, #"{"code":"IDEMPOTENCY_NOT_SUPPORTED"}"#))
        server.enqueue(stub(503, #"{"error":"down"}"#))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("the 503 must surface")
        } catch is VedikaServerError {}
        XCTAssertEqual(server.requests().count, 2, "a keyless billed call must not be retried")
    }

    func testACallersOwnKeyIsNeverDropped() async throws {
        server.enqueue(stub(422, #"{"code":"IDEMPOTENCY_NOT_SUPPORTED","message":"no key here"}"#))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:], idempotencyKey: "mine-1")
            XCTFail("an unsupported caller key must throw")
        } catch is VedikaIdempotencyNotSupportedError {}
        XCTAssertEqual(server.requests().count, 1)
    }

    func testOtherIdempotencyErrorsStayPlain422s() async throws {
        server.enqueue(stub(422, #"{"code":"IDEMPOTENCY_KEY_REUSED","error":"reused"}"#))
        do {
            _ = try await client().vastu.vastuScore("overall", params: [:])
            XCTFail("a 422 must throw")
        } catch let error as VedikaApiError {
            XCTAssertFalse(error is VedikaIdempotencyNotSupportedError)
            XCTAssertEqual(error.code, "IDEMPOTENCY_KEY_REUSED")
        }
        XCTAssertEqual(server.requests().count, 1)
    }

    func testSandboxCallsGetNoAutomaticKeyAndAreNotRetriedOnA5xx() async throws {
        server.enqueue(stub(503, #"{"error":"down"}"#))
        server.enqueue(stub(200, #"{"success":true}"#))
        do {
            _ = try await client().post("/sandbox/v2/vastu/workspace/get", body: [:])
            XCTFail("the 503 must surface")
        } catch is VedikaServerError {}
        let wires = server.requests()
        XCTAssertEqual(wires.count, 1)
        XCTAssertNil(header(wires[0], "Idempotency-Key"))
        XCTAssertNil(header(wires[0], "X-Idempotency-Key"))
        XCTAssertNil(header(wires[0], "X-Request-Id"))
    }

    func testReportChatQueryUsesTheSpecHeaderSpelling() async throws {
        server.enqueue(stub(200, #"{"success":true}"#))
        _ = try await client().post("/api/v1/astrology/query", body: ["question": "q"])
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertNotNil(header(wire, "X-Idempotency-Key"))
        XCTAssertNil(header(wire, "Idempotency-Key"))
    }

    func testVastuCallsKeepTheSpecHeaderSpellingAndNeverSendXRequestId() async throws {
        server.enqueue(stub(200, #"{"success":true}"#))
        _ = try await client().vastu.vastuScore("overall", params: [:])
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertNotNil(header(wire, "Idempotency-Key"))
        XCTAssertNil(header(wire, "X-Idempotency-Key"))
        XCTAssertNil(header(wire, "X-Request-Id"))
        XCTAssertEqual(header(wire, "Authorization"), "Bearer vk_test_x")
    }

    func testSDKVersionHeaderMatchesTheReleaseInPackageMetadata() async throws {
        server.enqueue(stub(200, #"{"success":true}"#))
        _ = try await client().vastu.vastuScore("overall", params: [:])
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertEqual(header(wire, "X-SDK"), "vedika-swift/1.4.1")
    }
}
