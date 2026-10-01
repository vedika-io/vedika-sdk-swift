import Foundation

/// AR room capture -> `VastuRoomCapture`, the body `ar/room-capture` takes.
///
/// A line-for-line Swift port of `RoomCaptureGeometry` in
/// `sdks/android-ar/src/main/kotlin/io/vedika/sdk/ar/RoomCaptureGeometry.kt`,
/// itself a port of `web/vedika-public/js/vastu/room-capture-geometry.js`
/// (plus the circular-bearing helpers it borrows from `heading-provider.js`).
/// `RoomCaptureGeometryTests` runs the same shared fixtures
/// (`sdks/fixtures/vastu-room-capture/*.json`) through this port and asserts
/// the same expected capture, within 1e-6 — the Rust, JS, Kotlin and Swift
/// implementations must never silently drift apart. Do not change rounding,
/// ordering, or the sign convention here without re-checking those fixtures.
///
/// Input is a Y-up AR session (WebXR, ARCore and ARKit all use one): floor
/// corners in world metres and heading samples, each a compass heading paired
/// with the camera's forward vector at that moment. Output is north-up plan
/// geometry: metres, +X east, +Y true north, starting at 0, 0.
///
///  1. Floor point to plan point: (u, v) = (x, -z). The wrong sign swaps a
///     wall silently, so the shared fixtures pin a door's position.
///  2. theta, the true bearing of plan +v: the stationary median of
///     trueHeading - atan2(f.x, -f.z) over the samples.
///  3. Rotate clockwise by theta, move the traced outline's lower-left to 0, 0,
///     snap to 1 cm, drop corners within 2 cm of a straight run, and start
///     each ring counter-clockwise at its lowest corner.
///
/// Vedika-Task: R-004
public enum RoomCaptureGeometry {

    public static let roomCaptureSchema = "vedika.roomCapture/1"
    public static let roomCaptureAxes = "+X east,+Y true north"
    public static let spikeThresholdDeg = 20.0
    public static let spreadForZeroConfidenceDeg = 20.0
    public static let collinearToleranceM = 0.02
    public static let closedLoopToleranceM = 0.05

    private static let deg = Double.pi / 180.0

    // MARK: - Circular bearing math (ported from heading-provider.js)

    public static func normalizeBearing(_ deg: Double) -> Double {
        guard deg.isFinite else { return 0.0 }
        return (deg.truncatingRemainder(dividingBy: 360.0) + 360.0).truncatingRemainder(dividingBy: 360.0)
    }

    /// Shortest signed difference `b - a` in the range `(-180, 180]`.
    public static func circularDiff(_ a: Double, _ b: Double) -> Double {
        var d = (b - a).truncatingRemainder(dividingBy: 360.0)
        if d > 180.0 { d -= 360.0 }
        if d <= -180.0 { d += 360.0 }
        return d
    }

    public struct CircularMean {
        public let meanDeg: Double
        public let resultantLength: Double
        public let circularVariance: Double
    }

    public static func circularMeanDeg(_ samples: [Double]) -> CircularMean? {
        guard !samples.isEmpty else { return nil }
        var sx = 0.0
        var sy = 0.0
        for s in samples {
            let r = s * deg
            sx += cos(r)
            sy += sin(r)
        }
        let n = Double(samples.count)
        sx /= n
        sy /= n
        let meanDeg = normalizeBearing(atan2(sy, sx) / deg)
        let resultantLength = (sx * sx + sy * sy).squareRoot()
        return CircularMean(meanDeg: meanDeg, resultantLength: resultantLength, circularVariance: 1.0 - resultantLength)
    }

    /// The sample minimizing the summed circular distance to all other samples.
    public static func circularMedianDeg(_ samples: [Double]) -> Double? {
        guard !samples.isEmpty else { return nil }
        var best = samples[0]
        var bestCost = Double.infinity
        for cand in samples {
            var cost = 0.0
            for s in samples { cost += abs(circularDiff(cand, s)) }
            if cost < bestCost {
                bestCost = cost
                best = cand
            }
        }
        return normalizeBearing(best)
    }

