import Foundation

public struct LocalWorldMapReference: Codable, Sendable, Equatable {
    public let fileName: String
    public let sha256: String
    public let anchorIds: [UUID]
    public init(fileName: String, sha256: String, anchorIds: [UUID]) {
        self.fileName = fileName; self.sha256 = sha256; self.anchorIds = anchorIds
    }
}

public struct CaptureLocalMetadata: Codable, Sendable, Equatable {
    public let propertyId: String
    public let captureId: String
    public let worldMap: LocalWorldMapReference?
    public init(propertyId: String, captureId: String, worldMap: LocalWorldMapReference?) {
        self.propertyId = propertyId; self.captureId = captureId; self.worldMap = worldMap
    }
}

/// Normal tracking alone does not establish the identity of a restored place.
/// A physical landmark must agree with the restored anchor's projection.
public struct OverlayRelocalizationGate: Sendable {
    public private(set) var overlaysAllowed = false
    private var passingFrames = 0
    private var expectedIdentity: Set<UUID>?
    private var lastFrameTimestamp: Double?
    public let maximumReprojectionErrorPixels: Double
    public let requiredFrames: Int
    public init(maximumReprojectionErrorPixels: Double = 8, requiredFrames: Int = 3) {
        self.maximumReprojectionErrorPixels = maximumReprojectionErrorPixels
        self.requiredFrames = max(1, requiredFrames)
    }
    @discardableResult
    public mutating func observe(trackingNormal: Bool, expectedAnchorIds: Set<UUID>,
                                 restoredAnchorIds: Set<UUID>, reprojectionErrorsPixels: [Double],
                                 frameTimestamp: Double? = nil) -> Bool {
        if let timestamp = frameTimestamp {
            guard timestamp.isFinite, lastFrameTimestamp.map({ timestamp > $0 }) ?? true else {
                passingFrames = 0; overlaysAllowed = false; return false
            }
            lastFrameTimestamp = timestamp
        }
        if expectedIdentity != expectedAnchorIds { passingFrames = 0; overlaysAllowed = false }
        expectedIdentity = expectedAnchorIds
        guard maximumReprojectionErrorPixels.isFinite, maximumReprojectionErrorPixels > 0,
              trackingNormal, !expectedAnchorIds.isEmpty,
              expectedAnchorIds.isSubset(of: restoredAnchorIds), reprojectionErrorsPixels.count == expectedAnchorIds.count,
              reprojectionErrorsPixels.allSatisfy({ $0.isFinite && $0 >= 0 && $0 <= maximumReprojectionErrorPixels }) else {
            reset(); return false
        }
        passingFrames = min(requiredFrames, passingFrames + 1); overlaysAllowed = passingFrames >= requiredFrames
        return overlaysAllowed
    }
    public mutating func reset() {
        passingFrames = 0; overlaysAllowed = false; expectedIdentity = nil; lastFrameTimestamp = nil
    }
}

/// A rigid, column-major AR world pose. Camera poses are never floor anchors.
public struct FloorAnchorPose: Sendable, Equatable {
    public let columns: [Double]
    public init(columns: [Double]) throws {
        guard columns.count == 16, columns.allSatisfy({ $0.isFinite }),
              abs(columns[3]) < 1e-6, abs(columns[7]) < 1e-6,
              abs(columns[11]) < 1e-6, abs(columns[15] - 1) < 1e-6 else {
            throw FloorOverlayError.invalidTransform
        }
        let axes = (0..<3).map { i in SIMD3(columns[i * 4], columns[i * 4 + 1], columns[i * 4 + 2]) }
        for i in 0..<3 {
            guard abs(Self.dot(axes[i], axes[i]) - 1) < 1e-5 else { throw FloorOverlayError.invalidTransform }
            for j in 0..<i {
                guard abs(Self.dot(axes[i], axes[j])) < 1e-5 else { throw FloorOverlayError.invalidTransform }
            }
        }
        guard Self.dot(Self.cross(axes[0], axes[1]), axes[2]) > 0.99999 else { throw FloorOverlayError.invalidTransform }
        self.columns = columns
    }
    static func dot(_ a: SIMD3<Double>, _ b: SIMD3<Double>) -> Double { a.x * b.x + a.y * b.y + a.z * b.z }
    static func cross(_ a: SIMD3<Double>, _ b: SIMD3<Double>) -> SIMD3<Double> {
        SIMD3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
    }
    public func worldPoint(_ local: SIMD3<Double>) -> SIMD3<Double> {
        SIMD3(columns[12], columns[13], columns[14]) +
            SIMD3(columns[0], columns[1], columns[2]) * local.x +
            SIMD3(columns[4], columns[5], columns[6]) * local.y +
            SIMD3(columns[8], columns[9], columns[10]) * local.z
    }
    public func localPoint(_ world: SIMD3<Double>) -> SIMD3<Double> {
        let offset = world - SIMD3(columns[12], columns[13], columns[14])
        return SIMD3(Self.dot(offset, SIMD3(columns[0], columns[1], columns[2])),
                     Self.dot(offset, SIMD3(columns[4], columns[5], columns[6])),
                     Self.dot(offset, SIMD3(columns[8], columns[9], columns[10])))
    }
}

