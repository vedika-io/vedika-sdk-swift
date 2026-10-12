import XCTest
@testable import VedikaRoomCapture

final class RelocalizationTests: XCTestCase {
    func testRefusesUntilAnchorsAndReprojectionMatchThenRevokesOnLoss() {
        let anchor = UUID(); let expected: Set<UUID> = [anchor]
        var gate = OverlayRelocalizationGate()
        XCTAssertFalse(gate.overlaysAllowed)
        XCTAssertFalse(gate.observe(trackingNormal: true, expectedAnchorIds: expected, restoredAnchorIds: [], reprojectionErrorsPixels: [0]))
        XCTAssertFalse(gate.observe(trackingNormal: false, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [0]))
        for bad in [Double.nan, Double.infinity, -1, 8.1] {
            XCTAssertFalse(gate.observe(trackingNormal: true, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [bad]))
        }
        XCTAssertFalse(gate.observe(trackingNormal: true, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [2]))
        XCTAssertFalse(gate.observe(trackingNormal: true, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [2]))
        XCTAssertTrue(gate.observe(trackingNormal: true, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [2]))
        XCTAssertFalse(gate.observe(trackingNormal: false, expectedAnchorIds: expected, restoredAnchorIds: expected, reprojectionErrorsPixels: [2]))
        XCTAssertFalse(gate.overlaysAllowed)
    }
}

extension RelocalizationTests {
    private func pose(yaw: Double = 0, x: Double = 0, y: Double = 0, z: Double = 0) throws -> FloorAnchorPose {
        let c = cos(yaw), s = sin(yaw)
        return try FloorAnchorPose(columns: [c, 0, -s, 0, 0, 1, 0, 0, s, 0, c, 0, x, y, z, 1])
    }
    private func assertPoint(_ actual: SIMD3<Double>, _ expected: SIMD3<Double>, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(actual.x, expected.x, accuracy: 1e-8, file: file, line: line)
        XCTAssertEqual(actual.y, expected.y, accuracy: 1e-8, file: file, line: line)
        XCTAssertEqual(actual.z, expected.z, accuracy: 1e-8, file: file, line: line)
    }
    func testPlanToAnchorUsesCaptureOriginAndNorthAxes() throws {
        let original = try pose(yaw: .pi / 2, x: 10, y: 2, z: 20)
        let transform = try FloorPlanAnchorTransform(origin: [12, 2, 18], xAxis: [0, 0, -1], yAxis: [-1, 0, 0], originalAnchor: original)
        let local = try transform.anchorPoint(east: 3, north: 4)
        assertPoint(original.worldPoint(local), SIMD3(8, 2, 15))
        // Saved anchor-local point survives a changed world origin/rotation.
        let restored = try pose(yaw: 0, x: -5, y: 1, z: 7)
        assertPoint(restored.worldPoint(local), SIMD3(0, 1, 5))
        // A genuine fault control: reusing capture-world vertices on restore
        // differs by metres from the correctly bound anchor point.
        XCTAssertGreaterThan(abs(original.worldPoint(local).x - restored.worldPoint(local).x), 1)
    }
    func testContinuousCameraMovementCannotMovePinnedFloor() throws {
        let anchor = try pose(yaw: .pi / 3, x: 4, y: 0.7, z: -8)
        let transform = try FloorPlanAnchorTransform(origin: [2, 0.7, -3], xAxis: [1, 0, 0], yAxis: [0, 0, -1], originalAnchor: anchor)
        let local = try transform.anchorPoint(east: 1.5, north: 2.5)
        let expected = SIMD3(3.5, 0.7, -5.5)
        for step in 0..<120 {
            let camera = try pose(yaw: Double(step) * .pi / 60, x: Double(step) / 40, y: 1.6, z: Double(step) / 50)
            let screenSpace = camera.localPoint(anchor.worldPoint(local))
            assertPoint(camera.worldPoint(screenSpace), expected)
            assertPoint(anchor.worldPoint(local), expected)
            if step > 0 { XCTAssertNotEqual(screenSpace, local) } // camera-parented negative
        }
    }
    func testTrackingLossStalePoseAndNorthResetHideImmediately() {
        let session = UUID(), north = UUID()
        var guardState = FloorOverlayTrackingGuard(sessionId: session, northRevision: north)
        func observe(_ timestamp: Double?, _ now: Double, _ normal: Bool = true,
                     _ present: Bool = true, _ reused: Bool = true,
                     _ sessionId: UUID? = nil, _ revision: UUID? = nil) -> Bool {
            guardState.observe(timestamp: timestamp, now: now, trackingNormal: normal,
                anchorPresent: present, relocalized: reused, sessionId: sessionId ?? session, northRevision: revision ?? north)
        }
        XCTAssertTrue(observe(1, 1.01))
        XCTAssertFalse(observe(1.02, 1.03, false)); XCTAssertFalse(guardState.overlaysAllowed)
        XCTAssertFalse(observe(1.04, 1.05, true, true, false)) // recovery must pass map gate again
        XCTAssertTrue(observe(1.06, 1.07))
        XCTAssertFalse(observe(1.06, 1.08)) // duplicate
        XCTAssertFalse(observe(1.05, 1.08)) // reordered
        XCTAssertFalse(observe(1.1, 1.35)) // 250ms stale boundary
        XCTAssertFalse(observe(2, 1.4)) // future pose
        XCTAssertFalse(observe(nil, 1.4))
        XCTAssertFalse(observe(.nan, 1.4))
        XCTAssertFalse(observe(1.4, .infinity))
        XCTAssertFalse(observe(1.4, 1.41, true, false))
        XCTAssertFalse(observe(1.4, 1.41, true, true, true, UUID()))
        XCTAssertFalse(observe(1.4, 1.41, true, true, true, nil, UUID()))
        XCTAssertFalse(guardState.overlaysAllowed)
        guardState.reset(); XCTAssertFalse(guardState.overlaysAllowed)
        XCTAssertTrue(observe(1.42, 1.43))
    }
    func testMapIdentityChangeAndRepeatedFramesCannotQualifyReuse() {
        var gate = OverlayRelocalizationGate()
        let first: Set<UUID> = [UUID()], second: Set<UUID> = [UUID()]
        func observe(_ ids: Set<UUID>, _ time: Double) -> Bool {
            gate.observe(trackingNormal: true, expectedAnchorIds: ids, restoredAnchorIds: ids,
                         reprojectionErrorsPixels: [8], frameTimestamp: time)
        }
        XCTAssertFalse(observe(first, 1)); XCTAssertFalse(observe(first, 2))
        XCTAssertFalse(observe(second, 3)); XCTAssertFalse(observe(second, 4))
        XCTAssertFalse(observe(second, 4)); XCTAssertFalse(observe(second, 4))
        XCTAssertFalse(observe(second, 5)); XCTAssertFalse(observe(second, 6))
        XCTAssertTrue(observe(second, 7))
        XCTAssertFalse(observe(second, 7)); XCTAssertFalse(gate.overlaysAllowed)
        XCTAssertFalse(observe(second, 8)); XCTAssertFalse(observe(second, 9))
        XCTAssertTrue(observe(second, 10))
        XCTAssertFalse(gate.observe(trackingNormal: false, expectedAnchorIds: second, restoredAnchorIds: second,
            reprojectionErrorsPixels: [0], frameTimestamp: 11))
        XCTAssertFalse(observe(second, 12)); XCTAssertFalse(observe(second, 13))
        XCTAssertTrue(observe(second, 14))
    }
    func testInvalidTransformsAndPlanGeometryRefuse() throws {
        let identity = try pose()
        for columns in [[Double](), Array(repeating: 0.0, count: 16), [Double.nan] + Array(identity.columns.dropFirst())] {
            XCTAssertThrowsError(try FloorAnchorPose(columns: columns))
        }
        var mirrored = identity.columns; mirrored[0] = -1
        XCTAssertThrowsError(try FloorAnchorPose(columns: mirrored))
        for axes in [([2.0, 0, 0], [0.0, 0, -1]), ([1.0, 0, 0], [1.0, 0, 0]), ([1.0, 0, 0], [0.0, 0, 1])] {
            XCTAssertThrowsError(try FloorPlanAnchorTransform(origin: [0, 0, 0], xAxis: axes.0, yAxis: axes.1, originalAnchor: identity))
        }
        XCTAssertThrowsError(try FloorPlanAnchorTransform(origin: [0, 0, 0], xAxis: [1, 0, 0], yAxis: [0, 0, -1], originalAnchor: identity, units: "feet"))
        let transform = try FloorPlanAnchorTransform(origin: [0, 0, 0], xAxis: [1, 0, 0], yAxis: [0, 0, -1], originalAnchor: identity)
        XCTAssertThrowsError(try transform.anchorPoint(east: .nan, north: 0))
        XCTAssertThrowsError(try FloorOverlayPolygon(label: "N", points: []))
        XCTAssertThrowsError(try FloorOverlayPolygon(label: "N", points: [SIMD2(0, 0), SIMD2(1, 1), SIMD2(2, 2)]))
        XCTAssertThrowsError(try FloorOverlayPolygon(label: "N", points: Array(repeating: SIMD2(0, 0), count: 3)))
        XCTAssertNoThrow(try FloorOverlayPolygon(label: "N", points: [SIMD2(0, 0), SIMD2(1, 0), SIMD2(0, 1)]))
    }
}

