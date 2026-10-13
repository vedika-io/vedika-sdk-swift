import CoreFoundation
import Foundation
import VedikaSDK

/// Returned advice and its own source, positioned in capture-plan metres.
/// Placement sources are never substituted for missing remedy sources.
public struct RemedyFloorPlacement: Sendable {
    public let id: String
    public let roomId: String?
    public let zone: String?
    public let point: SIMD2<Double>
    public let advice: String
    public let source: String
    public let classification: String?
    public let number: Int
    public var sourceLabel: String { source.isEmpty ? "Remedy source not supplied." : "Remedy source: \(source)" }
}

/// Geometry port of the public floor scene: data.rooms, audit.defects,
/// planAnalysis.defects, anchorRecommendations.anchors and reference catalogs.
/// Advice is copied from responses. This adapter computes no Vastu rules,
/// north correction, efficacy claim or device-accuracy estimate.
public struct RemedyFloorOverlay: Sendable {
    public let captureId: String
    public let placements: [RemedyFloorPlacement]
    public let polygons: [FloorOverlayPolygon]

    public init(capture: VastuRoomCapture, response: VastuTypedResponse<VastuArRoomCaptureData>,
                catalog: [String: Any] = [:]) throws {
        try self.init(capture: capture.dictionary, response: response.raw, catalog: catalog)
    }

