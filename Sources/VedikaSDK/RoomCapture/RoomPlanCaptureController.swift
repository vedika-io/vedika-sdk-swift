// RoomPlan capture path (LiDAR devices, iOS 16+), gated exactly like every
// other AR file in this target: `#if os(iOS) && canImport(RoomPlan)` plus
// `@available(iOS 16.0, *)` on the type itself, so `swift build` with no
// `-sdk`/`--destination` override (a plain macOS build) stays green — the
// same pattern `VastuArView.swift` documents for its own `#if os(iOS)` guard.
//
// Verified against the installed iOS 26.2 SDK's own
// `RoomPlan.swiftmodule/*.swiftinterface` this pass (not against the web or
// memory) — every `(TV)` the design doc (`docs/ops/2026-09-16-vastu-design-ar-room-capture.md`,
// §3) flagged is resolved there:
//   - `CapturedRoom.floors`, `Surface.polygonCorners`, `Section`/`sections`,
//     `StructureBuilder`, `RoomCaptureSession.init(arSession:)`: all
//     `@available(iOS 17.0, *)`, confirming the doc's guess.
//   - `CapturedRoom: Codable` is available from iOS 16.0, one version
//     EARLIER than the doc guessed ("I believe these are iOS 17 additions").
//   - `RoomCaptureSession.arSession` (the property, not the iOS-17-only
//     initializer) is available on the base iOS 16 class — heading samples
//     paired with camera poses are reachable without iOS 17.
//
// This file only builds the iOS-16 floor: single-room capture (walls,
// doors, windows, openings), no `StructureBuilder` multi-room stitching and
// no `.floors`/`.sections` labels (both iOS 17+). Multi-room and RoomPlan
// section labels are deferred, same as the design doc's own build order.
//
// UNVERIFIED ON A DEVICE: RoomPlan does not run in the iOS Simulator (no
// LiDAR), so this file is a compile-time (`swiftc -typecheck` /
// `swift build` for iOS) proof only. Everything below the wall-chaining
// comment is this session's best-effort geometry, not something this
// session could run against a real scan.
//
// Vedika-Task: R-004
#if os(iOS) && canImport(RoomPlan)
import ARKit
import Foundation
import RoomPlan
import simd

@available(iOS 16.0, *)
public protocol RoomPlanCaptureControllerDelegate: AnyObject {
    /// The session finished (successfully or not). `result` is `nil` when
    /// the room could not be built (see `error` on `RoomBuilder`'s own
    /// throw); the controller never fabricates a placeholder capture.
    func roomPlanCapture(_ controller: RoomPlanCaptureController, didFinish result: RoomCaptureSession?, error: Error?)
}

/// Wraps a `RoomCaptureView` + `RoomCaptureSession`: runs the LiDAR scan,
/// hands the finished `CapturedRoom` to `RoomBuilder`, and turns it into the
/// `RoomCaptureSession` shape `RoomCaptureGeometry.buildRoomCapture` takes.
///
/// This controller has no compass of its own — heading samples must be fed
/// in via `addHeadingSample(headingDeg:)` while scanning (a `TrueHeadingSampler`
/// paired with `captureSession.arSession.currentFrame?.camera.transform` is
/// the intended source; see that file). Without at least
/// `RoomCaptureModel.minNorthSamples` heading samples,
/// `RoomCaptureGeometry.buildRoomCapture` throws exactly as it does for the
/// manual ARKit path.
@available(iOS 16.0, *)
@MainActor
public final class RoomPlanCaptureController: NSObject {

    public weak var delegate: RoomPlanCaptureControllerDelegate?

    /// `RoomCaptureView` creates and owns its own `RoomCaptureSession`
    /// internally (`captureSession` is get-only on the SDK type); this
    /// controller only ever reads it through `view.captureSession`, never
    /// constructs one itself.
    public let view: RoomCaptureView
    private let captureId: String
    private let startedAt = Date()
    private var headingSamples: [RoomCaptureHeadingSample] = []
    private var declinationDeg: Double?
    private var declinationProvenance = "unset"

    public init(captureId: String, frame: CGRect = .zero) {
        self.captureId = captureId
        self.view = RoomCaptureView(frame: frame)
        super.init()
        view.delegate = self
    }

    /// The ARKit session RoomPlan is riding on top of — the camera-pose
    /// source for `TrueHeadingSampler` (see that file's header).
    public var arSession: ARSession { view.captureSession.arSession }

    public func start() {
        // `RoomPlan.RoomCaptureSession.Configuration` — qualified because this
        // module's own `RoomCaptureSession` (see `RoomCaptureTypes.swift`)
        // shadows RoomPlan's class of the same name here.
        var configuration = RoomPlan.RoomCaptureSession.Configuration()
        configuration.isCoachingEnabled = true
        view.captureSession.run(configuration: configuration)
    }

    public func stop() {
        view.captureSession.stop()
    }

    /// One "facing north" sample: pair a compass heading with the current
    /// camera-forward vector. `forward` is the ARKit camera's forward
    /// direction in world space (Y-up), matching every other platform's
    /// `RoomCaptureHeadingSample.forward`.
    public func addHeadingSample(headingDeg: Double, forward: Vec3) {
        headingSamples.append(RoomCaptureHeadingSample(headingDeg: headingDeg, forward: forward))
    }

    /// Set once true declination is known (see `TrueHeadingSampler`); if
    /// never called, the capture is honestly built with `referenceFrame:
    /// "magnetic"` and the server refuses it, exactly like every other
    /// platform's magnetic-frame case (`sdks/fixtures/vastu-room-capture/magnetic-frame.json`).
    public func setDeclination(_ declinationDeg: Double, provenance: String) {
        self.declinationDeg = declinationDeg
        self.declinationProvenance = provenance
    }

