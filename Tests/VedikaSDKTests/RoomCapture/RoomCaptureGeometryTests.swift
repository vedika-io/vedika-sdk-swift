import Foundation
import XCTest

@testable import VedikaSDK

/// Swift parity for `RoomCaptureGeometryTest.kt`
/// (`sdks/android-ar/src/test/kotlin/io/vedika/sdk/ar/RoomCaptureGeometryTest.kt`)
/// and, through it, `web/vedika-public/js/vastu/__tests__/room-capture-geometry.test.mjs`.
/// Same shared fixtures, same scenarios, same expected outcomes (numeric
/// fields within 1e-6 — see `RoomCaptureFixtures`).
final class RoomCaptureGeometryTests: XCTestCase {

    private func withFixtures(_ block: ([(name: String, json: [String: Any])]) throws -> Void) throws {
        guard let dir = RoomCaptureFixtures.directory else {
            XCTFail("room-capture fixtures are neither in a monorepo checkout nor bundled with the test target")
            return
        }
        try block(try RoomCaptureFixtures.load(dir))
    }

    func testBundledRoomCaptureFixturesMatchCanonical() throws {
        guard let canonical = RoomCaptureFixtures.canonicalDirectory else {
            throw XCTSkip("no monorepo checkout reachable; the bundled copy is the only copy here")
        }
        guard let bundled = RoomCaptureFixtures.bundledDirectory else {
            XCTFail("RoomCaptureFixtures resource missing from the test bundle")
            return
        }
        let names = { (dir: URL) throws -> [String] in
            try FileManager.default.contentsOfDirectory(atPath: dir.path).filter { $0.hasSuffix(".json") }.sorted()
        }
        let canonicalNames = try names(canonical)
        XCTAssertEqual(canonicalNames, try names(bundled), "bundled fixture set drifted from sdks/fixtures/vastu-room-capture")
        for name in canonicalNames {
            let a = try Data(contentsOf: canonical.appendingPathComponent(name))
            let b = try Data(contentsOf: bundled.appendingPathComponent(name))
            XCTAssertEqual(a, b, "\(name) drifted from sdks/fixtures/vastu-room-capture")
        }
    }

    func testEverySharedFixtureSessionBecomesItsExpectedCaptureExactly() throws {
        try withFixtures { fixtures in
            XCTAssertEqual(7, fixtures.count)
            for fixture in fixtures {
                let session = RoomCaptureFixtures.parseSession(fixture.json["session"] as! [String: Any])
                let capture = try RoomCaptureGeometry.buildRoomCapture(session)
                let expected = ((fixture.json["expected"] as! [String: Any])["capture"] as! [String: Any])
                RoomCaptureFixtures.assertMatches(capture.dictionary, expected, path: fixture.name)
            }
        }
    }

    func testTheEastDoorLandsOnTheEastWallAtEveryDeviceYaw() throws {
        try withFixtures { fixtures in
            for name in ["room-3x4-yaw0.json", "room-3x4-yaw90.json", "room-3x4-yaw233.json"] {
                guard let fixture = fixtures.first(where: { $0.name == name }) else {
                    XCTFail("missing fixture \(name)")
                    continue
                }
                let session = RoomCaptureFixtures.parseSession(fixture.json["session"] as! [String: Any])
                let capture = try RoomCaptureGeometry.buildRoomCapture(session)
                XCTAssertEqual(capture.outline.polygon, [[0.0, 0.0], [9.0, 0.0], [9.0, 12.0], [0.0, 12.0]], name)
                XCTAssertEqual(capture.rooms[0].polygon, [[6.0, 0.0], [9.0, 0.0], [9.0, 4.0], [6.0, 4.0]], name)
                XCTAssertEqual(capture.rooms[0].openings?[0].centerXY ?? [], [9.0, 1.0], name)
            }
        }
    }

    func testAMirroredFloorMappingCannotPassTheDoorCheck() throws {
        try withFixtures { fixtures in
            guard let fixture = fixtures.first(where: { $0.name == "room-3x4-yaw90.json" }) else {
                XCTFail("missing fixture")
                return
            }
            let session = RoomCaptureFixtures.parseSession(fixture.json["session"] as! [String: Any])
            func mirror(_ p: Vec3) -> Vec3 { Vec3(x: p.x, y: p.y, z: -p.z) }
            let mirrored = RoomCaptureSession(
                captureId: session.captureId, capturedAtEpoch: session.capturedAtEpoch, device: session.device,
                headingFrame: session.headingFrame, north: session.north,
                headingSamples: session.headingSamples.map { RoomCaptureHeadingSample(headingDeg: $0.headingDeg, forward: mirror($0.forward)) },
                outline: RoomCaptureOutlineInput(
                    source: session.outline.source, worldCorners: session.outline.worldCorners.map(mirror),
                    closingTap: session.outline.closingTap.map(mirror)
                ),
                rooms: session.rooms.map { room in
                    RoomCaptureRoomInput(
                        id: room.id, label: room.label, labelSource: room.labelSource, floorIndex: room.floorIndex,
                        heightM: room.heightM, worldCorners: room.worldCorners.map(mirror),
                        closingTap: room.closingTap.map(mirror),
                        openings: room.openings.map {
                            RoomCaptureOpeningInput(kind: $0.kind, centerWorld: mirror($0.centerWorld), widthM: $0.widthM, heightM: $0.heightM, confidence: $0.confidence)
                        }
                    )
                },
                quality: session.quality
            )
            let capture = try RoomCaptureGeometry.buildRoomCapture(mirrored)
            XCTAssertNotEqual(capture.rooms[0].openings?[0].centerXY ?? [], [9.0, 1.0])
        }
    }

