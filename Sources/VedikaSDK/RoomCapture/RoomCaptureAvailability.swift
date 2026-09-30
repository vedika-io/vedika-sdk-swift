import Foundation

/// Which capture path this device can run, decided once up front so a
/// caller never has to probe RoomPlan/ARKit symbols itself. Mirrors the
/// Android port's `ArCoreAvailability.kt` in shape (an availability enum
/// plus one entry point), though the underlying checks are Apple's own.
///
/// `#if os(iOS) && canImport(RoomPlan)` — not just `#if os(iOS)` — because
/// this whole file only makes a claim about RoomPlan/ARKit, and gating it
/// the same way the rest of this feature's iOS-only files are gated
/// (`RoomPlanCaptureController.swift`, `ARKitCornerCaptureController.swift`)
/// keeps `swift build` green on macOS with zero RoomPlan/ARKit on the search
/// path, exactly like `VastuArView.swift`'s own `#if os(iOS)` guard keeps the
/// package building on macOS today (see that file's header for the a
/// `swift build` run with no `-sdk`/`--destination` override targets macOS).
#if os(iOS) && canImport(RoomPlan)
import RoomPlan
import ARKit

/// Vedika-Task: R-004
public enum RoomCaptureAvailability {
    public enum Path: String, Sendable {
        /// LiDAR devices, iOS 16+: `RoomCaptureView`/`RoomCaptureSession` -> `CapturedRoom`.
        case roomPlan
        /// No LiDAR (or pre-iOS 16): `ARWorldTrackingConfiguration` + plane raycast, corners tapped by hand.
        case arKitFallback
        /// Neither RoomPlan nor world tracking is available on this device.
        case unsupported
    }

    /// `RoomCaptureSession.isSupported` needs LiDAR; a device without it (or
    /// an iOS below 16) still runs `ARWorldTrackingConfiguration` as long as
    /// `ARWorldTrackingConfiguration.isSupported` (checked without importing
    /// ARKit's session type here, `ARConfiguration.isSupported` covers both
    /// world-tracking and its subclasses per Apple's own docs).
    @MainActor
    public static func currentPath() -> Path {
        // Qualified `RoomPlan.RoomCaptureSession` — this module's own
        // `RoomCaptureSession` (the plain-value type in `RoomCaptureTypes.swift`,
        // shared with the Kotlin/JS/Rust ports) shadows RoomPlan's class of
        // the same name for unqualified lookups in this file.
        if #available(iOS 16.0, *), RoomPlan.RoomCaptureSession.isSupported {
            return .roomPlan
        }
        if ARWorldTrackingConfiguration.isSupported {
            return .arKitFallback
        }
        return .unsupported
    }
}
#endif
