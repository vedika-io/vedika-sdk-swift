import Foundation
import XCTest

@testable import VedikaSDK

/// N05 and N06 of the Vastu SDK audit: the RoomPlan path must not send a
/// density it did not measure, and must not bridge missing walls or report a
/// closed loop it did not see. RoomPlan itself cannot run on macOS, so the
/// chain and quality code are pure and are tested here.
final class RoomPlanWallChainTests: XCTestCase {

    private func p(_ x: Double, _ z: Double) -> Vec3 { Vec3(x: x, y: 0, z: z) }
    private func wall(_ x1: Double, _ z1: Double, _ x2: Double, _ z2: Double) -> RoomPlanWallSegment {
        RoomPlanWallSegment(start: p(x1, z1), end: p(x2, z2))
    }

    /// A clean 4 m by 3 m room, walls given as separate segments.
    private var cleanRoom: [RoomPlanWallSegment] {
        [wall(0, 0, 4, 0), wall(4, 0, 4, 3), wall(4, 3, 0, 3), wall(0, 3, 0, 0)]
    }

    private func build(_ trace: RoomPlanWallTrace, quality: RoomCaptureQualityInput = RoomPlanCaptureQuality.measured()) throws -> VastuRoomCapture {
        let samples = (0..<3).map { _ in RoomCaptureHeadingSample(headingDeg: 0, forward: Vec3(x: 0, y: 0, z: -1)) }
        let session = RoomCaptureSession(
            captureId: "t", capturedAtEpoch: 1,
            device: RoomCaptureDeviceInput(platform: "ios", method: "roomplan", depth: "lidar"),
            headingFrame: "true",
            north: RoomCaptureNorthInput(referenceFrame: "true", headingSource: "test", declinationDeg: 0, declinationProvenance: "test"),
            headingSamples: samples, outline: trace.outline,
            rooms: [RoomCaptureRoomInput(
                id: "room-1", label: "kitchen", labelSource: "user", floorIndex: 0, worldCorners: trace.corners,
                closingTap: trace.closingTap
            )],
            quality: quality
        )
        return try RoomCaptureGeometry.buildRoomCapture(session)
    }

    // MARK: N06

    func testTheAuditReplayKeepsEveryMeasuredEndAndReportsTheRealGap() throws {
        // The walls from the audit: three 1 m joins and a last end 1 m from the start.
        let walls = [wall(0, 0, 4, 0), wall(4, 1, 4, 4), wall(3, 4, 0, 4), wall(0, 3, 0, 1)]
        let trace = try RoomPlanWallChain.trace(walls)
        XCTAssertEqual(trace.joinGapsM, [1, 1, 1])
        XCTAssertEqual(trace.closureGapM, 1, accuracy: 1e-9)
        XCTAssertEqual(trace.closingTap, p(0, 1), "closing tap is the last measured wall end, not the first corner")
        XCTAssertEqual(trace.corners.count, 8, "no wall end may be skipped")
        let capture = try build(trace)
        XCTAssertEqual(capture.quality.closureGapM, 1.0)
        XCTAssertFalse(capture.quality.polygonClosure)
    }

    func testAHoleInTheMiddleOfTheLoopIsNotReportedAsClosed() throws {
        // Last wall ends exactly on the start, but the second join is open by 1.5 m.
        let walls = [wall(0, 0, 4, 0), wall(4, 0, 4, 3), wall(2.5, 3, 0, 3), wall(0, 3, 0, 0)]
        let trace = try RoomPlanWallChain.trace(walls)
        XCTAssertEqual(trace.closureGapM, 0, accuracy: 1e-9)
        XCTAssertEqual(trace.maxSeamGapM, 1.5, accuracy: 1e-9)
        let capture = try build(trace)
        XCTAssertEqual(capture.quality.closureGapM, 1.5)
        XCTAssertFalse(capture.quality.polygonClosure)
    }

    func testACleanRoomClosesWithAZeroMeasuredGap() throws {
        let trace = try RoomPlanWallChain.trace(cleanRoom)
        XCTAssertEqual(trace.corners.count, 4)
        XCTAssertEqual(trace.maxSeamGapM, 0, accuracy: 1e-9)
        let capture = try build(trace)
        XCTAssertEqual(capture.quality.closureGapM, 0.0)
        XCTAssertTrue(capture.quality.polygonClosure)
        XCTAssertEqual(capture.rooms[0].areaM2, 12.0, accuracy: 1e-9)
    }