public enum FloorOverlayError: Error { case invalidTransform, invalidGeometry, invalidIdentity }

/// Freeze capture.frame.planToWorld in the ORIGINAL floor anchor's space.
/// After map restore use that same anchor ID's CURRENT pose, never the camera.
/// Units/axes and north provenance come from the capture; no compass correction
/// is applied here. A changed north confirmation requires a new binding.
public struct FloorPlanAnchorTransform: Sendable {
    public let originalAnchor: FloorAnchorPose
    public let origin: SIMD3<Double>
    public let xAxis: SIMD3<Double>
    public let yAxis: SIMD3<Double>
    public init(origin: [Double], xAxis: [Double], yAxis: [Double],
                originalAnchor: FloorAnchorPose, units: String = "metres") throws {
        guard units == "metres", [origin, xAxis, yAxis].allSatisfy({ $0.count == 3 && $0.allSatisfy({ $0.isFinite }) }) else {
            throw FloorOverlayError.invalidTransform
        }
        let x = SIMD3(xAxis[0], xAxis[1], xAxis[2]), y = SIMD3(yAxis[0], yAxis[1], yAxis[2])
        // The published plan frame is horizontal, orthonormal and Y-up.
        guard abs(FloorAnchorPose.dot(x, x) - 1) < 1e-5,
              abs(FloorAnchorPose.dot(y, y) - 1) < 1e-5,
              abs(FloorAnchorPose.dot(x, y)) < 1e-5,
              FloorAnchorPose.cross(x, y).y > 0.99999 else { throw FloorOverlayError.invalidTransform }
        self.originalAnchor = originalAnchor; self.origin = SIMD3(origin[0], origin[1], origin[2])
        self.xAxis = x; self.yAxis = y
    }
    public func anchorPoint(east: Double, north: Double) throws -> SIMD3<Double> {
        guard east.isFinite, north.isFinite else { throw FloorOverlayError.invalidGeometry }
        let point = originalAnchor.localPoint(origin + xAxis * east + yAxis * north)
        guard point.x.isFinite, point.y.isFinite, point.z.isFinite else { throw FloorOverlayError.invalidGeometry }
        return point
    }
}

/// Separate frame freshness from map reuse policy (three frames, eight pixels).
/// Cached/duplicate frames cannot establish a place or retain visible geometry.
public struct FloorOverlayTrackingGuard: Sendable {
    public private(set) var overlaysAllowed = false
    private var lastTimestamp: Double?
    private let sessionId: UUID
    private let northRevision: UUID
    public init(sessionId: UUID, northRevision: UUID) {
        self.sessionId = sessionId; self.northRevision = northRevision
    }
    @discardableResult
    public mutating func observe(timestamp: Double?, now: Double, trackingNormal: Bool,
                                 anchorPresent: Bool, relocalized: Bool,
                                 sessionId: UUID, northRevision: UUID) -> Bool {
        guard let timestamp, timestamp.isFinite, now.isFinite,
              now >= timestamp, now - timestamp < 0.25,
              lastTimestamp.map({ timestamp > $0 }) ?? true,
              trackingNormal, anchorPresent, relocalized,
              sessionId == self.sessionId, northRevision == self.northRevision else {
            overlaysAllowed = false
            return false
        }
        lastTimestamp = timestamp; overlaysAllowed = true
        return true
    }
    public mutating func reset() { lastTimestamp = nil; overlaysAllowed = false }
}

