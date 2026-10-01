import Foundation
import XCTest

@testable import VedikaSDK

final class VastuJobsTests: XCTestCase {
    private let job = "vjob_0123456789abcdef0123456789abcdef"
    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    private func client() throws -> VedikaClient { try VedikaClient(apiKey: "vk_test", baseURL: server.baseURL) }

    private func request() -> VastuJobsRequest {
        VastuJobsRequest(
            items: [VastuJobsRequestItem(id: "p1", input: VastuAssessmentsRequest(inputSource: "plan-derived"))],
            webhookId: "wh_12345678")
    }

    private var submitted: String {
        #"{"success":true,"data":{"jobId":"\#(job)","status":"queued","itemCount":1,"maxCharge":0.1,"replayed":false}}"#
    }

    private var status: String {
        #"{"success":true,"data":{"jobId":"\#(job)","status":"running","operation":"assessments","itemCount":1,"counts":{"succeeded":0,"failed":0,"pending":1,"cancelled":0},"billing":{"currency":"USD","pricePerItem":0.1,"maxCharge":0.1,"charged":0,"basis":"per item"},"cancelRequested":false,"createdAt":1,"updatedAt":1,"expiresAt":9,"resultsUrl":"https://api.vedika.io/v2/vastu/jobs/\#(job)/results"}}"#
    }

    private func header(_ wire: LoopbackHTTPServer.RecordedRequest, _ name: String) -> String? {
        wire.headers.first { $0.key.lowercased() == name.lowercased() }?.value
    }

    func testRequestBodyNamesTheOperationAndCarriesItemsUnderInput() {
        let body = request().dictionary
        XCTAssertEqual(body["operation"] as? String, "assessments")
        XCTAssertEqual(body["webhookId"] as? String, "wh_12345678")
        let items = body["items"] as? [[String: Any]]
        XCTAssertEqual(items?.count, 1)
        XCTAssertEqual(items?[0]["id"] as? String, "p1")
        XCTAssertEqual((items?[0]["input"] as? [String: Any])?["inputSource"] as? String, "plan-derived")
        XCTAssertNil(VastuJobsRequest(items: request().items).dictionary["webhookId"])
    }