    /// `RoomCaptureViewDelegate.captureView(didPresent:error:)` (below)
    /// already hands over the fully-built `CapturedRoom` — `RoomCaptureView`
    /// runs its own internal `RoomBuilder` before presenting it, so this
    /// controller does not need to call `RoomBuilder` itself. Only a
    /// lower-level `RoomCaptureSessionDelegate` (bypassing `RoomCaptureView`
    /// entirely) would need to build from raw `CapturedRoomData`.
    private func finish(room: CapturedRoom) {
        do {
            let session = try Self.toCaptureSession(
                room, captureId: captureId, startedAt: startedAt, headingSamples: headingSamples,
                declinationDeg: declinationDeg, declinationProvenance: declinationProvenance
            )
            delegate?.roomPlanCapture(self, didFinish: session, error: nil)
        } catch {
            delegate?.roomPlanCapture(self, didFinish: nil, error: error)
        }
    }

    /// Chain wall endpoints into a floor outline, and turn walls/doors/
    /// windows/openings into the one `RoomCaptureRoomInput` this iOS-16
    /// (single-room, no `StructureBuilder`) path produces.
    static func toCaptureSession(
        _ room: CapturedRoom, captureId: String, startedAt: Date, headingSamples: [RoomCaptureHeadingSample],
        declinationDeg: Double?, declinationProvenance: String
    ) throws -> RoomCaptureSession {
        let trace = try chainWallOutline(room.walls)
        let openings: [RoomCaptureOpeningInput] = (room.doors.map { ("door", $0) } + room.windows.map { ("window", $0) } + room.openings.map { ("opening", $0) })
            .map { kind, surface in
                RoomCaptureOpeningInput(
                    kind: kind, centerWorld: worldPosition(surface.transform), widthM: Double(surface.dimensions.x),
                    heightM: Double(surface.dimensions.y), confidence: confidenceString(surface.confidence)
                )
            }
        let headingFrame = declinationDeg != nil ? "true" : "magnetic"
        return RoomCaptureSession(
            captureId: captureId,
            capturedAtEpoch: Int(startedAt.timeIntervalSince1970),
            device: RoomCaptureDeviceInput(platform: "ios", method: "roomplan", depth: "lidar"),
            headingFrame: headingFrame,
            north: RoomCaptureNorthInput(
                referenceFrame: "true", headingSource: "roomplan-coaching+core-location",
                declinationDeg: declinationDeg, declinationProvenance: declinationProvenance
            ),
            headingSamples: headingSamples,
            outline: trace.outline,
            rooms: [
                RoomCaptureRoomInput(
                    id: "room-1", label: nil, labelSource: "none", floorIndex: 0, heightM: nil,
                    worldCorners: trace.corners, closingTap: trace.closingTap, openings: openings
                ),
            ],
            quality: RoomPlanCaptureQuality.measured()
        )
    }

    private static func confidenceString(_ confidence: CapturedRoom.Confidence) -> String {
        switch confidence {
        case .high: return "high"
        case .medium: return "medium"
        case .low: return "low"
        @unknown default: return "low"
        }
    }

    private static func worldPosition(_ transform: simd_float4x4) -> Vec3 {
        let p = transform.columns.3
        return Vec3(x: Double(p.x), y: Double(p.y), z: Double(p.z))
    }

    /// Each wall's local +X axis (`transform.columns.0`) spans its width
    /// (`dimensions.x`); the two endpoints are the wall center offset by
    /// half that span each way. The chaining and closure maths live in
    /// `RoomPlanWallChain` so they are tested on every platform.
    private static func chainWallOutline(_ walls: [CapturedRoom.Surface]) throws -> RoomPlanWallTrace {
        try RoomPlanWallChain.trace(walls.map { wall in
            let center = worldPosition(wall.transform)
            let xAxis = wall.transform.columns.0
            let halfSpan = Double(wall.dimensions.x) / 2.0
            let norm = (Double(xAxis.x) * Double(xAxis.x) + Double(xAxis.z) * Double(xAxis.z)).squareRoot()
            let ux = norm > 0 ? Double(xAxis.x) / norm : 1
            let uz = norm > 0 ? Double(xAxis.z) / norm : 0
            return RoomPlanWallSegment(
                start: Vec3(x: center.x - ux * halfSpan, y: center.y, z: center.z - uz * halfSpan),
                end: Vec3(x: center.x + ux * halfSpan, y: center.y, z: center.z + uz * halfSpan)
            )
        })
    }
}

// `RoomCaptureViewDelegate` extends `Foundation.NSCoding` (verified against
// the installed SDK's own `RoomPlan.swiftmodule` interface this pass — not
// obvious from the design doc, and easy to miss since nothing about this
// delegate looks coder-related). `RoomPlanCaptureController` is never
// actually archived/unarchived; these two stubs exist only to satisfy the
// protocol's structural requirement.
@available(iOS 16.0, *)
extension RoomPlanCaptureController: @preconcurrency NSCoding {
    public func encode(with coder: NSCoder) {}

    public convenience init?(coder: NSCoder) {
        return nil
    }
}

// `@preconcurrency`: see `ARKitCornerCaptureController`'s identical note on
// its own `ARSessionDelegate` conformance — same unmarked-ObjC-protocol
// pattern, same reasoning.
@available(iOS 16.0, *)
extension RoomPlanCaptureController: @preconcurrency RoomCaptureViewDelegate {
    public func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        error == nil
    }

    public func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        if let error {
            delegate?.roomPlanCapture(self, didFinish: nil, error: error)
            return
        }
        finish(room: processedResult)
    }
}
#endif
