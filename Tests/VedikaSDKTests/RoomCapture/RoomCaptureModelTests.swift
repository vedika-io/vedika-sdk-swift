import Foundation
import XCTest

@testable import VedikaSDK

/// Swift parity for the model-only scenarios in `RoomCaptureModelTest.kt`
/// (`sdks/android-ar/src/test/kotlin/io/vedika/sdk/ar/RoomCaptureModelTest.kt`),
/// itself parity for `web/vedika-public/js/vastu/__tests__/room-capture-webxr.test.mjs`
/// (the WebGL/DOM/XR-session driver half of that suite has no iOS analogue —
/// a real RoomPlan/ARKit capture controller is exercised on-device only, see
/// `sdks/ios-acceptance` instead).
final class RoomCaptureModelTests: XCTestCase {

    private final class Clock {
        private(set) var t: Int64
        init(start: Int64 = 1_000_000) { t = start }
        func now() -> Int64 { t }
        func advance(_ ms: Int64) { t += ms }
    }

    private func holdNorth(_ model: RoomCaptureModel, _ forward: Vec3, _ clock: Clock, samples: Int = 20, stepMs: Int64 = 200) {
        for _ in 0..<samples {
            model.addNorthSample(forward, at: clock.now())
            clock.advance(stepMs)
        }
    }

    private func withFixtures(_ block: ([(name: String, json: [String: Any])]) throws -> Void) throws {
        guard let dir = RoomCaptureFixtures.directory else {
            XCTFail("room-capture fixtures are neither in a monorepo checkout nor bundled with the test target")
            return
        }
        try block(try RoomCaptureFixtures.load(dir))
    }

    func testTapsReproduceEveryTracedFixturesOutlineAndRoomCornersExactly() throws {
        try withFixtures { fixtures in
            var checked = 0
            for fixture in fixtures {
                let sessionJson = fixture.json["session"] as! [String: Any]
                let outlineJson = sessionJson["outline"] as! [String: Any]
                guard (outlineJson["source"] as? String) == "traced" else { continue }
                let parsed = RoomCaptureFixtures.parseSession(sessionJson)
                let clock = Clock()
                let model = RoomCaptureModel("x", now: clock.now)
                for c in parsed.outline.worldCorners {
                    XCTAssertEqual(try model.tap(c), .added, fixture.name)
                }
                guard let closingTap = parsed.outline.closingTap, let first = parsed.outline.worldCorners.first else {
                    XCTFail("fixture missing outline closingTap/first corner")
                    continue
                }
                let snaps = hypot(closingTap.x - first.x, closingTap.z - first.z) <= RoomCaptureModel.closeSnapM
                if snaps {
                    XCTAssertEqual(try model.tap(closingTap), .closed, fixture.name)
                } else {
                    try model.closeAt(closingTap)
                }
                for room in parsed.rooms {
                    try model.startRoom(room.label)
                    for c in room.worldCorners { try model.tap(c) }
                    guard let roomClosingTap = room.closingTap else {
                        XCTFail("fixture room missing closingTap")
                        continue
                    }
                    try model.closeAt(roomClosingTap)
                }
                let northClock = Clock()
                holdNorth(model, Vec3(x: 0, y: 0, z: -1), northClock) // north is not what this test pins
                let built = try model.toSession(endedAt: northClock.now())
                XCTAssertEqual(parsed.outline.worldCorners, built.outline.worldCorners, fixture.name)
                XCTAssertEqual(parsed.outline.closingTap, built.outline.closingTap, fixture.name)
                XCTAssertEqual(parsed.rooms.count, built.rooms.count, fixture.name)
                for (i, r) in built.rooms.enumerated() {
                    XCTAssertEqual(parsed.rooms[i].worldCorners, r.worldCorners, "\(fixture.name) room \(i)")
                    XCTAssertEqual(parsed.rooms[i].closingTap, r.closingTap, "\(fixture.name) room \(i)")
                    XCTAssertEqual(parsed.rooms[i].label, r.label, "\(fixture.name) room \(i)")
                }
                checked += 1
            }
            XCTAssertGreaterThanOrEqual(checked, 5, "only \(checked) traced fixtures")
        }
    }

    /// A 4 m x 6 m house traced in AR world coordinates, with a kitchen in one corner.
    private func traceHouse(_ model: RoomCaptureModel, _ toWorld: (Double, Double) -> Vec3) throws {
        for (x, y) in [(0.0, 0.0), (4.0, 0.0), (4.0, 6.0), (0.0, 6.0)] { try model.tap(toWorld(x, y)) }
        XCTAssertEqual(try model.tap(toWorld(0.1, 0.1)), .closed)
        try model.startRoom("kitchen")
        for (x, y) in [(3.0, 5.0), (4.0, 5.0), (4.0, 6.0), (3.0, 6.0)] { try model.tap(toWorld(x, y)) }
        XCTAssertEqual(try model.tap(toWorld(3.05, 5.05)), .closed)
    }

