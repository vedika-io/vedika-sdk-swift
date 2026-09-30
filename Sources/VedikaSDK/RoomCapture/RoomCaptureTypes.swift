// Plain-value types the pure capture model and geometry work with. No
// UIKit/ARKit/RoomPlan/CoreLocation import anywhere in this file: this file,
// `RoomCaptureGeometry.swift` and `RoomCaptureModel.swift` must build and run
// under a plain `swift build`/`swift test` on macOS, exactly like the JVM
// port (`sdks/android-ar/src/main/kotlin/io/vedika/sdk/ar/RoomCaptureTypes.kt`)
// builds on a bare JVM — see that file's header for why that matters for
// cross-platform parity (this is a line-for-line Swift port of it).
//
// Vedika-Task: R-004

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

    public init(source: String, worldCorners: [Vec3], closingTap: Vec3?) {
        self.source = source
        self.worldCorners = worldCorners
        self.closingTap = closingTap
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

    public init(
        captureId: String, capturedAtEpoch: Int, device: RoomCaptureDeviceInput, headingFrame: String,
        north: RoomCaptureNorthInput, headingSamples: [RoomCaptureHeadingSample], outline: RoomCaptureOutlineInput,
        rooms: [RoomCaptureRoomInput], quality: RoomCaptureQualityInput
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