    public struct StationarySummary {
        public let headingDeg: Double?
        public let sampleCount: Int
        public let keptCount: Int
        public let rejectedCount: Int
        public let circularVariance: Double?
        public let insufficientSamples: Bool
    }

    public static func summarizeStationarySamples(
        _ samples: [Double], spikeThresholdDeg: Double = 20.0, minSamples: Int = 3
    ) -> StationarySummary? {
        guard !samples.isEmpty else { return nil }
        let roughMedian = circularMedianDeg(samples)!
        let kept = samples.filter { abs(circularDiff(roughMedian, $0)) <= spikeThresholdDeg }
        let useSet = kept.count >= max(3, Int(ceil(Double(samples.count) * 0.4))) ? kept : samples
        let median = circularMedianDeg(useSet)
        let insufficientSamples = samples.count < minSamples
        let stats = insufficientSamples ? nil : circularMeanDeg(useSet)
        return StationarySummary(
            headingDeg: median, sampleCount: samples.count, keptCount: useSet.count,
            rejectedCount: samples.count - useSet.count, circularVariance: stats?.circularVariance,
            insufficientSamples: insufficientSamples
        )
    }

    // MARK: - Rounding

    /// Round half toward +infinity at `places` decimals; -0 becomes 0.
    public static func roundHalfUp(_ value: Double, _ places: Int) -> Double {
        let f = pow(10.0, Double(places))
        return (value * f + 0.5).rounded(.down) / f + 0.0
    }

    public static func snapCm(_ value: Double) -> Double { roundHalfUp(value, 2) }

    // MARK: - Floor <-> plan mapping

    /// World (x, y, z) -> plan (u, v).
    public static func floorToPlan(_ point: Vec3) -> (Double, Double) { (point.x, -point.z) }

    /// Clockwise bearing of a camera forward vector within the plan, in degrees.
    public static func forwardBearingDeg(_ forward: Vec3) -> Double { atan2(forward.x, -forward.z) / deg }

    public struct NorthRotation {
        public let thetaDeg: Double
        public let yawSamples: Int
        public let yawSpreadDeg: Double
        public let compassConfidence: Double
        public let trueFrame: Bool
    }

    /// theta and its spread from heading samples. `headingFrame` is `"true"`
    /// when headings already include declination.
    public static func northRotation(
        _ samples: [RoomCaptureHeadingSample], headingFrame: String, declinationDeg: Double?
    ) throws -> NorthRotation {
        guard !samples.isEmpty else { throw RoomCaptureError("Take heading samples before building a capture") }
        let offsets = samples.map { sample -> Double in
            let heading = (headingFrame == "magnetic" && declinationDeg != nil) ? sample.headingDeg + declinationDeg! : sample.headingDeg
            return normalizeBearing(heading - forwardBearingDeg(sample.forward))
        }
        let rough = circularMedianDeg(offsets)!
        let kept = offsets.filter { abs(circularDiff(rough, $0)) <= spikeThresholdDeg }
        let used = kept.count >= max(3, Int(ceil(Double(offsets.count) * 0.4))) ? kept : offsets
        var sx = 0.0
        var sy = 0.0
        for d in used {
            sx += cos(d * deg)
            sy += sin(d * deg)
        }
        let mx = sx / Double(used.count)
        let my = sy / Double(used.count)
        let r = min(1.0, (mx * mx + my * my).squareRoot())
        let spread = r < 1.0 ? (-2.0 * log(r)).squareRoot() / deg : 0.0
        let confidence = max(0.0, min(1.0, 1.0 - spread / spreadForZeroConfidenceDeg))
        let summary = summarizeStationarySamples(offsets, spikeThresholdDeg: spikeThresholdDeg)!
        return NorthRotation(
            thetaDeg: summary.headingDeg!, yawSamples: offsets.count, yawSpreadDeg: roundHalfUp(spread, 2),
            compassConfidence: roundHalfUp(confidence, 3), trueFrame: headingFrame == "true" || declinationDeg != nil
        )
    }

