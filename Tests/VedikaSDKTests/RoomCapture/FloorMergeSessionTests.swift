import XCTest

@testable import VedikaSDK

/// `FloorMergeSession` collects floors and picked shared points for a "merge floors"
/// entry and hands them to `FloorMerge`. No network is used.
final class FloorMergeSessionTests: XCTestCase {
    private let square: [[Double]] = [[0, 0], [6, 0], [6, 5], [0, 5]]
    private func capture(_ id: String, floor: Int, referenceFrame: String = "true", closed: Bool = true) -> VastuRoomCapture {
        VastuRoomCapture(
            schema: "vedika.roomCapture/1", captureId: id, capturedAtEpoch: 1_789_000_000,
            device: VastuRoomCaptureDevice(platform: "ios", method: "arkit-hit", depth: "none"),
            frame: VastuRoomCaptureFrame(
                units: "metres", axes: "+X east,+Y true north",
                north: VastuRoomCaptureFrameNorth(
                    referenceFrame: referenceFrame, headingSource: "arkit-true-heading", declinationProvenance: "fixture",
                    yawSamples: 17, compassConfidence: 0.9)),
            outline: VastuRoomCaptureOutline(polygon: square),
            rooms: [VastuRoomCaptureRoomsItem(id: "r-\(id)", label: "kitchen", labelSource: "user", polygon: square, areaM2: 30, floorIndex: floor)],
            quality: VastuRoomCaptureQuality(polygonClosure: closed, pointCloudDensityBasis: "none", roomCount: 1, roomsTagged: 1),
            attestation: "caller-reported")
    }

    /// Stair points: the same horizontal spot, shifted on the upper plan by (dx, dy).
    private func stairs(dx: Double = -1.2, dy: Double = -0.4, noise: Double = 0) -> [SharedFloorPoint] {
        [
            SharedFloorPoint(reference: FloorPoint(x: 2, y: 1), next: FloorPoint(x: 2 + dx, y: 1 + dy)),
            SharedFloorPoint(reference: FloorPoint(x: 2, y: 3), next: FloorPoint(x: 2 + dx, y: 3 + dy + noise)),
            SharedFloorPoint(reference: FloorPoint(x: 4, y: 2), next: FloorPoint(x: 4 + dx, y: 2 + dy)),
        ]
    }

    private func twoFloors(points: [SharedFloorPoint]? = nil, toleranceM: Double = 0.05, kind: FloorLinkKind = .stair) -> FloorMergeInput {
        FloorMergeInput(
            scans: [FloorScan(capture: capture("ground", floor: 0), elevationM: 0), FloorScan(capture: capture("first", floor: 1), elevationM: 3.2)],
            links: [FloorLink(toCaptureId: "first", kind: kind, points: points ?? stairs())],
            toleranceM: toleranceM)
    }

    private func assertRefused(_ expected: FloorMergeRefusal, _ input: FloorMergeInput, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertThrowsError(try FloorMerge.prepare(input), file: file, line: line) { error in
            XCTAssertEqual((error as? FloorMergeRefused)?.reason, expected, "\(error)", file: file, line: line)
        }
    }

    // MARK: the entry flow

    private func session() throws -> FloorMergeSession {
        let s = FloorMergeSession()
        try s.addFloor(capture("ground", floor: 0), elevationM: 0)
        try s.addFloor(capture("first", floor: 1), elevationM: 3.2)
        return s
    }

    func testOneFloorCannotMergeAndTheScreenSaysWhatToDo() throws {
        let s = FloorMergeSession()
        try s.addFloor(capture("ground", floor: 0), elevationM: 0)
        XCTAssertFalse(s.canMerge)
        XCTAssertTrue(s.status.hasPrefix("Scan a second floor"))
        assertRefused(.tooFewFloors, s.input())
    }

    func testThreePairsOnTheSecondFloorUnlockTheMerge() throws {
        let s = try session()
        XCTAssertFalse(s.canMerge)
        XCTAssertEqual(s.pairsStillNeeded(captureId: "first"), 3)
        for p in stairs().prefix(2) { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        XCTAssertFalse(s.canMerge)
        XCTAssertEqual(s.pairsStillNeeded(captureId: "first"), 1)
        XCTAssertTrue(s.status.contains("pick 1 more"))
        for p in stairs().dropFirst(2) { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        XCTAssertTrue(s.canMerge)
        XCTAssertTrue(s.status.hasPrefix("Ready: 2 floors linked"))
    }

    func testTheSessionBuildsTheSameRequestAsTheDirectCall() throws {
        let s = try session()
        for p in stairs() { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        let viaSession = try s.prepare(maxChargeUsd: "0.50")
        var direct = twoFloors()
        direct.maxChargeUsd = "0.50"
        let expected = try FloorMerge.prepare(direct)
        XCTAssertEqual(viaSession.registration, expected.registration)
        XCTAssertEqual(viaSession.request.captures.map { $0.id }, expected.request.captures.map { $0.id })
        XCTAssertEqual(viaSession.request.floors.map { $0.originXY }, expected.request.floors.map { $0.originXY })
    }

    func testABadLinkIsRefusedByTheSharedValidatorBeforeAnyRequest() throws {
        let s = try session()
        for p in stairs(noise: 0.9) { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        XCTAssertTrue(s.canMerge)
        assertRefused(.errorAboveTolerance, s.input())
    }

    func testUndoRemovesTheLastPickAndRemovingAFloorDropsItsPicks() throws {
        let s = try session()
        for p in stairs() { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        s.undoPick(captureId: "first")
        XCTAssertEqual(s.pickCount(captureId: "first"), 2)
        s.removeLastFloor()
        XCTAssertEqual(s.floorCount, 1)
        XCTAssertEqual(s.pickCount(captureId: "first"), 0)
        XCTAssertThrowsError(try s.addPick(captureId: "first", reference: FloorPoint(x: 1, y: 1), next: FloorPoint(x: 1, y: 1)))
    }

    func testTheSameScanTwiceAPickOnTheReferenceFloorAndANonFiniteHeightAreRejected() throws {
        let s = try session()
        XCTAssertThrowsError(try s.addFloor(capture("first", floor: 1), elevationM: 6.4)) {
            XCTAssertEqual($0 as? FloorMergeSession.SessionError, .duplicateScan)
        }
        XCTAssertThrowsError(try s.addPick(captureId: "ground", reference: FloorPoint(x: 1, y: 1), next: FloorPoint(x: 1, y: 1)))
        XCTAssertThrowsError(try s.addFloor(capture("second", floor: 2), elevationM: .nan)) {
            XCTAssertEqual($0 as? FloorMergeSession.SessionError, .badElevation)
        }
    }

    func testDoorKindIsCarriedToTheLink() throws {
        let s = try session()
        for p in stairs() { try s.addPick(captureId: "first", reference: p.reference, next: p.next) }
        try s.setKind(.door, captureId: "first")
        XCTAssertEqual(s.input().links.first?.kind, .door)
    }
}