    public init(capture: [String: Any], response: [String: Any], catalog: [String: Any] = [:]) throws {
        guard capture["schema"] as? String == "vedika.roomCapture/1",
              let id = capture["captureId"] as? String, !id.isEmpty,
              (capture["frame"] as? [String: Any])?["units"] as? String == "metres",
              let outlineObject = capture["outline"] as? [String: Any],
              let roomRows = capture["rooms"] as? [[String: Any]], roomRows.count <= 64 else {
            throw FloorOverlayError.invalidGeometry
        }
        // A single floor renderer cannot represent voids or multiple levels.
        guard (outlineObject["holes"] as? [Any] ?? []).isEmpty,
              (outlineObject["multipolygons"] as? [Any] ?? []).isEmpty else { throw FloorOverlayError.invalidGeometry }
        let outline = try Self.polygon(outlineObject["polygon"])
        let data = response["data"] as? [String: Any] ?? response
        if let returnedId = (data["capture"] as? [String: Any])?["captureId"] as? String, returnedId != id {
            throw FloorOverlayError.invalidIdentity
        }
        if response["success"] as? Bool == false { throw FloorOverlayError.invalidIdentity }
        let returned = data["rooms"] as? [[String: Any]] ?? []
        var rooms: [Room] = []
        var identities = Set<String>(), floors = Set<Int>()
        for row in roomRows {
            guard let roomId = row["id"] as? String, !roomId.isEmpty, identities.insert(roomId).inserted else {
                throw FloorOverlayError.invalidIdentity
            }
            floors.insert(row["floorIndex"] as? Int ?? 0)
            let polygon = try Self.polygon(row["polygon"])
            let actual = returned.first { $0["id"] as? String == roomId }
            rooms.append(Room(id: roomId, label: Self.text(row["label"]),
                roomType: Self.text(actual?["roomType"] ?? row["label"]),
                zone: actual?["zone"] as? String, polygon: polygon,
                point: try Self.interior(polygon)))
        }
        guard floors.count <= 1 else { throw FloorOverlayError.invalidGeometry }
        let audit = data["audit"] as? [String: Any] ?? [:]
        let analysis = data["planAnalysis"] as? [String: Any] ?? [:]
        let defects = (audit["defects"] as? [[String: Any]] ?? []) + (analysis["defects"] as? [[String: Any]] ?? [])
        guard defects.count <= 1024 else { throw FloorOverlayError.invalidGeometry }
        var seen = Set<String>(), unique: [[String: Any]] = []
        for defect in defects {
            let signature: [Any] = [defect["roomId"] ?? NSNull(), defect["room"] ?? NSNull(),
                defect["roomType"] ?? NSNull(), defect["zone"] ?? NSNull(), defect["code"] ?? NSNull(),
                defect["issue"] ?? defect["message"] ?? NSNull(), defect["remedy"] ?? NSNull()]
            if seen.insert(try AttestationCanonicalJSON.encode(signature)).inserted { unique.append(defect) }
        }
        let remedyRows = catalog["remedies"] as? [[String: Any]] ?? []
        let zoneRows = catalog["zoneRemedies"] as? [[String: Any]] ?? []
        let recommendations = (data["anchorRecommendations"] as? [String: Any])?["anchors"] as? [[String: Any]] ?? []
        // Room and issue markers participate in the web scene's numbering and
        // collision spacing; only remedy markers become these floor polygons.
        var markers = rooms.map { Marker(id: "room-\($0.id)", room: $0, point: $0.point, owner: $0.polygon) }
        for (index, defect) in unique.enumerated() {
            let matched = rooms.filter { Self.matches(defect, room: $0) }
            let targets: [Room?] = matched.isEmpty ? [nil] : matched.map { Optional($0) }
            for room in targets {
                let owner = room?.polygon ?? outline, position = try room?.point ?? Self.interior(outline)
                let suffix = "\(index)-\(room?.id ?? "plot")"
                markers.append(Marker(id: "issue-\(suffix)", room: room, point: position, owner: owner))
                let entry = remedyRows.first { ($0["defectCode"] as? String) == (defect["code"] as? String) && defect["code"] is String }
                let advice = Self.text(defect["remedy"] ?? entry?["remedy"])
                if !advice.isEmpty {
                    markers.append(Marker(id: "remedy-\(suffix)", room: room, point: position, owner: owner,
                        advice: advice, source: Self.text(defect["remedySource"] ?? entry?["source"]),
                        classification: (defect["remedyClassification"] ?? entry?["classification"]) as? String,
                        zone: defect["zone"] as? String ?? room?.zone))
                }
                if let zone = defect["recommendedZone"] as? String, let room,
                   recommendations.contains(where: {
                       guard $0["zone"] as? String == zone, let p = Self.point($0["planPosition"]) else { return false }
                       return Self.inside(p, outline)
                   }) {
                    markers.append(Marker(id: "move-\(suffix)", room: room, point: position, owner: owner))
                }
            }
        }
        for room in rooms where !unique.contains(where: { Self.matches($0, room: room) }) {
            if let row = zoneRows.first(where: { ($0["zone"] as? String) == room.zone && !Self.text($0["remedy"]).isEmpty }), room.zone != nil {
                markers.append(Marker(id: "zone-remedy-\(room.id)", room: room, point: room.point, owner: room.polygon,
                    advice: Self.text(row["remedy"]), source: Self.text(row["source"]),
                    classification: row["classification"] as? String, zone: room.zone))
            }
        }
        var stacks: [SIMD2<Double>: Int] = [:], placements: [RemedyFloorPlacement] = [], polygons: [FloorOverlayPolygon] = []
        for (index, marker) in markers.enumerated() {
            let n = stacks[marker.point] ?? 0; stacks[marker.point] = n + 1
            var p = marker.point
            if n > 0 {
                let b = Self.bounds(marker.owner)
                let radius = min(min(b.1.x - b.0.x, b.1.y - b.0.y) / 5, 0.25 * sqrt(Double(n)))
                p = try Self.interior(marker.owner, preferred: p + SIMD2(cos(Double(n) * 2.4), sin(Double(n) * 2.4)) * radius)
            }
            guard let advice = marker.advice else { continue }
            placements.append(RemedyFloorPlacement(id: marker.id, roomId: marker.room?.id, zone: marker.zone,
                point: p, advice: advice, source: marker.source, classification: marker.classification, number: index + 1))
            let label = "\(index + 1). " + (advice.count > 64 ? String(advice.prefix(61)) + "…" : advice)
            polygons.append(try FloorOverlayPolygon(label: label, points: Self.markerPolygon(at: p, inside: marker.owner)))
        }
        self.captureId = id; self.placements = placements; self.polygons = polygons
    }

