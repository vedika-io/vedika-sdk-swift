import CryptoKit
import Foundation
import XCTest
@testable import VedikaRoomCapture

final class NativeAttestationTests: XCTestCase {
    func testBundledVectorsMatchCanonical() throws {
        let bundled = try XCTUnwrap(Bundle.module.url(forResource: "attestation-vectors", withExtension: "json"))
        var source = URL(fileURLWithPath: #filePath)
        for _ in 0..<4 { source.deleteLastPathComponent() }
        source.appendPathComponent("fixtures/vastu-attestation-binding/vectors.json")
        if FileManager.default.fileExists(atPath: source.path) {
            XCTAssertEqual(try Data(contentsOf: bundled), try Data(contentsOf: source))
        }
    }
    func testEverySharedBindingVector() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "attestation-vectors", withExtension: "json"))
        let document = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any])
        let cases = try XCTUnwrap(document["cases"] as? [[String: Any]])
        XCTAssertEqual(cases.count, 5)
        for row in cases {
            let body = try XCTUnwrap(row["body"] as? [String: Any]); let name = row["name"] as! String
            XCTAssertEqual(try AttestationCanonicalJSON.encode(body), row["canonical"] as? String, name)
            let challenge = try NativeAttestationChallenge(value: row["challenge"] as! String, expiresAt: .distantFuture, platform: "ios")
            let digest = try NativeAttestation.digest(operation: row["operation"] as! String, challenge: challenge, body: body)
            XCTAssertEqual(digest.map { String(format: "%02x", $0) }.joined(), row["digestHex"] as? String, name)
            XCTAssertEqual(NativeAttestation.playRequestHash(digest), row["playRequestHash"] as? String, name)
        }
    }
    func testBindingExcludesOnlyTopLevelProofAndDetectsEdits() throws {
        let challenge = try NativeAttestationChallenge(value: "challenge", expiresAt: .distantFuture, platform: "ios")
        let body: [String: Any] = ["capture": ["room": "kitchen"]]
        let a = try NativeAttestation.digest(operation: "ar/room-capture", challenge: challenge, body: body)
        var proven = body; proven["deviceAttestation"] = ["assertion": "bytes"]
        XCTAssertEqual(a, try NativeAttestation.digest(operation: "ar/room-capture", challenge: challenge, body: proven))
        XCTAssertNotEqual(a, try NativeAttestation.digest(operation: "ar/scan-quality", challenge: challenge, body: body))
        XCTAssertNotEqual(a, try NativeAttestation.digest(operation: "ar/room-capture", challenge: challenge, body: ["capture": ["room": "bedroom"]]))
    }
    func testExpiryInvalidNumbersAndUTF16Ordering() throws {
        let challenge = try NativeAttestationChallenge(value: "challenge", expiresAt: Date(timeIntervalSince1970: 10), platform: "ios")
        XCTAssertThrowsError(try NativeAttestation.digest(operation: "ar/room-capture", challenge: challenge, body: [:], now: Date(timeIntervalSince1970: 10)))
        XCTAssertThrowsError(try AttestationCanonicalJSON.encode(Double.nan))
        XCTAssertThrowsError(try AttestationCanonicalJSON.encode(NSNumber(value: Int64(9_007_199_254_740_992))))
        XCTAssertThrowsError(try NativeAttestationChallenge(value: "bad\nchallenge", expiresAt: .distantFuture, platform: "ios"))
        XCTAssertEqual(try AttestationCanonicalJSON.encode(["\u{e000}": 2, "\u{1f600}": 1]), "{\"\u{1f600}\":1,\"\u{e000}\":2}")
        XCTAssertEqual(try AttestationCanonicalJSON.encode([1.0, -0.0, 1e-6, 1e-7, 1e20, 1e21]), "[1,0,0.000001,1e-7,100000000000000000000,1e+21]")
    }
}