/// Geometry supplied by the actual zone/mandala result, in capture plan metres.
/// This renderer adds no astrological interpretation or north estimate.
public struct FloorOverlayPolygon: Sendable {
    public let label: String
    public let points: [SIMD2<Double>]
    public init(label: String, points: [SIMD2<Double>]) throws {
        guard points.count >= 3, points.allSatisfy({ $0.x.isFinite && $0.y.isFinite }),
              Set(points.map { "\($0.x),\($0.y)" }).count >= 3 else { throw FloorOverlayError.invalidGeometry }
        let doubledArea = points.indices.reduce(0.0) { sum, i in
            let a = points[i], b = points[(i + 1) % points.count]
            return sum + a.x * b.y - b.x * a.y
        }
        guard doubledArea.isFinite, abs(doubledArea) > 1e-9 else { throw FloorOverlayError.invalidGeometry }
        self.label = label; self.points = points
    }
}

#if os(iOS) && canImport(ARKit)
import ARKit
import CryptoKit
import UIKit
import SceneKit

public enum WorldMapError: Error { case unavailable, missingAnchors, invalidReference, hashMismatch }

/// Maps and their references stay on the buyer's device. No Cloud Anchors,
/// Geospatial API or map upload is used. One store owns the supplied directory.
@available(iOS 16.0, *)
@MainActor
public final class LocalWorldMapStore {
    private let directory: URL
    private let key: SymmetricKey
    private let aad = Data("vedika.world-map/1".utf8)
    public init(directory: URL, key: SymmetricKey) { self.directory = directory; self.key = key }

    public func save(session: ARSession, anchorIds: Set<UUID>) async throws -> LocalWorldMapReference {
        let map: ARWorldMap = try await withCheckedThrowingContinuation { continuation in
            session.getCurrentWorldMap { map, error in
                if let error { continuation.resume(throwing: error) }
                else if let map { continuation.resume(returning: map) }
                else { continuation.resume(throwing: WorldMapError.unavailable) }
            }
        }
        guard !anchorIds.isEmpty, anchorIds.isSubset(of: Set(map.anchors.map(\.identifier))) else { throw WorldMapError.missingAnchors }
        let data = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
        let name = UUID().uuidString + ".worldmap.aesgcm"
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let box = try AES.GCM.seal(data, using: key, authenticating: aad)
        try box.combined!.write(to: directory.appendingPathComponent(name), options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
        return LocalWorldMapReference(fileName: name, sha256: CaptureOutbox.hash(data), anchorIds: anchorIds.sorted { $0.uuidString < $1.uuidString })
    }

    public func restore(_ reference: LocalWorldMapReference, session: ARSession) throws {
        // Permit the exact generated filename shape, never a relative traversal.
        let suffix = ".worldmap.aesgcm"
        guard reference.fileName.hasSuffix(suffix), UUID(uuidString: String(reference.fileName.dropLast(suffix.count))) != nil else { throw WorldMapError.invalidReference }
        let box = try AES.GCM.SealedBox(combined: Data(contentsOf: directory.appendingPathComponent(reference.fileName)))
        let data = try AES.GCM.open(box, using: key, authenticating: aad)
        guard CaptureOutbox.hash(data) == reference.sha256 else { throw WorldMapError.hashMismatch }
        guard let map = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data),
              !reference.anchorIds.isEmpty, Set(reference.anchorIds).isSubset(of: Set(map.anchors.map(\.identifier))) else { throw WorldMapError.missingAnchors }
        let config = ARWorldTrackingConfiguration(); config.initialWorldMap = map
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }

    /// The caller supplies screen observations of the SAME physical markers,
    /// from a manual tap or a measured detector, never saved pixel positions.
    /// Do not render overlays until the returned gate becomes true. Evaluate
    /// each frame and hide immediately when tracking/landmark agreement fails.
    nonisolated public static func evaluate(frame: ARFrame, reference: LocalWorldMapReference,
                                observedMarkers: [UUID: CGPoint], orientation: UIInterfaceOrientation,
                                viewport: CGSize, gate: inout OverlayRelocalizationGate) -> Bool {
        let expected = Set(reference.anchorIds)
        guard abs(ProcessInfo.processInfo.systemUptime - frame.timestamp) < 0.25,
              expected.isSubset(of: Set(observedMarkers.keys)), viewport.width > 0, viewport.height > 0 else { gate.reset(); return false }
        var errors: [Double] = []
        for anchor in frame.anchors where expected.contains(anchor.identifier) {
            let p = anchor.transform.columns.3
            let cameraPoint = simd_inverse(frame.camera.transform) * p
            guard cameraPoint.z < 0 else { gate.reset(); return false }
            let projected = frame.camera.projectPoint(SIMD3(p.x, p.y, p.z), orientation: orientation, viewportSize: viewport)
            let observed = observedMarkers[anchor.identifier]!
            guard projected.x.isFinite, projected.y.isFinite,
                  projected.x >= 0, projected.x <= viewport.width, projected.y >= 0, projected.y <= viewport.height,
                  observed.x.isFinite, observed.y.isFinite,
                  observed.x >= 0, observed.x <= viewport.width, observed.y >= 0, observed.y <= viewport.height else {
                gate.reset(); return false
            }
            errors.append(hypot(Double(projected.x - observed.x), Double(projected.y - observed.y)))
        }
        let normal: Bool
        if case .normal = frame.camera.trackingState { normal = true } else { normal = false }
        return gate.observe(trackingNormal: normal, expectedAnchorIds: expected,
            restoredAnchorIds: Set(frame.anchors.map(\.identifier)), reprojectionErrorsPixels: errors,
            frameTimestamp: frame.timestamp)
    }
}
#endif