    /// Plan (u, v) -> north-up (X, Y) for a plan whose +v has true bearing theta.
    public static func rotateToNorth(_ point: (Double, Double), thetaDeg: Double) -> (Double, Double) {
        let (u, v) = point
        let t = thetaDeg * deg
        return (u * cos(t) + v * sin(t), -u * sin(t) + v * cos(t))
    }

    public static func signedArea(_ ring: [(Double, Double)]) -> Double {
        var sum = 0.0
        for i in ring.indices {
            let (x1, y1) = ring[i]
            let (x2, y2) = ring[(i + 1) % ring.count]
            sum += x1 * y2 - x2 * y1
        }
        return sum / 2.0
    }

    /// Drop repeats and corners that sit within 2 cm of a straight run.
    public static func simplifyRing(_ points: [(Double, Double)]) -> [(Double, Double)] {
        var pts: [(Double, Double)] = []
        for p in points {
            if let last = pts.last, last.0 == p.0 && last.1 == p.1 { continue }
            pts.append(p)
        }
        while pts.count > 1, let first = pts.first, let last = pts.last, first.0 == last.0 && first.1 == last.1 {
            pts.removeLast()
        }
        var changed = true
        while changed && pts.count > 3 {
            changed = false
            let n = pts.count
            for i in 0..<n {
                let a = pts[(i - 1 + n) % n]
                let b = pts[i]
                let c = pts[(i + 1) % n]
                let ab = (b.0 - a.0, b.1 - a.1)
                let ac = (c.0 - a.0, c.1 - a.1)
                let span = (ac.0 * ac.0 + ac.1 * ac.1).squareRoot()
                if span == 0.0 { continue }
                let off = abs(ab.0 * ac.1 - ab.1 * ac.0) / span
                let along = (ab.0 * ac.0 + ab.1 * ac.1) / (span * span)
                if off <= collinearToleranceM && along > 0.0 && along < 1.0 {
                    pts.remove(at: i)
                    changed = true
                    break
                }
            }
        }
        return pts
    }

    /// Counter-clockwise, starting at the lowest-Y (then lowest-X) corner.
    public static func canonicalRing(_ points: [(Double, Double)]) -> [(Double, Double)] {
        let ring = signedArea(points) < 0.0 ? points.reversed().map { $0 } : points
        var start = 0
        for i in 1..<ring.count {
            if ring[i].1 < ring[start].1 || (ring[i].1 == ring[start].1 && ring[i].0 < ring[start].0) {
                start = i
            }
        }
        return Array(ring[start...]) + Array(ring[..<start])
    }

    private static func finish(_ points: [(Double, Double)], shift: (Double, Double)) -> [(Double, Double)] {
        canonicalRing(simplifyRing(points.map { (snapCm($0.0 - shift.0), snapCm($0.1 - shift.1)) }))
    }

    private static func toList(_ point: (Double, Double)) -> [Double] { [point.0, point.1] }

