import XCTest
import CryptoKit
@testable import VedikaSDK

/// The Swift half of ar#20: the packaged offline runtime is verified as an
/// installed consumer sees it, and a stale or corrupted one is refused
/// explicitly rather than silently rendered.
///
/// Mirrors the Android `VastuRuntimeBundleTest`, which reads through the
/// classpath. Here the equivalent is `Bundle.module` — the resource bundle
/// SwiftPM copies next to the library, so these are the bytes a consumer that
/// resolved `github.com/vedika-io/vedika-sdk-swift` actually loads, not the
/// files as they sit in the repository.
///
/// The two negative cases are the part that was missing on both platforms: it
/// is not enough that a good bundle passes, a bad one has to fail and has to
/// say WHY.
final class VastuRuntimeBundleTests: XCTestCase {

    private func packagedDirectory() throws -> URL {
        try XCTUnwrap(
            VastuRuntimeBundle.packagedDirectory,
            "the packaged VastuRuntime is not reachable through Bundle.module — it did not ship"
        )
    }

    /// Copies the packaged runtime to a scratch directory the test may mutate.
    private func copyOfPackagedRuntime() throws -> URL {
        let source = try packagedDirectory()
        let destination = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("vastu-runtime-\(UUID().uuidString)")
        try FileManager.default.copyItem(at: source, to: destination)
        addTeardownBlock { try? FileManager.default.removeItem(at: destination) }
        return destination
    }

    func testEveryPackagedResourceMatchesTheManifestDigest() throws {
        let directory = try packagedDirectory()
        XCTAssertNoThrow(
            try VastuRuntimeBundle.verify(in: directory),
            "the runtime this package ships must match its own manifest"
        )

        // Assert the digests independently of the code under test, so a
        // verifier that silently accepted everything could not pass this.
        let manifestData = try Data(contentsOf: directory.appendingPathComponent("manifest.json"))
        let manifest = try XCTUnwrap(
            try JSONSerialization.jsonObject(with: manifestData) as? [String: Any]
        )
        XCTAssertEqual(manifest["formatVersion"] as? Int, 1)
        let files = try XCTUnwrap(manifest["files"] as? [String: String])
        XCTAssertEqual(Set(files.keys), VastuRuntimeBundle.expectedFiles)
        for (name, expected) in files {
            let bytes = try Data(contentsOf: directory.appendingPathComponent(name))
            let actual = SHA256.hash(data: bytes).map { String(format: "%02x", $0) }.joined()
            XCTAssertEqual(actual, expected, "\(name) digest")
        }
    }

    func testTheRuntimeIsNotEmptyAndIsSelfContained() throws {
        let directory = try packagedDirectory()
        let html = try String(
            contentsOf: directory.appendingPathComponent("index.html"), encoding: .utf8
        )
        XCTAssertGreaterThan(html.count, 200, "index.html should be a real document")
        // An offline runtime must not reach the network on load.
        for scheme in ["http://", "https://"] {
            let pattern = try NSRegularExpression(pattern: "(src|href)\\s*=\\s*[\"']\(scheme)")
            let range = NSRange(html.startIndex..<html.endIndex, in: html)
            XCTAssertNil(
                pattern.firstMatch(in: html, range: range),
                "index.html must not load \(scheme) resources — the runtime is offline"
            )
        }
        let runtime = try Data(contentsOf: directory.appendingPathComponent("runtime.js"))
        XCTAssertGreaterThan(runtime.count, 10_000, "runtime.js should be substantial")
    }

    func testACorruptedResourceIsRefusedAndNamed() throws {
        let directory = try copyOfPackagedRuntime()
        let corrupted = directory.appendingPathComponent("runtime.js")
        var bytes = try Data(contentsOf: corrupted)
        bytes.append(0x20) // one byte — the smallest drift there is
        try bytes.write(to: corrupted)

        XCTAssertThrowsError(try VastuRuntimeBundle.verify(in: directory)) { error in
            guard case VastuRuntimeBundle.Failure.digestMismatch(let name, let expected, let actual) = error else {
                return XCTFail("expected a digestMismatch, got \(error)")
            }
            XCTAssertEqual(name, "runtime.js")
            XCTAssertNotEqual(expected, actual, "the failure must carry both digests")
        }
    }

    func testAMissingResourceIsRefusedAndNamed() throws {
        let directory = try copyOfPackagedRuntime()
        try FileManager.default.removeItem(at: directory.appendingPathComponent("hud-mandala.png"))

        XCTAssertThrowsError(try VastuRuntimeBundle.verify(in: directory)) { error in
            XCTAssertEqual(error as? VastuRuntimeBundle.Failure, .missingResource("hud-mandala.png"))
        }
    }

    func testAMissingManifestIsRefused() throws {
        let directory = try copyOfPackagedRuntime()
        try FileManager.default.removeItem(at: directory.appendingPathComponent("manifest.json"))

        XCTAssertThrowsError(try VastuRuntimeBundle.verify(in: directory)) { error in
            XCTAssertEqual(error as? VastuRuntimeBundle.Failure, .missingManifest)
        }
    }

    func testAStaleManifestThatLostAFileIsRefused() throws {
        let directory = try copyOfPackagedRuntime()
        let manifestURL = directory.appendingPathComponent("manifest.json")
        var manifest = try XCTUnwrap(
            try JSONSerialization.jsonObject(with: Data(contentsOf: manifestURL)) as? [String: Any]
        )
        var files = try XCTUnwrap(manifest["files"] as? [String: String])
        files.removeValue(forKey: "runtime.js")
        manifest["files"] = files
        try JSONSerialization.data(withJSONObject: manifest).write(to: manifestURL)

        XCTAssertThrowsError(try VastuRuntimeBundle.verify(in: directory)) { error in
            guard case VastuRuntimeBundle.Failure.unexpectedFileSet(let names) = error else {
                return XCTFail("expected an unexpectedFileSet, got \(error)")
            }
            XCTAssertFalse(names.contains("runtime.js"))
        }
    }

    func testAnUnsupportedFormatVersionIsRefused() throws {
        let directory = try copyOfPackagedRuntime()
        let manifestURL = directory.appendingPathComponent("manifest.json")
        var manifest = try XCTUnwrap(
            try JSONSerialization.jsonObject(with: Data(contentsOf: manifestURL)) as? [String: Any]
        )
        manifest["formatVersion"] = 2
        try JSONSerialization.data(withJSONObject: manifest).write(to: manifestURL)

        XCTAssertThrowsError(try VastuRuntimeBundle.verify(in: directory)) { error in
            XCTAssertEqual(error as? VastuRuntimeBundle.Failure, .unsupportedFormatVersion(2))
        }
    }
}