extension RelocalizationTests {
    func testEightZonePolygonsAndMandalaShareTheFloorAnchor() throws {
        let anchor = try pose(yaw: .pi / 4, x: 3, y: 0.2, z: -7)
        let transform = try FloorPlanAnchorTransform(origin: [3, 0.2, -7], xAxis: [1, 0, 0], yAxis: [0, 0, -1], originalAnchor: anchor)
        // Geometry-only fixture, NOT astrological advice or physical evidence.
        let zones = try (0..<8).map { index -> FloorOverlayPolygon in
            let a = Double(index) * .pi / 4, b = Double(index + 1) * .pi / 4
            return try FloorOverlayPolygon(label: "zone-\(index)", points: [SIMD2(0, 0), SIMD2(cos(a) * 2, sin(a) * 2), SIMD2(cos(b) * 2, sin(b) * 2)])
        }
        let mandala = try FloorOverlayPolygon(label: "mandala", points: [SIMD2(-1, -1), SIMD2(1, -1), SIMD2(1, 1), SIMD2(-1, 1)])
        XCTAssertEqual(zones.count, 8)
        for polygon in zones + [mandala] {
            for point in polygon.points {
                let local = try transform.anchorPoint(east: point.x, north: point.y)
                assertPoint(anchor.worldPoint(local), SIMD3(3 + point.x, 0.2, -7 - point.y))
            }
        }
    }
}
