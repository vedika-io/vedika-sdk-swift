import Foundation

// Scan the floors of one building one at a time, then merge them through
// `POST /v2/astrology/vastu/ar/capture-merge`.
//
// This is a port of the web reference (`prepareFloorMerge` in
// `web/vedika-public/js/vastu/room-capture-geometry.js`) so the web guide and
// the native modules send the same request for the same input.
//
// How the floors are tied together: the API only accepts `links` between two
// captures on the SAME floor, so a stair or door correspondence between two
// floors can never be sent as an API link. The shared points are resolved here,
// on the device, into one explicit floor frame per floor (`floors[].originXY`)
// and the request carries `links = []`. The first scan is the reference floor
// and sits at origin 0, 0. Every other floor gets a translation only: its
// recorded true north is never rotated and there is no scale change
// (`bearingDeg` stays 0).
//
// Everything in `FloorMerge.prepare` runs before any network call. A bad link
// throws `FloorMergeRefused` and nothing is sent, so nothing is billed. The
// error it states is the disagreement between the picked points (a
// correspondence residual). It is not a claim of survey or house accuracy.
//
// Plain Foundation, no platform import: runs in `swift test` on macOS and Linux.

/// A point on one floor plan, metres: +X east, +Y true north (the capture's own frame).
public struct FloorPoint: Equatable {
    public var x: Double
    public var y: Double
    public init(x: Double, y: Double) { self.x = x; self.y = y }
}

/// The same physical stair or door location, picked on the reference floor and on the next floor.
public struct SharedFloorPoint: Equatable {
    public var reference: FloorPoint
    public var next: FloorPoint
    public init(reference: FloorPoint, next: FloorPoint) { self.reference = reference; self.next = next }
}

public enum FloorLinkKind: String, Equatable {
    case stair
    case door
}

/// One finished room scan of one floor, with that floor's measured elevation above the building datum.
public struct FloorScan {
    public var capture: VastuRoomCapture
    public var elevationM: Double
    public init(capture: VastuRoomCapture, elevationM: Double) { self.capture = capture; self.elevationM = elevationM }
}

/// Ties the scan whose `captureId` is `toCaptureId` to the reference (first)
/// scan with `points`. Needs at least `FloorMerge.minSharedPoints` points. A
/// door link must use measured, vertically corresponding points: unrelated
/// doors cannot locate a floor.
public struct FloorLink {
    public var toCaptureId: String
    public var kind: FloorLinkKind
    public var points: [SharedFloorPoint]
    public init(toCaptureId: String, kind: FloorLinkKind, points: [SharedFloorPoint]) {
        self.toCaptureId = toCaptureId; self.kind = kind; self.points = points
    }
}

public struct FloorMergeInput {
    /// The first scan is the reference floor.
    public var scans: [FloorScan]
    /// One link for every scan after the first.
    public var links: [FloorLink]
    /// Largest accepted shared-point error, metres: 0.0001 to 1.
    public var toleranceM: Double
    /// Optional wallet cap sent as `maxChargeUsd`, an exact decimal string such as "0.50".
    public var maxChargeUsd: String?
    public init(scans: [FloorScan], links: [FloorLink], toleranceM: Double = FloorMerge.defaultToleranceM, maxChargeUsd: String? = nil) {
        self.scans = scans; self.links = links; self.toleranceM = toleranceM; self.maxChargeUsd = maxChargeUsd
    }
}

public enum FloorMergeRefusal: String, Equatable {
    case tooFewFloors
    case tooManyFloors
    case badTolerance
    case badMaxCharge
    case badIdempotencyKey
    case unsupportedCapture
    case duplicateCaptureId
    case duplicateFloorIndex
    case duplicateElevation
    case badElevation
    case tooManyRooms
    case missingLink
    case unknownFloorLink
    case duplicateLink
    case tooFewPoints
    case nonFinitePoint
    case pointOutsideFloor
    case noBaseline
    case errorAboveTolerance
    case requestTooLarge
}

