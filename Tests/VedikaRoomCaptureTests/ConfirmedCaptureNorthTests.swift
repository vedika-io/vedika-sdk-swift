import XCTest
import VedikaSDK
@testable import VedikaRoomCapture

final class ConfirmedCaptureNorthTests: XCTestCase {
    private var samples: [RoomCaptureHeadingSample] {
        (0..<RoomCaptureModel.minNorthSamples).map { _ in
            RoomCaptureHeadingSample(headingDeg: 0, forward: Vec3(x: 0, y: 0, z: -1))
        }
    }
    func testConfirmedNorthUsesContractProvenance() throws {
        for value in ["live", "manual", "native", "fixture"] {
            let north = try ConfirmedCaptureNorth(magneticSamples: samples, declinationDeg: 0,
                provenance: value, userConfirmed: true)
            XCTAssertEqual(north.provenance, value)
        }
        for value in ["", "unset", "synthetic-fixture", "synthetic-fixture-replay",
                      "vedika-direction-declination:2025:2026-10-04"] {
            XCTAssertThrowsError(try ConfirmedCaptureNorth(magneticSamples: samples, declinationDeg: 0,
                provenance: value, userConfirmed: true))
        }
    }
}