    private struct Room {
        let id: String; let label: String; let roomType: String; let zone: String?
        let polygon: [SIMD2<Double>]; let point: SIMD2<Double>
    }
    private struct Marker {
        let id: String; let room: Room?; let point: SIMD2<Double>; let owner: [SIMD2<Double>]
        var advice: String? = nil; var source: String = ""; var classification: String? = nil; var zone: String? = nil
    }
    private static func text(_ value: Any?) -> String { (value as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines) }
    private static func key(_ value: String) -> String { String(value.lowercased().filter { $0.isASCII && ($0.isLetter || $0.isNumber) }) }
    private static func matches(_ defect: [String: Any], room: Room) -> Bool {
        if let id = (defect["roomId"] ?? defect["room_id"]) as? String, !id.isEmpty { return id == room.id }
        let name = key(text(defect["room"] ?? defect["roomType"] ?? defect["roomName"]))
        return !name.isEmpty && [room.label, room.roomType].contains { key($0) == name } &&
            (text(defect["zone"]).isEmpty || defect["zone"] as? String == room.zone)
    }
    private static func point(_ value: Any?) -> SIMD2<Double>? {
        guard let a = value as? [Any], a.count == 2 else { return nil }
        var numbers: [Double] = []
        for value in a {
            guard let n = value as? NSNumber, CFGetTypeID(n) != CFBooleanGetTypeID(), n.doubleValue.isFinite else { return nil }
            numbers.append(n.doubleValue)
        }
        return SIMD2(numbers[0], numbers[1])
    }
    private static func polygon(_ value: Any?) throws -> [SIMD2<Double>] {
        guard let rows = value as? [Any], (3...256).contains(rows.count), rows.allSatisfy({ point($0) != nil }) else {
            throw FloorOverlayError.invalidGeometry
        }
        let points = rows.map { point($0)! }
        _ = try FloorOverlayPolygon(label: "", points: points)
        let b = bounds(points)
        guard b.1.x - b.0.x >= 0.01, b.1.y - b.0.y >= 0.01 else { throw FloorOverlayError.invalidGeometry }
        return points
    }
    private static func bounds(_ polygon: [SIMD2<Double>]) -> (SIMD2<Double>, SIMD2<Double>) {
        (SIMD2(polygon.map(\.x).min()!, polygon.map(\.y).min()!), SIMD2(polygon.map(\.x).max()!, polygon.map(\.y).max()!))
    }
    private static func inside(_ p: SIMD2<Double>, _ polygon: [SIMD2<Double>]) -> Bool {
        var yes = false
        for i in polygon.indices {
            let a = polygon[i], b = polygon[(i + 1) % polygon.count]
            let cross = (b.x - a.x) * (p.y - a.y) - (b.y - a.y) * (p.x - a.x)
            if abs(cross) < 1e-7 && p.x >= min(a.x, b.x) - 1e-7 && p.x <= max(a.x, b.x) + 1e-7 &&
                p.y >= min(a.y, b.y) - 1e-7 && p.y <= max(a.y, b.y) + 1e-7 { return true }
            if (a.y > p.y) != (b.y > p.y) && p.x < (b.x - a.x) * (p.y - a.y) / (b.y - a.y) + a.x { yes.toggle() }
        }
        return yes
    }
    private static func interior(_ polygon: [SIMD2<Double>], preferred: SIMD2<Double>? = nil) throws -> SIMD2<Double> {
        var area = 0.0, sum = SIMD2<Double>(repeating: 0)
        for i in polygon.indices {
            let a = polygon[i], b = polygon[(i + 1) % polygon.count], c = a.x * b.y - b.x * a.y
            area += c; sum += (a + b) * c
        }
        guard abs(area) >= 1e-8 else { throw FloorOverlayError.invalidGeometry }
        let p = preferred ?? sum / (3 * area)
        if inside(p, polygon) { return p }
        let b = bounds(polygon)
        let ys = [p.y] + (1...19).map { b.0.y + Double($0) * (b.1.y - b.0.y) / 20 }
        for y in ys {
            var cuts = [b.0.x, b.1.x]
            for i in polygon.indices {
                let a = polygon[i], z = polygon[(i + 1) % polygon.count]
                if abs(z.y - a.y) > 1e-10 {
                    let u = (y - a.y) / (z.y - a.y), x = a.x + u * (z.x - a.x)
                    if u >= 0 && u <= 1 && x > b.0.x && x < b.1.x { cuts.append(x) }
                }
            }
            cuts.sort(); var spans: [(Double, Double)] = []
            for i in 1..<cuts.count where cuts[i] - cuts[i - 1] > 1e-8 {
                if inside(SIMD2((cuts[i] + cuts[i - 1]) / 2, y), polygon) { spans.append((cuts[i - 1], cuts[i])) }
            }
            if let span = spans.max(by: { $0.1 - $0.0 < $1.1 - $1.0 }) { return SIMD2((span.0 + span.1) / 2, y) }
        }
        throw FloorOverlayError.invalidGeometry
    }
    private static func markerPolygon(at p: SIMD2<Double>, inside owner: [SIMD2<Double>]) throws -> [SIMD2<Double>] {
        let b = bounds(owner); var radius = min(0.08, min(b.1.x - b.0.x, b.1.y - b.0.y) / 10)
        for _ in 0..<20 {
            let ring = [SIMD2(p.x - radius, p.y - radius), SIMD2(p.x + radius, p.y - radius),
                        SIMD2(p.x + radius, p.y + radius), SIMD2(p.x - radius, p.y + radius)]
            if ring.allSatisfy({ inside($0, owner) }) { return ring }
            radius /= 2
        }
        throw FloorOverlayError.invalidGeometry
    }
}