    func testSubmitNeedsARetainedKeyBeforeAnyNetworkRequest() async throws {
        let client = try client()
        for key in ["", "   "] {
            do {
                _ = try await client.vastu.vastuJobSubmit(request(), idempotencyKey: key)
                XCTFail("a blank key must be refused")
            } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
            do {
                _ = try await client.vastu.vastu("jobs", params: request().dictionary, idempotencyKey: key)
                XCTFail("a blank key must be refused")
            } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
        }
        do {
            _ = try await client.vastu.vastu("jobs", params: request().dictionary)
            XCTFail("a missing key must be refused")
        } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testSubmitAcceptsThe202AnswerAndKeepsItsKeyAcrossARetryAndANewClient() async throws {
        server.enqueue(.init(status: 503, reason: "Unavailable", body: "{}"))
        server.enqueue(.init(status: 202, reason: "Accepted", body: submitted))
        server.enqueue(.init(status: 202, reason: "Accepted", body: submitted))
        for _ in 0..<2 {
            let result = try await client().vastu.vastuJobSubmit(request(), idempotencyKey: "saved-job-7")
            XCTAssertTrue(result.success)
            XCTAssertEqual(result.data.jobId, job)
            XCTAssertEqual(result.data.status, "queued")
            XCTAssertFalse(result.data.replayed)
        }
        let wires = server.requests()
        XCTAssertEqual(wires.count, 3)
        for wire in wires {
            XCTAssertEqual(wire.method, "POST")
            XCTAssertEqual(wire.path, "/v2/astrology/vastu/jobs")
            XCTAssertEqual(header(wire, "Idempotency-Key"), "saved-job-7")
            let body = try JSONSerialization.jsonObject(with: wire.body) as! [String: Any]
            XCTAssertEqual(body["operation"] as? String, "assessments")
        }
    }

    func testStatusResultsAndCancelUseTheRightVerbsAndPaths() async throws {
        server.enqueue(.init(body: status))
        server.enqueue(.init(body: #"{"success":true,"data":{"jobId":"\#(job)","jobStatus":"running","results":[],"nextCursor":null}}"#))
        server.enqueue(.init(body: status.replacingOccurrences(of: "\"cancelRequested\":false", with: "\"cancelRequested\":true")))
        let client = try client()
        let current = try await client.vastu.vastuJobStatus(job)
        XCTAssertEqual(current.data.counts.pending, 1)
        let page = try await client.vastu.vastuJobResults(job, cursor: "abc")
        XCTAssertNil(page.data.nextCursor)
        let cancelled = try await client.vastu.vastuJobCancel(job)
        XCTAssertTrue(cancelled.data.cancelRequested)
        let wires = server.requests()
        XCTAssertEqual(wires.map { $0.method }, ["GET", "GET", "POST"])
        XCTAssertEqual(wires[0].path, "/v2/astrology/vastu/jobs/\(job)")
        XCTAssertEqual(wires[1].path, "/v2/astrology/vastu/jobs/\(job)/results?cursor=abc")
        XCTAssertEqual(wires[2].path, "/v2/astrology/vastu/jobs/\(job)/cancel")
    }

    func testGenericEscapeHatchSendsGETForStatusAndResultsAndPOSTForCancel() async throws {
        for _ in 0..<3 { server.enqueue(.init(body: status)) }
        let client = try client()
        _ = try await client.vastu.vastu("jobs/\(job)")
        _ = try await client.vastu.vastu("jobs/\(job)/results", params: ["cursor": "c1"])
        _ = try await client.vastu.vastu("jobs/\(job)/cancel")
        XCTAssertEqual(server.requests().map { $0.method }, ["GET", "GET", "POST"])
        for bad in ["jobs/../../x", "jobs/vjob_x/results"] {
            do {
                _ = try await client.vastu.vastu(bad)
                XCTFail("\(bad) must be refused")
            } catch is VedikaApiError {}
        }
        XCTAssertEqual(server.requests().count, 3)
    }

    func testJobIdsAndCursorsAreCheckedBeforeAnyRequest() async throws {
        let client = try client()
        for bad in ["", "vjob_x", "../keys", "\(job)/../x"] {
            do {
                _ = try await client.vastu.vastuJobStatus(bad)
                XCTFail("\(bad) must be refused")
            } catch is VedikaApiError {}
            do {
                _ = try await client.vastu.vastuJobCancel(bad)
                XCTFail("\(bad) must be refused")
            } catch is VedikaApiError {}
        }
        do {
            _ = try await client.vastu.vastuJobResults(job, cursor: String(repeating: "x", count: 33))
            XCTFail("an over-long cursor must be refused")
        } catch is VedikaApiError {}
        XCTAssertEqual(server.requests().count, 0)
    }

    func testAllResultsFollowNextCursorToTheEnd() async throws {
        func item(_ i: Int) -> String { #"{"id":"p\#(i)","index":\#(i),"status":200,"response":{"success":true}}"# }
        server.enqueue(.init(body: #"{"success":true,"data":{"jobId":"\#(job)","jobStatus":"running","results":[\#(item(0)),\#(item(1))],"nextCursor":"c2"}}"#))
        server.enqueue(.init(body: #"{"success":true,"data":{"jobId":"\#(job)","jobStatus":"completed","results":[\#(item(2))],"nextCursor":null}}"#))
        let items = try await client().vastu.vastuJobAllResults(job)
        XCTAssertEqual(items.map { $0.index }, [0, 1, 2])
        XCTAssertEqual(items[0].status, 200)
        XCTAssertNil(items[0].code)
        let wires = server.requests()
        XCTAssertEqual(wires[0].path, "/v2/astrology/vastu/jobs/\(job)/results")
        XCTAssertEqual(wires[1].path, "/v2/astrology/vastu/jobs/\(job)/results?cursor=c2")
    }
}
