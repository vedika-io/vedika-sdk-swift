import Foundation
import XCTest

@testable import VedikaSDK

/// The RoomPlan controller's completion yields a single room with no label,
/// which the server refuses ("Tag at least one captured room"). These tests
/// build that exact session shape with the helper the controller itself calls
/// (`RoomCaptureSession.roomPlanSingleRoom`), run it through the same geometry
/// the server converter receives, and prove the label and outline confirmation
/// step makes it uploadable. Physical-device acceptance is separate: RoomPlan
/// does not run off-device.
final class RoomPlanHandoffTests: XCTestCase {
    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    /// A draft shaped exactly like the controller's output, from the first shared fixture's geometry.
    private func controllerDraft() throws -> RoomCaptureSession {
        guard let dir = RoomCaptureFixtures.directory else { throw XCTSkip("room-capture fixtures are unavailable") }
        let fixture = try XCTUnwrap(try RoomCaptureFixtures.load(dir).first { $0.name == "room-3x4-yaw0.json" })
        let source = RoomCaptureFixtures.parseSession(try XCTUnwrap(fixture.json["session"] as? [String: Any]))
        // The room's own walls, chained by the same code the controller uses.
        let corners = source.rooms[0].worldCorners
        let walls = corners.indices.map { RoomPlanWallSegment(start: corners[$0], end: corners[($0 + 1) % corners.count]) }
        let trace = try RoomPlanWallChain.trace(walls)
        return RoomCaptureSession.roomPlanSingleRoom(
            captureId: source.captureId, capturedAtEpoch: source.capturedAtEpoch, headingSamples: source.headingSamples,
            declinationDeg: source.north.declinationDeg ?? 0, declinationProvenance: source.north.declinationProvenance,
            trace: trace, openings: source.rooms[0].openings)
    }

    private func uploader() throws -> RoomCaptureUploader {
        RoomCaptureUploader(service: try VedikaClient(apiKey: "vk_test_x", baseURL: server.baseURL).vastu)
    }

    /// The server rule (vastu_room_capture.rs): a label with labelSource user or
    /// roomplan-section, or no label with labelSource none; at least one
    /// labelled room; quality.roomsTagged equals the labelled rooms.
    private func assertServerAcceptsLabels(_ body: [String: Any], file: StaticString = #filePath, line: UInt = #line) {
        let rooms = body["rooms"] as? [[String: Any]] ?? []
        var tagged = 0
        for room in rooms {
            let hasLabel = (room["label"] as? String).map { !$0.trimmingCharacters(in: .whitespaces).isEmpty } ?? false
            XCTAssertEqual(hasLabel, (room["labelSource"] as? String) != "none", file: file, line: line)
            if hasLabel { tagged += 1 }
        }
        XCTAssertGreaterThan(tagged, 0, "an untagged capture has nothing to audit", file: file, line: line)
        XCTAssertEqual((body["quality"] as? [String: Any])?["roomsTagged"] as? Int, tagged, file: file, line: line)
    }

    func testTheControllerShapedDraftIsUntaggedAndNotReady() throws {
        let draft = try controllerDraft()
        XCTAssertEqual(draft.rooms.count, 1)
        XCTAssertNil(draft.rooms[0].label)
        XCTAssertEqual(draft.rooms[0].labelSource, "none")
        XCTAssertFalse(draft.outlineConfirmed)
        XCTAssertFalse(draft.isReadyForUpload)
        // The measured trace and quality are kept, not replaced by an invented closure or density.
        XCTAssertEqual(draft.quality, RoomPlanCaptureQuality.measured())
        XCTAssertEqual(draft.quality.pointCloudDensityBasis, "none")
        XCTAssertEqual(draft.outline.maxSeamGapM, 0)
        XCTAssertEqual(draft.rooms[0].closingTap, draft.outline.closingTap)
        let built = try RoomCaptureGeometry.buildRoomCapture(draft)
        XCTAssertEqual(built.quality.roomsTagged, 0)
        XCTAssertNil(built.rooms[0].label)
    }