/// Thrown BEFORE any request when the floors or their shared points cannot be merged as given.
public struct FloorMergeRefused: Error, CustomStringConvertible, Equatable {
    public let reason: FloorMergeRefusal
    public let message: String
    public init(_ reason: FloorMergeRefusal, _ message: String) { self.reason = reason; self.message = message }
    public var description: String { message }
}

/// Thrown when the API answered but the merged building does not match what was
/// sent. Nothing is hidden: keep the original scans.
public struct FloorMergeResponseError: Error, CustomStringConvertible, Equatable {
    public let message: String
    public init(_ message: String) { self.message = message }
    public var description: String { message }
}

/// Agreement of the picked points for one floor against the reference floor, metres.
public struct FloorPairResidual: Equatable {
    public let fromCaptureId: String
    public let toCaptureId: String
    public let kind: FloorLinkKind
    public let controlCount: Int
    public let rmsResidualM: Double
    public let maxResidualM: Double
}

public struct FloorMergeRegistration: Equatable {
    public let pairResiduals: [FloorPairResidual]
    /// Point-weighted RMS over every link.
    public let rmsResidualM: Double
    public let maxResidualM: Double

    /// Plain-language statement of the error, safe to show to a person.
    public func describe() -> String {
        "Shared-point error: RMS \(String(format: "%.4f", rmsResidualM)) m; maximum \(String(format: "%.4f", maxResidualM)) m. "
            + "This is correspondence agreement, not survey accuracy. Original north and floor identities are preserved."
    }
}

/// A validated request plus the error it was built with. Nothing has been sent.
public struct PreparedFloorMerge {
    public let request: VastuArCaptureMergeRequest
    public let registration: FloorMergeRegistration
}

/// The merged building and the stated error of the floor links that produced it.
public struct FloorMergeResult {
    public let response: VastuTypedResponse<VastuArCaptureMergeData>
    public let registration: FloorMergeRegistration
    public var building: VastuArCaptureMergeData { response.data }
    public var rmsResidualM: Double { registration.rmsResidualM }
    public var maxResidualM: Double { registration.maxResidualM }
}

public enum FloorMerge {
    public static let defaultToleranceM = 0.05
    public static let minSharedPoints = 3
    public static let maxFloors = 16
    public static let minBaselineM = 0.1
    private static let maxRooms = 512
    private static let maxBodyBytes = 1024 * 1024