    func testCentimetreJoinsSnapAndTheMeasuredClosureGapIsKept() throws {
        // 4 cm slop at two joins and 3 cm at the third: all within tolerance; the widest seam is reported.
        let walls = [wall(0, 0, 4, 0), wall(4.04, 0, 4, 3), wall(4, 3.04, 0, 3), wall(0.03, 3, 0, 0)]
        let trace = try RoomPlanWallChain.trace(walls)
        XCTAssertEqual(trace.corners.count, 4)
        XCTAssertEqual(trace.closureGapM, 0, accuracy: 1e-9)
        XCTAssertEqual(trace.maxSeamGapM, 0.04, accuracy: 1e-9)
        let capture = try build(trace)
        XCTAssertTrue(capture.quality.polygonClosure)
        XCTAssertEqual(try XCTUnwrap(capture.quality.closureGapM), 0.04, accuracy: 1e-9)
    }

    func testAMissingWallLeavesAnHonestlyOpenLoop() throws {
        // Three of four walls: the loop is open by the length of the missing wall.
        let walls = [wall(0, 0, 4, 0), wall(4, 0, 4, 3), wall(4, 3, 0, 3)]
        let trace = try RoomPlanWallChain.trace(walls)
        XCTAssertEqual(trace.closureGapM, 3, accuracy: 1e-9)
        let capture = try build(trace)
        XCTAssertEqual(capture.quality.closureGapM, 3.0)
        XCTAssertFalse(capture.quality.polygonClosure)
    }

    func testReversedSegmentsAndEveryWallOrderGiveTheSameLoop() throws {
        let reference = try RoomPlanWallChain.trace(cleanRoom)
        let referenceArea = try build(reference).rooms[0].areaM2
        let reversedWalls = cleanRoom.map { RoomPlanWallSegment(start: $0.end, end: $0.start) }
        var orders: [[RoomPlanWallSegment]] = [reversedWalls]
        for shift in 0..<4 { orders.append(Array(cleanRoom[shift...] + cleanRoom[..<shift])) }
        orders.append([cleanRoom[2], cleanRoom[0], cleanRoom[3], cleanRoom[1]])
        orders.append([reversedWalls[1], cleanRoom[3], reversedWalls[0], cleanRoom[2]])
        for walls in orders {
            let trace = try RoomPlanWallChain.trace(walls)
            XCTAssertEqual(trace.maxSeamGapM, 0, accuracy: 1e-9)
            XCTAssertEqual(trace.corners.count, 4)
            let capture = try build(trace)
            XCTAssertTrue(capture.quality.polygonClosure)
            XCTAssertEqual(capture.rooms[0].areaM2, referenceArea, accuracy: 1e-9)
        }
    }

    func testFewerThanThreeWallsIsRefused() {
        XCTAssertThrowsError(try RoomPlanWallChain.trace([wall(0, 0, 4, 0), wall(4, 0, 4, 3)]))
    }

    func testTappedOutlinesKeepTheirOriginalClosureGap() throws {
        // The shared outline-gap fixture has no maxSeamGapM, so its 0.3 m gap is untouched.
        guard let dir = RoomCaptureFixtures.directory else { return XCTFail("fixtures missing") }
        let fixture = try RoomCaptureFixtures.load(dir).first { $0.name == "outline-gap.json" }!
        let session = RoomCaptureFixtures.parseSession(fixture.json["session"] as! [String: Any])
        XCTAssertNil(session.outline.maxSeamGapM)
        XCTAssertEqual(try XCTUnwrap(try RoomCaptureGeometry.buildRoomCapture(session).quality.closureGapM), 0.3, accuracy: 1e-9)
    }

    // MARK: N05

    func testRoomPlanQualityNeverClaimsADensityItDidNotMeasure() throws {
        let quality = RoomPlanCaptureQuality.measured()
        XCTAssertEqual(quality.pointCloudDensityBasis, "none")
        XCTAssertNil(quality.pointCloudDensity)
        // The server rule (vastu_room_capture.rs): a density is sent exactly when the basis is not "none".
        XCTAssertEqual(quality.pointCloudDensity != nil, quality.pointCloudDensityBasis != "none")
        let capture = try build(try RoomPlanWallChain.trace(cleanRoom))
        XCTAssertEqual(capture.quality.pointCloudDensityBasis, "none")
        XCTAssertNil(capture.quality.pointCloudDensity)
        XCTAssertEqual(capture.quality.expectedRoomCount, 1)
    }
}
