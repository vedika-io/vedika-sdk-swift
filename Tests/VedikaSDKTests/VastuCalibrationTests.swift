import XCTest
@testable import VedikaSDK

final class VastuCalibrationTests: XCTestCase {
    func testSensorQualityPreservesZeroAndOmittedUnknownValues() {
        let missing = VastuArTrueNorthCalibrateRequest(lat: 28.6, lon: 77.2, datetime: "2026-06-21T03:30:00Z", deviceHeadingAtSunDeg: 70).dictionary
        XCTAssertNil(missing["deviceHeadingAccuracyDeg"])
        XCTAssertNil(missing["headingSampleAgeMs"])
        let known = VastuArTrueNorthCalibrateRequest(lat: 28.6, lon: 77.2, datetime: "2026-06-21T03:30:00Z", deviceHeadingAtSunDeg: 70, deviceHeadingAccuracyDeg: 3, headingSampleAgeMs: 0).dictionary
        XCTAssertEqual(known["deviceHeadingAccuracyDeg"] as? Double, 3)
        XCTAssertEqual(known["headingSampleAgeMs"] as? Double, 0)
    }
}
