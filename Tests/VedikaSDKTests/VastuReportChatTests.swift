import Foundation
import XCTest

@testable import VedikaSDK

final class VastuReportChatTests: XCTestCase {
    private let upload = "vup_0123456789abcdef0123456789abcdef"
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

    private func header(_ wire: LoopbackHTTPServer.RecordedRequest, _ name: String) -> String? {
        wire.headers.first { $0.key.lowercased() == name.lowercased() }?.value
    }

    private var uploaded: String {
        #"{"uploadId":"\#(upload)","expiresAt":"2026-10-03T00:00:00Z","billing":{"chargedCents":2,"currency":"USD"}}"#
    }

    func testUploadSendsOnePdfPartWithTheRetainedKeyAcrossARetry() async throws {
        server.enqueue(.init(status: 503, reason: "Unavailable", body: "{}"))
        server.enqueue(.init(body: uploaded))
        let pdf = Data("%PDF-1.4 kitchen SE".utf8)
        let result = try await client().vastu.uploadVastuReport(pdf, filename: "my\r\n\"plan\".pdf", idempotencyKey: "upload-7")
        XCTAssertEqual(result["uploadId"] as? String, upload)
        let wires = server.requests()
        XCTAssertEqual(wires.count, 2)
        for wire in wires {
            XCTAssertEqual(wire.method, "POST")
            XCTAssertEqual(wire.path, "/api/v1/vastu/chat/uploads")
            XCTAssertEqual(header(wire, "Idempotency-Key"), "upload-7")
            let type = try XCTUnwrap(header(wire, "Content-Type"))
            XCTAssertTrue(type.hasPrefix("multipart/form-data; boundary="))
            let boundary = String(type.dropFirst("multipart/form-data; boundary=".count))
            let body = String(decoding: wire.body, as: UTF8.self)
            XCTAssertTrue(body.hasPrefix("--\(boundary)\r\n"))
            XCTAssertTrue(body.contains("name=\"file\"; filename=\"my___plan_.pdf\"\r\n"))
            XCTAssertTrue(body.contains("Content-Type: application/pdf\r\n\r\n%PDF-1.4 kitchen SE\r\n--\(boundary)--\r\n"))
        }
    }

    func testUploadRefusesABadKeyOrEmptyFileBeforeAnyRequest() async throws {
        let client = try client()
        for key in ["", "has space", String(repeating: "k", count: 257), "tab\tkey"] {
            do {
                _ = try await client.vastu.uploadVastuReport(Data("%PDF".utf8), idempotencyKey: key)
                XCTFail("key \(key.debugDescription) must be refused")
            } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
        }
        do {
            _ = try await client.vastu.uploadVastuReport(Data(), idempotencyKey: "ok-key")
            XCTFail("an empty file must be refused")
        } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("non-empty")) }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testAskWithAnUploadSendsTheReportRef() async throws {
        server.enqueue(.init(body: #"{"answer":"The kitchen is in the South-East [U1].","conversationId":"c1"}"#))
        let answer = try await client().vastu.askVastuReport(
            "Where is the kitchen?", reportRef: VastuReportRef(id: upload), language: "en")
        XCTAssertEqual(answer["conversationId"] as? String, "c1")
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertEqual(wire.method, "POST")
        XCTAssertEqual(wire.path, "/api/v1/astrology/query")
        let body = try JSONSerialization.jsonObject(with: wire.body) as! [String: Any]
        XCTAssertEqual(body["question"] as? String, "Where is the kitchen?")
        XCTAssertEqual(body["language"] as? String, "en")
        let ref = (body["vastuContext"] as? [String: Any])?["reportRef"] as? [String: Any]
        XCTAssertEqual(ref?["type"] as? String, "upload")
        XCTAssertEqual(ref?["id"] as? String, upload)
    }

    func testAskWithAReportBodyOrAFollowUp() throws {
        let withReport = try VastuReportChat.askBody(
            question: "q", report: ["score": 86], reportRef: nil, conversationId: nil, language: nil, speed: nil)
        XCTAssertEqual(((withReport["vastuContext"] as? [String: Any])?["report"] as? [String: Any])?["score"] as? Int, 86)
        let followUp = try VastuReportChat.askBody(
            question: "and the bedroom?", report: nil, reportRef: nil, conversationId: "c1", language: nil, speed: "fast")
        XCTAssertNil(followUp["vastuContext"])
        XCTAssertEqual(followUp["conversationId"] as? String, "c1")
        XCTAssertEqual(followUp["speed"] as? String, "fast")
    }

    func testAskRefusesAmbiguousOrEmptyContextBeforeAnyRequest() async throws {
        let client = try client()
        let cases: [([String: Any]?, VastuReportRef?, String?)] = [
            (["score": 1], VastuReportRef(id: upload), nil),
            (nil, VastuReportRef(id: "vup_short"), nil),
            (nil, VastuReportRef(id: "../\(upload)"), nil),
            (nil, nil, nil),
            (nil, nil, ""),
        ]
        for (report, ref, conversation) in cases {
            do {
                _ = try await client.vastu.askVastuReport("q", report: report, reportRef: ref, conversationId: conversation)
                XCTFail("must be refused: \(String(describing: ref)) \(String(describing: conversation))")
            } catch is VedikaApiError {}
        }
        XCTAssertEqual(server.requests().count, 0)
    }
}
