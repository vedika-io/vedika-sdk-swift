import Foundation
import VedikaSDK

/// A single explicit magnetic→true correction. Values are API-returned, not
/// CLLocation.trueHeading estimates. The person confirms the orientation.
public struct ConfirmedCaptureNorth: Sendable {
    public let magneticSamples: [RoomCaptureHeadingSample]
    public let declinationDeg: Double
    public let provenance: String
    public init(magneticSamples: [RoomCaptureHeadingSample], declinationDeg: Double,
                provenance: String, userConfirmed: Bool) throws {
        guard userConfirmed, declinationDeg.isFinite, abs(declinationDeg) <= 180,
              ["live", "manual", "native", "fixture"].contains(provenance),
              magneticSamples.count >= RoomCaptureModel.minNorthSamples,
              magneticSamples.allSatisfy({ $0.headingDeg.isFinite && $0.headingDeg >= 0 && $0.headingDeg < 360
                  && $0.forward.x.isFinite && $0.forward.y.isFinite && $0.forward.z.isFinite
                  && hypot($0.forward.x, $0.forward.z) > 0.01 }) else {
            throw RoomCaptureError("Confirm north using calibrated compass samples and API declination")
        }
        self.magneticSamples = magneticSamples; self.declinationDeg = declinationDeg; self.provenance = provenance
    }
}

#if os(iOS) && canImport(RoomPlan)
import RoomPlan
import ARKit
import SwiftUI

@available(iOS 16.0, *)
@MainActor
public enum RoomPlanAdapter {
    public static let roomTypes = ["kitchen", "bedroom", "master bedroom", "pooja", "toilet", "living",
                                   "dining", "storage", "treasury", "study", "staircase", "entrance", "guest", "children"]
    public static func session(room: CapturedRoom, captureId: String, capturedAt: Date,
                               label: String, north: ConfirmedCaptureNorth) throws -> VedikaSDK.RoomCaptureSession {
        guard roomTypes.contains(label) else { throw RoomCaptureError("Choose a supported room type") }
        var session = try RoomPlanCaptureController.toCaptureSession(room, captureId: captureId, startedAt: capturedAt,
            headingSamples: north.magneticSamples, declinationDeg: north.declinationDeg, declinationProvenance: north.provenance)
        // The legacy bridge assumes corrected samples when declination exists.
        // This adapter retains magnetic samples and lets geometry correct ONCE.
        session.headingFrame = "magnetic"
        let heights = room.walls.map { Double($0.dimensions.y) }.filter { $0.isFinite && $0 > 0 }
        if let minimum = heights.min(), let maximum = heights.max(), maximum - minimum <= 0.05 {
            session.rooms[0].heightM = heights.reduce(0, +) / Double(heights.count)
        }
        return try session.confirmed(label: label, outline: .singleRoomPerimeter)
    }
    public static func capture(room: CapturedRoom, captureId: String, capturedAt: Date = Date(),
                               label: String, north: ConfirmedCaptureNorth) throws -> VastuRoomCapture {
        try RoomCaptureGeometry.buildRoomCapture(session(room: room, captureId: captureId, capturedAt: capturedAt, label: label, north: north))
    }
    /// StructureBuilder rooms are already in one shared world frame. Never
    /// concatenate wall loops into a fabricated property boundary: the caller
    /// must trace and explicitly confirm that boundary in the SAME frame.
    @available(iOS 17.0, *)
    public static func capture(structure: CapturedStructure, captureId: String, capturedAt: Date = Date(),
                               labels: [UUID: String], north: ConfirmedCaptureNorth,
                               boundary: RoomCaptureOutlineInput, boundaryConfirmed: Bool) throws -> VastuRoomCapture {
        guard boundaryConfirmed, boundary.source == "traced", boundary.worldCorners.count >= 3,
              boundary.closingTap != nil, let first = structure.rooms.first,
              labels.count == structure.rooms.count else { throw RoomCaptureError("Confirm every room and the traced property boundary") }
        var combined = try session(room: first, captureId: captureId, capturedAt: capturedAt,
            label: labels[first.identifier] ?? "", north: north)
        combined.rooms = try structure.rooms.map { room in
            var input = try session(room: room, captureId: captureId, capturedAt: capturedAt,
                label: labels[room.identifier] ?? "", north: north).rooms[0]
            input.id = room.identifier.uuidString; input.floorIndex = room.story
            return input
        }
        combined.outline = boundary; combined.outlineConfirmed = true
        return try RoomCaptureGeometry.buildRoomCapture(combined)
    }
    public static func decode(_ json: Data) throws -> CapturedRoom { try JSONDecoder().decode(CapturedRoom.self, from: json) }
}

/// Render saved overlays only behind this per-frame gate. Passing a previous
/// frame or nil immediately removes the overlay; cached success is never used.
@available(iOS 16.0, *)
public struct RelocalizedOverlay<Content: View>: View {
    public let allowed: Bool
    private let content: () -> Content
    public init(allowed: Bool, @ViewBuilder content: @escaping () -> Content) { self.allowed = allowed; self.content = content }
    public var body: some View { Group { if allowed { content() } }.allowsHitTesting(allowed) }
}
#endif
