// Plain-value types the pure capture model and geometry work with. No
// UIKit/ARKit/RoomPlan/CoreLocation import anywhere in this file: this file,
// `RoomCaptureGeometry.swift` and `RoomCaptureModel.swift` must build and run
// under a plain `swift build`/`swift test` on macOS, exactly like the JVM
// port (`sdks/android-ar/src/main/kotlin/io/vedika/sdk/ar/RoomCaptureTypes.kt`)
// builds on a bare JVM — see that file's header for why that matters for
// cross-platform parity (this is a line-for-line Swift port of it).

import Foundation

/// A point in AR world space, metres, Y-up (matches WebXR/ARCore/ARKit convention).
public struct Vec3: Equatable, Sendable {
    public var x: Double
    public var y: Double
    public var z: Double

    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}

/// One "facing north" sample: the camera's forward vector at time of capture.
public struct RoomCaptureHeadingSample: Equatable, Sendable {
    public var headingDeg: Double
    public var forward: Vec3

    public init(headingDeg: Double, forward: Vec3) {
        self.headingDeg = headingDeg
        self.forward = forward
    }
}

public struct RoomCaptureOpeningInput: Equatable, Sendable {
    public var kind: String
    public var centerWorld: Vec3
    public var widthM: Double
    public var heightM: Double?
    public var confidence: String

    public init(kind: String, centerWorld: Vec3, widthM: Double, heightM: Double? = nil, confidence: String) {
        self.kind = kind
        self.centerWorld = centerWorld
        self.widthM = widthM
        self.heightM = heightM
        self.confidence = confidence
    }
}

public struct RoomCaptureRoomInput: Equatable, Sendable {
    public var id: String
    public var label: String?
    public var labelSource: String
    public var floorIndex: Int
    public var heightM: Double?
    public var worldCorners: [Vec3]
    public var closingTap: Vec3?
    public var openings: [RoomCaptureOpeningInput]

    public init(
        id: String, label: String?, labelSource: String, floorIndex: Int, heightM: Double? = nil,
        worldCorners: [Vec3], closingTap: Vec3?, openings: [RoomCaptureOpeningInput] = []
    ) {
        self.id = id
        self.label = label
        self.labelSource = labelSource
        self.floorIndex = floorIndex
        self.heightM = heightM
        self.worldCorners = worldCorners
        self.closingTap = closingTap
        self.openings = openings
    }
}

public struct RoomCaptureOutlineInput: Equatable, Sendable {
    public var source: String
    public var worldCorners: [Vec3]
    public var closingTap: Vec3?
    /// The widest unmeasured seam in the traced loop, for captures that are
    /// not tapped corner by corner (RoomPlan walls). `nil` for tapped
    /// outlines, where the closure gap is the only seam. When set, the
    /// reported closure gap is never smaller than this, so a hole in the
    /// middle of the loop cannot read as a closed outline.
    public var maxSeamGapM: Double?

    public init(source: String, worldCorners: [Vec3], closingTap: Vec3?, maxSeamGapM: Double? = nil) {
        self.source = source
        self.worldCorners = worldCorners
        self.closingTap = closingTap
        self.maxSeamGapM = maxSeamGapM
    }
}

public struct RoomCaptureQualityInput: Equatable, Sendable {
    public var pointCloudDensity: Double?
    public var pointCloudDensityBasis: String
    public var coveragePercent: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public var expectedRoomCount: Int?
    public var gpsConfidence: Double?

    public init(
        pointCloudDensity: Double? = nil, pointCloudDensityBasis: String, coveragePercent: Double? = nil,
        scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, expectedRoomCount: Int? = nil,
        gpsConfidence: Double? = nil
    ) {
        self.pointCloudDensity = pointCloudDensity
        self.pointCloudDensityBasis = pointCloudDensityBasis
        self.coveragePercent = coveragePercent
        self.scanDurationSec = scanDurationSec
        self.scannedAreaM2 = scannedAreaM2
        self.expectedRoomCount = expectedRoomCount
        self.gpsConfidence = gpsConfidence
    }
}

/// The `session.north` input before geometry recomputes `referenceFrame`.
public struct RoomCaptureNorthInput: Equatable, Sendable {
    public var referenceFrame: String
    public var headingSource: String
    public var declinationDeg: Double?
    public var declinationProvenance: String

    public init(referenceFrame: String, headingSource: String, declinationDeg: Double? = nil, declinationProvenance: String) {
        self.referenceFrame = referenceFrame
        self.headingSource = headingSource
        self.declinationDeg = declinationDeg
        self.declinationProvenance = declinationProvenance
    }
}

public struct RoomCaptureDeviceInput: Equatable, Sendable {
    public var platform: String
    public var method: String
    public var depth: String

    public init(platform: String, method: String, depth: String) {
        self.platform = platform
        self.method = method
        self.depth = depth
    }
}

/// The `session` object `RoomCaptureGeometry.buildRoomCapture` takes — the
/// same shape `room-capture-geometry.js`'s `session` parameter, the Kotlin
/// port's `RoomCaptureSession`, and the shared fixtures' `session` field
/// describe.
public struct RoomCaptureSession: Equatable, Sendable {
    public var captureId: String
    public var capturedAtEpoch: Int
    public var device: RoomCaptureDeviceInput
    /// "true" when `headingSamples[].headingDeg` already includes declination; "magnetic" otherwise.
    public var headingFrame: String
    public var north: RoomCaptureNorthInput
    public var headingSamples: [RoomCaptureHeadingSample]
    public var outline: RoomCaptureOutlineInput
    public var rooms: [RoomCaptureRoomInput]
    public var quality: RoomCaptureQualityInput
    /// True once the person scanning has named the room and confirmed how the
    /// outline relates to it (`confirmed(label:outline:)`). A RoomPlan capture
    /// starts unconfirmed: RoomPlan knows walls, not what the room is for.
    public var outlineConfirmed: Bool

