import Foundation

/// Native room capture for ARKit (and, by the same shape, RoomPlan's manual
/// fallback and ARCore): tap/closeAt/undo/startRoom/addNorthSample/toSession/
/// build. A line-for-line Swift port of `RoomCaptureModel` in
/// `sdks/android-ar/src/main/kotlin/io/vedika/sdk/ar/RoomCaptureModel.kt`,
/// itself a port of `createCaptureModel` in
/// `web/vedika-public/js/vastu/room-capture-webxr.js` — see that file's header
/// for what this pure model does and does not claim.
///
/// This class touches no UIKit, ARKit or RoomPlan type — a capture
/// controller feeds it raycast hit poses and camera-forward vectors as plain
/// `Vec3` values. That keeps it testable on a bare `swift build`/`swift
/// test`, exactly like its Kotlin and JS siblings.
///
/// North is set by the operator, never inferred: they face a direction they
/// already know is north and hold "This way is north" for `minNorthMs` while
/// at least `minNorthSamples` camera-forward samples arrive. The result's
/// `frame.north.referenceFrame` is always `"manual"` — this model has no
/// compass and makes no true-north claim of its own. (`TrueHeadingSampler`,
/// the iOS-only Core Location bridge, is a separate, optional source of real
/// heading samples for callers that want `"true"` or `"magnetic"` instead —
/// see its header.)
///
/// Vedika-Task: R-004
public final class RoomCaptureModel {

    public static let closeSnapM = 0.3
    public static let minCorners = 3
    /// North needs this many samples over at least this long, like the web calibrate step.
    public static let minNorthSamples = 15
    public static let minNorthMs: Int64 = 3000
    public static let maxRooms = 64
    public static let maxCorners = 256

    /// Room names the server's `normalize_room_type` recognises. Mirrors
    /// `ROOM_LABELS` in `room-capture-webxr.js` and the Kotlin port.
    public static let roomLabels: [String] = [
        "kitchen", "master bedroom", "bedroom", "children bedroom", "guest bedroom", "pooja",
        "living room", "dining room", "toilet", "bathroom", "study", "store room", "staircase", "entrance",
    ]

    public enum Phase { case outline, rooms }

    public enum TapResult { case added, closed }

    public struct RoomSummary { public let label: String?; public let corners: Int }

    private final class Loop {
        var worldCorners: [Vec3] = []
        var closingTap: Vec3?
    }

    private final class Room {
        let id: String
        let label: String?
        let labelSource: String
        var closingTap: Vec3?
        var worldCorners: [Vec3] = []
        var openings: [RoomCaptureOpeningInput] = []
        init(id: String, label: String?, labelSource: String) {
            self.id = id
            self.label = label
            self.labelSource = labelSource
        }
    }

    private let captureId: String
    private let now: () -> Int64
    private let startedAt: Int64
    private var phase: Phase = .outline
    private let outline = Loop()
    private var rooms: [Room] = []
    private var current: Room?
    private var north: [(Vec3, Int64)] = []
    private var northStart: Int64?

    public init(_ captureId: String, now: @escaping () -> Int64 = { Int64(Date().timeIntervalSince1970 * 1000) }) {
        self.captureId = captureId
        self.now = now
        self.startedAt = now()
    }

    public var currentPhase: Phase { phase }
    public var tracing: Bool { phase == .outline || current != nil }
    public var outlineCorners: [Vec3] { outline.worldCorners }
    public var roomSummaries: [RoomSummary] { rooms.map { RoomSummary(label: $0.label, corners: $0.worldCorners.count) } }
    public var currentRoom: RoomSummary? { current.map { RoomSummary(label: $0.label, corners: $0.worldCorners.count) } }
    public var northSamples: Int { north.count }
    public var northReady: Bool {
        north.count >= Self.minNorthSamples && (north.last?.1 ?? 0) - (northStart ?? 0) >= Self.minNorthMs
    }

    private func activeCorners() -> [Vec3]? { phase == .outline ? outline.worldCorners : current?.worldCorners }
    private func setActiveCorners(_ corners: [Vec3]) {
        if phase == .outline { outline.worldCorners = corners } else { current?.worldCorners = corners }
    }
    private func firstCorner() -> Vec3? { phase == .outline ? outline.worldCorners.first : current?.worldCorners.first }

    private func dist(_ a: Vec3, _ b: Vec3) -> Double {
        let dx = a.x - b.x
        let dz = a.z - b.z
        return (dx * dx + dz * dz).squareRoot()
    }

    private func closeLoop(_ tap: Vec3) throws {
        guard let corners = activeCorners() else { throw RoomCaptureError("Add a room before tapping corners") }
        guard corners.count >= Self.minCorners else { throw RoomCaptureError("Tap at least \(Self.minCorners) corners before closing") }
        if phase == .outline {
            outline.closingTap = tap
            phase = .rooms
        } else {
            guard let room = current else { throw RoomCaptureError("Nothing is being traced") }
            room.closingTap = tap
            rooms.append(room)
            current = nil
        }
    }

