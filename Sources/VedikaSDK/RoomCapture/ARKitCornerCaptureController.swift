// Non-LiDAR fallback (also usable on LiDAR devices that skip RoomPlan):
// `ARWorldTrackingConfiguration` with horizontal+vertical plane detection,
// corners placed by tapping a raycast hit. Same `#if os(iOS)` gate as
// `VastuArView.swift` — `ARKit` itself imports on macOS, but the session/
// plane/raycast APIs this file actually calls do not exist there, so the
// gate stays `#if os(iOS)` (not `canImport(ARKit)`, which is true on both
// platforms and would not protect a macOS build).
//
// Wraps `RoomCaptureModel` (pure Swift, no ARKit import — see that file)
// with the plumbing the design doc (§3, "Non-LiDAR fallback") specifies:
// `ARWorldTrackingConfiguration.planeDetection = [.horizontal, .vertical]`,
// `ARView.raycast(from:allowing:.estimatedPlane, alignment:.horizontal)` with
// `.existingPlaneGeometry` tried first, density from `ARFrame.rawFeaturePoints`,
// and tracking gated on `ARCamera.trackingState`.
//
// UNVERIFIED ON A DEVICE: world tracking with real plane detection does not
// run in the iOS Simulator. This file is a compile-time proof only — the
// raycast/tracking-state plumbing below has never run against a live scan.
//
// Vedika-Task: R-004
#if os(iOS)
import ARKit
import Foundation
import SceneKit

@available(iOS 15.0, *)
public protocol ARKitCornerCaptureControllerDelegate: AnyObject {
    /// `.estimatedPlane` hits are lower confidence than `.existingPlaneGeometry`;
    /// callers may want to warn the operator before accepting one.
    func arKitCapture(_ controller: ARKitCornerCaptureController, didAddCorner point: Vec3, isEstimated: Bool)
    func arKitCapture(_ controller: ARKitCornerCaptureController, trackingStateDidChange state: ARCamera.TrackingState)
}

/// Drives `RoomCaptureModel` from ARKit plane-raycast taps. Point-cloud
/// density (`pointCloudDensity`/`pointCloudDensityBasis: "feature-points"`)
/// is sampled from `ARFrame.rawFeaturePoints` on each tap and averaged into
/// the final quality block — this device has no LiDAR, so "feature-points"
/// is the honest basis label (see `vedika.roomCapture/1`'s `quality`
/// block, design doc §6).
@available(iOS 15.0, *)
@MainActor
public final class ARKitCornerCaptureController: NSObject {

    public weak var delegate: ARKitCornerCaptureControllerDelegate?

    public let session: ARSession
    private let model: RoomCaptureModel
    private var featurePointCounts: [Int] = []
    private var trackingState: ARCamera.TrackingState = .notAvailable

    public init(captureId: String, session: ARSession = ARSession()) {
        self.session = session
        self.model = RoomCaptureModel(captureId)
        super.init()
        session.delegate = self
    }

    public func start() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.worldAlignment = .gravity
        session.run(configuration)
    }

    public func stop() {
        session.pause()
    }

    /// Raycasts from a normalized screen point (0...1 in each axis, as
    /// `ARFrame.raycastQuery(from:allowing:alignment:)` takes) and, on a
    /// hit, taps the underlying `RoomCaptureModel`. Tries
    /// `.existingPlaneGeometry` first and falls back to `.estimatedPlane`,
    /// per the design doc.
    @discardableResult
    public func tapCorner(at screenPoint: CGPoint, viewportSize: CGSize) throws -> RoomCaptureModel.TapResult {
        guard let frame = session.currentFrame else { throw RoomCaptureError("No AR frame yet") }
        // `ARFrame.raycastQuery(from:allowing:alignment:)` returns a
        // non-optional `ARRaycastQuery` (verified against the installed
        // SDK's `ARFrame.h`: `-raycastQueryFromPoint:allowingTarget:alignment:`
        // is not nullable) — no `if let` needed on these two.
        let existingQuery = frame.raycastQuery(from: screenPoint, allowing: .existingPlaneGeometry, alignment: .horizontal)
        let estimatedQuery = frame.raycastQuery(from: screenPoint, allowing: .estimatedPlane, alignment: .horizontal)
        let isEstimated: Bool
        let hit: ARRaycastResult?
        if let result = session.raycast(existingQuery).first {
            hit = result
            isEstimated = false
        } else if let result = session.raycast(estimatedQuery).first {
            hit = result
            isEstimated = true
        } else {
            hit = nil
            isEstimated = false
        }
        guard let hit else { throw RoomCaptureError("No plane under that point yet") }
        let t = hit.worldTransform.columns.3
        let point = Vec3(x: Double(t.x), y: Double(t.y), z: Double(t.z))
        recordFeaturePointDensity(frame)
        let result = try model.tap(point)
        delegate?.arKitCapture(self, didAddCorner: point, isEstimated: isEstimated)
        return result
    }

    public func closeAt(_ point: Vec3) throws { try model.closeAt(point) }
    public func undo() -> Bool { model.undo() }
    public func startRoom(_ label: String?) throws { try model.startRoom(label) }
    public func addNorthSample(_ forward: Vec3) { model.addNorthSample(forward) }
    public func resetNorth() { model.resetNorth() }
    public var northReady: Bool { model.northReady }

    /// `pointCloudDensity` is points per square metre of the traced outline
    /// — an average of `rawFeaturePoints.count` across every tap, divided by
    /// the outline's own area once it is known. Until the outline is
    /// closed, this returns the raw average point count only.
    public func averageFeaturePointCount() -> Double? {
        guard !featurePointCounts.isEmpty else { return nil }
        return Double(featurePointCounts.reduce(0, +)) / Double(featurePointCounts.count)
    }

    private func recordFeaturePointDensity(_ frame: ARFrame) {
        if let cloud = frame.rawFeaturePoints {
            featurePointCounts.append(cloud.points.count)
        }
    }

    public func toSession(device: RoomCaptureDeviceInput? = nil) throws -> RoomCaptureSession {
        var session = try model.toSession(device: device ?? RoomCaptureDeviceInput(platform: "ios", method: "arkit-raycast", depth: "none"))
        if let avgPoints = averageFeaturePointCount(), let area = session.quality.scannedAreaM2, area > 0 {
            session.quality.pointCloudDensity = RoomCaptureGeometry.roundHalfUp(avgPoints / area, 1)
            session.quality.pointCloudDensityBasis = "feature-points"
        }
        return session
    }

    public func build(device: RoomCaptureDeviceInput? = nil) throws -> VastuRoomCapture {
        try RoomCaptureGeometry.buildRoomCapture(toSession(device: device))
    }
}

// `@preconcurrency` on the conformance: `ARSessionDelegate` is an
// unmarked Objective-C protocol, so its requirements are `nonisolated` by
// default; this whole class is `@MainActor`, and the delegate callback
// only ever actually arrives on the main thread in practice (ARKit's own
// documented behaviour), so `@preconcurrency` here reflects that rather
// than fighting it with `nonisolated` methods that could not touch
// `trackingState`/`delegate` directly.
@available(iOS 15.0, *)
extension ARKitCornerCaptureController: @preconcurrency ARSessionDelegate {
    // Verified against the installed SDK's `ARSession.h` this pass — the
    // delegate method is `session(_:cameraDidChangeTrackingState:)`, not
    // `session(_:camera:)` (which does not exist on `ARSessionDelegate`).
    public func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        trackingState = camera.trackingState
        delegate?.arKitCapture(self, trackingStateDidChange: camera.trackingState)
    }
}
#endif
