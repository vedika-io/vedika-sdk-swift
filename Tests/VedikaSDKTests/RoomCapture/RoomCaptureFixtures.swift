import Foundation
import XCTest

@testable import VedikaSDK

/// Shared-fixture plumbing for `RoomCaptureGeometryTests` and
/// `RoomCaptureModelTests`: locates `sdks/fixtures/vastu-room-capture` (its
/// `.json` files) from within a monorepo checkout (same walk-up-and-skip
/// pattern as the Kotlin port's `RoomCaptureFixtures.monorepoRoot()` — a
/// published standalone package does not carry the fixture directory),
/// falls back to the byte copy bundled with the test target,
/// parses a fixture's `session` object into `RoomCaptureSession`, and
/// asserts a built `VastuRoomCapture.dictionary` equals a fixture's
/// `expected.capture` within 1e-6 for every numeric field.
enum RoomCaptureFixtures {
    private static let tolerance = 1e-6

    static func monorepoRoot() -> URL? {
        var dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        while true {
            let candidate = dir.appendingPathComponent("sdks/fixtures/vastu-room-capture")
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: candidate.path, isDirectory: &isDir), isDir.boolValue {
                return dir
            }
            let parent = dir.deletingLastPathComponent()
            if parent.path == dir.path { return nil }
            dir = parent
        }
    }

    /// The canonical fixture directory when a monorepo checkout is reachable.
    static var canonicalDirectory: URL? {
        monorepoRoot()?.appendingPathComponent("sdks/fixtures/vastu-room-capture")
    }

    /// The byte copy bundled with the test target, so a standalone checkout of
    /// the published package runs these tests instead of skipping them.
    static var bundledDirectory: URL? {
        Bundle.module.url(forResource: "RoomCaptureFixtures", withExtension: nil)
    }

    /// Canonical copy first, bundled copy otherwise.
    static var directory: URL? { canonicalDirectory ?? bundledDirectory }

    static func load(_ dir: URL) throws -> [(name: String, json: [String: Any])] {
        let files = try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension == "json" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
        return try files.map { url in
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            return (url.lastPathComponent, json)
        }
    }

    private static func vec3(_ arr: [Any]) -> Vec3 {
        Vec3(x: (arr[0] as! NSNumber).doubleValue, y: (arr[1] as! NSNumber).doubleValue, z: (arr[2] as! NSNumber).doubleValue)
    }

    private static func double(_ dict: [String: Any], _ key: String) -> Double? {
        guard let value = dict[key], !(value is NSNull) else { return nil }
        return (value as? NSNumber)?.doubleValue
    }

    private static func string(_ dict: [String: Any], _ key: String) -> String? {
        guard let value = dict[key], !(value is NSNull) else { return nil }
        return value as? String
    }

    static func parseSession(_ session: [String: Any]) -> RoomCaptureSession {
        let device = session["device"] as! [String: Any]
        let north = session["north"] as! [String: Any]
        let outline = session["outline"] as! [String: Any]
        let quality = session["quality"] as! [String: Any]
        let outlineCorners = (outline["worldCorners"] as! [[Any]]).map(vec3)
        let rooms = (session["rooms"] as! [[String: Any]]).map { r -> RoomCaptureRoomInput in
            let openings = (r["openings"] as? [[String: Any]] ?? []).map { o -> RoomCaptureOpeningInput in
                RoomCaptureOpeningInput(
                    kind: o["kind"] as! String, centerWorld: vec3(o["centerWorld"] as! [Any]),
                    widthM: (o["widthM"] as! NSNumber).doubleValue, heightM: double(o, "heightM"),
                    confidence: o["confidence"] as! String
                )
            }
            return RoomCaptureRoomInput(
                id: r["id"] as! String, label: string(r, "label"), labelSource: r["labelSource"] as! String,
                floorIndex: (r["floorIndex"] as! NSNumber).intValue, heightM: double(r, "heightM"),
                worldCorners: (r["worldCorners"] as! [[Any]]).map(vec3),
                closingTap: (r["closingTap"] as? [Any]).map(vec3), openings: openings
            )
        }
        return RoomCaptureSession(
            captureId: session["captureId"] as! String,
            capturedAtEpoch: (session["capturedAtEpoch"] as! NSNumber).intValue,
            device: RoomCaptureDeviceInput(
                platform: device["platform"] as! String, method: device["method"] as! String, depth: device["depth"] as! String
            ),
            headingFrame: session["headingFrame"] as! String,
            north: RoomCaptureNorthInput(
                referenceFrame: north["referenceFrame"] as! String, headingSource: north["headingSource"] as! String,
                declinationDeg: double(north, "declinationDeg"), declinationProvenance: north["declinationProvenance"] as! String
            ),
            headingSamples: (session["headingSamples"] as! [[String: Any]]).map {
                RoomCaptureHeadingSample(headingDeg: ($0["headingDeg"] as! NSNumber).doubleValue, forward: vec3($0["forward"] as! [Any]))
            },
            outline: RoomCaptureOutlineInput(
                source: outline["source"] as! String, worldCorners: outlineCorners,
                closingTap: (outline["closingTap"] as? [Any]).map(vec3)
            ),
            rooms: rooms,
            quality: RoomCaptureQualityInput(
                pointCloudDensity: double(quality, "pointCloudDensity"),
                pointCloudDensityBasis: quality["pointCloudDensityBasis"] as! String,
                coveragePercent: double(quality, "coveragePercent"), scanDurationSec: double(quality, "scanDurationSec"),
                scannedAreaM2: double(quality, "scannedAreaM2"),
                expectedRoomCount: (quality["expectedRoomCount"] as? NSNumber)?.intValue,
                gpsConfidence: double(quality, "gpsConfidence")
            )
        )
    }

    /// Deep-compares a `.dictionary`-encoded capture against a fixture's
    /// expected JSON, numeric fields within 1e-6. An omitted key in `actual`
    /// (this SDK's request types drop `nil` fields rather than emit an
    /// explicit JSON null, see `VastuRoomCapture.dictionary`) must correspond
    /// to an explicit null in `expected`, never to an unexpected extra or
    /// missing non-null field — matching every other language port's fixture
    /// comparison in this repo.
    static func assertMatches(_ actual: Any?, _ expected: Any?, path: String = "$", file: StaticString = #filePath, line: UInt = #line) {
        switch expected {
        case nil, is NSNull:
            XCTAssertNil(actual, "\(path): expected null, got \(String(describing: actual))", file: file, line: line)
        case let expectedDict as [String: Any]:
            guard let actualDict = actual as? [String: Any] else {
                XCTFail("\(path): expected a dictionary, got \(String(describing: actual))", file: file, line: line)
                return
            }
            let actualKeys = Set(actualDict.keys)
            let expectedKeys = Set(expectedDict.keys)
            XCTAssertTrue(expectedKeys.isSuperset(of: actualKeys), "\(path): extra keys not in fixture \(actualKeys.subtracting(expectedKeys))", file: file, line: line)
            for key in expectedKeys {
                let expectedValue: Any? = (expectedDict[key] is NSNull) ? nil : expectedDict[key]
                guard let actualValue = actualDict[key] else {
                    XCTAssertNil(expectedValue, "\(path).\(key): missing from the built capture but fixture expects \(String(describing: expectedValue))", file: file, line: line)
                    continue
                }
                assertMatches(actualValue, expectedValue, path: "\(path).\(key)", file: file, line: line)
            }
        case let expectedArray as [Any]:
            guard let actualArray = actual as? [Any] else {
                XCTFail("\(path): expected an array, got \(String(describing: actual))", file: file, line: line)
                return
            }
            XCTAssertEqual(expectedArray.count, actualArray.count, "\(path): length", file: file, line: line)
            for i in 0..<min(expectedArray.count, actualArray.count) {
                let e = expectedArray[i] is NSNull ? nil : expectedArray[i]
                assertMatches(actualArray[i], e, path: "\(path)[\(i)]", file: file, line: line)
            }
        case let expectedNumber as NSNumber where CFGetTypeID(expectedNumber) == CFBooleanGetTypeID():
            // A JSON boolean decodes to an `NSNumber` wrapping `CFBoolean` on
            // Darwin — checked by CFTypeID, not by `as? Bool` (which would
            // also match a plain 0/1 numeric `NSNumber` and let it "pass" as
            // a boolean, or vice versa hide a real type mismatch).
            guard let actualNumber = actual as? NSNumber, CFGetTypeID(actualNumber) == CFBooleanGetTypeID() else {
                XCTFail("\(path): expected a Bool, got \(String(describing: actual))", file: file, line: line)
                return
            }
            XCTAssertEqual(expectedNumber.boolValue, actualNumber.boolValue, path, file: file, line: line)
        case let expectedNumber as NSNumber:
            guard let actualNumber = actual as? NSNumber else {
                XCTFail("\(path): expected a Number, got \(String(describing: actual))", file: file, line: line)
                return
            }
            let diff = abs(expectedNumber.doubleValue - actualNumber.doubleValue)
            XCTAssertTrue(diff <= tolerance, "\(path): expected \(expectedNumber.doubleValue), got \(actualNumber.doubleValue) (diff \(diff))", file: file, line: line)
        case let expectedString as String:
            XCTAssertEqual(expectedString, actual as? String, path, file: file, line: line)
        default:
            XCTFail("\(path): unhandled fixture value type \(type(of: expected as Any))", file: file, line: line)
        }
    }
}
