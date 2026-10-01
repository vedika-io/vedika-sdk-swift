import XCTest

@testable import VedikaSDK

/// `RoomCaptureUploader.saveCapture` against the loopback server: the exact
/// `scans/save` body (`snapshot.capture`, `inputSource: device-reported`), no
/// retry header, and identifier validation before any request is made.
final class RoomCaptureSaveTests: XCTestCase {
    private let scanId = "scan-0123456789abcdef"
    private let propertyId = "property-0123456789ab"
    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    private func uploader() throws -> RoomCaptureUploader {
        RoomCaptureUploader(service: try VedikaClient(apiKey: "vk_test_x", baseURL: server.baseURL).vastu)
    }

    private func fixtureCapture() throws -> VastuRoomCapture {
        guard let dir = RoomCaptureFixtures.directory else {
            throw XCTSkip("room-capture fixtures are unavailable")
        }
        let fixture = try XCTUnwrap(try RoomCaptureFixtures.load(dir).first)
        let session = RoomCaptureFixtures.parseSession(try XCTUnwrap(fixture.json["session"] as? [String: Any]))
        return try RoomCaptureGeometry.buildRoomCapture(session)
    }

    private func savedResponse(persistence: String = "account-store") -> LoopbackHTTPServer.StubResponse {
        var response = LoopbackHTTPServer.StubResponse()
        response.body =
            #"{"success":true,"data":{"scan":{"scanId":"\#(scanId)"},"replayed":false,"persistence":"\#(persistence)"},"#
            + #""billing":{"charged":0.005,"currency":"USD","balanceBefore":1.0,"balanceAfter":0.995,"endpoint":"/v2/vastu/scans/save","category":"vastu"}}"#
        return response
    }

    func testSaveCapturePostsTheCaptureAsADeviceReportedSnapshotWithoutARetryHeader() async throws {
        let capture = try fixtureCapture()
        server.enqueue(savedResponse())
        let response = try await uploader().saveCapture(
            capture, scanId: scanId, propertyId: propertyId, title: "Flat 4B living room", retentionDays: 14)

        XCTAssertTrue(response.success)
        XCTAssertEqual(response.data.persistence, "account-store")
        XCTAssertFalse(response.data.replayed)
        XCTAssertEqual(response.billing?["endpoint"] as? String, "/v2/vastu/scans/save")

        let requests = server.requests()
        XCTAssertEqual(requests.count, 1)
        let wire = try XCTUnwrap(requests.first)
        XCTAssertEqual(wire.method, "POST")
        XCTAssertEqual(wire.path, "/v2/astrology/vastu/scans/save")
        XCTAssertNil(wire.headers.first { $0.key.lowercased() == "idempotency-key" })

        let body = try XCTUnwrap(JSONSerialization.jsonObject(with: wire.body) as? [String: Any])
        XCTAssertEqual(Set(body.keys), ["scanId", "propertyId", "title", "retentionDays", "snapshot"])
        XCTAssertEqual(body["scanId"] as? String, scanId)
        XCTAssertEqual(body["propertyId"] as? String, propertyId)
        XCTAssertEqual(body["title"] as? String, "Flat 4B living room")
        XCTAssertEqual(body["retentionDays"] as? Int, 14)
        let snapshot = try XCTUnwrap(body["snapshot"] as? [String: Any])
        // The server refuses rooms, plotPolygon, bearingDeg or telemetry beside a capture.
        XCTAssertEqual(Set(snapshot.keys), ["inputSource", "capture"])
        XCTAssertEqual(snapshot["inputSource"] as? String, "device-reported")
        let sent = try XCTUnwrap(snapshot["capture"] as? [String: Any])
        XCTAssertEqual(sent["schema"] as? String, capture.schema)
        XCTAssertEqual(sent["captureId"] as? String, capture.captureId)
        XCTAssertEqual((sent["rooms"] as? [Any])?.count, capture.rooms.count)
    }

    func testSaveCaptureCarriesDeviceAttestationOnlyWhenGiven() async throws {
        let capture = try fixtureCapture()
        server.enqueue(savedResponse())
        server.enqueue(savedResponse())
        let sut = try uploader()
        _ = try await sut.saveCapture(capture, scanId: scanId, propertyId: propertyId, title: "Kitchen", retentionDays: 1)
        _ = try await sut.saveCapture(
            capture, scanId: scanId, propertyId: propertyId, title: "Kitchen", retentionDays: 1,
            deviceAttestation: VastuDeviceAttestation(platform: "ios", challenge: "challenge-1", keyId: "key-1", assertion: "assertion-1"))

        let bodies = try server.requests().map { try XCTUnwrap(JSONSerialization.jsonObject(with: $0.body) as? [String: Any]) }
        XCTAssertNil(bodies[0]["deviceAttestation"])
        let attestation = try XCTUnwrap(bodies[1]["deviceAttestation"] as? [String: Any])
        XCTAssertEqual(attestation["platform"] as? String, "ios")
        XCTAssertEqual(attestation["challenge"] as? String, "challenge-1")
        XCTAssertEqual(attestation["keyId"] as? String, "key-1")
        XCTAssertEqual(attestation["assertion"] as? String, "assertion-1")
    }

    func testAPreviewOnlyAnswerIsReportedAsNotStored() async throws {
        let capture = try fixtureCapture()
        server.enqueue(savedResponse(persistence: "preview-only"))
        let response = try await uploader().saveCapture(
            capture, scanId: scanId, propertyId: propertyId, title: "Kitchen", retentionDays: 7)
        XCTAssertEqual(response.data.persistence, "preview-only")
    }

    func testMalformedIdentifiersTitleAndRetentionAreRefusedBeforeAnyRequest() async throws {
        let capture = try fixtureCapture()
        let sut = try uploader()
        func refuse(
            scan: String? = nil, property: String? = nil, title: String = "Kitchen", days: Int = 7,
            _ label: String, file: StaticString = #filePath, line: UInt = #line
        ) async {
            do {
                _ = try await sut.saveCapture(
                    capture, scanId: scan ?? scanId, propertyId: property ?? propertyId, title: title, retentionDays: days)
                XCTFail("\(label) must be refused", file: file, line: line)
            } catch {
                XCTAssertTrue(error is VedikaApiError, label, file: file, line: line)
            }
        }
        await refuse(scan: "short", "short scanId")
        await refuse(scan: "scan 0123456789abcdef", "scanId with a space")
        await refuse(property: String(repeating: "p", count: 129), "overlong propertyId")
        await refuse(title: "   ", "blank title")
        await refuse(title: String(repeating: "x", count: 161), "overlong title")
        await refuse(days: 0, "zero retention")
        await refuse(days: 31, "retention over 30")
        XCTAssertEqual(server.requests().count, 0)
    }
}