    /// Validates `input` and builds the `ar/capture-merge` request. Makes no
    /// network call. Throws `FloorMergeRefused` with a `FloorMergeRefusal`
    /// reason for a bad link.
    public static func prepare(_ input: FloorMergeInput) throws -> PreparedFloorMerge {
        let scans = input.scans
        guard scans.count >= 2 else {
            throw FloorMergeRefused(.tooFewFloors, "Scan at least 2 floors to merge; one floor needs no merge.")
        }
        guard scans.count <= maxFloors else {
            throw FloorMergeRefused(.tooManyFloors, "Merge accepts at most \(maxFloors) floors.")
        }
        guard input.toleranceM.isFinite, input.toleranceM >= 0.0001, input.toleranceM <= 1 else {
            throw FloorMergeRefused(.badTolerance, "toleranceM must be 0.0001 to 1 metre.")
        }
        if let cap = input.maxChargeUsd, !isMaxCharge(cap) {
            throw FloorMergeRefused(.badMaxCharge, "maxChargeUsd must be an exact non-negative decimal string such as \"0.50\".")
        }

        var ids = Set<String>()
        var indices = Set<Int>()
        var elevations = Set<Double>()
        var floorIndexOf: [Int] = []
        for scan in scans {
            let capture = scan.capture
            let floorIndex = try readFloorIndex(capture)
            guard ids.insert(capture.captureId).inserted else {
                throw FloorMergeRefused(.duplicateCaptureId, "Two scans share the capture id \(capture.captureId). Use a fresh scan for each floor.")
            }
            guard indices.insert(floorIndex).inserted else {
                throw FloorMergeRefused(.duplicateFloorIndex, "Two scans record floor index \(floorIndex). Each floor needs its own index.")
            }
            guard scan.elevationM.isFinite, abs(scan.elevationM) <= 1000 else {
                throw FloorMergeRefused(.badElevation, "Floor \(floorIndex) needs a finite measured elevation within 1000 metres.")
            }
            guard elevations.insert(scan.elevationM).inserted else {
                throw FloorMergeRefused(.duplicateElevation, "Two floors share the elevation \(scan.elevationM) m. Floors need distinct measured elevations.")
            }
            floorIndexOf.append(floorIndex)
        }
        guard scans.reduce(0, { $0 + $1.capture.rooms.count }) <= maxRooms else {
            throw FloorMergeRefused(.tooManyRooms, "Merge accepts at most \(maxRooms) rooms across all floors.")
        }

        let linkable = Set(scans.dropFirst().map { $0.capture.captureId })
        var linked = Set<String>()
        for link in input.links {
            guard linkable.contains(link.toCaptureId) else {
                throw FloorMergeRefused(.unknownFloorLink, "A link names \(link.toCaptureId), which is not a scanned floor after the reference floor.")
            }
            guard linked.insert(link.toCaptureId).inserted else {
                throw FloorMergeRefused(.duplicateLink, "Floor \(link.toCaptureId) has more than one link.")
            }
        }

        let reference = scans[0]
        var residuals: [FloorPairResidual] = []
        var floors = [VastuArCaptureMergeRequestFloorsItem(floorIndex: floorIndexOf[0], elevationM: reference.elevationM, originXY: [0, 0], bearingDeg: 0)]
        for index in 1..<scans.count {
            let scan = scans[index]
            let id = scan.capture.captureId
            guard let link = input.links.first(where: { $0.toCaptureId == id }) else {
                throw FloorMergeRefused(.missingLink, "Floor \(floorIndexOf[index]) (\(id)) has no link to the reference floor.")
            }
            let points = link.points
            guard points.count >= minSharedPoints, points.count <= 256 else {
                throw FloorMergeRefused(
                    .tooFewPoints,
                    "Floor \(floorIndexOf[index]) needs \(minSharedPoints) to 256 shared stair or door points; got \(points.count). "
                        + "Three points give a check beyond a two-point baseline.")
            }
            for p in points {
                guard finite(p.reference), finite(p.next) else {
                    throw FloorMergeRefused(.nonFinitePoint, "Shared points must be finite metre coordinates.")
                }
                guard onFloor(p.reference, reference.capture.outline.polygon), onFloor(p.next, scan.capture.outline.polygon) else {
                    throw FloorMergeRefused(.pointOutsideFloor, "Shared points must lie within the recorded outline of their own floor.")
                }
            }
            guard hasBaseline(points.map { $0.reference }), hasBaseline(points.map { $0.next }) else {
                throw FloorMergeRefused(.noBaseline, "Shared points need a baseline of at least \(minBaselineM) metre on both floors.")
            }
            let n = Double(points.count)
            let originX = points.reduce(0.0) { $0 + $1.reference.x - $1.next.x } / n
            let originY = points.reduce(0.0) { $0 + $1.reference.y - $1.next.y } / n
            let distances = points.map { hypot($0.next.x + originX - $0.reference.x, $0.next.y + originY - $0.reference.y) }
            let rms = (distances.reduce(0.0) { $0 + $1 * $1 } / n).squareRoot()
            let worst = distances.max() ?? 0
            guard worst <= input.toleranceM, rms <= input.toleranceM else {
                throw FloorMergeRefused(
                    .errorAboveTolerance,
                    "Shared-link error \(String(format: "%.4f", worst)) m exceeds \(input.toleranceM) m. Check the points and north; no merge request was sent.")
            }
            residuals.append(FloorPairResidual(
                fromCaptureId: reference.capture.captureId, toCaptureId: id, kind: link.kind,
                controlCount: points.count, rmsResidualM: rms, maxResidualM: worst))
            floors.append(VastuArCaptureMergeRequestFloorsItem(floorIndex: floorIndexOf[index], elevationM: scan.elevationM, originXY: [originX, originY], bearingDeg: 0))
        }

        let request = VastuArCaptureMergeRequest(
            captures: scans.enumerated().map { VastuArCaptureMergeRequestCapturesItem(id: $0.element.capture.captureId, floorIndex: floorIndexOf[$0.offset], payload: $0.element.capture) },
            links: [],
            floors: floors,
            toleranceM: input.toleranceM,
            maxChargeUsd: input.maxChargeUsd)
        guard JSONSerialization.isValidJSONObject(request.dictionary),
            let body = try? JSONSerialization.data(withJSONObject: request.dictionary),
            body.count <= maxBodyBytes
        else {
            throw FloorMergeRefused(.requestTooLarge, "Merge request exceeds 1 MiB.")
        }
        let totalPoints = Double(residuals.reduce(0) { $0 + $1.controlCount })
        let weighted = residuals.reduce(0.0) { $0 + $1.rmsResidualM * $1.rmsResidualM * Double($1.controlCount) }
        let registration = FloorMergeRegistration(
            pairResiduals: residuals,
            rmsResidualM: (weighted / totalPoints).squareRoot(),
            maxResidualM: residuals.map { $0.maxResidualM }.max() ?? 0)
        return PreparedFloorMerge(request: request, registration: registration)
    }