#if os(iOS) && canImport(ARKit)
/// Actual ARKit camera consumer. Geometry is attached to a floor anchor, not
/// SwiftUI screen coordinates. Own one renderer per camera view, and call
/// invalidate() before north/session reset, interruption or leaving the view.
/// Keep the original anchor pose and plan transform locally with the map.
@available(iOS 16.0, *)
public final class PinnedFloorOverlayRenderer: @unchecked Sendable {
    public let view: ARSCNView
    private let root = SCNNode()
    private let lock = NSRecursiveLock()
    private let session: ARSession
    private let anchorId: UUID
    private let reference: LocalWorldMapReference
    private var mapGate = OverlayRelocalizationGate()
    private var trackingGuard: FloorOverlayTrackingGuard
    private let sessionId: UUID
    private let northRevision: UUID
    private let delegateProxy = FloorOverlaySceneDelegate()

    /// Remedies share the zone polygons' floor anchor and per-frame refusal
    /// gates. Keep full advice/source text from remedies.placements in the UI.
    public convenience init(session: ARSession, anchorId: UUID, reference: LocalWorldMapReference,
                            sessionId: UUID, northRevision: UUID, transform: FloorPlanAnchorTransform,
                            remedies: RemedyFloorOverlay, polygons: [FloorOverlayPolygon] = []) throws {
        try self.init(session: session, sessionId: sessionId, northRevision: northRevision,
            reference: reference, anchorId: anchorId, transform: transform,
            polygons: polygons + remedies.polygons)
    }
    /// Fresh physical-marker observations in the CURRENT view viewport. A
    /// timestamp is mandatory; cached saved marker pixels never establish reuse.
    private var markerProvider: (() -> (timestamp: TimeInterval, points: [UUID: CGPoint]))?
    private var orientation: UIInterfaceOrientation = .portrait
    /// Invoked on the render thread; the provider must be thread-safe.
    public var observedMarkers: (() -> (timestamp: TimeInterval, points: [UUID: CGPoint]))? {
        get { lock.lock(); defer { lock.unlock() }; return markerProvider }
        set { lock.lock(); defer { lock.unlock() }; markerProvider = newValue }
    }
    public var interfaceOrientation: UIInterfaceOrientation {
        get { lock.lock(); defer { lock.unlock() }; return orientation }
        set { lock.lock(); defer { lock.unlock() }; orientation = newValue }
    }

