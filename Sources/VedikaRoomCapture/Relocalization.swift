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
    public let maximumReprojectionErrorPixels: Double
    public let requiredFrames: Int
    public init(maximumReprojectionErrorPixels: Double = 8, requiredFrames: Int = 3) {
        self.maximumReprojectionErrorPixels = maximumReprojectionErrorPixels
        self.requiredFrames = max(1, requiredFrames)
    }
    @discardableResult
    public mutating func observe(trackingNormal: Bool, expectedAnchorIds: Set<UUID>,
                                 restoredAnchorIds: Set<UUID>, reprojectionErrorsPixels: [Double]) -> Bool {
        guard maximumReprojectionErrorPixels.isFinite, maximumReprojectionErrorPixels > 0,
              trackingNormal, !expectedAnchorIds.isEmpty,
              expectedAnchorIds.isSubset(of: restoredAnchorIds), reprojectionErrorsPixels.count == expectedAnchorIds.count,
              reprojectionErrorsPixels.allSatisfy({ $0.isFinite && $0 >= 0 && $0 <= maximumReprojectionErrorPixels }) else {
            reset(); return false
        }
        passingFrames += 1; overlaysAllowed = passingFrames >= requiredFrames
        return overlaysAllowed
    }
    public mutating func reset() { passingFrames = 0; overlaysAllowed = false }
}

#if os(iOS) && canImport(ARKit)
import ARKit
import CryptoKit
import UIKit

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
    public static func evaluate(frame: ARFrame, reference: LocalWorldMapReference,
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
            restoredAnchorIds: Set(frame.anchors.map(\.identifier)), reprojectionErrorsPixels: errors)
    }
}
#endif
