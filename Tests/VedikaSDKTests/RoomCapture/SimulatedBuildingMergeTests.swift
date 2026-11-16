import Foundation
import XCTest

@testable import VedikaSDK

/// Swift parity for `SimulatedBuildingMergeTest.kt`: a three-storey house
/// scanned one floor at a time through `RoomCaptureModel`, each floor with its
/// own floor index and its own phone start and heading, then tied together in
/// `FloorMergeSession` with the same stair and lift corners picked on each
/// plan. The upper floors overhang the ground floor (1 m west, 0.8 m south), so
/// each plan sits in its own frame and the picks must carry a real offset.
/// Before the model took a floor index, every scan recorded floor 0 and
/// `FloorMerge` refused the second floor as the same floor.
final class SimulatedBuildingMergeTests: XCTestCase {

    private struct Rect {
        let label: String; let x0: Double; let y0: Double; let x1: Double; let y1: Double
        var corners: [(Double, Double)] { [(x0, y0), (x1, y0), (x1, y1), (x0, y1)] }
    }

    private struct Floor {
        let index: Int; let elevationM: Double; let startEast: Double; let startNorth: Double; let worldYawDeg: Double
        let rooms: [Rect]
        let outline: [(Double, Double)]
        var min: (Double, Double) { (outline.map { $0.0 }.min()!, outline.map { $0.1 }.min()!) }
    }
    private let stair = Rect(label: "staircase", x0: -5, y0: -4, x1: -3, y1: -1.5)
    private let lift: [(Double, Double)] = [(-3, -4), (-1.5, -4), (-1.5, -2.5), (-3, -2.5)]
    private let shared: [(Double, Double)] = [(-5, -4), (-3, -1.5), (-1.5, -4), (-1.5, -2.5)]
    private let scatter: [(Double, Double)] = [(0.006, 0.004), (-0.005, 0.007), (0.004, 0.005), (-0.006, -0.003)]

    private var floors: [Floor] {
        [
            Floor(index: 0, elevationM: 0, startEast: 0, startNorth: 0, worldYawDeg: 0, rooms: [
                stair, Rect(label: "kitchen", x0: 2, y0: -4, x1: 5, y1: -1), Rect(label: "pooja", x0: 2, y0: 1.5, x1: 5, y1: 4),
                Rect(label: "living room", x0: -5, y0: 1, x1: -1, y1: 4),
            ], outline: [(-5, -4), (5, -4), (5, 4), (-5, 4)]),
            Floor(index: 1, elevationM: 3, startEast: 2.3, startNorth: -1.7, worldYawDeg: 25, rooms: [
                stair, Rect(label: "master bedroom", x0: -1.45, y0: -4, x1: 2, y1: -0.5), Rect(label: "bedroom", x0: -5, y0: 1, x1: -1, y1: 4),
                Rect(label: "study", x0: 2, y0: 1.5, x1: 5, y1: 4),
            ], outline: [(-6, -4), (5, -4), (5, 4), (-6, 4)]),
            Floor(index: 2, elevationM: 6, startEast: -3.1, startNorth: 2.2, worldYawDeg: -40, rooms: [
                stair, Rect(label: "bedroom", x0: 2, y0: -4, x1: 5, y1: -1), Rect(label: "toilet", x0: 2, y0: 1.5, x1: 5, y1: 4),
                Rect(label: "living room", x0: -5, y0: 1, x1: -1, y1: 4),
            ], outline: [(-5, -4.8), (5, -4.8), (5, 4), (-5, 4)]),
        ]
    }

    private func rotate(_ v: Vec3, _ yawDeg: Double) -> Vec3 {
        let a = yawDeg * .pi / 180
        return Vec3(x: v.x * cos(a) - v.z * sin(a), y: v.y, z: v.x * sin(a) + v.z * cos(a))
    }

    private func world(_ f: Floor, _ x: Double, _ y: Double) -> Vec3 {
        rotate(Vec3(x: x - f.startEast, y: -1.4, z: -(y - f.startNorth)), f.worldYawDeg)
    }

    private func scan(_ f: Floor, floorIndex: Int? = nil) throws -> VastuRoomCapture {
        var t: Int64 = 1_794_100_000_000 + Int64(f.index) * 3_600_000
        let model = RoomCaptureModel("sim-building-f\(f.index)", now: { t }, floorIndex: floorIndex ?? f.index)
        for (x, y) in f.outline { try model.tap(world(f, x, y)) }
        XCTAssertEqual(try model.tap(world(f, f.outline[0].0 + 0.02, f.outline[0].1 + 0.02)), .closed)
        for room in f.rooms {
            try model.startRoom(room.label)
            for (x, y) in room.corners { try model.tap(world(f, x, y)) }
            XCTAssertEqual(try model.tap(world(f, room.corners[0].0 + 0.02, room.corners[0].1 + 0.02)), .closed, room.label)
            t += 20_000
        }
        let north = rotate(Vec3(x: 0, y: -0.3, z: -1), f.worldYawDeg)
        for _ in 0..<20 { model.addNorthSample(north, at: t); t += 200 }
        return try model.build(device: RoomCaptureDeviceInput(platform: "ios", method: "manual-trace", depth: "none"), endedAt: t)
    }