    func testNorthNeedsSamplesAndReportsAMagneticFrameWhenDeclinationIsUnknown() throws {
        XCTAssertThrowsError(try RoomCaptureGeometry.northRotation([], headingFrame: "magnetic", declinationDeg: 1.0))

        try withFixtures { fixtures in
            guard let magnetic = fixtures.first(where: { $0.name == "magnetic-frame.json" }) else {
                XCTFail("missing fixture")
                return
            }
            let magneticSession = RoomCaptureFixtures.parseSession(magnetic.json["session"] as! [String: Any])
            let magneticCapture = try RoomCaptureGeometry.buildRoomCapture(magneticSession)
            XCTAssertEqual(magneticCapture.frame.north.referenceFrame, "magnetic")

            // All six samples give a median of 2; dropping the two spikes gives 1.
            let samples = [0.0, 1.0, 2.0, 3.0, 100.0, 101.0].map { RoomCaptureHeadingSample(headingDeg: $0, forward: Vec3(x: 0, y: 0, z: -1)) }
            let r = try RoomCaptureGeometry.northRotation(samples, headingFrame: "true", declinationDeg: nil)
            XCTAssertEqual(r.thetaDeg, 1.0, accuracy: 1e-9)
            XCTAssertGreaterThan(r.compassConfidence, 0.9)

            guard let lShape = fixtures.first(where: { $0.name == "l-shape-traced.json" }) else {
                XCTFail("missing fixture")
                return
            }
            let lShapeSession = RoomCaptureFixtures.parseSession(lShape.json["session"] as! [String: Any])
            let lShapeCapture = try RoomCaptureGeometry.buildRoomCapture(lShapeSession)
            XCTAssertEqual(lShapeCapture.frame.north.yawSamples, 19)
        }
    }

    func testFloorMappingRoundingAndRingHelpers() {
        let plan = RoomCaptureGeometry.floorToPlan(Vec3(x: 2.0, y: -1.4, z: 3.0))
        XCTAssertEqual(plan.0, 2.0)
        XCTAssertEqual(plan.1, -3.0)
        XCTAssertEqual(RoomCaptureGeometry.roundHalfUp(0.125, 2), 0.13)
        XCTAssertEqual(RoomCaptureGeometry.roundHalfUp(-0.001, 2), 0.0)
        XCTAssertTrue(1.0 / RoomCaptureGeometry.roundHalfUp(-0.001, 2) > 0, "-0.0 must become +0.0, not stay a negative zero")
        XCTAssertEqual(
            RoomCaptureGeometry.simplifyRing([(0.0, 0.0), (1.0, 0.01), (2.0, 0.0), (2.0, 2.0), (0.0, 2.0), (0.0, 0.0)]).map { [$0.0, $0.1] },
            [[0.0, 0.0], [2.0, 0.0], [2.0, 2.0], [0.0, 2.0]]
        )
        XCTAssertEqual(
            RoomCaptureGeometry.canonicalRing([(0.0, 2.0), (2.0, 2.0), (2.0, 0.0), (0.0, 0.0)]).map { [$0.0, $0.1] },
            [[0.0, 0.0], [2.0, 0.0], [2.0, 2.0], [0.0, 2.0]]
        )
    }

    func testACaptureNeedsATracedOutline() throws {
        try withFixtures { fixtures in
            guard let fixture = fixtures.first(where: { $0.name == "room-3x4-yaw0.json" }) else {
                XCTFail("missing fixture")
                return
            }
            var session = RoomCaptureFixtures.parseSession(fixture.json["session"] as! [String: Any])
            session = RoomCaptureSession(
                captureId: session.captureId, capturedAtEpoch: session.capturedAtEpoch, device: session.device,
                headingFrame: session.headingFrame, north: session.north, headingSamples: session.headingSamples,
                outline: RoomCaptureOutlineInput(source: "union-of-rooms", worldCorners: [], closingTap: nil),
                rooms: session.rooms, quality: session.quality
            )
            XCTAssertThrowsError(try RoomCaptureGeometry.buildRoomCapture(session)) { error in
                XCTAssertTrue((error as? RoomCaptureError)?.message.contains("Trace the plot or house outline") ?? false)
            }
        }
    }
}