    /// Validates, then posts `ar/capture-merge`. The call is billed, so a
    /// caller-retained `idempotencyKey` (1-256 visible ASCII characters) is
    /// required: retry a timeout with the SAME key and the same `input` and the
    /// first result is replayed with no second charge. The key is checked first,
    /// and a bad link throws before any request.
    ///
    /// `FloorMergeResult.registration` holds the stated shared-point error. The
    /// response is cross-checked against what was sent; a mismatch throws
    /// `FloorMergeResponseError`.
    public static func merge(
        service: VastuService, input: FloorMergeInput, idempotencyKey: String
    ) async throws -> FloorMergeResult {
        guard isKey(idempotencyKey) else {
            throw FloorMergeRefused(.badIdempotencyKey, "A caller-retained idempotencyKey (1-256 visible ASCII characters) is required to merge floors.")
        }
        let prepared = try prepare(input)
        let response = try await service.vastuOperation(VastuContracts.arCaptureMerge, request: prepared.request, idempotencyKey: idempotencyKey)
        try checkResponse(prepared.request, response)
        return FloorMergeResult(response: response, registration: prepared.registration)
    }

    private static func checkResponse(_ request: VastuArCaptureMergeRequest, _ response: VastuTypedResponse<VastuArCaptureMergeData>) throws {
        let bad = FloorMergeResponseError("Invalid or empty merge result; keep the original scans and check the response before retrying.")
        let raw = response.data.raw
        guard response.success, raw["method"] as? String == "capture-merge",
            let rooms = raw["rooms"] as? [[String: Any]],
            let stack = raw["floorStack"] as? [[String: Any]],
            let unresolved = raw["unresolvedAlignmentErrors"] as? [Any], unresolved.isEmpty,
            rooms.count == request.captures.reduce(0, { $0 + $1.payload.rooms.count }),
            stack.count == request.floors.count
        else { throw bad }
        for floor in request.floors {
            guard stack.contains(where: { number($0["floorIndex"]) == Double(floor.floorIndex) && number($0["elevationM"]) == floor.elevationM }) else { throw bad }
        }
        for capture in request.captures {
            let count = rooms.filter { ($0["captureId"] as? String) == capture.id && number($0["floorIndex"]) == Double(capture.floorIndex) }.count
            guard count == capture.payload.rooms.count else { throw bad }
        }
    }

