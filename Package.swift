// swift-tools-version:5.9
import PackageDescription

// Vedika Swift SDK — native URLSession client for the Vastu surface.
//
// Platform floor is `.iOS(.v15), .macOS(.v12)` (the task's stated floor):
// `URLSession.data(for:)` async, used throughout `VedikaClient`, needs
// exactly that floor. Zero external dependencies on purpose — both the
// production client (URLSession only) and the test target (a bundled
// dependency-free loopback HTTP server, see
// `Tests/VedikaSDKTests/LoopbackHTTPServer.swift`) build and test with a
// bare Swift toolchain, no network fetch to resolve a package graph.
//
// Distribution: SwiftPM still cannot resolve a package that lives in a
// subdirectory of a larger git repository, so this package is mirrored to
// `github.com/vedika-io/vedika-sdk-swift`, where it sits at the repository
// root and is installable by URL:
//
//     .package(url: "https://github.com/vedika-io/vedika-sdk-swift.git", from: "1.0.0")
//
// A local path consumer still works: `.package(path: "../vedika/sdks/swift")`.
// This directory remains the source of truth; the mirror is synced from it.
let package = Package(
    name: "VedikaSDK",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "VedikaSDK", targets: ["VedikaSDK"])
    ],
    targets: [
        .target(
            name: "VedikaSDK",
            resources: [.copy("Resources/VastuRuntime")]
        ),
        .testTarget(
            name: "VedikaSDKTests",
            dependencies: ["VedikaSDK"],
            // The shared live fixture, so the package tests itself when it is
            // consumed as a standalone repository rather than from inside the
            // monorepo. `monorepoFixtureURL` still prefers the canonical copy
            // when it is reachable, and `testBundledFixtureMatchesCanonical`
            // fails if the two ever drift.
            resources: [.process("Resources")]
        ),
    ]
)