    /// Build the capture body from an AR session. See the shared fixtures'
    /// `session` objects for the input shape.
    public static func buildRoomCapture(_ session: RoomCaptureSession) throws -> VastuRoomCapture {
        let northInput = session.north
        let quality = session.quality
        let rotation = try northRotation(session.headingSamples, headingFrame: session.headingFrame, declinationDeg: northInput.declinationDeg)
        let toPlan: (Vec3) -> (Double, Double) = { p in rotateToNorth(floorToPlan(p), thetaDeg: rotation.thetaDeg) }

        guard session.outline.source == "traced", !session.outline.worldCorners.isEmpty else {
            throw RoomCaptureError("Trace the plot or house outline first; a room is zoned by where it sits in it")
        }
        let outlineWorldCorners = session.outline.worldCorners
        guard let closingTap = session.outline.closingTap else {
            throw RoomCaptureError("Trace the plot or house outline first; a room is zoned by where it sits in it")
        }

        let roomsPlan = session.rooms.map { room in room.worldCorners.map(toPlan) }
        let outlinePlan = outlineWorldCorners.map(toPlan)
        let loopA = outlineWorldCorners[0]
        let loopB = closingTap
        let shift = (outlinePlan.map(\.0).min()!, outlinePlan.map(\.1).min()!)
        let a = toPlan(loopA)
        let b = toPlan(loopB)
        let dx = a.0 - b.0
        let dy = a.1 - b.1
        let gap = roundHalfUp(max((dx * dx + dy * dy).squareRoot(), session.outline.maxSeamGapM ?? 0), 2)

        var rooms: [VastuRoomCaptureRoomsItem] = []
        for (index, room) in session.rooms.enumerated() {
            let ring = finish(roomsPlan[index], shift: shift)
            let openings = room.openings.map { o -> VastuRoomCaptureRoomsItemOpeningsItem in
                let (cx, cy) = toPlan(o.centerWorld)
                return VastuRoomCaptureRoomsItemOpeningsItem(
                    kind: o.kind, centerXY: [snapCm(cx - shift.0), snapCm(cy - shift.1)], widthM: o.widthM,
                    confidence: o.confidence, heightM: o.heightM
                )
            }
            rooms.append(VastuRoomCaptureRoomsItem(
                id: room.id, label: room.label, labelSource: room.labelSource, polygon: ring.map(toList),
                areaM2: roundHalfUp(abs(signedArea(ring)), 2), floorIndex: room.floorIndex, heightM: room.heightM,
                // Always an array (never nil), even when empty — the Kotlin
                // port's `toMap()` and every shared fixture's `expected.capture`
                // spell out `"openings": []` for a room with none; nil would
                // omit the key entirely, which the fixture comparison in
                // RoomCaptureFixtures.assertMatches treats as a real mismatch.
                openings: openings
            ))
        }

        let t = rotation.thetaDeg * deg
        let c = cos(t)
        let s = sin(t)
        let u0 = c * shift.0 - s * shift.1
        let v0 = s * shift.0 + c * shift.1

        return VastuRoomCapture(
            schema: roomCaptureSchema,
            captureId: session.captureId,
            capturedAtEpoch: session.capturedAtEpoch,
            device: VastuRoomCaptureDevice(platform: session.device.platform, method: session.device.method, depth: session.device.depth),
            frame: VastuRoomCaptureFrame(
                units: "metres",
                axes: roomCaptureAxes,
                north: VastuRoomCaptureFrameNorth(
                    referenceFrame: rotation.trueFrame ? northInput.referenceFrame : "magnetic",
                    headingSource: northInput.headingSource,
                    declinationProvenance: northInput.declinationProvenance,
                    yawSamples: rotation.yawSamples,
                    compassConfidence: rotation.compassConfidence,
                    declinationDeg: northInput.declinationDeg,
                    yawSpreadDeg: rotation.yawSpreadDeg
                ),
                planToWorld: VastuArPlanToWorld(
                    units: "metres",
                    origin: [roundHalfUp(u0, 3), roundHalfUp(loopA.y, 3), roundHalfUp(-v0, 3)],
                    xAxis: [roundHalfUp(c, 9), 0.0, roundHalfUp(-s, 9)],
                    yAxis: [roundHalfUp(-s, 9), 0.0, roundHalfUp(-c, 9)]
                )
            ),
            outline: VastuRoomCaptureOutline(polygon: finish(outlinePlan, shift: shift).map(toList), source: session.outline.source),
            rooms: rooms,
            quality: VastuRoomCaptureQuality(
                polygonClosure: gap <= closedLoopToleranceM,
                pointCloudDensityBasis: quality.pointCloudDensityBasis,
                roomCount: rooms.count,
                roomsTagged: rooms.filter { $0.label != nil }.count,
                closureGapM: gap,
                pointCloudDensity: quality.pointCloudDensity,
                coveragePercent: quality.coveragePercent,
                scanDurationSec: quality.scanDurationSec,
                scannedAreaM2: quality.scannedAreaM2,
                expectedRoomCount: quality.expectedRoomCount,
                gpsConfidence: quality.gpsConfidence
            ),
            attestation: "caller-reported"
        )
    }
}