    // MARK: validation helpers (mirror readFloorCapture / onFloor in the web reference)

    private static func number(_ value: Any?) -> Double? { (value as? NSNumber)?.doubleValue }

    private static func isKey(_ value: String) -> Bool {
        let bytes = Array(value.utf8)
        return (1...256).contains(bytes.count) && bytes.allSatisfy { (0x21...0x7e).contains($0) }
    }

    private static func isMaxCharge(_ value: String) -> Bool {
        value.range(of: #"^(0|[1-9][0-9]*)(\.[0-9]{1,2})?$"#, options: .regularExpression) != nil
    }

    private static func finite(_ p: FloorPoint) -> Bool { p.x.isFinite && p.y.isFinite }

    private static func signedArea(_ ring: [[Double]]) -> Double {
        var sum = 0.0
        for i in ring.indices {
            let a = ring[i]
            let b = ring[(i + 1) % ring.count]
            sum += a[0] * b[1] - b[0] * a[1]
        }
        return sum / 2
    }

    private static func validRing(_ ring: [[Double]]) -> Bool {
        (3...256).contains(ring.count) && ring.allSatisfy { $0.count == 2 && $0[0].isFinite && $0[1].isFinite }
            && abs(signedArea(ring)) > 0.001
    }

    /// The floor index a scan recorded. Never relabelled: refuses a scan that cannot be stacked as measured.
    private static func readFloorIndex(_ capture: VastuRoomCapture) throws -> Int {
        guard capture.schema == RoomCaptureGeometry.roomCaptureSchema, !capture.captureId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            capture.captureId.count <= 128, capture.frame.units == "metres", capture.frame.axes == RoomCaptureGeometry.roomCaptureAxes,
            ["true", "manual"].contains(capture.frame.north.referenceFrame)
        else {
            throw FloorMergeRefused(
                .unsupportedCapture,
                "Use a metre-based room scan with recorded true or explicitly entered north; magnetic north cannot be stacked as true north.")
        }
        guard validRing(capture.outline.polygon), (1...64).contains(capture.rooms.count), capture.quality.polygonClosure,
            capture.rooms.allSatisfy({ validRing($0.polygon) })
        else {
            throw FloorMergeRefused(.unsupportedCapture, "Use a closed outline with 1 to 64 measured room polygons.")
        }
        let floorIndex = capture.rooms[0].floorIndex
        guard (-3...9).contains(floorIndex), capture.rooms.allSatisfy({ $0.floorIndex == floorIndex }) else {
            throw FloorMergeRefused(.unsupportedCapture, "A scan must retain one recorded integer floor index from -3 to 9.")
        }
        return floorIndex
    }

    /// Inside or exactly on the ring: door controls often sit on a wall.
    private static func onFloor(_ p: FloorPoint, _ ring: [[Double]]) -> Bool {
        var inside = false
        var j = ring.count - 1
        for i in ring.indices {
            let a = ring[j]
            let b = ring[i]
            let dx = b[0] - a[0]
            let dy = b[1] - a[1]
            let along = (p.x - a[0]) * dx + (p.y - a[1]) * dy
            if (dx != 0 || dy != 0) && abs((p.x - a[0]) * dy - (p.y - a[1]) * dx) <= 1e-8 && along >= 0 && along <= dx * dx + dy * dy {
                return true
            }
            let straddles = (a[1] > p.y) != (b[1] > p.y)
            if straddles {
                let crossingX: Double = (b[0] - a[0]) * (p.y - a[1]) / (b[1] - a[1]) + a[0]
                if p.x < crossingX { inside.toggle() }
            }
            j = i
        }
        return inside
    }

    private static func hasBaseline(_ points: [FloorPoint]) -> Bool {
        var widest = 0.0
        for i in points.indices {
            for k in (i + 1)..<points.count {
                widest = max(widest, hypot(points[i].x - points[k].x, points[i].y - points[k].y))
            }
        }
        return widest >= minBaselineM
    }
}
