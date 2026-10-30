import Foundation

/// The state behind a "merge floors" entry in a scanner flow: floors scanned one
/// at a time, the stair or door points the person picked on the reference floor
/// and on each later floor, and the measured elevations. A host screen only
/// feeds it taps and shows ``status``; validation, the request and the
/// refusal-before-billing rules stay in ``FloorMerge``.
///
/// The first floor added is the reference floor. Every later floor is tied to it
/// with at least ``FloorMerge/minSharedPoints`` picked pairs. No network is used
/// until ``merge(service:idempotencyKey:maxChargeUsd:)``.
public final class FloorMergeSession {
    public enum SessionError: Error, Equatable, CustomStringConvertible {
        case badElevation
        case duplicateScan
        case tooManyFloors
        case notALaterFloor(String)
        public var description: String {
            switch self {
            case .badElevation: return "elevationM must be a finite number of metres."
            case .duplicateScan: return "That scan is already part of this merge."
            case .tooManyFloors: return "Merge accepts at most \(FloorMerge.maxFloors) floors."
            case .notALaterFloor(let id): return "\(id) is not a floor after the reference floor."
            }
        }
    }

    public var toleranceM: Double
    public private(set) var floors: [FloorScan] = []
    private var picks: [String: [SharedFloorPoint]] = [:]
    private var order: [String] = []
    private var kinds: [String: FloorLinkKind] = [:]

    public init(toleranceM: Double = FloorMerge.defaultToleranceM) { self.toleranceM = toleranceM }

    public var floorCount: Int { floors.count }

    /// Adds a finished floor scan with its measured elevation (metres above the building datum).
    public func addFloor(_ capture: VastuRoomCapture, elevationM: Double) throws {
        guard elevationM.isFinite else { throw SessionError.badElevation }
        guard !floors.contains(where: { $0.capture.captureId == capture.captureId }) else { throw SessionError.duplicateScan }
        guard floors.count < FloorMerge.maxFloors else { throw SessionError.tooManyFloors }
        floors.append(FloorScan(capture: capture, elevationM: elevationM))
        if floors.count > 1 {
            picks[capture.captureId] = []
            order.append(capture.captureId)
        }
    }

    /// Drops the most recently added floor and its picks.
    public func removeLastFloor() {
        guard let last = floors.popLast() else { return }
        picks[last.capture.captureId] = nil
        kinds[last.capture.captureId] = nil
        order.removeAll { $0 == last.capture.captureId }
    }

    /// One stair or door spot, as picked on the reference floor and on the floor `captureId`.
    public func addPick(captureId: String, reference: FloorPoint, next: FloorPoint) throws {
        guard picks[captureId] != nil else { throw SessionError.notALaterFloor(captureId) }
        picks[captureId]?.append(SharedFloorPoint(reference: reference, next: next))
    }

    public func undoPick(captureId: String) { _ = picks[captureId]?.popLast() }

    public func setKind(_ kind: FloorLinkKind, captureId: String) throws {
        guard picks[captureId] != nil else { throw SessionError.notALaterFloor(captureId) }
        kinds[captureId] = kind
    }

    public func pickCount(captureId: String) -> Int { picks[captureId]?.count ?? 0 }

    /// Pairs still missing before `captureId` can be tied to the reference floor.
    public func pairsStillNeeded(captureId: String) -> Int { max(0, FloorMerge.minSharedPoints - pickCount(captureId: captureId)) }

    /// True once there are two floors and every later floor has its three pairs. Validation proper is ``FloorMerge/prepare(_:)``.
    public var canMerge: Bool { floors.count >= 2 && order.allSatisfy { pairsStillNeeded(captureId: $0) == 0 } }

    /// One sentence for the screen: what to do next, or that the merge can be requested.
    public var status: String {
        if floors.count < 2 { return "Scan a second floor, then pick shared stair or door points on both plans." }
        guard let missing = order.first(where: { pairsStillNeeded(captureId: $0) > 0 }) else {
            return "Ready: \(floors.count) floors linked. Merging is billed once and shows the shared-point error."
        }
        let index = floors.firstIndex { $0.capture.captureId == missing } ?? 1
        return "Floor \(index + 1): pick \(pairsStillNeeded(captureId: missing)) more stair or door point(s) on the reference plan and on this plan."
    }

    public func input(maxChargeUsd: String? = nil) -> FloorMergeInput {
        FloorMergeInput(
            scans: floors,
            links: order.map { FloorLink(toCaptureId: $0, kind: kinds[$0] ?? .stair, points: picks[$0] ?? []) },
            toleranceM: toleranceM, maxChargeUsd: maxChargeUsd)
    }

    /// Validates and builds the request without sending it. Throws ``FloorMergeRefused`` for a bad link.
    public func prepare(maxChargeUsd: String? = nil) throws -> PreparedFloorMerge {
        try FloorMerge.prepare(input(maxChargeUsd: maxChargeUsd))
    }

    /// Posts the merge. `idempotencyKey` must be kept by the caller and reused to retry the same merge without a second charge.
    public func merge(service: VastuService, idempotencyKey: String, maxChargeUsd: String? = nil) async throws -> FloorMergeResult {
        try await FloorMerge.merge(service: service, input: input(maxChargeUsd: maxChargeUsd), idempotencyKey: idempotencyKey)
    }
}
