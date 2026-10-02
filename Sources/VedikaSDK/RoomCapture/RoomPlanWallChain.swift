// Pure geometry for the RoomPlan path: turns measured wall segments into a
// floor outline without inventing any connection, and states what RoomPlan
// did and did not measure. It lives outside the `#if canImport(RoomPlan)`
// controller so it builds and is tested on every platform (RoomPlan itself
// cannot run on macOS CI).
import Foundation

/// One wall's measured floor-plane endpoints, in Y-up world metres.
public struct RoomPlanWallSegment: Equatable, Sendable {
    public var start: Vec3
    public var end: Vec3

    public init(start: Vec3, end: Vec3) {
        self.start = start
        self.end = end
    }
}

/// The outline traced from a set of wall segments.
public struct RoomPlanWallTrace: Equatable, Sendable {
    /// Measured corners. A join within the snap tolerance is one corner (the
    /// midpoint of the two wall ends). A join beyond it keeps BOTH wall ends,
    /// so no unmeasured stretch is hidden as if it were a wall.
    public var corners: [Vec3]
    /// The last wall endpoint actually measured, not a copy of the first corner.
    public var closingTap: Vec3
    /// Distance between the first corner and `closingTap`.
    public var closureGapM: Double
    /// Distance across every join between consecutive walls, in chain order.
    public var joinGapsM: [Double]
    /// The largest of the closure gap and every join gap. This is the figure
    /// the server should judge: a loop with a 1 m hole in a side is not closed
    /// even when its last wall ends on its first.
    public var maxSeamGapM: Double

    public var outline: RoomCaptureOutlineInput {
        RoomCaptureOutlineInput(source: "traced", worldCorners: corners, closingTap: closingTap, maxSeamGapM: maxSeamGapM)
    }
}

public enum RoomPlanWallChain {
    /// Two wall ends this close are one corner. RoomPlan walls meet within a
    /// few centimetres on a clean scan; anything wider stays a visible seam.
    public static let joinSnapToleranceM = 0.10

    static func distance(_ a: Vec3, _ b: Vec3) -> Double {
        let dx = a.x - b.x
        let dz = a.z - b.z
        return (dx * dx + dz * dz).squareRoot()
    }

    private static func midpoint(_ a: Vec3, _ b: Vec3) -> Vec3 {
        Vec3(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2, z: (a.z + b.z) / 2)
    }

    /// Greedy nearest-endpoint chain from the first wall. It never drops a
    /// wall end and never closes the loop itself. The first wall is tried in
    /// both directions and the chain with the smaller total seam wins, so the
    /// result does not depend on which way RoomPlan happened to orient it.
    public static func trace(_ walls: [RoomPlanWallSegment], snapToleranceM: Double = joinSnapToleranceM) throws -> RoomPlanWallTrace {
        guard walls.count >= 3 else { throw RoomCaptureError("Need at least 3 walls to trace an outline") }
        let forward = chain(walls, flipFirst: false)
        let reversed = chain(walls, flipFirst: true)
        let ordered = reversed.seamTotal < forward.seamTotal ? reversed.ordered : forward.ordered

        var corners: [Vec3] = [ordered[0].start]
        var joinGaps: [Double] = []
        for i in 1..<ordered.count {
            let previousEnd = ordered[i - 1].end
            let nextStart = ordered[i].start
            let gap = distance(previousEnd, nextStart)
            joinGaps.append(gap)
            if gap <= snapToleranceM {
                corners.append(midpoint(previousEnd, nextStart))
            } else {
                corners.append(previousEnd)
                corners.append(nextStart)
            }
        }
        let tail = ordered[ordered.count - 1].end
        let closure = distance(corners[0], tail)
        if closure > snapToleranceM {
            // The last wall ends away from the start: keep its real end as a corner.
            corners.append(tail)
        }
        return RoomPlanWallTrace(
            corners: corners, closingTap: tail, closureGapM: closure, joinGapsM: joinGaps,
            maxSeamGapM: ([closure] + joinGaps).max() ?? closure
        )
    }

    private static func chain(_ walls: [RoomPlanWallSegment], flipFirst: Bool) -> (ordered: [RoomPlanWallSegment], seamTotal: Double) {
        var remaining = walls
        var first = remaining.removeFirst()
        if flipFirst { first = RoomPlanWallSegment(start: first.end, end: first.start) }
        var ordered = [first]
        var total = 0.0
        while !remaining.isEmpty {
            let tail = ordered[ordered.count - 1].end
            var bestIndex = 0
            var bestFlip = false
            var bestDist = Double.infinity
            for (i, wall) in remaining.enumerated() {
                let dStart = distance(tail, wall.start)
                let dEnd = distance(tail, wall.end)
                if dStart < bestDist { bestDist = dStart; bestIndex = i; bestFlip = false }
                if dEnd < bestDist { bestDist = dEnd; bestIndex = i; bestFlip = true }
            }
            var next = remaining.remove(at: bestIndex)
            if bestFlip { next = RoomPlanWallSegment(start: next.end, end: next.start) }
            ordered.append(next)
            total += bestDist
        }
        return (ordered, total)
    }
}

public enum RoomPlanCaptureQuality {
    /// What RoomPlan really reports. `CapturedRoom` exposes surfaces and
    /// confidence, not a point cloud, so no density exists to send. The basis
    /// is "none" with a null density (the server requires exactly that pair)
    /// and the server warns that density was not measured. Do not change the
    /// basis to "lidar-depth" without a measured density value.
    public static func measured(expectedRoomCount: Int = 1) -> RoomCaptureQualityInput {
        RoomCaptureQualityInput(pointCloudDensity: nil, pointCloudDensityBasis: "none", expectedRoomCount: expectedRoomCount)
    }
}