    /// Design point (x, y) in a capture's own plan frame: north-corrected, so a translation only.
    private func inCapture(_ c: VastuRoomCapture, _ p: (Double, Double)) -> FloorPoint {
        let ring = c.outline.polygon
        let (mx, my) = floors.first { "sim-building-f\($0.index)" == c.captureId }!.min
        return FloorPoint(x: p.0 + ring.map { $0[0] }.min()! - mx, y: p.1 + ring.map { $0[1] }.min()! - my)
    }

    private func session(_ captures: [VastuRoomCapture], misreadEastM: Double = 0) throws -> FloorMergeSession {
        let session = FloorMergeSession()
        for (i, c) in captures.enumerated() { try session.addFloor(c, elevationM: floors[i].elevationM) }
        for upper in captures.dropFirst() {
            try session.setKind(.stair, captureId: upper.captureId)
            for (i, p) in shared.enumerated() {
                let next = inCapture(upper, p)
                try session.addPick(
                    captureId: upper.captureId, reference: inCapture(captures[0], p),
                    next: FloorPoint(x: next.x + scatter[i].0 + (i == 1 ? misreadEastM : 0), y: next.y + scatter[i].1)
                )
            }
        }
        return session
    }

    private func worstGap(_ ring: [[Double]], _ shift: [Double], _ target: [[Double]]) -> Double {
        ring.map { p in target.map { q in hypot(p[0] + shift[0] - q[0], p[1] + shift[1] - q[1]) }.min()! }.max()!
    }

    func testEachFloorScanRecordsItsOwnFloorIndex() throws {
        for f in floors {
            let c = try scan(f)
            XCTAssertEqual(Set(c.rooms.map(\.floorIndex)), [f.index])
            XCTAssertEqual(c.rooms.count, f.rooms.count)
        }
        for bad in [-4, 10] {
            XCTAssertThrowsError(try scan(floors[0], floorIndex: bad))
        }
    }

    func testScansWithoutTheirOwnFloorIndexAreRefusedNotRelabelled() throws {
        let unindexed = try floors.prefix(2).map { try scan($0, floorIndex: 0) }
        XCTAssertThrowsError(try session(unindexed).prepare()) { error in
            XCTAssertEqual((error as? FloorMergeRefused)?.reason, .duplicateFloorIndex, "\(error)")
        }
    }

    func testThreeFloorsStackOnTheStairAndLiftWithAStatedError() throws {
        let captures = try floors.map { try scan($0) }
        let session = try session(captures)
        XCTAssertTrue(session.canMerge, session.status)
        let prepared = try session.prepare()
        let body = prepared.request.dictionary
        let sentCaptures = try XCTUnwrap(body["captures"] as? [[String: Any]])
        XCTAssertEqual(sentCaptures.map { $0["floorIndex"] as? Int }, [0, 1, 2])
        XCTAssertEqual((body["links"] as? [Any])?.count, 0)
        let frames = try XCTUnwrap(body["floors"] as? [[String: Any]])
        XCTAssertEqual(frames.map { $0["elevationM"] as? Double }, [0, 3, 6])

        let groundStair = try XCTUnwrap(captures[0].rooms.first { $0.label == "staircase" }).polygon
        let groundLift = lift.map { inCapture(captures[0], $0) }
        let (gx, gy) = floors[0].min
        for k in 1...2 {
            let origin = try XCTUnwrap(frames[k]["originXY"] as? [Double])
            let (ex, ey) = (floors[k].min.0 - gx, floors[k].min.1 - gy)
            XCTAssertLessThanOrEqual(hypot(origin[0] - ex, origin[1] - ey), 0.01, "floor \(k) origin \(origin) vs designed (\(ex), \(ey))")
            XCTAssertGreaterThanOrEqual(hypot(origin[0], origin[1]), 0.5, "floor \(k) needs a real offset")
            let stairK = try XCTUnwrap(captures[k].rooms.first { $0.label == "staircase" }).polygon
            XCTAssertLessThanOrEqual(worstGap(stairK, origin, groundStair), 0.01, "floor \(k) stair")
            let liftGap = zip(lift.map { inCapture(captures[k], $0) }, groundLift)
                .map { hypot($0.x + origin[0] - $1.x, $0.y + origin[1] - $1.y) }.max()!
            XCTAssertLessThanOrEqual(liftGap, 0.01, "floor \(k) lift")
            let designed = floors[k].outline.map { [$0.0 - gx, $0.1 - gy] }
            XCTAssertLessThanOrEqual(worstGap(captures[k].outline.polygon, origin, designed), 0.01, "floor \(k) outline")
        }
        let reg = prepared.registration
        XCTAssertEqual(reg.pairResiduals.count, 2)
        XCTAssertTrue(reg.rmsResidualM > 0 && reg.rmsResidualM < 0.02, "\(reg.rmsResidualM)")
        XCTAssertLessThanOrEqual(reg.maxResidualM, FloorMerge.defaultToleranceM)
    }

    func testAMisreadStairPickIsRefusedBeforeAnyRequest() throws {
        let captures = try floors.map { try scan($0) }
        XCTAssertThrowsError(try session(captures, misreadEastM: 0.5).prepare()) { error in
            XCTAssertEqual((error as? FloorMergeRefused)?.reason, .errorAboveTolerance, "\(error)")
        }
    }
}