    func testNorthSetByFacingItThatDirectionBecomesPlusYFrameIsManual() throws {
        // World where "north" is -Z: plan (x, y) sits at world (x, 0, -y).
        let clock = Clock()
        let model = RoomCaptureModel("n1", now: clock.now)
        try traceHouse(model) { x, y in Vec3(x: x, y: -1.4, z: -y) }
        holdNorth(model, Vec3(x: 0, y: -0.3, z: -1), clock)
        let capture = try model.build()
        XCTAssertEqual(capture.frame.north.referenceFrame, "manual")
        XCTAssertEqual(capture.frame.north.declinationProvenance, "manual")
        XCTAssertEqual(capture.outline.polygon, [[0.0, 0.0], [4.0, 0.0], [4.0, 6.0], [0.0, 6.0]])
        XCTAssertEqual(capture.rooms[0].polygon, [[3.0, 5.0], [4.0, 5.0], [4.0, 6.0], [3.0, 6.0]])
        XCTAssertEqual(capture.rooms[0].label, "kitchen")
        XCTAssertNil(capture.quality.pointCloudDensity)
        XCTAssertEqual(capture.device.method, "arkit-raycast")
    }

    func testTheSameHouseWithTheArWorldTurned90DegreesGivesTheSamePlan() throws {
        // Now north is world +X: plan (x, y) sits at world (y, 0, x).
        let clock = Clock()
        let model = RoomCaptureModel("n2", now: clock.now)
        try traceHouse(model) { x, y in Vec3(x: y, y: -1.4, z: x) }
        holdNorth(model, Vec3(x: 1, y: -0.2, z: 0), clock)
        let capture = try model.build()
        XCTAssertEqual(capture.outline.polygon, [[0.0, 0.0], [4.0, 0.0], [4.0, 6.0], [0.0, 6.0]])
        XCTAssertEqual(capture.rooms[0].polygon, [[3.0, 5.0], [4.0, 5.0], [4.0, 6.0], [3.0, 6.0]])
    }

    func testNorthNeedsEnoughSamplesOverEnoughTimeAndAClosedOutlineFirst() throws {
        let clock = Clock()
        let model = RoomCaptureModel("n3", now: clock.now)
        XCTAssertThrowsError(try model.toSession())
        try traceHouse(model) { x, y in Vec3(x: x, y: 0, z: -y) }
        holdNorth(model, Vec3(x: 0, y: 0, z: -1), clock, samples: RoomCaptureModel.minNorthSamples - 1, stepMs: 400)
        XCTAssertFalse(model.northReady)
        XCTAssertThrowsError(try model.toSession())
        model.resetNorth()
        holdNorth(model, Vec3(x: 0, y: 0, z: -1), clock, samples: RoomCaptureModel.minNorthSamples + 5, stepMs: RoomCaptureModel.minNorthMs / 40)
        XCTAssertFalse(model.northReady)
        model.resetNorth()
        holdNorth(model, Vec3(x: 0, y: 0, z: -1), clock)
        XCTAssertTrue(model.northReady)
    }

    func testARoomStillBeingTracedBlocksFinishAndBlocksStartingAnother() throws {
        let clock = Clock()
        let model = RoomCaptureModel("n4", now: clock.now)
        try traceHouse(model) { x, y in Vec3(x: x, y: 0, z: -y) }
        holdNorth(model, Vec3(x: 0, y: 0, z: -1), clock)
        try model.startRoom("pooja")
        try model.tap(Vec3(x: 0, y: 0, z: 0))
        XCTAssertThrowsError(try model.toSession())
        XCTAssertTrue(model.undo())
        XCTAssertEqual(model.currentRoom?.corners, 0)
        XCTAssertThrowsError(try model.startRoom("toilet"))
    }

    func testClosingNeedsThreeCornersAFarTapAddsACornerInstead() throws {
        let model = RoomCaptureModel("n5")
        try model.tap(Vec3(x: 0, y: 0, z: 0))
        try model.tap(Vec3(x: 1, y: 0, z: 0))
        XCTAssertEqual(try model.tap(Vec3(x: 0.05, y: 0, z: 0)), .added) // only two corners before it, so no snap
        XCTAssertThrowsError(try RoomCaptureModel("n6").closeAt(Vec3(x: 0, y: 0, z: 0)))
    }

    func testEveryOfferedRoomNameIsOneTheServerRecognises() throws {
        // Mirrors normalize_room_type in ported/vastu.rs.
        let known = try NSRegularExpression(pattern:
            "kitchen|cooking|master|pooja|puja|mandir|prayer|toilet|bath|living|hall|drawing|dining|" +
            "treasury|granary|locker|vault|storage|store|study|stair|entrance|door|entry|guest|children|kid|bed"
        )
        for label in RoomCaptureModel.roomLabels {
            let cleaned = label.lowercased().unicodeScalars.filter { CharacterSet.letters.contains($0) }.map(String.init).joined()
            let range = NSRange(cleaned.startIndex..<cleaned.endIndex, in: cleaned)
            XCTAssertNotNil(known.firstMatch(in: cleaned, range: range), label)
        }
    }
}
