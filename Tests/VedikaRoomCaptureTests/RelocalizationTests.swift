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