    /// Returns `.added` or `.closed`. A tap near the loop's first corner closes it.
    @discardableResult
    public func tap(_ point: Vec3) throws -> TapResult {
        if phase == .rooms && current == nil { throw RoomCaptureError("Add a room before tapping corners") }
        var corners = activeCorners()!
        let first = firstCorner()
        if corners.count >= Self.minCorners, let first, dist(point, first) <= Self.closeSnapM {
            try closeLoop(point)
            return .closed
        }
        if corners.count >= Self.maxCorners { throw RoomCaptureError("A loop can have at most \(Self.maxCorners) corners") }
        corners.append(point)
        setActiveCorners(corners)
        return .added
    }

    /// Close the current loop with this tap even if it is not near the first corner.
    public func closeAt(_ point: Vec3) throws {
        if phase == .rooms && current == nil { throw RoomCaptureError("Nothing is being traced") }
        try closeLoop(point)
    }

    @discardableResult
    public func undo() -> Bool {
        if var corners = activeCorners(), !corners.isEmpty {
            corners.removeLast()
            setActiveCorners(corners)
            return true
        }
        if phase == .rooms && current == nil && !rooms.isEmpty {
            let restored = rooms.removeLast()
            restored.closingTap = nil
            current = restored
            return true
        }
        return false
    }

    public func startRoom(_ label: String?) throws {
        guard phase == .rooms else { throw RoomCaptureError("Close the outline first") }
        guard current == nil else { throw RoomCaptureError("Finish the room you are tracing first") }
        guard rooms.count < Self.maxRooms else { throw RoomCaptureError("At most \(Self.maxRooms) rooms") }
        let clean = label?.trimmingCharacters(in: .whitespacesAndNewlines).nonEmpty
        current = Room(id: "room-\(rooms.count + 1)", label: clean, labelSource: clean != nil ? "user" : "none")
    }

    /// One "facing north" sample: the camera's forward vector at time `t`.
    public func addNorthSample(_ forward: Vec3, at t: Int64? = nil) {
        let time = t ?? now()
        if northStart == nil { northStart = time }
        north.append((forward, time))
    }

    public func resetNorth() {
        north.removeAll()
        northStart = nil
    }

    /// The `RoomCaptureSession` `RoomCaptureGeometry.buildRoomCapture` takes.
    public func toSession(device: RoomCaptureDeviceInput? = nil, endedAt: Int64? = nil) throws -> RoomCaptureSession {
        let ended = endedAt ?? now()
        guard phase != .outline else { throw RoomCaptureError("Trace and close the outline first") }
        if let current { throw RoomCaptureError("Finish the room \"\(current.label ?? "unnamed")\" first") }
        guard northReady else { throw RoomCaptureError("Set north first") }
        let outlinePlan = outline.worldCorners.map { ($0.x, -$0.z) }
        let area = abs(RoomCaptureGeometry.signedArea(outlinePlan))
        return RoomCaptureSession(
            captureId: captureId,
            capturedAtEpoch: Int(startedAt / 1000),
            device: device ?? RoomCaptureDeviceInput(platform: "ios", method: "arkit-raycast", depth: "none"),
            headingFrame: "true",
            north: RoomCaptureNorthInput(referenceFrame: "manual", headingSource: "viewer-facing-north", declinationProvenance: "manual"),
            // Facing north means a heading of 0 along the camera's forward vector.
            headingSamples: north.map { RoomCaptureHeadingSample(headingDeg: 0.0, forward: $0.0) },
            outline: RoomCaptureOutlineInput(source: "traced", worldCorners: outline.worldCorners, closingTap: outline.closingTap),
            rooms: rooms.map { room in
                RoomCaptureRoomInput(
                    id: room.id, label: room.label, labelSource: room.labelSource, floorIndex: 0, heightM: nil,
                    worldCorners: room.worldCorners, closingTap: room.closingTap, openings: room.openings
                )
            },
            quality: RoomCaptureQualityInput(
                pointCloudDensityBasis: "none",
                scanDurationSec: Double(max(0, Int64((Double(ended - startedAt) / 1000.0).rounded()))),
                scannedAreaM2: RoomCaptureGeometry.roundHalfUp(area, 2),
                expectedRoomCount: rooms.count
            )
        )
    }

    public func build(device: RoomCaptureDeviceInput? = nil, endedAt: Int64? = nil) throws -> VastuRoomCapture {
        try RoomCaptureGeometry.buildRoomCapture(toSession(device: device, endedAt: endedAt))
    }
}

private extension String {
    var nonEmpty: String? { isEmpty ? nil : self }
}