    @MainActor
    public init(session: ARSession, sessionId: UUID, northRevision: UUID,
                reference: LocalWorldMapReference, anchorId: UUID,
                transform: FloorPlanAnchorTransform, polygons: [FloorOverlayPolygon]) throws {
        guard reference.anchorIds.contains(anchorId), !polygons.isEmpty else { throw FloorOverlayError.invalidIdentity }
        self.anchorId = anchorId; self.reference = reference; self.session = session
        self.sessionId = sessionId; self.northRevision = northRevision
        trackingGuard = FloorOverlayTrackingGuard(sessionId: sessionId, northRevision: northRevision)
        view = ARSCNView(frame: .zero); view.session = session; view.scene = SCNScene()
        root.isHidden = true; view.scene.rootNode.addChildNode(root)
        for polygon in polygons {
            let points = try polygon.points.map { try transform.anchorPoint(east: $0.x, north: $0.y) }
            let vertices = points.map { point -> SCNVector3 in
                let lifted = transform.originalAnchor.localPoint(transform.originalAnchor.worldPoint(point) + SIMD3(0, 0.008, 0))
                return SCNVector3(Float(lifted.x), Float(lifted.y), Float(lifted.z))
            }
            let indices = points.indices.flatMap { [Int32($0), Int32(($0 + 1) % points.count)] }
            let geometry = SCNGeometry(sources: [SCNGeometrySource(vertices: vertices)],
                elements: [SCNGeometryElement(indices: indices, primitiveType: .line)])
            let material = SCNMaterial(); material.diffuse.contents = UIColor.systemYellow
            material.lightingModel = .constant; material.readsFromDepthBuffer = false
            material.writesToDepthBuffer = false; geometry.materials = [material]
            root.addChildNode(SCNNode(geometry: geometry))
            if !polygon.label.isEmpty {
                let text = SCNText(string: polygon.label, extrusionDepth: 0)
                text.font = .systemFont(ofSize: 1); text.flatness = 0.1; text.materials = [material]
                let label = SCNNode(geometry: text)
                let center = points.reduce(SIMD3<Double>(repeating: 0), +) / Double(points.count)
                let labelPoint = transform.originalAnchor.localPoint(transform.originalAnchor.worldPoint(center) + SIMD3(0, 0.025, 0))
                label.position = SCNVector3(Float(labelPoint.x), Float(labelPoint.y), Float(labelPoint.z))
                label.scale = SCNVector3(0.12, 0.12, 0.12)
                let (minimum, maximum) = label.boundingBox
                label.pivot = SCNMatrix4MakeTranslation((minimum.x + maximum.x) / 2, (minimum.y + maximum.y) / 2, 0)
                label.constraints = [SCNBillboardConstraint()]; root.addChildNode(label)
            }
        }
        delegateProxy.owner = self; view.delegate = delegateProxy
        view.isPlaying = true; view.rendersContinuously = true
    }
    /// Called on EACH displayed frame by SceneKit, including when ARKit stops
    /// producing frames. Hide before validation so failures never retain success.
    fileprivate func update(viewport: CGSize) {
        lock.lock(); defer { lock.unlock() }
        root.isHidden = true
        let now = ProcessInfo.processInfo.systemUptime
        guard let frame = session.currentFrame,
              let anchor = frame.anchors.first(where: { $0.identifier == anchorId }),
              let observations = markerProvider?(), observations.timestamp.isFinite,
              observations.timestamp <= now, now - observations.timestamp < 0.25,
              abs(observations.timestamp - frame.timestamp) < 0.25 else {
            mapGate.reset(); trackingGuard.reset(); return
        }
        let normal: Bool
        if case .normal = frame.camera.trackingState { normal = true } else { normal = false }
        let mapAllowed = LocalWorldMapStore.evaluate(frame: frame, reference: reference,
            observedMarkers: observations.points, orientation: orientation,
            viewport: viewport, gate: &mapGate)
        let allowed = trackingGuard.observe(timestamp: frame.timestamp, now: now,
            trackingNormal: normal, anchorPresent: true, relocalized: mapAllowed,
            sessionId: sessionId, northRevision: northRevision)
        guard allowed else { if mapAllowed { mapGate.reset() }; return }
        let matrix = anchor.transform
        let columns = [matrix.columns.0, matrix.columns.1, matrix.columns.2, matrix.columns.3]
            .flatMap { [Double($0.x), Double($0.y), Double($0.z), Double($0.w)] }
        guard (try? FloorAnchorPose(columns: columns)) != nil else {
            mapGate.reset(); trackingGuard.reset(); return
        }
        root.simdTransform = anchor.transform; root.isHidden = false
    }
    fileprivate func trackingLost() {
        lock.lock(); defer { lock.unlock() }
        root.isHidden = true; mapGate.reset(); trackingGuard.reset()
    }
    deinit { root.isHidden = true }
    public func invalidate() {
        lock.lock(); defer { lock.unlock() }
        root.isHidden = true; mapGate.reset(); trackingGuard.reset(); markerProvider = nil
    }
}

@available(iOS 16.0, *)
private final class FloorOverlaySceneDelegate: NSObject, ARSCNViewDelegate {
    weak var owner: PinnedFloorOverlayRenderer?
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        if case .normal = camera.trackingState { return }
        owner?.trackingLost()
    }
    func sessionWasInterrupted(_ session: ARSession) { owner?.invalidate() }
    func session(_ session: ARSession, didFailWithError error: Error) { owner?.invalidate() }
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Run before drawing on SceneKit's render thread. Never synchronously
        // dispatch to main: the UI may already be waiting for this renderer.
        owner?.update(viewport: renderer.currentViewport.size)
    }
}
#endif