    func testAnUntaggedDraftIsRefusedBeforeAnyRequest() async throws {
        let draft = try controllerDraft()
        do {
            _ = try await uploader().upload(session: draft)
            XCTFail("an untagged capture must not be sent")
        } catch let error as RoomCaptureError {
            XCTAssertTrue(error.message.contains("Tag at least one room"))
        }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testConfirmingTheLabelMakesTheCaptureReadyAndUploadable() async throws {
        let draft = try controllerDraft()
        let confirmed = try draft.confirmed(label: "  kitchen ", outline: .singleRoomPerimeter)
        XCTAssertTrue(confirmed.isReadyForUpload)
        XCTAssertEqual(confirmed.rooms[0].label, "kitchen")
        XCTAssertEqual(confirmed.rooms[0].labelSource, "user")
        XCTAssertEqual(confirmed.outline, draft.outline, "single-room scope keeps the room perimeter as the outline")
        XCTAssertNil(draft.rooms[0].label, "confirmed(label:outline:) returns a copy")

        let built = try RoomCaptureGeometry.buildRoomCapture(confirmed)
        XCTAssertEqual(built.quality.roomsTagged, 1)

        server.enqueue(.init(body: #"{"success":true,"data":{}}"#))
        _ = try await uploader().upload(session: confirmed, zoneResolution: 16, idempotencyKey: "upload-1")
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertEqual(wire.path, "/v2/astrology/vastu/ar/room-capture")
        let body = try XCTUnwrap(try JSONSerialization.jsonObject(with: wire.body) as? [String: Any])
        let capture = try XCTUnwrap(body["capture"] as? [String: Any])
        assertServerAcceptsLabels(capture)
        let room = try XCTUnwrap((capture["rooms"] as? [[String: Any]])?.first)
        XCTAssertEqual(room["label"] as? String, "kitchen")
        XCTAssertEqual(room["labelSource"] as? String, "user")
    }

    func testAPropertyBoundaryReplacesTheOutlineAndStatesTheScope() throws {
        let draft = try controllerDraft()
        let boundary = [Vec3(x: -5, y: 0, z: -5), Vec3(x: 5, y: 0, z: -5), Vec3(x: 5, y: 0, z: 5), Vec3(x: -5, y: 0, z: 5)]
        let confirmed = try draft.confirmed(
            label: "bedroom", outline: .propertyBoundary(worldCorners: boundary, closingTap: boundary[0]))
        XCTAssertEqual(confirmed.outline.worldCorners, boundary)
        XCTAssertEqual(confirmed.outline.source, "traced")
        XCTAssertEqual(confirmed.rooms[0].worldCorners, draft.rooms[0].worldCorners, "the room itself is unchanged")
        XCTAssertTrue(confirmed.isReadyForUpload)
    }

    func testConfirmationRefusesBadInput() throws {
        let draft = try controllerDraft()
        XCTAssertThrowsError(try draft.confirmed(label: "   ", outline: .singleRoomPerimeter))
        XCTAssertThrowsError(try draft.confirmed(label: String(repeating: "k", count: 65), outline: .singleRoomPerimeter))
        XCTAssertThrowsError(
            try draft.confirmed(label: "kitchen", outline: .propertyBoundary(worldCorners: [Vec3(x: 0, y: 0, z: 0), Vec3(x: 1, y: 0, z: 0)], closingTap: nil)))
        var elsewhere = draft
        elsewhere.outline = RoomCaptureOutlineInput(
            source: "traced", worldCorners: [Vec3(x: 9, y: 0, z: 9), Vec3(x: 10, y: 0, z: 9), Vec3(x: 10, y: 0, z: 10)], closingTap: nil)
        XCTAssertThrowsError(try elsewhere.confirmed(label: "kitchen", outline: .singleRoomPerimeter))
        var two = draft
        two.rooms.append(draft.rooms[0])
        XCTAssertThrowsError(try two.confirmed(label: "kitchen", outline: .singleRoomPerimeter))
    }

    // Parity with the Android VastuArCoreUploaderTest: the same body keys and
    // attestation field names reach the wire.
    func testUploadForwardsDeviceAttestationUnchangedAndOmitsItWhenAbsent() async throws {
        let confirmed = try controllerDraft().confirmed(label: "kitchen", outline: .singleRoomPerimeter)
        server.enqueue(.init(body: #"{"success":true,"data":{}}"#))
        server.enqueue(.init(body: #"{"success":true,"data":{}}"#))
        let proof = VastuDeviceAttestation(platform: "ios", challenge: "challenge-1", keyId: "key-1", assertion: "assertion-1")
        _ = try await uploader().upload(session: confirmed, zoneResolution: 16, deviceAttestation: proof, idempotencyKey: "upload-key-1")
        _ = try await uploader().upload(session: confirmed)

        let wires = server.requests()
        let withProof = try XCTUnwrap(try JSONSerialization.jsonObject(with: wires[0].body) as? [String: Any])
        XCTAssertEqual(Set(withProof.keys), ["capture", "zoneResolution", "deviceAttestation"])
        XCTAssertEqual(wires[0].headers.first { $0.key.lowercased() == "idempotency-key" }?.value, "upload-key-1")
        let sent = try XCTUnwrap(withProof["deviceAttestation"] as? [String: Any])
        XCTAssertEqual(Set(sent.keys), ["platform", "challenge", "keyId", "assertion"])
        XCTAssertEqual(sent["platform"] as? String, "ios")
        XCTAssertEqual(sent["challenge"] as? String, "challenge-1")

        let without = try XCTUnwrap(try JSONSerialization.jsonObject(with: wires[1].body) as? [String: Any])
        XCTAssertEqual(Set(without.keys), ["capture"])
    }
}
