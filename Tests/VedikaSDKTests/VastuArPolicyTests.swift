import XCTest
@testable import VedikaSDK

final class VastuArPolicyTests: XCTestCase {
    func testARTrustIncludesOriginAndExactBundledFile() {
        let target = URL(string: "https://vedika.io/vastu-ar/")!
        XCTAssertTrue(VastuArPolicy.trustedPage(URL(string: "https://vedika.io:443/other"), expected: target))
        for value in ["http://vedika.io/", "https://vedika.io:8443/", "https://evil.example/", "https://user@vedika.io/", "file:///index.html"] {
            XCTAssertFalse(VastuArPolicy.trustedPage(URL(string: value), expected: target), value)
        }
        let file = URL(fileURLWithPath: "/bundle/index.html")
        XCTAssertTrue(VastuArPolicy.trustedPage(file, expected: file))
        XCTAssertFalse(VastuArPolicy.trustedPage(URL(fileURLWithPath: "/other/index.html"), expected: file))
        XCTAssertFalse(VastuArPolicy.trustedPage(nil, expected: target))
    }

    func testLocationDenialKeepsMagneticHeadingUpdates() {
        let denied = VastuArPolicy.updates(active: true, hasCompass: true, locationAuthorized: false)
        XCTAssertTrue(denied.heading)
        XCTAssertFalse(denied.location)
        let allowed = VastuArPolicy.updates(active: true, hasCompass: true, locationAuthorized: true)
        XCTAssertTrue(allowed.heading)
        XCTAssertTrue(allowed.location)
        let stopped = VastuArPolicy.updates(active: false, hasCompass: true, locationAuthorized: true)
        XCTAssertFalse(stopped.heading)
        XCTAssertFalse(stopped.location)
        XCTAssertFalse(VastuArPolicy.updates(active: true, hasCompass: false, locationAuthorized: false).heading)
    }

    func testHeadingTracksEachInterfaceOrientationWithoutGuessingUnknown() {
        // UIKit UIOrientation.h reverses the landscape names: interface-left
        // is raw 4, the physical Core Location landscape-right orientation.
        for (interface, physical) in [(1, 1), (2, 2), (4, 4), (3, 3)] {
            XCTAssertEqual(VastuArPolicy.headingOrientation(interfaceOrientation: interface), physical)
        }
        for value in [0, -1, 5, 6, 99] {
            XCTAssertNil(VastuArPolicy.headingOrientation(interfaceOrientation: value))
        }
    }

    func testTrueAndMagneticSamplesKeepMeasuredAccuracyAndTheirFrame() {
        let resolved = VastuArPolicy.sample(trueHeading: 12, magneticHeading: 10, accuracy: 4)
        XCTAssertEqual(resolved?.degrees, 12)
        XCTAssertEqual(resolved?.accuracy, 4)
        XCTAssertEqual(resolved?.frame, "true")
        let magnetic = VastuArPolicy.sample(trueHeading: -1, magneticHeading: 10, accuracy: 8)
        XCTAssertEqual(magnetic?.degrees, 10)
        XCTAssertEqual(magnetic?.frame, "magnetic")
    }

    func testInvalidOrUnusableNativeSamplesAreRefused() {
        for accuracy in [-1.0, .nan, .infinity, 45.01] {
            XCTAssertNil(VastuArPolicy.sample(trueHeading: 10, magneticHeading: 8, accuracy: accuracy))
        }
        XCTAssertNotNil(VastuArPolicy.sample(trueHeading: 10, magneticHeading: 8, accuracy: 45))
        XCTAssertNil(VastuArPolicy.sample(trueHeading: .infinity, magneticHeading: 8, accuracy: 4))
        XCTAssertNil(VastuArPolicy.sample(trueHeading: -1, magneticHeading: .nan, accuracy: 4))
        XCTAssertNil(VastuArPolicy.sample(trueHeading: -1, magneticHeading: -1, accuracy: 4))
    }
}
