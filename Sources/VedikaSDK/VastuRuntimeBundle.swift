// Packaged offline AR runtime — integrity, as a CONSUMER of the package sees it.
//
// ## Why this is its own platform-free file (ar#20, 2026-09-18)
// The digest check used to live inline in `VastuArView.verifyRuntime()`, which
// is inside that file's `#if os(iOS)` guard. That made the integrity of the
// bytes this package actually SHIPS untestable: `swift test` targets macOS, so
// nothing compiled the check, and the Swift half of "stale or corrupted
// resource checks fail explicitly" was a claim rather than an assertion. The
// Android SDK had already made it an assertion (`VastuRuntimeBundleTest`
// reads through the classpath), and the same bundle drifting out of its
// manifest is exactly what broke the Android jar before #931 — there, a stale
// manifest failed the build; here it would `preconditionFailure` inside a
// customer's iOS app at runtime, with nothing upstream to catch it.
//
// Nothing here imports UIKit, WebKit or Core Location, so it compiles and is
// tested on macOS while `VastuArView` keeps calling it on iOS. The iOS
// behaviour is unchanged: a failure is still a `preconditionFailure`, because
// a corrupt offline runtime must not be rendered.

import Foundation
import CryptoKit

/// The versioned offline AR runtime bundled with this package.
enum VastuRuntimeBundle {
    /// Exactly the files the manifest must describe. A runtime that gained or
    /// lost a file without the manifest changing is refused, not merged.
    static let expectedFiles: Set<String> = ["index.html", "runtime.js", "hud-mandala.png"]

    /// Every way a packaged runtime can be unusable, named rather than lumped
    /// into one opaque failure — a missing manifest and a corrupt resource are
    /// different bugs with different fixes.
    enum Failure: Error, Equatable, CustomStringConvertible {
        case missingManifest
        case unreadableManifest
        case unsupportedFormatVersion(Int?)
        case unexpectedFileSet([String])
        case missingResource(String)
        case digestMismatch(name: String, expected: String, actual: String)

        var description: String {
            switch self {
            case .missingManifest:
                return "bundled Vastu runtime manifest.json is missing"
            case .unreadableManifest:
                return "bundled Vastu runtime manifest.json is not readable JSON"
            case .unsupportedFormatVersion(let v):
                return "bundled Vastu runtime manifest formatVersion \(v.map(String.init) ?? "absent") is not supported"
            case .unexpectedFileSet(let names):
                return "bundled Vastu runtime manifest describes \(names), not \(expectedFiles.sorted())"
            case .missingResource(let name):
                return "bundled Vastu runtime resource \(name) is missing"
            case .digestMismatch(let name, let expected, let actual):
                return "bundled Vastu runtime resource \(name) digest \(actual) does not match manifest \(expected)"
            }
        }
    }

    /// The directory holding the packaged runtime inside this module's own
    /// resource bundle — the same bytes an installed consumer loads.
    static var packagedDirectory: URL? {
        Bundle.module
            .url(forResource: "index", withExtension: "html", subdirectory: "VastuRuntime")?
            .deletingLastPathComponent()
    }

    /// Verifies every file in `directory` against that directory's manifest.
    ///
    /// Throws the specific `Failure` rather than returning a bool so a caller
    /// (and a test) can tell a stale manifest from a corrupted resource.
    static func verify(in directory: URL) throws {
        guard let data = try? Data(contentsOf: directory.appendingPathComponent("manifest.json")) else {
            throw Failure.missingManifest
        }
        guard let manifest = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            throw Failure.unreadableManifest
        }
        let formatVersion = manifest["formatVersion"] as? Int
        guard formatVersion == 1 else { throw Failure.unsupportedFormatVersion(formatVersion) }
        guard let files = manifest["files"] as? [String: String], Set(files.keys) == expectedFiles else {
            throw Failure.unexpectedFileSet(((manifest["files"] as? [String: String])?.keys).map { $0.sorted() } ?? [])
        }
        for (name, expected) in files.sorted(by: { $0.key < $1.key }) {
            guard let bytes = try? Data(contentsOf: directory.appendingPathComponent(name)) else {
                throw Failure.missingResource(name)
            }
            let actual = SHA256.hash(data: bytes).map { String(format: "%02x", $0) }.joined()
            guard actual == expected else {
                throw Failure.digestMismatch(name: name, expected: expected, actual: actual)
            }
        }
    }
}