    public init(
        captureId: String, capturedAtEpoch: Int, device: RoomCaptureDeviceInput, headingFrame: String,
        north: RoomCaptureNorthInput, headingSamples: [RoomCaptureHeadingSample], outline: RoomCaptureOutlineInput,
        rooms: [RoomCaptureRoomInput], quality: RoomCaptureQualityInput, outlineConfirmed: Bool = false
    ) {
        self.captureId = captureId
        self.capturedAtEpoch = capturedAtEpoch
        self.device = device
        self.headingFrame = headingFrame
        self.north = north
        self.headingSamples = headingSamples
        self.outline = outline
        self.rooms = rooms
        self.quality = quality
        self.outlineConfirmed = outlineConfirmed
    }
}

/// What the outline of a single-room RoomPlan capture means. The audit scope
/// is always explicit: one room, or a property boundary the caller traced.
public enum RoomCaptureOutlineConfirmation: Equatable, Sendable {
    /// The outline is this one room's own perimeter, as scanned. The audit
    /// covers this room only and says nothing about its place in a larger home.
    case singleRoomPerimeter
    /// The outline is the property boundary the caller traced (at least three
    /// corners, same world frame); the scanned room sits inside it.
    case propertyBoundary(worldCorners: [Vec3], closingTap: Vec3?)
}

extension RoomCaptureSession {
    /// The one `RoomCaptureSession` shape the RoomPlan controller produces for a
    /// finished scan: a single room with no label (`labelSource` "none") whose
    /// outline is the traced wall perimeter, not yet confirmed. The measured
    /// seams (`trace.closingTap`, `maxSeamGapM`) and RoomPlan's real quality
    /// (`RoomPlanCaptureQuality.measured()`) are kept as RoomPlan reported them.
    /// The server refuses a capture with no labelled room, so this is a draft
    /// until `confirmed(label:outline:)` names the room.
    public static func roomPlanSingleRoom(
        captureId: String, capturedAtEpoch: Int, headingSamples: [RoomCaptureHeadingSample],
        declinationDeg: Double?, declinationProvenance: String, trace: RoomPlanWallTrace,
        openings: [RoomCaptureOpeningInput]
    ) -> RoomCaptureSession {
        RoomCaptureSession(
            captureId: captureId,
            capturedAtEpoch: capturedAtEpoch,
            device: RoomCaptureDeviceInput(platform: "ios", method: "roomplan", depth: "lidar"),
            headingFrame: declinationDeg != nil ? "true" : "magnetic",
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

    /// True when at least one room carries a label the person gave (the
    /// server's own rule: an untagged capture has nothing to audit) and the
    /// outline has been confirmed.
    public var isReadyForUpload: Bool {
        outlineConfirmed && rooms.contains { $0.label != nil && $0.labelSource != "none" }
    }

    /// The label and outline confirmation step for a single-room capture.
    ///
    /// `label` is the room's use as the person says it: kitchen, bedroom,
    /// master bedroom, pooja, toilet, living, dining, storage, treasury,
    /// study, staircase, entrance, guest or children (the API refuses any
    /// other label and names the ones it did not recognise). It is sent with
    /// `labelSource` "user". `outline` states the scope: the room's own
    /// perimeter, or a property boundary the caller traced. Returns a copy;
    /// throws `RoomCaptureError` for a blank or over-long label, a session with
    /// more than one room, an outline that is not this room's perimeter, or a
    /// boundary of fewer than three corners.
    public func confirmed(label: String, outline confirmation: RoomCaptureOutlineConfirmation) throws -> RoomCaptureSession {
        let trimmed = label.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.utf8.count <= 64 else {
            throw RoomCaptureError("label must be nonblank and at most 64 characters")
        }
        guard rooms.count == 1 else {
            throw RoomCaptureError("confirmed(label:outline:) tags the one scanned room; this session holds \(rooms.count) rooms")
        }
        var copy = self
        switch confirmation {
        case .singleRoomPerimeter:
            guard outline.worldCorners == rooms[0].worldCorners else {
                throw RoomCaptureError(
                    "the outline is not this room's perimeter; confirm .propertyBoundary with the traced boundary instead")
            }
        case .propertyBoundary(let corners, let closingTap):
            guard corners.count >= 3 else {
                throw RoomCaptureError("a property boundary needs at least 3 corners")
            }
            copy.outline = RoomCaptureOutlineInput(source: "traced", worldCorners: corners, closingTap: closingTap)
        }
        copy.rooms[0].label = trimmed
        copy.rooms[0].labelSource = "user"
        copy.outlineConfirmed = true
        return copy
    }
}

/// Thrown by `RoomCaptureGeometry` and `RoomCaptureModel` for the same
/// caller-facing mistakes the Kotlin port raises as `IllegalArgumentException`
/// / `IllegalStateException` (there is no such split in Swift's `Error`, so
/// both collapse onto this one type; callers match on the message like the
/// Kotlin tests do).
public struct RoomCaptureError: Error, CustomStringConvertible, Equatable {
    public let message: String
    public init(_ message: String) { self.message = message }
    public var description: String { message }
}
