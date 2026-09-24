import Foundation

public enum VastuOperation: String, CaseIterable, Sendable {
    case scansTimelapse = "scans/timelapse"
    case scansDelete = "scans/delete"
    case scansList = "scans/list"
    case scansRetrieve = "scans/retrieve"
    case scansSave = "scans/save"
    case arDeityIcons = "ar/deity-icons"
    case arRoomCapture = "ar/room-capture"
    case arYantraMeshes = "ar/yantra-meshes"
    case arZoneTextures = "ar/zone-textures"
    case arAnchorRecommendations = "ar/anchor-recommendations"
    case arHeatmapRaster = "ar/heatmap-raster"
    case plotShape = "plot/shape"
    case plotRatio = "plot/ratio"
    case entrancePada = "entrance/pada"
    case directionCorrect = "direction/correct"
    case directionDeclination = "direction/declination"
    case directionZoneFromBearing = "direction/zone-from-bearing"
    case auditFloorPlan = "audit/floor-plan"
    case auditFloorPlanDetailed = "audit/floor-plan-detailed"
    case auditSingleRoom = "audit/single-room"
    case arScanQuality = "ar/scan-quality"
    case mandalaProject9Zone = "mandala/project/9-zone"
    case mandalaProject81Pada = "mandala/project/81-pada"
    case mandalaProjectBrahmasthan = "mandala/project/brahmasthan"
    case referenceDirections8 = "reference/directions/8"
    case referenceMandala9Zone = "reference/mandala/9-zone"
    case referenceMandala45Devatas = "reference/mandala/45-devatas"
    case referenceDefectsCatalog = "reference/defects/catalog"
    case referenceRemediesCatalog = "reference/remedies/catalog"
    case referenceDirections16 = "reference/directions/16"
    case referenceDirections32 = "reference/directions/32"
    case referenceColorsByZone = "reference/colors-by-zone"
    case referenceMaterialsByZone = "reference/materials-by-zone"
    case referenceMandala64Pada = "reference/mandala/64-pada"
    case referenceGateObstructions = "reference/gate-obstructions"
    case roomKitchen = "room/kitchen"
    case roomBedroom = "room/bedroom"
    case roomPooja = "room/pooja"
    case roomToilet = "room/toilet"
    case roomStaircase = "room/staircase"
    case roomStudy = "room/study"
    case roomLiving = "room/living"
    case roomDining = "room/dining"
    case roomStore = "room/store"
    case roomWaterStorage = "room/water-storage"
    case placementBorewell = "placement/borewell"
    case placementWell = "placement/well"
    case placementSepticTank = "placement/septic-tank"
    case placementOverheadTank = "placement/overhead-tank"
    case placementTree = "placement/tree"
    case placementGarden = "placement/garden"
    case placementBalcony = "placement/balcony"
    case placementWindow = "placement/window"
    case placementGeneratorElectrical = "placement/generator-electrical"
    case placementMainGate = "placement/main-gate"
    case plotExtensionsCuts = "plot/extensions-cuts"
    case plotSlope = "plot/slope"
    case plotOrientation = "plot/orientation"
    case plotRoadOrientation = "plot/road-orientation"
    case entranceRecommend = "entrance/recommend"
    case elementsDistribution = "elements/distribution"
    case elementsBalanceSuggest = "elements/balance-suggest"
    case directionAuspiciousFacing = "direction/auspicious-facing"
    case scoreOverall = "score/overall"
    case scoreZoneWise = "score/zone-wise"
    case scoreComplianceIndex = "score/compliance-index"
    case multiStoreyFloorRules = "multi-storey/floor-rules"
    case compoundWallAnalysis = "compound/wall-analysis"
    case floorLevelAnalysis = "floor/level-analysis"
    case specializedResidential = "specialized/residential"
    case specializedCommercial = "specialized/commercial"
    case specializedTemple = "specialized/temple"
    case specializedFactory = "specialized/factory"
    case specializedHospital = "specialized/hospital"
    case specializedRestaurant = "specialized/restaurant"
    case specializedEducational = "specialized/educational"
    case timingBhumiPujan = "timing/bhumi-pujan"
    case timingGrihapravesh = "timing/grihapravesh"
    case timingConstructionStart = "timing/construction-start"
    case timingVastuShanti = "timing/vastu-shanti"
    case planAnalyze = "plan/analyze"
    case planUpload = "plan/upload"
    case planReport = "plan/report"
    case planGenerate = "plan/generate"
    case planFromRequirements = "plan/from-requirements"
    case planOptimize = "plan/optimize"
    case fusionChart = "fusion/chart"
    case compareBeforeAfterRemedy = "compare/before-after-remedy"
    case entranceObstructionCheck = "entrance/obstruction-check"
    case directionSunPath = "direction/sun-path"
    case arTrueNorthCalibrate = "ar/true-north-calibrate"
    case assessments = "assessments"
    case assessmentsBatch = "assessments/batch"
}

public struct VastuPoint: Sendable {
    public let x: Double
    public let y: Double
    public init(x: Double, y: Double) { self.x = x; self.y = y }
    fileprivate var array: [Double] { [x, y] }
}

public struct VastuRoomInput: Sendable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var polygon: [VastuPoint]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, polygon: [VastuPoint]? = nil, area: Double? = nil) {
        self.name = name; self.roomType = roomType; self.zone = zone; self.polygon = polygon; self.area = area
    }
}

public struct VastuPlotInput: Sendable {
    public var width: Double?
    public var length: Double?
    public var facing: String?
    public var polygon: [VastuPoint]?
    public init(width: Double? = nil, length: Double? = nil, facing: String? = nil, polygon: [VastuPoint]? = nil) {
        self.width = width; self.length = length; self.facing = facing; self.polygon = polygon
    }
}

public struct VastuOperationRequest: Sendable {
    public var plotPolygon: [VastuPoint]?
    public var bearingDeg: Double?
    public var doorXY: VastuPoint?
    public var zone: String?
    public var rooms: [VastuRoomInput]?
    public var plot: VastuPlotInput?
    public var lat: Double?
    public var lon: Double?
    public var latitude: Double?
    public var longitude: Double?
    public var datetime: String?
    public var date: String?
    public var deviceHeadingAtSunDeg: Double?
    public var pointCloudDensity: Double?
    public var polygonClosure: Bool?
    public var roomsTagged: Bool?
    public var compassConfidence: Double?
    public var gpsConfidence: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public var variants: Int?
    public var obstruction: String?
    public var distance: Double?
    public var entranceDirection: String?

    public init() {}

    fileprivate var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let plotPolygon { result["plotPolygon"] = plotPolygon.map(\.array) }
        if let bearingDeg { result["bearingDeg"] = bearingDeg }
        if let doorXY { result["doorXY"] = doorXY.array }
        if let zone { result["zone"] = zone }
        if let rooms { result["rooms"] = rooms.map { room in
            var value: [String: Any] = ["name": room.name]
            if let roomType = room.roomType { value["roomType"] = roomType }
            if let zone = room.zone { value["zone"] = zone }
            if let polygon = room.polygon { value["polygon"] = polygon.map(\.array) }
            if let area = room.area { value["area"] = area }
            return value
        } }
        if let plot {
            var value: [String: Any] = [:]
            if let width = plot.width { value["width"] = width }
            if let length = plot.length { value["length"] = length }
            if let facing = plot.facing { value["facing"] = facing }
            if let polygon = plot.polygon { value["polygon"] = polygon.map(\.array) }
            result["plot"] = value
        }
        let optionals: [(String, Any?)] = [
            ("lat", lat), ("lon", lon), ("latitude", latitude), ("longitude", longitude),
            ("datetime", datetime), ("date", date), ("deviceHeadingAtSunDeg", deviceHeadingAtSunDeg),
            ("pointCloudDensity", pointCloudDensity), ("polygonClosure", polygonClosure),
            ("roomsTagged", roomsTagged), ("compassConfidence", compassConfidence),
            ("gpsConfidence", gpsConfidence), ("scanDurationSec", scanDurationSec),
            ("scannedAreaM2", scannedAreaM2), ("variants", variants),
            ("obstruction", obstruction), ("distance", distance), ("entranceDirection", entranceDirection),
        ]
        for (key, value) in optionals { if let value { result[key] = value } }
        return result
    }
}

public struct VastuOperationResult {
    public let raw: [String: Any]
    public var success: Bool? { raw["success"] as? Bool }
    public var score: Double? { (raw["score"] as? NSNumber)?.doubleValue }
    public var grade: String? { raw["grade"] as? String }
    public var reliable: Bool? { raw["reliable"] as? Bool }
    public var reason: String? { raw["reason"] as? String }
    public var offsetDeg: Double? { (raw["offsetDeg"] as? NSNumber)?.doubleValue }
}







// BEGIN GENERATED VASTU CONTRACTS — source: served OpenAPI

public protocol VastuEncodable { var dictionary: [String: Any] { get } }

public protocol VastuRequest: VastuEncodable {}

public struct VastuNoRequest: VastuRequest { public init() {}
    public var dictionary: [String: Any] { [:] }
}

public enum VastuJsonObjectOrArray { case object([String: Any]); case array([[String: Any]]) }

private func encodeVastu(_ value: Any) -> Any {
    if let value = value as? VastuEncodable { return value.dictionary }
    if let value = value as? VastuJsonObjectOrArray { switch value { case .object(let object): return object; case .array(let array): return array } }
    if let value = value as? [Any] { return value.map(encodeVastu) }
    return value
}

private func vastuDouble(_ value: Any?) -> Double? { (value as? NSNumber)?.doubleValue }

private func vastuInt(_ value: Any?) -> Int? { (value as? NSNumber)?.intValue }

private func vastuBool(_ value: Any?) -> Bool? { (value as? NSNumber)?.boolValue }

public struct VastuArHeatmapRasterRequestRoomsItem: VastuRequest {
    public var roomType: String
    public var zone: String
    public init(roomType: String, zone: String) { self.roomType = roomType; self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArHeatmapRasterRequest: VastuRequest {
    public var rooms: [VastuArHeatmapRasterRequestRoomsItem]
    public var plotPolygon: [[Double]]?
    public var bearingDeg: Double?
    public init(rooms: [VastuArHeatmapRasterRequestRoomsItem], plotPolygon: [[Double]]? = nil, bearingDeg: Double? = nil) { self.rooms = rooms; self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArPlanToWorld: VastuRequest {
    public var units: String
    public var origin: [Double]
    public var xAxis: [Double]
    public var yAxis: [Double]
    public init(units: String, origin: [Double], xAxis: [Double], yAxis: [Double]) { self.units = units; self.origin = origin; self.xAxis = xAxis; self.yAxis = yAxis }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units as Any? { result["units"] = encodeVastu(value) }
        if let value = origin as Any? { result["origin"] = encodeVastu(value) }
        if let value = xAxis as Any? { result["xAxis"] = encodeVastu(value) }
        if let value = yAxis as Any? { result["yAxis"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArAnchorRecommendationsRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double
    public var planToWorld: VastuArPlanToWorld
    public init(plotPolygon: [[Double]], bearingDeg: Double, planToWorld: VastuArPlanToWorld) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.planToWorld = planToWorld }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = planToWorld as Any? { result["planToWorld"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArZoneTexturesRequest: VastuRequest {
    public var zone: String?
    public init(zone: String? = nil) { self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArYantraMeshesRequest: VastuRequest {
    public var model: String
    public var format: String?
    public init(model: String, format: String? = nil) { self.model = model; self.format = format }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = model as Any? { result["model"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArDeityIconsRequest: VastuRequest {
    public var zone: String?
    public init(zone: String? = nil) { self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureDevice: VastuRequest {
    public var platform: String
    public var method: String
    public var depth: String
    public init(platform: String, method: String, depth: String) { self.platform = platform; self.method = method; self.depth = depth }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = platform as Any? { result["platform"] = encodeVastu(value) }
        if let value = method as Any? { result["method"] = encodeVastu(value) }
        if let value = depth as Any? { result["depth"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureFrameNorth: VastuRequest {
    public var referenceFrame: String
    public var headingSource: String
    public var declinationProvenance: String
    public var yawSamples: Int
    public var compassConfidence: Double
    public var declinationDeg: Double?
    public var yawSpreadDeg: Double?
    public init(referenceFrame: String, headingSource: String, declinationProvenance: String, yawSamples: Int, compassConfidence: Double, declinationDeg: Double? = nil, yawSpreadDeg: Double? = nil) { self.referenceFrame = referenceFrame; self.headingSource = headingSource; self.declinationProvenance = declinationProvenance; self.yawSamples = yawSamples; self.compassConfidence = compassConfidence; self.declinationDeg = declinationDeg; self.yawSpreadDeg = yawSpreadDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = referenceFrame as Any? { result["referenceFrame"] = encodeVastu(value) }
        if let value = headingSource as Any? { result["headingSource"] = encodeVastu(value) }
        if let value = declinationDeg as Any? { result["declinationDeg"] = encodeVastu(value) }
        if let value = declinationProvenance as Any? { result["declinationProvenance"] = encodeVastu(value) }
        if let value = yawSamples as Any? { result["yawSamples"] = encodeVastu(value) }
        if let value = yawSpreadDeg as Any? { result["yawSpreadDeg"] = encodeVastu(value) }
        if let value = compassConfidence as Any? { result["compassConfidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureFrame: VastuRequest {
    public var units: String
    public var axes: String
    public var north: VastuRoomCaptureFrameNorth
    public var planToWorld: VastuArPlanToWorld?
    public init(units: String, axes: String, north: VastuRoomCaptureFrameNorth, planToWorld: VastuArPlanToWorld? = nil) { self.units = units; self.axes = axes; self.north = north; self.planToWorld = planToWorld }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units as Any? { result["units"] = encodeVastu(value) }
        if let value = axes as Any? { result["axes"] = encodeVastu(value) }
        if let value = north as Any? { result["north"] = encodeVastu(value) }
        if let value = planToWorld as Any? { result["planToWorld"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureOutline: VastuRequest {
    public var polygon: [[Double]]
    public var source: String
    public init(polygon: [[Double]], source: String = "traced") { self.polygon = polygon; self.source = source }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = source as Any? { result["source"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureRoomsItemOpeningsItem: VastuRequest {
    public var kind: String
    public var centerXY: [Double]
    public var widthM: Double
    public var confidence: String
    public var heightM: Double?
    public init(kind: String, centerXY: [Double], widthM: Double, confidence: String, heightM: Double? = nil) { self.kind = kind; self.centerXY = centerXY; self.widthM = widthM; self.confidence = confidence; self.heightM = heightM }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = kind as Any? { result["kind"] = encodeVastu(value) }
        if let value = centerXY as Any? { result["centerXY"] = encodeVastu(value) }
        if let value = widthM as Any? { result["widthM"] = encodeVastu(value) }
        if let value = heightM as Any? { result["heightM"] = encodeVastu(value) }
        if let value = confidence as Any? { result["confidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureRoomsItem: VastuRequest {
    public var id: String
    public var label: String?
    public var labelSource: String
    public var polygon: [[Double]]
    public var areaM2: Double
    public var floorIndex: Int
    public var heightM: Double?
    public var openings: [VastuRoomCaptureRoomsItemOpeningsItem]?
    public init(id: String, label: String?, labelSource: String, polygon: [[Double]], areaM2: Double, floorIndex: Int, heightM: Double? = nil, openings: [VastuRoomCaptureRoomsItemOpeningsItem]? = nil) { self.id = id; self.label = label; self.labelSource = labelSource; self.polygon = polygon; self.areaM2 = areaM2; self.floorIndex = floorIndex; self.heightM = heightM; self.openings = openings }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = labelSource as Any? { result["labelSource"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = areaM2 as Any? { result["areaM2"] = encodeVastu(value) }
        if let value = heightM as Any? { result["heightM"] = encodeVastu(value) }
        if let value = floorIndex as Any? { result["floorIndex"] = encodeVastu(value) }
        if let value = openings as Any? { result["openings"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCaptureQuality: VastuRequest {
    public var polygonClosure: Bool
    public var pointCloudDensityBasis: String
    public var roomCount: Int
    public var roomsTagged: Int
    public var closureGapM: Double?
    public var pointCloudDensity: Double?
    public var coveragePercent: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public var expectedRoomCount: Int?
    public var gpsConfidence: Double?
    public init(polygonClosure: Bool, pointCloudDensityBasis: String, roomCount: Int, roomsTagged: Int, closureGapM: Double? = nil, pointCloudDensity: Double? = nil, coveragePercent: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, expectedRoomCount: Int? = nil, gpsConfidence: Double? = nil) { self.polygonClosure = polygonClosure; self.pointCloudDensityBasis = pointCloudDensityBasis; self.roomCount = roomCount; self.roomsTagged = roomsTagged; self.closureGapM = closureGapM; self.pointCloudDensity = pointCloudDensity; self.coveragePercent = coveragePercent; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.expectedRoomCount = expectedRoomCount; self.gpsConfidence = gpsConfidence }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = polygonClosure as Any? { result["polygonClosure"] = encodeVastu(value) }
        if let value = closureGapM as Any? { result["closureGapM"] = encodeVastu(value) }
        if let value = pointCloudDensity as Any? { result["pointCloudDensity"] = encodeVastu(value) }
        if let value = pointCloudDensityBasis as Any? { result["pointCloudDensityBasis"] = encodeVastu(value) }
        if let value = coveragePercent as Any? { result["coveragePercent"] = encodeVastu(value) }
        if let value = scanDurationSec as Any? { result["scanDurationSec"] = encodeVastu(value) }
        if let value = scannedAreaM2 as Any? { result["scannedAreaM2"] = encodeVastu(value) }
        if let value = roomCount as Any? { result["roomCount"] = encodeVastu(value) }
        if let value = expectedRoomCount as Any? { result["expectedRoomCount"] = encodeVastu(value) }
        if let value = roomsTagged as Any? { result["roomsTagged"] = encodeVastu(value) }
        if let value = gpsConfidence as Any? { result["gpsConfidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomCapture: VastuRequest {
    public var schema: String
    public var captureId: String
    public var capturedAtEpoch: Int
    public var device: VastuRoomCaptureDevice
    public var frame: VastuRoomCaptureFrame
    public var outline: VastuRoomCaptureOutline
    public var rooms: [VastuRoomCaptureRoomsItem]
    public var quality: VastuRoomCaptureQuality
    public var attestation: String
    public init(schema: String, captureId: String, capturedAtEpoch: Int, device: VastuRoomCaptureDevice, frame: VastuRoomCaptureFrame, outline: VastuRoomCaptureOutline, rooms: [VastuRoomCaptureRoomsItem], quality: VastuRoomCaptureQuality, attestation: String) { self.schema = schema; self.captureId = captureId; self.capturedAtEpoch = capturedAtEpoch; self.device = device; self.frame = frame; self.outline = outline; self.rooms = rooms; self.quality = quality; self.attestation = attestation }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = schema as Any? { result["schema"] = encodeVastu(value) }
        if let value = captureId as Any? { result["captureId"] = encodeVastu(value) }
        if let value = capturedAtEpoch as Any? { result["capturedAtEpoch"] = encodeVastu(value) }
        if let value = device as Any? { result["device"] = encodeVastu(value) }
        if let value = frame as Any? { result["frame"] = encodeVastu(value) }
        if let value = outline as Any? { result["outline"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = quality as Any? { result["quality"] = encodeVastu(value) }
        if let value = attestation as Any? { result["attestation"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArRoomCaptureRequest: VastuRequest {
    public var capture: VastuRoomCapture
    public var zoneResolution: Int?
    public init(capture: VastuRoomCapture, zoneResolution: Int? = nil) { self.capture = capture; self.zoneResolution = zoneResolution }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = capture as Any? { result["capture"] = encodeVastu(value) }
        if let value = zoneResolution as Any? { result["zoneResolution"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScanSnapshotRoomsItem: VastuRequest {
    public var roomType: String
    public var zone: String
    public init(roomType: String, zone: String) { self.roomType = roomType; self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScanTelemetry: VastuRequest {
    public var pointCloudDensity: Double
    public var polygonClosure: Bool
    public var compassConfidence: Double
    public var gpsConfidence: Double
    public var roomsTagged: Int
    public var scanDurationSec: Double
    public var scannedAreaM2: Double
    public var roomCount: Int?
    public var expectedRoomCount: Int?
    public init(pointCloudDensity: Double, polygonClosure: Bool, compassConfidence: Double, gpsConfidence: Double, roomsTagged: Int, scanDurationSec: Double, scannedAreaM2: Double, roomCount: Int? = nil, expectedRoomCount: Int? = nil) { self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.roomsTagged = roomsTagged; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.roomCount = roomCount; self.expectedRoomCount = expectedRoomCount }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = pointCloudDensity as Any? { result["pointCloudDensity"] = encodeVastu(value) }
        if let value = polygonClosure as Any? { result["polygonClosure"] = encodeVastu(value) }
        if let value = compassConfidence as Any? { result["compassConfidence"] = encodeVastu(value) }
        if let value = gpsConfidence as Any? { result["gpsConfidence"] = encodeVastu(value) }
        if let value = roomsTagged as Any? { result["roomsTagged"] = encodeVastu(value) }
        if let value = scanDurationSec as Any? { result["scanDurationSec"] = encodeVastu(value) }
        if let value = scannedAreaM2 as Any? { result["scannedAreaM2"] = encodeVastu(value) }
        if let value = roomCount as Any? { result["roomCount"] = encodeVastu(value) }
        if let value = expectedRoomCount as Any? { result["expectedRoomCount"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScanSnapshot: VastuRequest {
    public var inputSource: String
    public var rooms: [VastuScanSnapshotRoomsItem]?
    public var plotPolygon: [[Double]]?
    public var bearingDeg: Double?
    public var telemetry: VastuScanTelemetry?
    public var capture: VastuRoomCapture?
    public init(inputSource: String, rooms: [VastuScanSnapshotRoomsItem]? = nil, plotPolygon: [[Double]]? = nil, bearingDeg: Double? = nil, telemetry: VastuScanTelemetry? = nil, capture: VastuRoomCapture? = nil) { self.inputSource = inputSource; self.rooms = rooms; self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.telemetry = telemetry; self.capture = capture }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = inputSource as Any? { result["inputSource"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = telemetry as Any? { result["telemetry"] = encodeVastu(value) }
        if let value = capture as Any? { result["capture"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScansSaveRequest: VastuRequest {
    public var scanId: String
    public var propertyId: String
    public var title: String
    public var retentionDays: Int
    public var snapshot: VastuScanSnapshot
    public init(scanId: String, propertyId: String, title: String, retentionDays: Int, snapshot: VastuScanSnapshot) { self.scanId = scanId; self.propertyId = propertyId; self.title = title; self.retentionDays = retentionDays; self.snapshot = snapshot }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = retentionDays as Any? { result["retentionDays"] = encodeVastu(value) }
        if let value = snapshot as Any? { result["snapshot"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScansRetrieveRequest: VastuRequest {
    public var requestId: String
    public var scanId: String
    public init(requestId: String, scanId: String) { self.requestId = requestId; self.scanId = scanId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScansListRequest: VastuRequest {
    public var requestId: String
    public var limit: Int
    public var cursor: String?
    public init(requestId: String, limit: Int, cursor: String? = nil) { self.requestId = requestId; self.limit = limit; self.cursor = cursor }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = limit as Any? { result["limit"] = encodeVastu(value) }
        if let value = cursor as Any? { result["cursor"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScansDeleteRequest: VastuRequest {
    public var scanId: String
    public init(scanId: String) { self.scanId = scanId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScansTimelapseRequest: VastuRequest {
    public var requestId: String
    public var scanIds: [String]
    public init(requestId: String, scanIds: [String]) { self.requestId = requestId; self.scanIds = scanIds }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = scanIds as Any? { result["scanIds"] = encodeVastu(value) }
        return result
    }
}


public struct VastuArScanQualityRequest: VastuRequest {
    public var pointCloudDensity: Double?
    public var polygonClosure: Bool?
    public var roomsTagged: Bool?
    public var compassConfidence: Double?
    public var gpsConfidence: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public var roomCount: Int?
    public var expectedRoomCount: Int?
    public var pointCloudDensityPerM2: Double?
    public var polygonClosed: Bool?
    public var coveragePercent: Double?
    public var pointCloudDensityBasis: String?
    public init(pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Bool? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, roomCount: Int? = nil, expectedRoomCount: Int? = nil, pointCloudDensityPerM2: Double? = nil, polygonClosed: Bool? = nil, coveragePercent: Double? = nil, pointCloudDensityBasis: String? = nil) { self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.roomCount = roomCount; self.expectedRoomCount = expectedRoomCount; self.pointCloudDensityPerM2 = pointCloudDensityPerM2; self.polygonClosed = polygonClosed; self.coveragePercent = coveragePercent; self.pointCloudDensityBasis = pointCloudDensityBasis }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = pointCloudDensity as Any? { result["pointCloudDensity"] = encodeVastu(value) }
        if let value = polygonClosure as Any? { result["polygonClosure"] = encodeVastu(value) }
        if let value = roomsTagged as Any? { result["roomsTagged"] = encodeVastu(value) }
        if let value = compassConfidence as Any? { result["compassConfidence"] = encodeVastu(value) }
        if let value = gpsConfidence as Any? { result["gpsConfidence"] = encodeVastu(value) }
        if let value = scanDurationSec as Any? { result["scanDurationSec"] = encodeVastu(value) }
        if let value = scannedAreaM2 as Any? { result["scannedAreaM2"] = encodeVastu(value) }
        if let value = roomCount as Any? { result["roomCount"] = encodeVastu(value) }
        if let value = expectedRoomCount as Any? { result["expectedRoomCount"] = encodeVastu(value) }
        if let value = pointCloudDensityPerM2 as Any? { result["pointCloudDensityPerM2"] = encodeVastu(value) }
        if let value = polygonClosed as Any? { result["polygonClosed"] = encodeVastu(value) }
        if let value = coveragePercent as Any? { result["coveragePercent"] = encodeVastu(value) }
        if let value = pointCloudDensityBasis as Any? { result["pointCloudDensityBasis"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCountedScanQualityRequest: VastuRequest {
    public var pointCloudDensity: Double?
    public var polygonClosure: Bool?
    public var roomsTagged: Int?
    public var compassConfidence: Double?
    public var gpsConfidence: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public var roomCount: Int?
    public var expectedRoomCount: Int?
    public var pointCloudDensityPerM2: Double?
    public var polygonClosed: Bool?
    public var coveragePercent: Double?
    public var pointCloudDensityBasis: String?
    public init(pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Int? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, roomCount: Int? = nil, expectedRoomCount: Int? = nil, pointCloudDensityPerM2: Double? = nil, polygonClosed: Bool? = nil, coveragePercent: Double? = nil, pointCloudDensityBasis: String? = nil) { self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.roomCount = roomCount; self.expectedRoomCount = expectedRoomCount; self.pointCloudDensityPerM2 = pointCloudDensityPerM2; self.polygonClosed = polygonClosed; self.coveragePercent = coveragePercent; self.pointCloudDensityBasis = pointCloudDensityBasis }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = pointCloudDensity as Any? { result["pointCloudDensity"] = encodeVastu(value) }
        if let value = polygonClosure as Any? { result["polygonClosure"] = encodeVastu(value) }
        if let value = roomsTagged as Any? { result["roomsTagged"] = encodeVastu(value) }
        if let value = compassConfidence as Any? { result["compassConfidence"] = encodeVastu(value) }
        if let value = gpsConfidence as Any? { result["gpsConfidence"] = encodeVastu(value) }
        if let value = scanDurationSec as Any? { result["scanDurationSec"] = encodeVastu(value) }
        if let value = scannedAreaM2 as Any? { result["scannedAreaM2"] = encodeVastu(value) }
        if let value = roomCount as Any? { result["roomCount"] = encodeVastu(value) }
        if let value = expectedRoomCount as Any? { result["expectedRoomCount"] = encodeVastu(value) }
        if let value = pointCloudDensityPerM2 as Any? { result["pointCloudDensityPerM2"] = encodeVastu(value) }
        if let value = polygonClosed as Any? { result["polygonClosed"] = encodeVastu(value) }
        if let value = coveragePercent as Any? { result["coveragePercent"] = encodeVastu(value) }
        if let value = pointCloudDensityBasis as Any? { result["pointCloudDensityBasis"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArTrueNorthCalibrateRequest: VastuRequest {
    public var lat: Double
    public var lon: Double
    public var datetime: String
    public var deviceHeadingAtSunDeg: Double
    public var deviceHeadingAccuracyDeg: Double?
    public var headingSampleAgeMs: Double?
    public init(lat: Double, lon: Double, datetime: String, deviceHeadingAtSunDeg: Double, deviceHeadingAccuracyDeg: Double? = nil, headingSampleAgeMs: Double? = nil) { self.lat = lat; self.lon = lon; self.datetime = datetime; self.deviceHeadingAtSunDeg = deviceHeadingAtSunDeg; self.deviceHeadingAccuracyDeg = deviceHeadingAccuracyDeg; self.headingSampleAgeMs = headingSampleAgeMs }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = deviceHeadingAtSunDeg as Any? { result["deviceHeadingAtSunDeg"] = encodeVastu(value) }
        if let value = deviceHeadingAccuracyDeg { result["deviceHeadingAccuracyDeg"] = value }
        if let value = headingSampleAgeMs { result["headingSampleAgeMs"] = value }
        return result
    }
}

public struct VastuAssessmentsRequestRoomsItem: VastuEncodable {
    public var roomType: String
    public var zone: String
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(roomType: String, zone: String, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAssessmentsRequest: VastuRequest {
    public var inputSource: String
    public var rooms: [VastuAssessmentsRequestRoomsItem]?
    public var plotPolygon: [[Double]]?
    public var doorXY: VastuPoint?
    public var bearingDeg: Double?
    public var confidence: Double?
    public var pointCloudDensity: Double?
    public var polygonClosure: Bool?
    public var roomsTagged: Bool?
    public var compassConfidence: Double?
    public var gpsConfidence: Double?
    public var scanDurationSec: Double?
    public var scannedAreaM2: Double?
    public init(inputSource: String, rooms: [VastuAssessmentsRequestRoomsItem]? = nil, plotPolygon: [[Double]]? = nil, doorXY: VastuPoint? = nil, bearingDeg: Double? = nil, confidence: Double? = nil, pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Bool? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil) { self.inputSource = inputSource; self.rooms = rooms; self.plotPolygon = plotPolygon; self.doorXY = doorXY; self.bearingDeg = bearingDeg; self.confidence = confidence; self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2 }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = inputSource as Any? { result["inputSource"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let doorXY { result["doorXY"] = encodeVastu(doorXY.array) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = confidence as Any? { result["confidence"] = encodeVastu(value) }
        if let value = pointCloudDensity as Any? { result["pointCloudDensity"] = encodeVastu(value) }
        if let value = polygonClosure as Any? { result["polygonClosure"] = encodeVastu(value) }
        if let value = roomsTagged as Any? { result["roomsTagged"] = encodeVastu(value) }
        if let value = compassConfidence as Any? { result["compassConfidence"] = encodeVastu(value) }
        if let value = gpsConfidence as Any? { result["gpsConfidence"] = encodeVastu(value) }
        if let value = scanDurationSec as Any? { result["scanDurationSec"] = encodeVastu(value) }
        if let value = scannedAreaM2 as Any? { result["scannedAreaM2"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAssessmentsBatchRequestItemsItem: VastuEncodable {
    public var id: String
    public var assessment: VastuAssessmentsRequest
    public init(id: String, assessment: VastuAssessmentsRequest) { self.id = id; self.assessment = assessment }
    public var dictionary: [String: Any] { ["id": id, "assessment": assessment.dictionary] }
}

/// One to twenty items with unique IDs. Retain the caller key for retries.
public struct VastuAssessmentsBatchRequest: VastuRequest {
    public var items: [VastuAssessmentsBatchRequestItemsItem]
    public init(items: [VastuAssessmentsBatchRequestItemsItem]) { self.items = items }
    public var dictionary: [String: Any] { ["items": items.map { $0.dictionary }] }
}


public struct VastuAuditFloorPlanDetailedRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAuditFloorPlanDetailedRequest: VastuRequest {
    public var rooms: [VastuAuditFloorPlanDetailedRequestRoomsItem]
    public var plotPolygon: [[Double]]?
    public var bearingDeg: Double?
    public init(rooms: [VastuAuditFloorPlanDetailedRequestRoomsItem], plotPolygon: [[Double]]? = nil, bearingDeg: Double? = nil) { self.rooms = rooms; self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAuditFloorPlanRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAuditFloorPlanRequest: VastuRequest {
    public var rooms: [VastuAuditFloorPlanRequestRoomsItem]?
    public var text: String?
    public init(rooms: [VastuAuditFloorPlanRequestRoomsItem]? = nil, text: String? = nil) { self.rooms = rooms; self.text = text }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = text as Any? { result["text"] = encodeVastu(value) }
        return result
    }
}

public struct VastuAuditSingleRoomRequest: VastuRequest {
    public var roomType: String
    public var zone: String
    public init(roomType: String, zone: String) { self.roomType = roomType; self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuCompareBeforeAfterRemedyRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuCompareBeforeAfterRemedyRequestRemediesItem: VastuEncodable {
    public var room: String?
    public var name: String?
    public var roomType: String?
    public var toZone: String
    public var zone: String?
    public init(room: String? = nil, name: String? = nil, roomType: String? = nil, toZone: String, zone: String? = nil) { self.room = room; self.name = name; self.roomType = roomType; self.toZone = toZone; self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = room as Any? { result["room"] = encodeVastu(value) }
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = toZone as Any? { result["toZone"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuCompareBeforeAfterRemedyRequest: VastuRequest {
    public var rooms: [VastuCompareBeforeAfterRemedyRequestRoomsItem]?
    public var text: String?
    public var remedies: [VastuCompareBeforeAfterRemedyRequestRemediesItem]
    public init(rooms: [VastuCompareBeforeAfterRemedyRequestRoomsItem]? = nil, text: String? = nil, remedies: [VastuCompareBeforeAfterRemedyRequestRemediesItem]) { self.rooms = rooms; self.text = text; self.remedies = remedies }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = text as Any? { result["text"] = encodeVastu(value) }
        if let value = remedies as Any? { result["remedies"] = encodeVastu(value) }
        return result
    }
}

public struct VastuCompoundWallAnalysisRequest: VastuRequest {
    public var walls: VastuJsonObjectOrArray?
    public init(walls: VastuJsonObjectOrArray? = nil) { self.walls = walls }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = walls as Any? { result["walls"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDirectionAuspiciousFacingRequest: VastuRequest {
    public var purpose: String
    public var occupant: String?
    public init(purpose: String, occupant: String? = nil) { self.purpose = purpose; self.occupant = occupant }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = purpose as Any? { result["purpose"] = encodeVastu(value) }
        if let value = occupant as Any? { result["occupant"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDirectionCorrectRequest: VastuRequest {
    public var direction: String
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(direction: String, lat: Double, lon: Double, date: String? = nil) { self.direction = direction; self.lat = lat; self.lon = lon; self.date = date }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDirectionDeclinationRequest: VastuRequest {
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(lat: Double, lon: Double, date: String? = nil) { self.lat = lat; self.lon = lon; self.date = date }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDirectionSunPathRequest: VastuRequest {
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(lat: Double, lon: Double, date: String? = nil) { self.lat = lat; self.lon = lon; self.date = date }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDirectionZoneFromBearingRequest: VastuRequest {
    public var bearingDeg: Double
    public init(bearingDeg: Double) { self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuElementsBalanceSuggestRequest: VastuRequest {
    public var distribution: [String: Any]?
    public var deficient: [String]?
    public var excess: [String]?
    public init(distribution: [String: Any]? = nil, deficient: [String]? = nil, excess: [String]? = nil) { self.distribution = distribution; self.deficient = deficient; self.excess = excess }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = distribution as Any? { result["distribution"] = encodeVastu(value) }
        if let value = deficient as Any? { result["deficient"] = encodeVastu(value) }
        if let value = excess as Any? { result["excess"] = encodeVastu(value) }
        return result
    }
}

public struct VastuElementsDistributionRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuElementsDistributionRequest: VastuRequest {
    public var rooms: [VastuElementsDistributionRequestRoomsItem]
    public init(rooms: [VastuElementsDistributionRequestRoomsItem]) { self.rooms = rooms }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        return result
    }
}

public struct VastuEntranceObstructionCheckRequest: VastuRequest {
    public var feature: String
    public var houseHeightMeters: Double?
    public var distanceMeters: Double?
    public init(feature: String, houseHeightMeters: Double? = nil, distanceMeters: Double? = nil) { self.feature = feature; self.houseHeightMeters = houseHeightMeters; self.distanceMeters = distanceMeters }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = feature as Any? { result["feature"] = encodeVastu(value) }
        if let value = houseHeightMeters as Any? { result["houseHeightMeters"] = encodeVastu(value) }
        if let value = distanceMeters as Any? { result["distanceMeters"] = encodeVastu(value) }
        return result
    }
}

public struct VastuEntrancePadaRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var doorXY: [Double]
    public var bearingDeg: Double?
    public init(plotPolygon: [[Double]], doorXY: [Double], bearingDeg: Double? = nil) { self.plotPolygon = plotPolygon; self.doorXY = doorXY; self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuEntranceRecommendRequest: VastuRequest {
    public var facing: String
    public init(facing: String) { self.facing = facing }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        return result
    }
}

public struct VastuFloorLevelAnalysisRequest: VastuRequest {
    public var levels: VastuJsonObjectOrArray?
    public init(levels: VastuJsonObjectOrArray? = nil) { self.levels = levels }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = levels as Any? { result["levels"] = encodeVastu(value) }
        return result
    }
}

public struct VastuFusionChartRequest: VastuRequest {
    public var datetime: String
    public var latitude: Double
    public var longitude: Double
    public var timezone: String?
    public var facing: String?
    public init(datetime: String, latitude: Double, longitude: Double, timezone: String? = nil, facing: String? = nil) { self.datetime = datetime; self.latitude = latitude; self.longitude = longitude; self.timezone = timezone; self.facing = facing }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMandalaProject81PadaRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMandalaProject9ZoneRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMandalaProjectBrahmasthanRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMultiStoreyFloorRulesRequest: VastuRequest {
    public var floors: Int
    public init(floors: Int) { self.floors = floors }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = floors as Any? { result["floors"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementBalconyRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementBorewellRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementGardenRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementGeneratorElectricalRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementMainGateRequest: VastuRequest {
    public var facing: String
    public var direction: String?
    public var zone: String?
    public var pada: Int?
    public init(facing: String, direction: String? = nil, zone: String? = nil, pada: Int? = nil) { self.facing = facing; self.direction = direction; self.zone = zone; self.pada = pada }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = pada as Any? { result["pada"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementOverheadTankRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementSepticTankRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementTreeRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementWellRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlacementWindowRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanAnalyzeRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanAnalyzeRequest: VastuRequest {
    public var rooms: [VastuPlanAnalyzeRequestRoomsItem]
    public var plot: [String: Any]?
    public var zoneResolution: Int?
    public init(rooms: [VastuPlanAnalyzeRequestRoomsItem], plot: [String: Any]? = nil, zoneResolution: Int? = nil) { self.rooms = rooms; self.plot = plot; self.zoneResolution = zoneResolution }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = zoneResolution as Any? { result["zoneResolution"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanFromRequirementsRequestPlotSetbacks: VastuEncodable {
    public var front: Double?
    public var rear: Double?
    public var left: Double?
    public var right: Double?
    public init(front: Double? = nil, rear: Double? = nil, left: Double? = nil, right: Double? = nil) { self.front = front; self.rear = rear; self.left = left; self.right = right }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = front as Any? { result["front"] = encodeVastu(value) }
        if let value = rear as Any? { result["rear"] = encodeVastu(value) }
        if let value = left as Any? { result["left"] = encodeVastu(value) }
        if let value = right as Any? { result["right"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanFromRequirementsRequestPlot: VastuEncodable {
    public var width: Double?
    public var length: Double?
    public var facing: String?
    public var polygon: [[Double]]?
    public var setbacks: VastuPlanFromRequirementsRequestPlotSetbacks?
    public init(width: Double? = nil, length: Double? = nil, facing: String? = nil, polygon: [[Double]]? = nil, setbacks: VastuPlanFromRequirementsRequestPlotSetbacks? = nil) { self.width = width; self.length = length; self.facing = facing; self.polygon = polygon; self.setbacks = setbacks }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = setbacks as Any? { result["setbacks"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanFromRequirementsRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanFromRequirementsRequest: VastuRequest {
    public var plot: VastuPlanFromRequirementsRequestPlot
    public var entrance: [String: Any]?
    public var rooms: [VastuPlanFromRequirementsRequestRoomsItem]?
    public var requirements: [String: Any]?
    public var parking: [String: Any]?
    public var staircase: [String: Any]?
    public var lift: [String: Any]?
    public var variants: Int?
    public var variantSvg: Bool?
    public var includeSvg: Bool?
    public init(plot: VastuPlanFromRequirementsRequestPlot, entrance: [String: Any]? = nil, rooms: [VastuPlanFromRequirementsRequestRoomsItem]? = nil, requirements: [String: Any]? = nil, parking: [String: Any]? = nil, staircase: [String: Any]? = nil, lift: [String: Any]? = nil, variants: Int? = nil, variantSvg: Bool? = nil, includeSvg: Bool? = nil) { self.plot = plot; self.entrance = entrance; self.rooms = rooms; self.requirements = requirements; self.parking = parking; self.staircase = staircase; self.lift = lift; self.variants = variants; self.variantSvg = variantSvg; self.includeSvg = includeSvg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = entrance as Any? { result["entrance"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = requirements as Any? { result["requirements"] = encodeVastu(value) }
        if let value = parking as Any? { result["parking"] = encodeVastu(value) }
        if let value = staircase as Any? { result["staircase"] = encodeVastu(value) }
        if let value = lift as Any? { result["lift"] = encodeVastu(value) }
        if let value = variants as Any? { result["variants"] = encodeVastu(value) }
        if let value = variantSvg as Any? { result["variantSvg"] = encodeVastu(value) }
        if let includeSvg { result["includeSvg"] = includeSvg }
        return result
    }
}

public struct VastuPlanGenerateRequestPlotSetbacks: VastuEncodable {
    public var front: Double?
    public var rear: Double?
    public var left: Double?
    public var right: Double?
    public init(front: Double? = nil, rear: Double? = nil, left: Double? = nil, right: Double? = nil) { self.front = front; self.rear = rear; self.left = left; self.right = right }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = front as Any? { result["front"] = encodeVastu(value) }
        if let value = rear as Any? { result["rear"] = encodeVastu(value) }
        if let value = left as Any? { result["left"] = encodeVastu(value) }
        if let value = right as Any? { result["right"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanGenerateRequestPlot: VastuEncodable {
    public var width: Double?
    public var length: Double?
    public var facing: String?
    public var polygon: [[Double]]?
    public var setbacks: VastuPlanGenerateRequestPlotSetbacks?
    public init(width: Double? = nil, length: Double? = nil, facing: String? = nil, polygon: [[Double]]? = nil, setbacks: VastuPlanGenerateRequestPlotSetbacks? = nil) { self.width = width; self.length = length; self.facing = facing; self.polygon = polygon; self.setbacks = setbacks }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = setbacks as Any? { result["setbacks"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanGenerateRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanGenerateRequest: VastuRequest {
    public var plot: VastuPlanGenerateRequestPlot
    public var entrance: [String: Any]?
    public var rooms: [VastuPlanGenerateRequestRoomsItem]?
    public var requirements: [String: Any]?
    public var parking: [String: Any]?
    public var staircase: [String: Any]?
    public var lift: [String: Any]?
    public var variants: Int?
    public var variantSvg: Bool?
    public var includeSvg: Bool?
    public init(plot: VastuPlanGenerateRequestPlot, entrance: [String: Any]? = nil, rooms: [VastuPlanGenerateRequestRoomsItem]? = nil, requirements: [String: Any]? = nil, parking: [String: Any]? = nil, staircase: [String: Any]? = nil, lift: [String: Any]? = nil, variants: Int? = nil, variantSvg: Bool? = nil, includeSvg: Bool? = nil) { self.plot = plot; self.entrance = entrance; self.rooms = rooms; self.requirements = requirements; self.parking = parking; self.staircase = staircase; self.lift = lift; self.variants = variants; self.variantSvg = variantSvg; self.includeSvg = includeSvg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = entrance as Any? { result["entrance"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = requirements as Any? { result["requirements"] = encodeVastu(value) }
        if let value = parking as Any? { result["parking"] = encodeVastu(value) }
        if let value = staircase as Any? { result["staircase"] = encodeVastu(value) }
        if let value = lift as Any? { result["lift"] = encodeVastu(value) }
        if let value = variants as Any? { result["variants"] = encodeVastu(value) }
        if let value = variantSvg as Any? { result["variantSvg"] = encodeVastu(value) }
        if let includeSvg { result["includeSvg"] = includeSvg }
        return result
    }
}

public struct VastuPlanOptimizeRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanOptimizeRequest: VastuRequest {
    public var rooms: [VastuPlanOptimizeRequestRoomsItem]
    public var plot: [String: Any]?
    public var includeSvg: Bool?
    public init(rooms: [VastuPlanOptimizeRequestRoomsItem], plot: [String: Any]? = nil, includeSvg: Bool? = nil) { self.rooms = rooms; self.plot = plot; self.includeSvg = includeSvg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let includeSvg { result["includeSvg"] = includeSvg }
        return result
    }
}

public struct VastuPlanReportRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanReportRequestBrand: VastuEncodable {
    public var reportTitle: String?
    public var generatedFor: String?
    public init(reportTitle: String? = nil, generatedFor: String? = nil) { self.reportTitle = reportTitle; self.generatedFor = generatedFor }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let reportTitle { result["reportTitle"] = reportTitle }
        if let generatedFor { result["generatedFor"] = generatedFor }
        return result
    }
}

public struct VastuPlanReportRequest: VastuRequest {
    public var rooms: [VastuPlanReportRequestRoomsItem]
    public var plot: [String: Any]?
    public var format: String?
    public var brand: VastuPlanReportRequestBrand?
    public var reportTitle: String?
    public var generatedFor: String?
    public var tenantName: String?
    public init(rooms: [VastuPlanReportRequestRoomsItem], plot: [String: Any]? = nil, format: String? = nil, brand: VastuPlanReportRequestBrand? = nil, reportTitle: String? = nil, generatedFor: String? = nil, tenantName: String? = nil) { self.rooms = rooms; self.plot = plot; self.format = format; self.brand = brand; self.reportTitle = reportTitle; self.generatedFor = generatedFor; self.tenantName = tenantName }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let format { result["format"] = format }
        if let brand { result["brand"] = brand.dictionary }
        if let reportTitle { result["reportTitle"] = reportTitle }
        if let generatedFor { result["generatedFor"] = generatedFor }
        if let tenantName { result["tenantName"] = tenantName }
        return result
    }
}

public struct VastuPlanUploadRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanUploadRequest: VastuRequest {
    public var rooms: [VastuPlanUploadRequestRoomsItem]?
    public var layout: [String: Any]?
    public var asciiGrid: String?
    public var plot: [String: Any]?
    public init(rooms: [VastuPlanUploadRequestRoomsItem]? = nil, layout: [String: Any]? = nil, asciiGrid: String? = nil, plot: [String: Any]? = nil) { self.rooms = rooms; self.layout = layout; self.asciiGrid = asciiGrid; self.plot = plot }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = layout as Any? { result["layout"] = encodeVastu(value) }
        if let value = asciiGrid as Any? { result["asciiGrid"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotExtensionsCutsRequest: VastuRequest {
    public var plotPolygon: [[Double]]?
    public var length: Double?
    public var width: Double?
    public init(plotPolygon: [[Double]]? = nil, length: Double? = nil, width: Double? = nil) { self.plotPolygon = plotPolygon; self.length = length; self.width = width }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotOrientationRequest: VastuRequest {
    public var facingBearingDeg: Double?
    public var bearingDeg: Double?
    public init(facingBearingDeg: Double? = nil, bearingDeg: Double? = nil) { self.facingBearingDeg = facingBearingDeg; self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facingBearingDeg as Any? { result["facingBearingDeg"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotRatioRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotRoadOrientationRequest: VastuRequest {
    public var roads: [String]?
    public var roadSides: [String]?
    public var veedhiShoola: String?
    public var tPointFrom: String?
    public var roadThrustFrom: String?
    public init(roads: [String]? = nil, roadSides: [String]? = nil, veedhiShoola: String? = nil, tPointFrom: String? = nil, roadThrustFrom: String? = nil) { self.roads = roads; self.roadSides = roadSides; self.veedhiShoola = veedhiShoola; self.tPointFrom = tPointFrom; self.roadThrustFrom = roadThrustFrom }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roads as Any? { result["roads"] = encodeVastu(value) }
        if let value = roadSides as Any? { result["roadSides"] = encodeVastu(value) }
        if let value = veedhiShoola as Any? { result["veedhiShoola"] = encodeVastu(value) }
        if let value = tPointFrom as Any? { result["tPointFrom"] = encodeVastu(value) }
        if let value = roadThrustFrom as Any? { result["roadThrustFrom"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotShapeRequest: VastuRequest {
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotSlopeRequest: VastuRequest {
    public var slopeDirection: String?
    public var lowSide: String?
    public var lowCorner: String?
    public var slopeBearingDeg: Double?
    public init(slopeDirection: String? = nil, lowSide: String? = nil, lowCorner: String? = nil, slopeBearingDeg: Double? = nil) { self.slopeDirection = slopeDirection; self.lowSide = lowSide; self.lowCorner = lowCorner; self.slopeBearingDeg = slopeBearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = slopeDirection as Any? { result["slopeDirection"] = encodeVastu(value) }
        if let value = lowSide as Any? { result["lowSide"] = encodeVastu(value) }
        if let value = lowCorner as Any? { result["lowCorner"] = encodeVastu(value) }
        if let value = slopeBearingDeg as Any? { result["slopeBearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomBedroomRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomDiningRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomKitchenRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomLivingRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomPoojaRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomStaircaseRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomStoreRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomStudyRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomToiletRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRoomWaterStorageRequest: VastuRequest {
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreComplianceIndexRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreComplianceIndexRequest: VastuRequest {
    public var rooms: [VastuScoreComplianceIndexRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreComplianceIndexRequestRoomsItem], plot: [String: Any]? = nil) { self.rooms = rooms; self.plot = plot }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreOverallRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreOverallRequest: VastuRequest {
    public var rooms: [VastuScoreOverallRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreOverallRequestRoomsItem], plot: [String: Any]? = nil) { self.rooms = rooms; self.plot = plot }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreZoneWiseRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuScoreZoneWiseRequest: VastuRequest {
    public var rooms: [VastuScoreZoneWiseRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreZoneWiseRequestRoomsItem], plot: [String: Any]? = nil) { self.rooms = rooms; self.plot = plot }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedCommercialRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedCommercialRequest: VastuRequest {
    public var rooms: [VastuSpecializedCommercialRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedCommercialRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedEducationalRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedEducationalRequest: VastuRequest {
    public var rooms: [VastuSpecializedEducationalRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedEducationalRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedFactoryRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedFactoryRequest: VastuRequest {
    public var rooms: [VastuSpecializedFactoryRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedFactoryRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedHospitalRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedHospitalRequest: VastuRequest {
    public var rooms: [VastuSpecializedHospitalRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedHospitalRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedResidentialRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedResidentialRequest: VastuRequest {
    public var rooms: [VastuSpecializedResidentialRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedResidentialRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedRestaurantRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedRestaurantRequest: VastuRequest {
    public var rooms: [VastuSpecializedRestaurantRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedRestaurantRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedTempleRequestRoomsItem: VastuEncodable {
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil) { self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuSpecializedTempleRequest: VastuRequest {
    public var rooms: [VastuSpecializedTempleRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedTempleRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuTimingBhumiPujanRequest: VastuRequest {
    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        return result
    }
}

public struct VastuTimingConstructionStartRequest: VastuRequest {
    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        return result
    }
}

public struct VastuTimingGrihapraveshRequest: VastuRequest {
    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        return result
    }
}

public struct VastuTimingVastuShantiRequest: VastuRequest {
    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        return result
    }
}

public protocol VastuData { var raw: [String: Any] { get } }

// BEGIN GENERATED VASTU RESPONSE DATA
public struct VastuArAnchorRecommendationsDataAnchorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var deity: String { (raw["deity"] as? String)! }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var planPosition: [Double] { (raw["planPosition"] as? [Double])! }
    public var worldPosition: [Double] { (raw["worldPosition"] as? [Double])! }
    public var normal: [Double] { (raw["normal"] as? [Double])! }
    public var insidePlot: Bool { vastuBool(raw["insidePlot"])! }
}

public struct VastuArDeityIconsDataIconsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String { (raw["zone"] as? String)! }
    public var deity: String { (raw["deity"] as? String)! }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var kind: String { (raw["kind"] as? String)! }
    public var png: Any { raw["png"]! }
    public var svg: Any { raw["svg"]! }
    public var width: Int { vastuInt(raw["width"])! }
    public var height: Int { vastuInt(raw["height"])! }
}

public struct VastuArHeatmapRasterDataZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String { (raw["zone"] as? String)! }
    public var deity: String { (raw["deity"] as? String)! }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var disturbed: Bool { vastuBool(raw["disturbed"])! }
    public var observed: Bool { vastuBool(raw["observed"])! }
    public var roomCount: Int { vastuInt(raw["roomCount"])! }
}

public struct VastuArHeatmapRasterDataCompleteness {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var status: String { (raw["status"] as? String)! }
    public var computedComponents: [String] { (raw["computedComponents"] as? [String])! }
    public var missingInputs: [String] { (raw["missingInputs"] as? [String])! }
    public var projectedCellCount: Int { vastuInt(raw["projectedCellCount"])! }
    public var physicalCoverageVerified: Bool { vastuBool(raw["physicalCoverageVerified"])! }
    public var note: String { (raw["note"] as? String)! }
}

public struct VastuArHeatmapRasterDataLegendDisturbed {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var color: String { (raw["color"] as? String)! }
    public var meaning: String { (raw["meaning"] as? String)! }
}

public struct VastuArHeatmapRasterDataLegendNeutral {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var color: String { (raw["color"] as? String)! }
    public var meaning: String { (raw["meaning"] as? String)! }
}

public struct VastuArHeatmapRasterDataLegend {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var disturbed: VastuArHeatmapRasterDataLegendDisturbed { VastuArHeatmapRasterDataLegendDisturbed(raw: raw["disturbed"] as! [String: Any]) }
    public var neutral: VastuArHeatmapRasterDataLegendNeutral { VastuArHeatmapRasterDataLegendNeutral(raw: raw["neutral"] as! [String: Any]) }
    public var observed: String { (raw["observed"] as? String)! }
}

public struct VastuArRoomCaptureDataCaptureOutline {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
    public var source: String { (raw["source"] as? String)! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var length: Double { vastuDouble(raw["length"])! }
    public var areaM2: Double { vastuDouble(raw["areaM2"])! }
}

public struct VastuArRoomCaptureDataCapture {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var captureId: String { (raw["captureId"] as? String)! }
    public var capturedAtEpoch: Int { vastuInt(raw["capturedAtEpoch"])! }
    public var device: [String: Any] { (raw["device"] as? [String: Any])! }
    public var north: [String: Any] { (raw["north"] as? [String: Any])! }
    public var floorIndex: Int { vastuInt(raw["floorIndex"])! }
    public var outline: VastuArRoomCaptureDataCaptureOutline { VastuArRoomCaptureDataCaptureOutline(raw: raw["outline"] as! [String: Any]) }
    public var originShiftM: [Double] { (raw["originShiftM"] as? [Double])! }
    public var roomCount: Int { vastuInt(raw["roomCount"])! }
    public var openingCount: Int { vastuInt(raw["openingCount"])! }
}

public struct VastuArRoomCaptureDataRoomsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var label: String? { (raw["label"] as? String) }
    public var roomType: String? { (raw["roomType"] as? String) }
    public var zone: String { (raw["zone"] as? String)! }
    public var zoneBasis: String { (raw["zoneBasis"] as? String)! }
    public var areaM2: Double { vastuDouble(raw["areaM2"])! }
    public var centroid: [Double] { (raw["centroid"] as? [Double])! }
    public var heightM: Double? { vastuDouble(raw["heightM"]) }
    public var openingCount: Int { vastuInt(raw["openingCount"])! }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
}

public struct VastuArRoomCaptureDataDerivedRequests {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var planAnalyze: Any { raw["planAnalyze"]! }
    public var auditFloorPlanDetailed: Any { raw["auditFloorPlanDetailed"]! }
    public var scanQuality: Any { raw["scanQuality"]! }
    public var anchorRecommendations: Any? { (raw["anchorRecommendations"] is NSNull ? nil : raw["anchorRecommendations"]) }
}

public struct VastuArRoomCaptureDataCompleteness {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var acceptForAudit: Bool { vastuBool(raw["acceptForAudit"])! }
    public var labelledRooms: Int { vastuInt(raw["labelledRooms"])! }
    public var unlabelledRooms: [String] { (raw["unlabelledRooms"] as? [String])! }
    public var missing: [String] { (raw["missing"] as? [String])! }
    public var warnings: [String] { (raw["warnings"] as? [String])! }
}

public struct VastuArScanQualityDataDimensionsPointCloudDensity {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
}

public struct VastuArScanQualityDataDimensionsPolygonClosure {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
}

public struct VastuArScanQualityDataDimensionsCompassConfidence {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
}

public struct VastuArScanQualityDataDimensionsGpsConfidence {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
}

public struct VastuArScanQualityDataDimensionsRoomsTagged {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
}

public struct VastuArScanQualityDataDimensionsCoverage {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var reason: String { (raw["reason"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
}

public struct VastuArScanQualityDataDimensions {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var pointCloudDensity: VastuArScanQualityDataDimensionsPointCloudDensity { VastuArScanQualityDataDimensionsPointCloudDensity(raw: raw["pointCloudDensity"] as! [String: Any]) }
    public var polygonClosure: VastuArScanQualityDataDimensionsPolygonClosure { VastuArScanQualityDataDimensionsPolygonClosure(raw: raw["polygonClosure"] as! [String: Any]) }
    public var compassConfidence: VastuArScanQualityDataDimensionsCompassConfidence { VastuArScanQualityDataDimensionsCompassConfidence(raw: raw["compassConfidence"] as! [String: Any]) }
    public var gpsConfidence: VastuArScanQualityDataDimensionsGpsConfidence { VastuArScanQualityDataDimensionsGpsConfidence(raw: raw["gpsConfidence"] as! [String: Any]) }
    public var roomsTagged: VastuArScanQualityDataDimensionsRoomsTagged { VastuArScanQualityDataDimensionsRoomsTagged(raw: raw["roomsTagged"] as! [String: Any]) }
    public var coverage: VastuArScanQualityDataDimensionsCoverage { VastuArScanQualityDataDimensionsCoverage(raw: raw["coverage"] as! [String: Any]) }
}

public struct VastuArScanQualityDataRoomCoverage {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var expectedRoomCount: Int? { vastuInt(raw["expectedRoomCount"]) }
    public var percent: Double? { vastuDouble(raw["percent"]) }
    public var status: String { (raw["status"] as? String)! }
    public var scope: String { (raw["scope"] as? String)! }
}

public struct VastuArTrueNorthDataInput {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var lat: Double { vastuDouble(raw["lat"])! }
    public var lon: Double { vastuDouble(raw["lon"])! }
    public var datetime: String { (raw["datetime"] as? String)! }
    public var deviceHeadingAtSunDeg: Double { vastuDouble(raw["deviceHeadingAtSunDeg"])! }
}

public struct VastuArTrueNorthDataHeadingQuality {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var accuracyDeg: Double? { vastuDouble(raw["accuracyDeg"]) }
    public var sampleAgeMs: Double? { vastuDouble(raw["sampleAgeMs"]) }
    public var maxAccuracyDeg: Double { vastuDouble(raw["maxAccuracyDeg"])! }
    public var maxSampleAgeMs: Double { vastuDouble(raw["maxSampleAgeMs"])! }
    public var reliable: Bool { vastuBool(raw["reliable"])! }
    public var basis: String { (raw["basis"] as? String)! }
}

public struct VastuArYantraMeshesDataGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var vertices: Int { vastuInt(raw["vertices"])! }
    public var triangles: Int { vastuInt(raw["triangles"])! }
    public var upAxis: String { (raw["upAxis"] as? String)! }
    public var northAxis: String { (raw["northAxis"] as? String)! }
    public var eastAxis: String { (raw["eastAxis"] as? String)! }
    public var units: String { (raw["units"] as? String)! }
}

public struct VastuArZoneTexturesDataCellsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var contentInsetPixels: Int { vastuInt(raw["contentInsetPixels"])! }
    public var devata: String { (raw["devata"] as? String)! }
    public var gltfUvBoundsTopLeft: [Double] { (raw["gltfUvBoundsTopLeft"] as? [Double])! }
    public var maskBit: Int { vastuInt(raw["maskBit"])! }
    public var pixelBoundsExclusive: [Int] { (raw["pixelBoundsExclusive"] as? [Int])! }
    public var usdUvBoundsBottomLeft: [Double] { (raw["usdUvBoundsBottomLeft"] as? [Double])! }
    public var zone: String { (raw["zone"] as? String)! }
}

public struct VastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var inputSource: String { (raw["inputSource"] as? String)! }
    public var badge: String? { (raw["badge"] as? String) }
    public var eligible: Bool { vastuBool(raw["eligible"])! }
    public var variant: String? { (raw["variant"] as? String) }
    public var confidence: Double? { vastuDouble(raw["confidence"]) }
    public var fullBadgeThreshold: Double? { vastuDouble(raw["fullBadgeThreshold"]) }
    public var minimumConfidence: Double? { vastuDouble(raw["minimumConfidence"]) }
    public var reason: String { (raw["reason"] as? String)! }
}

public struct VastuAssessmentBatchDataResultsItemResponseDataSourcesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var source: String { (raw["source"] as? String)! }
    public var scope: String { (raw["scope"] as? String)! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuAssessmentBatchDataResultsItemResponseData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var confidence: Double { vastuDouble(raw["confidence"])! }
    public var badgeEligibility: VastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility { VastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility(raw: raw["badgeEligibility"] as! [String: Any]) }
    public var findings: [[String: Any]]? { (raw["findings"] as? [[String: Any]]) }
    public var maxScore: Double? { vastuDouble(raw["maxScore"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var gradeLabel: String? { (raw["gradeLabel"] as? String) }
    public var scoreBreakdown: [String: Any]? { (raw["scoreBreakdown"] as? [String: Any]) }
    public var confidenceBasis: [String: Any] { (raw["confidenceBasis"] as? [String: Any])! }
    public var entrance: [String: Any]? { (raw["entrance"] as? [String: Any]) }
    public var scanQuality: [String: Any]? { (raw["scanQuality"] as? [String: Any]) }
    public var zoneReference: [String: Any]? { (raw["zoneReference"] as? [String: Any]) }
    public var sources: [VastuAssessmentBatchDataResultsItemResponseDataSourcesItem]? { (raw["sources"] as? [[String: Any]])?.map { VastuAssessmentBatchDataResultsItemResponseDataSourcesItem(raw: $0) } }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var reason: String? { (raw["reason"] as? String) }
    public var requiredConfidence: Double? { vastuDouble(raw["requiredConfidence"]) }
    public var missingData: [String]? { (raw["missingData"] as? [String]) }
    public var reScanSuggestions: [String]? { (raw["reScanSuggestions"] as? [String]) }
    public var charged: Bool? { vastuBool(raw["charged"]) }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var listingId: Any? { (raw["listingId"] is NSNull ? nil : raw["listingId"]) }
}

public struct VastuAssessmentBatchDataResultsItemResponseBilling {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var charged: Double { vastuDouble(raw["charged"])! }
    public var currency: String { (raw["currency"] as? String)! }
    public var balanceBefore: Double { vastuDouble(raw["balanceBefore"])! }
    public var balanceAfter: Double { vastuDouble(raw["balanceAfter"])! }
    public var endpoint: String { (raw["endpoint"] as? String)! }
    public var category: String { (raw["category"] as? String)! }
}

public struct VastuAssessmentBatchDataResultsItemResponseMeta {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var source: String? { (raw["source"] as? String) }
    public var engine: String { (raw["engine"] as? String)! }
    public var version: String { (raw["version"] as? String)! }
    public var dataSource: String? { (raw["dataSource"] as? String) }
}

public struct VastuAssessmentBatchDataResultsItemResponse {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var success: Bool { vastuBool(raw["success"])! }
    public var data: VastuAssessmentBatchDataResultsItemResponseData? { (raw["data"] as? [String: Any]).map { VastuAssessmentBatchDataResultsItemResponseData(raw: $0) } }
    public var error: String? { (raw["error"] as? String) }
    public var code: String? { (raw["code"] as? String) }
    public var billing: VastuAssessmentBatchDataResultsItemResponseBilling? { (raw["billing"] as? [String: Any]).map { VastuAssessmentBatchDataResultsItemResponseBilling(raw: $0) } }
    public var meta: VastuAssessmentBatchDataResultsItemResponseMeta? { (raw["meta"] as? [String: Any]).map { VastuAssessmentBatchDataResultsItemResponseMeta(raw: $0) } }
}

public struct VastuAssessmentBatchDataResultsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var status: Int { vastuInt(raw["status"])! }
    public var response: VastuAssessmentBatchDataResultsItemResponse { VastuAssessmentBatchDataResultsItemResponse(raw: raw["response"] as! [String: Any]) }
}

public struct VastuAssessmentBatchDataSummary {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var total: Int { vastuInt(raw["total"])! }
    public var succeeded: Int { vastuInt(raw["succeeded"])! }
    public var failed: Int { vastuInt(raw["failed"])! }
}

public struct VastuAssessmentBadgeEligibility {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var inputSource: String { (raw["inputSource"] as? String)! }
    public var badge: String? { (raw["badge"] as? String) }
    public var eligible: Bool { vastuBool(raw["eligible"])! }
    public var variant: String? { (raw["variant"] as? String) }
    public var confidence: Double? { vastuDouble(raw["confidence"]) }
    public var fullBadgeThreshold: Double? { vastuDouble(raw["fullBadgeThreshold"]) }
    public var minimumConfidence: Double? { vastuDouble(raw["minimumConfidence"]) }
    public var reason: String { (raw["reason"] as? String)! }
}

public struct VastuAssessmentDataFindingsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var code: String? { (raw["code"] as? String) }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var detail: String? { (raw["detail"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var zoneReference: [String: Any]? { (raw["zoneReference"] as? [String: Any]) }
    public var pada: [String: Any]? { (raw["pada"] as? [String: Any]) }
    public var missingData: [Any]? { (raw["missingData"] as? [Any]) }
    public var reScanSuggestions: [Any]? { (raw["reScanSuggestions"] as? [Any]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
    public var source: String? { (raw["source"] as? String) }
}

public struct VastuAssessmentDataSourcesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var source: String { (raw["source"] as? String)! }
    public var scope: String { (raw["scope"] as? String)! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuAssessmentDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuCatalogReferenceDataDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var labelKey: String? { (raw["labelKey"] as? String) }
    public var labelParams: [String: Any]? { (raw["labelParams"] as? [String: Any]) }
    public var code: String? { (raw["code"] as? String) }
    public var label: String? { (raw["label"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
}

public struct VastuCatalogReferenceDataRemediesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var defectCode: String? { (raw["defectCode"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var source: String? { (raw["source"] as? String) }
}

public struct VastuComplianceIndexDataDrivingDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var weight: Int? { vastuInt(raw["weight"]) }
    public var pointsLost: Double? { vastuDouble(raw["pointsLost"]) }
    public var issue: String? { (raw["issue"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var ruleProvenance: [String: Any]? { (raw["ruleProvenance"] as? [String: Any]) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuComplianceIndexDataScoring {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var formula: String { (raw["formula"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
    public var comparisonBasis: String { (raw["comparisonBasis"] as? String)! }
    public var classification: String { (raw["classification"] as? String)! }
    public var inputPlacementCount: Int { vastuInt(raw["inputPlacementCount"])! }
    public var uniquePlacementCount: Int { vastuInt(raw["uniquePlacementCount"])! }
    public var duplicatePlacementCount: Int { vastuInt(raw["duplicatePlacementCount"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuComplianceIndexDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuDetailedFloorPlanAuditDataDefectsItemIssueParams {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var roomType: String { (raw["roomType"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var severity: String { (raw["severity"] as? String)! }
}

public struct VastuDetailedFloorPlanAuditDataDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var issueKey: String? { (raw["issueKey"] as? String) }
    public var issueParams: VastuDetailedFloorPlanAuditDataDefectsItemIssueParams? { (raw["issueParams"] as? [String: Any]).map { VastuDetailedFloorPlanAuditDataDefectsItemIssueParams(raw: $0) } }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var code: String? { (raw["code"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuDetailedFloorPlanAuditDataDevataHeatmapItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var deity: String? { (raw["deity"] as? String) }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var devatas: [[String: Any]]? { (raw["devatas"] as? [[String: Any]]) }
    public var disturbed: Bool? { vastuBool(raw["disturbed"]) }
}

public struct VastuDetailedFloorPlanAuditDataRemediationOrderItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var actionKey: String? { (raw["actionKey"] as? String) }
    public var actionParams: [String: Any]? { (raw["actionParams"] as? [String: Any]) }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var action: String? { (raw["action"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var code: String? { (raw["code"] as? String) }
    public var step: Int? { vastuInt(raw["step"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuDetailedFloorPlanAuditDataScoring {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var formula: String { (raw["formula"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
    public var comparisonBasis: String { (raw["comparisonBasis"] as? String)! }
    public var classification: String { (raw["classification"] as? String)! }
    public var inputPlacementCount: Int { vastuInt(raw["inputPlacementCount"])! }
    public var uniquePlacementCount: Int { vastuInt(raw["uniquePlacementCount"])! }
    public var duplicatePlacementCount: Int { vastuInt(raw["duplicatePlacementCount"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuDetailedFloorPlanAuditDataCompleteness {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var status: String { (raw["status"] as? String)! }
    public var computedComponents: [String] { (raw["computedComponents"] as? [String])! }
    public var missingInputs: [String] { (raw["missingInputs"] as? [String])! }
    public var projectedCellCount: Int { vastuInt(raw["projectedCellCount"])! }
    public var physicalCoverageVerified: Bool { vastuBool(raw["physicalCoverageVerified"])! }
    public var note: String { (raw["note"] as? String)! }
}

public struct VastuDetailedFloorPlanAuditDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuDirectionsReferenceDataDirectionsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var code: String? { (raw["code"] as? String) }
    public var sanskrit: String? { (raw["sanskrit"] as? String) }
    public var deity: String? { (raw["deity"] as? String) }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var element: String? { (raw["element"] as? String) }
    public var bearingStart: Double? { vastuDouble(raw["bearingStart"]) }
    public var bearingEnd: Double? { vastuDouble(raw["bearingEnd"]) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var source: String? { (raw["source"] as? String) }
}

public struct VastuEntrancePadaDataPada {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var index: Int { vastuInt(raw["index"])! }
    public var deity: String { (raw["deity"] as? String)! }
    public var quadrant: String { (raw["quadrant"] as? String)! }
    public var subIndex: Int { vastuInt(raw["subIndex"])! }
    public var bearingStart: Double { vastuDouble(raw["bearingStart"])! }
    public var bearingEnd: Double { vastuDouble(raw["bearingEnd"])! }
    public var auspiciousness: String { (raw["auspiciousness"] as? String)! }
    public var source: String { (raw["source"] as? String)! }
    public var deityRosterName: String? { (raw["deityRosterName"] as? String) }
    public var deityNameClassification: String? { (raw["deityNameClassification"] as? String) }
    public var deityNameSource: String? { (raw["deityNameSource"] as? String) }
    public var deityPlacementClassification: String? { (raw["deityPlacementClassification"] as? String) }
    public var deityPlacementSource: String? { (raw["deityPlacementSource"] as? String) }
}

public struct VastuFloorPlanAuditDataDefectsItemIssueParams {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var roomType: String { (raw["roomType"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var severity: String { (raw["severity"] as? String)! }
}

public struct VastuFloorPlanAuditDataDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var issueKey: String? { (raw["issueKey"] as? String) }
    public var issueParams: VastuFloorPlanAuditDataDefectsItemIssueParams? { (raw["issueParams"] as? [String: Any]).map { VastuFloorPlanAuditDataDefectsItemIssueParams(raw: $0) } }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var code: String? { (raw["code"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuFloorPlanAuditDataScoring {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var formula: String { (raw["formula"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
    public var comparisonBasis: String { (raw["comparisonBasis"] as? String)! }
    public var classification: String { (raw["classification"] as? String)! }
    public var inputPlacementCount: Int { vastuInt(raw["inputPlacementCount"])! }
    public var uniquePlacementCount: Int { vastuInt(raw["uniquePlacementCount"])! }
    public var duplicatePlacementCount: Int { vastuInt(raw["duplicatePlacementCount"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuFloorPlanAuditDataTextParse {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var transliterations: String { (raw["transliterations"] as? String)! }
    public var grammar: String { (raw["grammar"] as? String)! }
    public var coverage: String { (raw["coverage"] as? String)! }
    public var supportedLanguages: [String] { (raw["supportedLanguages"] as? [String])! }
    public var roomVocabulary: [String] { (raw["roomVocabulary"] as? [String])! }
    public var directionVocabulary: [String] { (raw["directionVocabulary"] as? [String])! }
    public var unparsedClauses: [String] { (raw["unparsedClauses"] as? [String])! }
    public var parsedClauseCount: Int { vastuInt(raw["parsedClauseCount"])! }
}

public struct VastuFloorPlanAuditDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuMandalaReferenceDataZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var zone: String? { (raw["zone"] as? String) }
    public var deity: String? { (raw["deity"] as? String) }
    public var element: String? { (raw["element"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var sourceClassification: String? { (raw["sourceClassification"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var prescribed: [String]? { (raw["prescribed"] as? [String]) }
    public var forbidden: [String]? { (raw["forbidden"] as? [String]) }
    public var verseBackedRooms: [String]? { (raw["verseBackedRooms"] as? [String]) }
    public var verseBackedRoomsSource: String? { (raw["verseBackedRoomsSource"] as? String) }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var elementClassification: String? { (raw["elementClassification"] as? String) }
    public var elementSource: String? { (raw["elementSource"] as? String) }
}

public struct VastuMandalaReferenceDataCellsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String? { (raw["id"] as? String) }
    public var padaNumber: Int? { vastuInt(raw["padaNumber"]) }
    public var row: Int? { vastuInt(raw["row"]) }
    public var col: Int? { vastuInt(raw["col"]) }
    public var zone: String? { (raw["zone"] as? String) }
    public var isBrahmasthan: Bool? { vastuBool(raw["isBrahmasthan"]) }
    public var devata: String? { (raw["devata"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var devataVerified: Bool? { vastuBool(raw["devataVerified"]) }
    public var devataNameVerified: Bool? { vastuBool(raw["devataNameVerified"]) }
    public var placementClassification: String? { (raw["placementClassification"] as? String) }
    public var placementSource: String? { (raw["placementSource"] as? String) }
    public var polygon: [[Double]]? { (raw["polygon"] as? [[Double]]) }
    public var centroid: [Double]? { (raw["centroid"] as? [Double]) }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var insidePlot: Bool? { vastuBool(raw["insidePlot"]) }
}

public struct VastuOverallScoreDataPlacementsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var weight: Int? { vastuInt(raw["weight"]) }
    public var merit: Double? { vastuDouble(raw["merit"]) }
    public var demerit: Double? { vastuDouble(raw["demerit"]) }
    public var compliant: Bool? { vastuBool(raw["compliant"]) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var ruleProvenance: [String: Any]? { (raw["ruleProvenance"] as? [String: Any]) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuOverallScoreDataScoring {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var formula: String { (raw["formula"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
    public var comparisonBasis: String { (raw["comparisonBasis"] as? String)! }
    public var classification: String { (raw["classification"] as? String)! }
    public var inputPlacementCount: Int { vastuInt(raw["inputPlacementCount"])! }
    public var uniquePlacementCount: Int { vastuInt(raw["uniquePlacementCount"])! }
    public var duplicatePlacementCount: Int { vastuInt(raw["duplicatePlacementCount"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuOverallScoreDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuPlanAuditDataRoomByRoomItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var zoneSource: String? { (raw["zoneSource"] as? String) }
    public var ideal: String? { (raw["ideal"] as? String) }
    public var verdict: String? { (raw["verdict"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var defect: String? { (raw["defect"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var ruleProvenance: [String: Any]? { (raw["ruleProvenance"] as? [String: Any]) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuPlanAuditDataDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuPlanAuditDataRemediesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var priority: Int? { vastuInt(raw["priority"]) }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var action: String? { (raw["action"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuPlanAuditDataArtifact {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var contentType: String { (raw["contentType"] as? String)! }
    public var filename: String { (raw["filename"] as? String)! }
    public var content: String { (raw["content"] as? String)! }
}

public struct VastuPlanAuditDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuRemedyComparisonDataBeforeDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuRemedyComparisonDataBefore {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var defectCount: Int? { vastuInt(raw["defectCount"]) }
    public var prescribedCount: Int? { vastuInt(raw["prescribedCount"]) }
    public var defects: [VastuRemedyComparisonDataBeforeDefectsItem]? { (raw["defects"] as? [[String: Any]])?.map { VastuRemedyComparisonDataBeforeDefectsItem(raw: $0) } }
}

public struct VastuRemedyComparisonDataAfterDefectsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var issue: String? { (raw["issue"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuRemedyComparisonDataAfter {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var defectCount: Int? { vastuInt(raw["defectCount"]) }
    public var prescribedCount: Int? { vastuInt(raw["prescribedCount"]) }
    public var defects: [VastuRemedyComparisonDataAfterDefectsItem]? { (raw["defects"] as? [[String: Any]])?.map { VastuRemedyComparisonDataAfterDefectsItem(raw: $0) } }
}

public struct VastuRemedyComparisonDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuSpecializedAuditDataFindingsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var zone: String? { (raw["zone"] as? String) }
    public var function: String? { (raw["function"] as? String) }
    public var status: String? { (raw["status"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var idealZones: [String]? { (raw["idealZones"] as? [String]) }
    public var deity: String? { (raw["deity"] as? String) }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var element: String? { (raw["element"] as? String) }
    public var elementTradition: String? { (raw["elementTradition"] as? String) }
    public var waterEffect: [String: Any]? { (raw["waterEffect"] as? [String: Any]) }
    public var note: String? { (raw["note"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var source: String? { (raw["source"] as? String) }
}

public struct VastuSpecializedAuditDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuSunPathDataInput {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var lat: Double { vastuDouble(raw["lat"])! }
    public var lon: Double { vastuDouble(raw["lon"])! }
    public var date: String { (raw["date"] as? String)! }
}

public struct VastuZoneWiseScoreDataZonesItemRoomsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String? { (raw["room"] as? String) }
    public var severity: String? { (raw["severity"] as? String) }
    public var compliant: Bool? { vastuBool(raw["compliant"]) }
    public var issue: String? { (raw["issue"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
}

public struct VastuZoneWiseScoreDataZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var zoneWeight: Int? { vastuInt(raw["zoneWeight"]) }
    public var zoneImportance: String? { (raw["zoneImportance"] as? String) }
    public var score: Int? { vastuInt(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var worstSeverity: String? { (raw["worstSeverity"] as? String) }
    public var rooms: [VastuZoneWiseScoreDataZonesItemRoomsItem]? { (raw["rooms"] as? [[String: Any]])?.map { VastuZoneWiseScoreDataZonesItemRoomsItem(raw: $0) } }
    public var source: String? { (raw["source"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuZoneWiseScoreDataScoring {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var version: String { (raw["version"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var formula: String { (raw["formula"] as? String)! }
    public var basis: String { (raw["basis"] as? String)! }
    public var comparisonBasis: String { (raw["comparisonBasis"] as? String)! }
    public var classification: String { (raw["classification"] as? String)! }
    public var inputPlacementCount: Int { vastuInt(raw["inputPlacementCount"])! }
    public var uniquePlacementCount: Int { vastuInt(raw["uniquePlacementCount"])! }
    public var duplicatePlacementCount: Int { vastuInt(raw["duplicatePlacementCount"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuZoneWiseScoreDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuArAnchorRecommendationsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var anchors: [VastuArAnchorRecommendationsDataAnchorsItem] { (raw["anchors"] as! [[String: Any]]).map { VastuArAnchorRecommendationsDataAnchorsItem(raw: $0) } }
    public var omittedZones: [String] { (raw["omittedZones"] as? [String])! }
    public var planToWorld: Any { raw["planToWorld"]! }
    public var bearingDeg: Double { vastuDouble(raw["bearingDeg"])! }
    public var bearingAssumedNorth: Bool { vastuBool(raw["bearingAssumedNorth"])! }
    public var physicalRegistrationVerified: Bool { vastuBool(raw["physicalRegistrationVerified"])! }
    public var physicalNorthVerified: Bool { vastuBool(raw["physicalNorthVerified"])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var physicalCoverageVerified: Bool { vastuBool(raw["physicalCoverageVerified"])! }
    public var coordinateNote: String { (raw["coordinateNote"] as? String)! }
    public var omissionNote: String { (raw["omissionNote"] as? String)! }
}

public struct VastuArDeityIconsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var icons: [VastuArDeityIconsDataIconsItem] { (raw["icons"] as! [[String: Any]]).map { VastuArDeityIconsDataIconsItem(raw: $0) } }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
}

public struct VastuArHeatmapRasterData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var mask: Int { vastuInt(raw["mask"])! }
    public var texture: Any { raw["texture"]! }
    public var maskBitOrder: [String] { (raw["maskBitOrder"] as? [String])! }
    public var zones: [VastuArHeatmapRasterDataZonesItem] { (raw["zones"] as! [[String: Any]]).map { VastuArHeatmapRasterDataZonesItem(raw: $0) } }
    public var observedZones: [String] { (raw["observedZones"] as? [String])! }
    public var unobservedZones: [String] { (raw["unobservedZones"] as? [String])! }
    public var mandalaProjection: [String: Any]? { (raw["mandalaProjection"] as? [String: Any]) }
    public var bearingAssumedNorth: Bool { vastuBool(raw["bearingAssumedNorth"])! }
    public var completeness: VastuArHeatmapRasterDataCompleteness { VastuArHeatmapRasterDataCompleteness(raw: raw["completeness"] as! [String: Any]) }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var physicalCoverageVerified: Bool { vastuBool(raw["physicalCoverageVerified"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
    public var legend: VastuArHeatmapRasterDataLegend { VastuArHeatmapRasterDataLegend(raw: raw["legend"] as! [String: Any]) }
    public var computed: Bool { vastuBool(raw["computed"])! }
}

public struct VastuArRoomCaptureData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var method: String { (raw["method"] as? String)! }
    public var schema: String { (raw["schema"] as? String)! }
    public var capture: VastuArRoomCaptureDataCapture { VastuArRoomCaptureDataCapture(raw: raw["capture"] as! [String: Any]) }
    public var rooms: [VastuArRoomCaptureDataRoomsItem] { (raw["rooms"] as! [[String: Any]]).map { VastuArRoomCaptureDataRoomsItem(raw: $0) } }
    public var derivedRequests: VastuArRoomCaptureDataDerivedRequests { VastuArRoomCaptureDataDerivedRequests(raw: raw["derivedRequests"] as! [String: Any]) }
    public var planAnalysis: Any { raw["planAnalysis"]! }
    public var audit: Any { raw["audit"]! }
    public var scanQuality: Any { raw["scanQuality"]! }
    public var anchorRecommendations: Any? { (raw["anchorRecommendations"] is NSNull ? nil : raw["anchorRecommendations"]) }
    public var completeness: VastuArRoomCaptureDataCompleteness { VastuArRoomCaptureDataCompleteness(raw: raw["completeness"] as! [String: Any]) }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var captureVerification: String { (raw["captureVerification"] as? String)! }
    public var attestation: String { (raw["attestation"] as? String)! }
    public var note: String { (raw["note"] as? String)! }
}

public struct VastuArScanQualityData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var grade: String? { (raw["grade"] as? String) }
    public var score: Int? { vastuInt(raw["score"]) }
    public var missingData: [String] { (raw["missingData"] as? [String])! }
    public var warnings: [String] { (raw["warnings"] as? [String])! }
    public var reScanSuggestions: [String] { (raw["reScanSuggestions"] as? [String])! }
    public var dimensions: VastuArScanQualityDataDimensions { VastuArScanQualityDataDimensions(raw: raw["dimensions"] as! [String: Any]) }
    public var acceptForAudit: Bool { vastuBool(raw["acceptForAudit"])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var roomsTaggedCount: Double? { vastuDouble(raw["roomsTaggedCount"]) }
    public var unreportedDimensions: [String] { (raw["unreportedDimensions"] as? [String])! }
    public var roomCount: Int? { vastuInt(raw["roomCount"]) }
    public var roomCoverage: VastuArScanQualityDataRoomCoverage { VastuArScanQualityDataRoomCoverage(raw: raw["roomCoverage"] as! [String: Any]) }
    public var scoreScope: String { (raw["scoreScope"] as? String)! }
    public var evidenceSource: String { (raw["evidenceSource"] as? String)! }
    public var sensorAttestation: Bool { vastuBool(raw["sensorAttestation"])! }
    public var limitations: String { (raw["limitations"] as? String)! }
}

public struct VastuArTrueNorthData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var input: VastuArTrueNorthDataInput { VastuArTrueNorthDataInput(raw: raw["input"] as! [String: Any]) }
    public var sunAzimuthTrueDeg: Double { vastuDouble(raw["sunAzimuthTrueDeg"])! }
    public var solarElevationDeg: Double { vastuDouble(raw["solarElevationDeg"])! }
    public var offsetDeg: Double { vastuDouble(raw["offsetDeg"])! }
    public var headingCorrection: String { (raw["headingCorrection"] as? String)! }
    public var reliable: Bool { vastuBool(raw["reliable"])! }
    public var reason: String { (raw["reason"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var solarGeometryReliable: Bool { vastuBool(raw["solarGeometryReliable"])! }
    public var headingQuality: VastuArTrueNorthDataHeadingQuality { VastuArTrueNorthDataHeadingQuality(raw: raw["headingQuality"] as! [String: Any]) }
}

public struct VastuArYantraMeshesData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var name: String { (raw["name"] as? String)! }
    public var format: String { (raw["format"] as? String)! }
    public var asset: Any { raw["asset"]! }
    public var dimensionsMetres: [Double] { (raw["dimensionsMetres"] as? [Double])! }
    public var geometry: VastuArYantraMeshesDataGeometry { VastuArYantraMeshesDataGeometry(raw: raw["geometry"] as! [String: Any]) }
    public var ritualDesign: Bool { vastuBool(raw["ritualDesign"])! }
    public var remedyEfficacyClaimed: Bool { vastuBool(raw["remedyEfficacyClaimed"])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
    public var assetId: String { (raw["assetId"] as? String)! }
}

public struct VastuArZoneTexturesData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var png: Any { raw["png"]! }
    public var svg: Any { raw["svg"]! }
    public var width: Int { vastuInt(raw["width"])! }
    public var height: Int { vastuInt(raw["height"])! }
    public var cells: [VastuArZoneTexturesDataCellsItem] { (raw["cells"] as! [[String: Any]]).map { VastuArZoneTexturesDataCellsItem(raw: $0) } }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
    public var pixelBoundsConvention: String { (raw["pixelBoundsConvention"] as? String)! }
    public var gltfUvOrigin: String { (raw["gltfUvOrigin"] as? String)! }
    public var usdUvOrigin: String { (raw["usdUvOrigin"] as? String)! }
}

public struct VastuAssessmentBatchData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var results: [VastuAssessmentBatchDataResultsItem] { (raw["results"] as! [[String: Any]]).map { VastuAssessmentBatchDataResultsItem(raw: $0) } }
    public var summary: VastuAssessmentBatchDataSummary { VastuAssessmentBatchDataSummary(raw: raw["summary"] as! [String: Any]) }
    public var billingBasis: String { (raw["billingBasis"] as? String)! }
    public var execution: String { (raw["execution"] as? String)! }
}

public struct VastuAssessmentData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var confidence: Double { vastuDouble(raw["confidence"])! }
    public var badgeEligibility: VastuAssessmentBadgeEligibility { VastuAssessmentBadgeEligibility(raw: raw["badgeEligibility"] as! [String: Any]) }
    public var findings: [VastuAssessmentDataFindingsItem]? { (raw["findings"] as? [[String: Any]])?.map { VastuAssessmentDataFindingsItem(raw: $0) } }
    public var maxScore: Double? { vastuDouble(raw["maxScore"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var gradeLabel: String? { (raw["gradeLabel"] as? String) }
    public var scoreBreakdown: [String: Any]? { (raw["scoreBreakdown"] as? [String: Any]) }
    public var confidenceBasis: [String: Any] { (raw["confidenceBasis"] as? [String: Any])! }
    public var entrance: [String: Any]? { (raw["entrance"] as? [String: Any]) }
    public var scanQuality: [String: Any]? { (raw["scanQuality"] as? [String: Any]) }
    public var zoneReference: [String: Any]? { (raw["zoneReference"] as? [String: Any]) }
    public var sources: [VastuAssessmentDataSourcesItem]? { (raw["sources"] as? [[String: Any]])?.map { VastuAssessmentDataSourcesItem(raw: $0) } }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var reason: String? { (raw["reason"] as? String) }
    public var requiredConfidence: Double? { vastuDouble(raw["requiredConfidence"]) }
    public var missingData: [String]? { (raw["missingData"] as? [String]) }
    public var reScanSuggestions: [String]? { (raw["reScanSuggestions"] as? [String]) }
    public var charged: Bool? { vastuBool(raw["charged"]) }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var listingId: Any? { (raw["listingId"] is NSNull ? nil : raw["listingId"]) }
    public var notAssessed: [VastuAssessmentDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuAssessmentDataNotAssessedItem(raw: $0) } }
}

public struct VastuAuspiciousFacingData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var purpose: String { (raw["purpose"] as? String)! }
    public var bestFacing: [[String: Any]] { (raw["bestFacing"] as? [[String: Any]])! }
    public var bestZone: [[String: Any]] { (raw["bestZone"] as? [[String: Any]])! }
    public var avoidFacing: [[String: Any]] { (raw["avoidFacing"] as? [[String: Any]])! }
    public var verifiedPlacement: [String: Any]? { (raw["verifiedPlacement"] as? [String: Any]) }
    public var zoneComplianceCheck: [[String: Any]] { (raw["zoneComplianceCheck"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var rationale: String? { (raw["rationale"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuBearingZoneData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var bearingDeg: Double { vastuDouble(raw["bearingDeg"])! }
    public var zone: String { (raw["zone"] as? String)! }
    public var deity: String { (raw["deity"] as? String)! }
    public var element: String { (raw["element"] as? String)! }
    public var prescribedRooms: [String] { (raw["prescribedRooms"] as? [String])! }
    public var forbiddenRooms: [String] { (raw["forbiddenRooms"] as? [String])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var elementClassification: String? { (raw["elementClassification"] as? String) }
    public var elementSource: String? { (raw["elementSource"] as? String) }
    public var verseBackedRooms: [String]? { (raw["verseBackedRooms"] as? [String]) }
    public var roomRulesClassification: String? { (raw["roomRulesClassification"] as? String) }
}

public struct VastuBrahmasthanProjectionData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var centerPolygon: [[Double]] { (raw["centerPolygon"] as? [[Double]])! }
    public var bufferPolygon: [[Double]] { (raw["bufferPolygon"] as? [[Double]])! }
    public var centroid: [Double] { (raw["centroid"] as? [Double])! }
    public var area: Double { vastuDouble(raw["area"])! }
    public var forbiddenActions: [String] { (raw["forbiddenActions"] as? [String])! }
    public var classicalSource: String { (raw["classicalSource"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var bearingAssumedNorth: Bool? { vastuBool(raw["bearingAssumedNorth"]) }
    public var forbiddenActionsClassification: String? { (raw["forbiddenActionsClassification"] as? String) }
    public var forbiddenActionsSource: String? { (raw["forbiddenActionsSource"] as? String) }
    public var classicalSourceScope: String? { (raw["classicalSourceScope"] as? String) }
}

public struct VastuCatalogReferenceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var defectCount: Int? { vastuInt(raw["defectCount"]) }
    public var defects: [VastuCatalogReferenceDataDefectsItem]? { (raw["defects"] as? [[String: Any]])?.map { VastuCatalogReferenceDataDefectsItem(raw: $0) } }
    public var remedyCount: Int? { vastuInt(raw["remedyCount"]) }
    public var remedies: [VastuCatalogReferenceDataRemediesItem]? { (raw["remedies"] as? [[String: Any]])?.map { VastuCatalogReferenceDataRemediesItem(raw: $0) } }
    public var featureCount: Int? { vastuInt(raw["featureCount"]) }
    public var features: [[String: Any]]? { (raw["features"] as? [[String: Any]]) }
    public var rangeClassification: String? { (raw["rangeClassification"] as? String) }
    public var rangeSource: String? { (raw["rangeSource"] as? String) }
    public var sources: [String]? { (raw["sources"] as? [String]) }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var note: String? { (raw["note"] as? String) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var referenceVersion: String { (raw["referenceVersion"] as? String)! }
}

public struct VastuComplianceIndexData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var complianceIndex: String? { (raw["complianceIndex"] as? String) }
    public var drivingDefects: [VastuComplianceIndexDataDrivingDefectsItem] { (raw["drivingDefects"] as! [[String: Any]]).map { VastuComplianceIndexDataDrivingDefectsItem(raw: $0) } }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var basis: String? { (raw["basis"] as? String) }
    public var defectsSummary: [String: Any]? { (raw["defectsSummary"] as? [String: Any]) }
    public var indexLabel: String? { (raw["indexLabel"] as? String) }
    public var indexScale: [[String: Any]]? { (raw["indexScale"] as? [[String: Any]]) }
    public var indexScaleNote: String? { (raw["indexScaleNote"] as? String) }
    public var indexType: String? { (raw["indexType"] as? String) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var verdict: String? { (raw["verdict"] as? String) }
    public var scoring: VastuComplianceIndexDataScoring { VastuComplianceIndexDataScoring(raw: raw["scoring"] as! [String: Any]) }
    public var notAssessed: [VastuComplianceIndexDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuComplianceIndexDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuDetailedFloorPlanAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var totalRooms: Int { vastuInt(raw["totalRooms"])! }
    public var prescribedCount: Int { vastuInt(raw["prescribedCount"])! }
    public var defects: [VastuDetailedFloorPlanAuditDataDefectsItem] { (raw["defects"] as! [[String: Any]]).map { VastuDetailedFloorPlanAuditDataDefectsItem(raw: $0) } }
    public var devataHeatmap: [VastuDetailedFloorPlanAuditDataDevataHeatmapItem] { (raw["devataHeatmap"] as! [[String: Any]]).map { VastuDetailedFloorPlanAuditDataDevataHeatmapItem(raw: $0) } }
    public var mandalaProjection: [String: Any]? { (raw["mandalaProjection"] as? [String: Any]) }
    public var remediationOrder: [VastuDetailedFloorPlanAuditDataRemediationOrderItem] { (raw["remediationOrder"] as! [[String: Any]]).map { VastuDetailedFloorPlanAuditDataRemediationOrderItem(raw: $0) } }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var bearingAssumedNorth: Bool? { vastuBool(raw["bearingAssumedNorth"]) }
    public var gradeScale: [String: Any]? { (raw["gradeScale"] as? [String: Any]) }
    public var scoring: VastuDetailedFloorPlanAuditDataScoring { VastuDetailedFloorPlanAuditDataScoring(raw: raw["scoring"] as! [String: Any]) }
    public var completeness: VastuDetailedFloorPlanAuditDataCompleteness { VastuDetailedFloorPlanAuditDataCompleteness(raw: raw["completeness"] as! [String: Any]) }
    public var notAssessed: [VastuDetailedFloorPlanAuditDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuDetailedFloorPlanAuditDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuDirectionCorrectData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var magneticBearingDeg: Double? { vastuDouble(raw["magneticBearingDeg"]) }
    public var declinationDeg: Double? { vastuDouble(raw["declinationDeg"]) }
    public var trueBearingDeg: Double? { vastuDouble(raw["trueBearingDeg"]) }
    public var correctedZone: String { (raw["correctedZone"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var correctedZoneIsMagnetic: Bool? { vastuBool(raw["correctedZoneIsMagnetic"]) }
    public var declinationCoverage: String? { (raw["declinationCoverage"] as? String) }
}

public struct VastuDirectionDeclinationData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var lat: Double { vastuDouble(raw["lat"])! }
    public var lon: Double { vastuDouble(raw["lon"])! }
    public var date: String { (raw["date"] as? String)! }
    public var declinationDeg: Double? { vastuDouble(raw["declinationDeg"]) }
    public var interpretation: String { (raw["interpretation"] as? String)! }
    public var gridEpoch: String { (raw["gridEpoch"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var declinationCoverage: String? { (raw["declinationCoverage"] as? String) }
}

public struct VastuDirections32ReferenceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String? { (raw["system"] as? String) }
    public var method: String? { (raw["method"] as? String) }
    public var padaCount: Int { vastuInt(raw["padaCount"])! }
    public var padaWidthDeg: Double? { vastuDouble(raw["padaWidthDeg"]) }
    public var auspiciousCount: Int? { vastuInt(raw["auspiciousCount"]) }
    public var avoidCount: Int? { vastuInt(raw["avoidCount"]) }
    public var classicalDoorScheme: [String: Any]? { (raw["classicalDoorScheme"] as? [String: Any]) }
    public var padas: [[String: Any]] { (raw["padas"] as? [[String: Any]])! }
    public var note: String? { (raw["note"] as? String) }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var referenceVersion: String { (raw["referenceVersion"] as? String)! }
}

public struct VastuDirectionsReferenceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var directionCount: Int { vastuInt(raw["directionCount"])! }
    public var directions: [VastuDirectionsReferenceDataDirectionsItem] { (raw["directions"] as! [[String: Any]]).map { VastuDirectionsReferenceDataDirectionsItem(raw: $0) } }
    public var note: String? { (raw["note"] as? String) }
    public var sources: [String]? { (raw["sources"] as? [String]) }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var system: String? { (raw["system"] as? String) }
    public var method: String? { (raw["method"] as? String) }
    public var sectorWidthDeg: Double? { vastuDouble(raw["sectorWidthDeg"]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var referenceVersion: String { (raw["referenceVersion"] as? String)! }
}

public struct VastuElementBalanceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var derivedFrom: String { (raw["derivedFrom"] as? String)! }
    public var deficientElements: [String] { (raw["deficientElements"] as? [String])! }
    public var excessElements: [String] { (raw["excessElements"] as? [String])! }
    public var remedies: [[String: Any]] { (raw["remedies"] as? [[String: Any]])! }
    public var balanced: Bool { vastuBool(raw["balanced"])! }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var summary: String? { (raw["summary"] as? String) }
    public var system: String? { (raw["system"] as? String) }
}

public struct VastuElementDistributionData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var elementDistribution: [[String: Any]] { (raw["elementDistribution"] as? [[String: Any]])! }
    public var idealModel: [String: Any] { (raw["idealModel"] as? [String: Any])! }
    public var dominantElement: String { (raw["dominantElement"] as? String)! }
    public var deficientElements: [String] { (raw["deficientElements"] as? [String])! }
    public var excessElements: [String] { (raw["excessElements"] as? [String])! }
    public var zoneBreakdown: [[String: Any]] { (raw["zoneBreakdown"] as? [[String: Any]])! }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var totalRooms: Double? { vastuDouble(raw["totalRooms"]) }
    public var weightingBasis: String? { (raw["weightingBasis"] as? String) }
}

public struct VastuEntrancePadaData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var doorXY: [Double] { (raw["doorXY"] as? [Double])! }
    public var plotCentroid: [Double] { (raw["plotCentroid"] as? [Double])! }
    public var rawBearingDeg: Double { vastuDouble(raw["rawBearingDeg"])! }
    public var trueBearingDeg: Double { vastuDouble(raw["trueBearingDeg"])! }
    public var pada: VastuEntrancePadaDataPada { VastuEntrancePadaDataPada(raw: raw["pada"] as! [String: Any]) }
    public var edgeRefined: Bool { vastuBool(raw["edgeRefined"])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
}

public struct VastuEntranceRecommendData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var facing: [String: Any] { (raw["facing"] as? [String: Any])! }
    public var bestEntrancePada: [String: Any] { (raw["bestEntrancePada"] as? [String: Any])! }
    public var recommendedPadas: [[String: Any]] { (raw["recommendedPadas"] as? [[String: Any]])! }
    public var avoidPadas: [[String: Any]] { (raw["avoidPadas"] as? [[String: Any]])! }
    public var facingCaution: [String: Any]? { (raw["facingCaution"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var poojaPrescribedHere: [String: Any]? { (raw["poojaPrescribedHere"] as? [String: Any]) }
    public var prescribedRoomsAtFacing: [String]? { (raw["prescribedRoomsAtFacing"] as? [String]) }
    public var system: String? { (raw["system"] as? String) }
}

public struct VastuFloorPlanAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var totalRooms: Int { vastuInt(raw["totalRooms"])! }
    public var prescribedCount: Int { vastuInt(raw["prescribedCount"])! }
    public var defects: [VastuFloorPlanAuditDataDefectsItem] { (raw["defects"] as! [[String: Any]]).map { VastuFloorPlanAuditDataDefectsItem(raw: $0) } }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var gradeScale: [String: Any]? { (raw["gradeScale"] as? [String: Any]) }
    public var scoring: VastuFloorPlanAuditDataScoring { VastuFloorPlanAuditDataScoring(raw: raw["scoring"] as! [String: Any]) }
    public var textParse: VastuFloorPlanAuditDataTextParse? { (raw["textParse"] as? [String: Any]).map { VastuFloorPlanAuditDataTextParse(raw: $0) } }
    public var notAssessed: [VastuFloorPlanAuditDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuFloorPlanAuditDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuFloorRulesData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var masterBedroomFloor: Int { vastuInt(raw["masterBedroomFloor"])! }
    public var floorRules: [[String: Any]] { (raw["floorRules"] as? [[String: Any]])! }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var principle: String? { (raw["principle"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuFusionChartData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var ascendant: [String: Any] { (raw["ascendant"] as? [String: Any])! }
    public var grahaDirections: [[String: Any]] { (raw["grahaDirections"] as? [[String: Any]])! }
    public var favourableDirections: [[String: Any]] { (raw["favourableDirections"] as? [[String: Any]])! }
    public var cautionDirections: [String] { (raw["cautionDirections"] as? [String])! }
    public var methodology: [String: Any] { (raw["methodology"] as? [String: Any])! }
    public var summary: String { (raw["summary"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
}

public struct VastuLevelAnalysisData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var idealLevels: [[String: Any]] { (raw["idealLevels"] as? [[String: Any]])! }
    public var observedAnalysis: [String: Any]? { (raw["observedAnalysis"] as? [String: Any]) }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var idealOrdering: String? { (raw["idealOrdering"] as? String) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var principle: String? { (raw["principle"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuMainGateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var facing: String { (raw["facing"] as? String)! }
    public var padaScheme: String { (raw["padaScheme"] as? String)! }
    public var prescribedPadas: [Int] { (raw["prescribedPadas"] as? [Int])! }
    public var rule: String { (raw["rule"] as? String)! }
    public var remedy: String { (raw["remedy"] as? String)! }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var padaVerdict: [String: Any]? { (raw["padaVerdict"] as? [String: Any]) }
    public var feature: String? { (raw["feature"] as? String) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
}

public struct VastuMandalaProjectionData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var cells: [[String: Any]] { (raw["cells"] as? [[String: Any]])! }
    public var plotCentroid: [Double] { (raw["plotCentroid"] as? [Double])! }
    public var bearingDeg: Double { vastuDouble(raw["bearingDeg"])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var bearingAssumedNorth: Bool? { vastuBool(raw["bearingAssumedNorth"]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var computed: Bool? { vastuBool(raw["computed"]) }
}

public struct VastuMandalaReferenceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zoneCount: Int? { vastuInt(raw["zoneCount"]) }
    public var zones: [VastuMandalaReferenceDataZonesItem]? { (raw["zones"] as? [[String: Any]])?.map { VastuMandalaReferenceDataZonesItem(raw: $0) } }
    public var devataCount: Int? { vastuInt(raw["devataCount"]) }
    public var devatas: [[String: Any]]? { (raw["devatas"] as? [[String: Any]]) }
    public var cells: [VastuMandalaReferenceDataCellsItem]? { (raw["cells"] as? [[String: Any]])?.map { VastuMandalaReferenceDataCellsItem(raw: $0) } }
    public var padaCount: Int? { vastuInt(raw["padaCount"]) }
    public var grid: [String: Any]? { (raw["grid"] as? [String: Any]) }
    public var sources: [String]? { (raw["sources"] as? [String]) }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var system: String? { (raw["system"] as? String) }
    public var method: String? { (raw["method"] as? String) }
    public var note: String? { (raw["note"] as? String) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var bearingDeg: Double? { vastuDouble(raw["bearingDeg"]) }
    public var brahmasthanPadas: [Double]? { (raw["brahmasthanPadas"] as? [Double]) }
    public var classBreakdown: [String: Any]? { (raw["classBreakdown"] as? [String: Any]) }
    public var devataSource: String? { (raw["devataSource"] as? String) }
    public var devataVerified: Bool? { vastuBool(raw["devataVerified"]) }
    public var mandala: String? { (raw["mandala"] as? String) }
    public var plotCentroid: [Double]? { (raw["plotCentroid"] as? [Double]) }
    public var projected: Bool? { vastuBool(raw["projected"]) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var referenceVersion: String { (raw["referenceVersion"] as? String)! }
}

public struct VastuObstructionData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var matchedFeature: String { (raw["matchedFeature"] as? String)! }
    public var effect: String { (raw["effect"] as? String)! }
    public var rangeChecked: Bool { vastuBool(raw["rangeChecked"])! }
    public var inRange: Bool? { vastuBool(raw["inRange"]) }
    public var houseHeightMultiples: Double? { vastuDouble(raw["houseHeightMultiples"]) }
    public var verdict: String { (raw["verdict"] as? String)! }
    public var note: String { (raw["note"] as? String)! }
    public var source: String { (raw["source"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var rangeClassification: String? { (raw["rangeClassification"] as? String) }
    public var rangeSource: String? { (raw["rangeSource"] as? String) }
}

public struct VastuOverallScoreData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var placements: [VastuOverallScoreDataPlacementsItem] { (raw["placements"] as! [[String: Any]]).map { VastuOverallScoreDataPlacementsItem(raw: $0) } }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var basis: String? { (raw["basis"] as? String) }
    public var formula: String? { (raw["formula"] as? String) }
    public var gradeLabel: String? { (raw["gradeLabel"] as? String) }
    public var indexType: String? { (raw["indexType"] as? String) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var maxScore: Double? { vastuDouble(raw["maxScore"]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var scoreBreakdown: [String: Any]? { (raw["scoreBreakdown"] as? [String: Any]) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var verdict: String? { (raw["verdict"] as? String) }
    public var scoring: VastuOverallScoreDataScoring { VastuOverallScoreDataScoring(raw: raw["scoring"] as! [String: Any]) }
    public var notAssessed: [VastuOverallScoreDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuOverallScoreDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuPlacementData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var feature: String { (raw["feature"] as? String)! }
    public var proposedZone: String { (raw["proposedZone"] as? String)! }
    public var verdict: String { (raw["verdict"] as? String)! }
    public var severity: String { (raw["severity"] as? String)! }
    public var idealZones: [String] { (raw["idealZones"] as? [String])! }
    public var acceptableZones: [String] { (raw["acceptableZones"] as? [String])! }
    public var forbiddenZones: [String] { (raw["forbiddenZones"] as? [String])! }
    public var deity: String { (raw["deity"] as? String)! }
    public var deityClassification: String? { (raw["deityClassification"] as? String) }
    public var deitySource: String? { (raw["deitySource"] as? String) }
    public var element: String { (raw["element"] as? String)! }
    public var elementVerified: Bool { vastuBool(raw["elementVerified"])! }
    public var elementSource: String? { (raw["elementSource"] as? String) }
    public var principle: String { (raw["principle"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuPlanAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var facing: [String: Any] { (raw["facing"] as? [String: Any])! }
    public var plotShape: [String: Any] { (raw["plotShape"] as? [String: Any])! }
    public var overallScore: Double? { vastuDouble(raw["overallScore"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var summary: String { (raw["summary"] as? String)! }
    public var zoneCompliance: [[String: Any]] { (raw["zoneCompliance"] as? [[String: Any]])! }
    public var roomByRoom: [VastuPlanAuditDataRoomByRoomItem] { (raw["roomByRoom"] as! [[String: Any]]).map { VastuPlanAuditDataRoomByRoomItem(raw: $0) } }
    public var defects: [VastuPlanAuditDataDefectsItem] { (raw["defects"] as! [[String: Any]]).map { VastuPlanAuditDataDefectsItem(raw: $0) } }
    public var remedies: [VastuPlanAuditDataRemediesItem] { (raw["remedies"] as! [[String: Any]]).map { VastuPlanAuditDataRemediesItem(raw: $0) } }
    public var elementBalance: [String: Any] { (raw["elementBalance"] as? [String: Any])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var provenance: [String: Any] { (raw["provenance"] as? [String: Any])! }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var printReady: [String: Any]? { (raw["printReady"] as? [String: Any]) }
    public var tracedGeometry: [String: Any]? { (raw["tracedGeometry"] as? [String: Any]) }
    public var gradeLabel: String? { (raw["gradeLabel"] as? String) }
    public var scoreDisclaimer: String? { (raw["scoreDisclaimer"] as? String) }
    public var artifact: VastuPlanAuditDataArtifact? { (raw["artifact"] as? [String: Any]).map { VastuPlanAuditDataArtifact(raw: $0) } }
    public var notAssessed: [VastuPlanAuditDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuPlanAuditDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuPlanGenerateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plot: [String: Any] { (raw["plot"] as? [String: Any])! }
    public var entrance: [String: Any] { (raw["entrance"] as? [String: Any])! }
    public var rooms: [[String: Any]] { (raw["rooms"] as? [[String: Any]])! }
    public var mandala: [String: Any] { (raw["mandala"] as? [String: Any])! }
    public var compliance: [String: Any] { (raw["compliance"] as? [String: Any])! }
    public var openings: [String: Any] { (raw["openings"] as? [String: Any])! }
    public var svg: String? { (raw["svg"] as? String) }
    public var variants: [[String: Any]] { (raw["variants"] as? [[String: Any]])! }
    public var recommendedVariant: String { (raw["recommendedVariant"] as? String)! }
    public var architecturalRooms: [[String: Any]]? { (raw["architecturalRooms"] as? [[String: Any]]) }
    public var derivedRoomProgramme: [[String: Any]]? { (raw["derivedRoomProgramme"] as? [[String: Any]]) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var requirements: [String: Any]? { (raw["requirements"] as? [String: Any]) }
    public var roomProgrammeNote: String? { (raw["roomProgrammeNote"] as? String) }
    public var sources: [[String: Any]]? { (raw["sources"] as? [[String: Any]]) }
    public var system: String? { (raw["system"] as? String) }
    public var variantCount: Double? { vastuDouble(raw["variantCount"]) }
    public var variantNote: String? { (raw["variantNote"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var floors: [[String: Any]]? { (raw["floors"] as? [[String: Any]]) }
    public var core: [String: Any]? { (raw["core"] as? [String: Any]) }
    public var verticalChecks: [[String: Any]]? { (raw["verticalChecks"] as? [[String: Any]]) }
    public var floorNote: String? { (raw["floorNote"] as? String) }
}

public struct VastuPlanOptimizeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var before: [String: Any] { (raw["before"] as? [String: Any])! }
    public var after: [String: Any] { (raw["after"] as? [String: Any])! }
    public var improvement: [String: Any] { (raw["improvement"] as? [String: Any])! }
    public var moves: [[String: Any]] { (raw["moves"] as? [[String: Any]])! }
    public var mandala: [String: Any] { (raw["mandala"] as? [String: Any])! }
    public var svg: String? { (raw["svg"] as? String) }
    public var compliance: [String: Any]? { (raw["compliance"] as? [String: Any]) }
    public var entrance: [String: Any]? { (raw["entrance"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var openings: [String: Any]? { (raw["openings"] as? [String: Any]) }
    public var plot: [String: Any]? { (raw["plot"] as? [String: Any]) }
    public var sources: [[String: Any]]? { (raw["sources"] as? [[String: Any]]) }
    public var system: String? { (raw["system"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
}

public struct VastuPlotExtensionsCutsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var directions: [[String: Any]] { (raw["directions"] as? [[String: Any]])! }
    public var extensions: [String] { (raw["extensions"] as? [String])! }
    public var cuts: [[String: Any]] { (raw["cuts"] as? [[String: Any]])! }
    public var severeCuts: [[String: Any]] { (raw["severeCuts"] as? [[String: Any]])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var actualPlotArea: Double? { vastuDouble(raw["actualPlotArea"]) }
    public var areaEfficiency: Double? { vastuDouble(raw["areaEfficiency"]) }
    public var idealRectangleArea: Double? { vastuDouble(raw["idealRectangleArea"]) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var provenance: [String: Any]? { (raw["provenance"] as? [String: Any]) }
    public var summary: String? { (raw["summary"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var verdict: String? { (raw["verdict"] as? String) }
}

public struct VastuPlotOrientationData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var facing: String { (raw["facing"] as? String)! }
    public var grade: String { (raw["grade"] as? String)! }
    public var doorPadaScheme: [String: Any] { (raw["doorPadaScheme"] as? [String: Any])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var auspicious: Bool? { vastuBool(raw["auspicious"]) }
    public var deity: String? { (raw["deity"] as? String) }
    public var facingSanskrit: String? { (raw["facingSanskrit"] as? String) }
    public var gradeProvenance: [String: Any]? { (raw["gradeProvenance"] as? [String: Any]) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var note: String? { (raw["note"] as? String) }
    public var provenance: [String: Any]? { (raw["provenance"] as? [String: Any]) }
    public var system: String? { (raw["system"] as? String) }
}

public struct VastuPlotRatioData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var length: Double { vastuDouble(raw["length"])! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var units: String { (raw["units"] as? String)! }
    public var unitsNote: String { (raw["unitsNote"] as? String)! }
    public var lengthM: Double? { vastuDouble(raw["lengthM"]) }
    public var widthM: Double? { vastuDouble(raw["widthM"]) }
    public var ratio: Double { vastuDouble(raw["ratio"])! }
    public var category: String { (raw["category"] as? String)! }
    public var acceptable: Bool { vastuBool(raw["acceptable"])! }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var classicalSource: String { (raw["classicalSource"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var boundingFrame: String { (raw["boundingFrame"] as? String)! }
}

public struct VastuPlotShapeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var shape: String { (raw["shape"] as? String)! }
    public var vertices: Int { vastuInt(raw["vertices"])! }
    public var area: Double { vastuDouble(raw["area"])! }
    public var bboxArea: Double { vastuDouble(raw["bboxArea"])! }
    public var fillRatio: Double { vastuDouble(raw["fillRatio"])! }
    public var vastuGrade: String { (raw["vastuGrade"] as? String)! }
    public var notes: String { (raw["notes"] as? String)! }
    public var classicalSource: String { (raw["classicalSource"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var boundingFrame: String { (raw["boundingFrame"] as? String)! }
}

public struct VastuPlotSlopeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var downSlopeDirection: String { (raw["downSlopeDirection"] as? String)! }
    public var classicalReference: [String: Any] { (raw["classicalReference"] as? [String: Any])! }
    public var verdict: String? { (raw["verdict"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var auspicious: Bool? { vastuBool(raw["auspicious"]) }
    public var effect: String? { (raw["effect"] as? String) }
    public var effectProvenance: [String: Any]? { (raw["effectProvenance"] as? [String: Any]) }
    public var idealRule: String? { (raw["idealRule"] as? String) }
    public var idealRuleProvenance: [String: Any]? { (raw["idealRuleProvenance"] as? [String: Any]) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var provenance: [String: Any]? { (raw["provenance"] as? [String: Any]) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var system: String? { (raw["system"] as? String) }
}

public struct VastuRemedyComparisonData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var before: VastuRemedyComparisonDataBefore { VastuRemedyComparisonDataBefore(raw: raw["before"] as! [String: Any]) }
    public var after: VastuRemedyComparisonDataAfter { VastuRemedyComparisonDataAfter(raw: raw["after"] as! [String: Any]) }
    public var scoreDelta: Double? { vastuDouble(raw["scoreDelta"]) }
    public var scoring: [String: Any] { (raw["scoring"] as? [String: Any])! }
    public var verdict: String? { (raw["verdict"] as? String) }
    public var remediesApplied: [[String: Any]] { (raw["remediesApplied"] as? [[String: Any]])! }
    public var roomChanges: [[String: Any]] { (raw["roomChanges"] as? [[String: Any]])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var notAssessed: [VastuRemedyComparisonDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuRemedyComparisonDataNotAssessedItem(raw: $0) } }
}

public struct VastuRoadOrientationData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var roadAnalysis: [[String: Any]] { (raw["roadAnalysis"] as? [[String: Any]])! }
    public var beneficRoads: [String] { (raw["beneficRoads"] as? [String])! }
    public var cautionRoads: [String] { (raw["cautionRoads"] as? [String])! }
    public var veedhiShoola: [String: Any] { (raw["veedhiShoola"] as? [String: Any])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var chaturMukhi: Bool? { vastuBool(raw["chaturMukhi"]) }
    public var hasNorthOrEastRoad: Bool? { vastuBool(raw["hasNorthOrEastRoad"]) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var provenance: [String: Any]? { (raw["provenance"] as? [String: Any]) }
    public var summary: String? { (raw["summary"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var verdict: String? { (raw["verdict"] as? String) }
}

public struct VastuRoomData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var room: String { (raw["room"] as? String)! }
    public var placement: [String: Any] { (raw["placement"] as? [String: Any])! }
    public var verdict: String { (raw["verdict"] as? String)! }
    public var severity: String { (raw["severity"] as? String)! }
    public var idealZones: [String] { (raw["idealZones"] as? [String])! }
    public var acceptableZones: [String] { (raw["acceptableZones"] as? [String])! }
    public var forbiddenZones: [String] { (raw["forbiddenZones"] as? [String])! }
    public var defect: [String: Any]? { (raw["defect"] as? [String: Any]) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyType: String? { (raw["remedyType"] as? String) }
    public var guidance: String? { (raw["guidance"] as? String) }
    public var citation: [String: Any] { (raw["citation"] as? [String: Any])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var storageType: String? { (raw["storageType"] as? String) }
    public var placementVerified: Bool? { vastuBool(raw["placementVerified"]) }
    public var guidanceClassification: String? { (raw["guidanceClassification"] as? String) }
}

public struct VastuScanStoredData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var schemaVersion: Int { vastuInt(raw["schemaVersion"])! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var snapshot: Any { raw["snapshot"]! }
    public var audit: Any { raw["audit"]! }
    public var scanQuality: Any? { (raw["scanQuality"] is NSNull ? nil : raw["scanQuality"]) }
    public var captureVerification: String { (raw["captureVerification"] as? String)! }
    public var geometryUnits: String { (raw["geometryUnits"] as? String)! }
    public var assessmentNote: String { (raw["assessmentNote"] as? String)! }
}

public struct VastuScansDeleteData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scanId: String { (raw["scanId"] as? String)! }
    public var deleted: Bool { vastuBool(raw["deleted"])! }
    public var deletionScope: String { (raw["deletionScope"] as? String)! }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
}

public struct VastuScansListData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scans: [Any] { (raw["scans"] as? [Any])! }
    public var nextCursor: String? { (raw["nextCursor"] as? String) }
    public var paginationNote: String? { (raw["paginationNote"] as? String) }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
}

public struct VastuScansRetrieveData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scan: Any { raw["scan"]! }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
}

public struct VastuScansSaveData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scan: Any { raw["scan"]! }
    public var replayed: Bool { vastuBool(raw["replayed"])! }
    public var retentionNote: String? { (raw["retentionNote"] as? String) }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
}

public struct VastuScansTimelapseData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var scans: [Any] { (raw["scans"] as? [Any])! }
    public var comparisonNote: String { (raw["comparisonNote"] as? String)! }
    public var physicalChangeVerified: Bool { vastuBool(raw["physicalChangeVerified"])! }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
}

public struct VastuSingleRoomAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var compliance: String { (raw["compliance"] as? String)! }
    public var severity: String { (raw["severity"] as? String)! }
    public var recommendedZone: String? { (raw["recommendedZone"] as? String) }
    public var remedy: String { (raw["remedy"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var computed: Bool { vastuBool(raw["computed"])! }
    public var classification: String { (raw["classification"] as? String)! }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var remedyClassification: String? { (raw["remedyClassification"] as? String) }
    public var remedySource: String? { (raw["remedySource"] as? String) }
}

public struct VastuSpecializedAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var buildingType: String { (raw["buildingType"] as? String)! }
    public var score: Double? { vastuDouble(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var scoringBasis: String { (raw["scoringBasis"] as? String)! }
    public var auditedRooms: Int { vastuInt(raw["auditedRooms"])! }
    public var idealCount: Int { vastuInt(raw["idealCount"])! }
    public var compliantCount: Int { vastuInt(raw["compliantCount"])! }
    public var defectCount: Int { vastuInt(raw["defectCount"])! }
    public var findings: [VastuSpecializedAuditDataFindingsItem] { (raw["findings"] as! [[String: Any]]).map { VastuSpecializedAuditDataFindingsItem(raw: $0) } }
    public var remedies: [[String: Any]] { (raw["remedies"] as? [[String: Any]])! }
    public var unknownRooms: [[String: Any]] { (raw["unknownRooms"] as? [[String: Any]])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var provenance: [String: Any] { (raw["provenance"] as? [String: Any])! }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var buildingDirection: [String: Any]? { (raw["buildingDirection"] as? [String: Any]) }
    public var notAssessed: [VastuSpecializedAuditDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuSpecializedAuditDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuSunPathData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var input: VastuSunPathDataInput { VastuSunPathDataInput(raw: raw["input"] as! [String: Any]) }
    public var sunriseUtc: String? { (raw["sunriseUtc"] as? String) }
    public var sunriseAzimuthDeg: Double? { vastuDouble(raw["sunriseAzimuthDeg"]) }
    public var solarNoonUtc: String? { (raw["solarNoonUtc"] as? String) }
    public var solarNoonAzimuthDeg: Double? { vastuDouble(raw["solarNoonAzimuthDeg"]) }
    public var solarNoonElevationDeg: Double? { vastuDouble(raw["solarNoonElevationDeg"]) }
    public var sunsetUtc: String? { (raw["sunsetUtc"] as? String) }
    public var sunsetAzimuthDeg: Double? { vastuDouble(raw["sunsetAzimuthDeg"]) }
    public var declinationDeg: Double? { vastuDouble(raw["declinationDeg"]) }
    public var arc: [[String: Any]] { (raw["arc"] as? [[String: Any]])! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var dayStatus: String? { (raw["dayStatus"] as? String) }
    public var note: String? { (raw["note"] as? String) }
    public var noonUtc: String? { (raw["noonUtc"] as? String) }
    public var noonElevationDeg: Double? { vastuDouble(raw["noonElevationDeg"]) }
}

public struct VastuTimingData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var activity: String { (raw["activity"] as? String)! }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var summary: [String: Any] { (raw["summary"] as? [String: Any])! }
    public var auspiciousDates: [[String: Any]] { (raw["auspiciousDates"] as? [[String: Any]])! }
    public var meta: [String: Any] { (raw["meta"] as? [String: Any])! }
    public var guidance: [String: Any] { (raw["guidance"] as? [String: Any])! }
    public var foundationRite: [String: Any]? { (raw["foundationRite"] as? [String: Any]) }
}

public struct VastuWallAnalysisData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var idealWalls: [[String: Any]] { (raw["idealWalls"] as? [[String: Any]])! }
    public var observedAnalysis: [String: Any]? { (raw["observedAnalysis"] as? [String: Any]) }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var idealOrdering: String? { (raw["idealOrdering"] as? String) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var principle: String? { (raw["principle"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
}

public struct VastuZoneReferenceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String? { (raw["system"] as? String) }
    public var method: String? { (raw["method"] as? String) }
    public var zoneCount: Int { vastuInt(raw["zoneCount"])! }
    public var zones: [[String: Any]] { (raw["zones"] as? [[String: Any]])! }
    public var note: String? { (raw["note"] as? String) }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var referenceVersion: String { (raw["referenceVersion"] as? String)! }
}

public struct VastuZoneWiseScoreData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zones: [VastuZoneWiseScoreDataZonesItem] { (raw["zones"] as! [[String: Any]]).map { VastuZoneWiseScoreDataZonesItem(raw: $0) } }
    public var sources: [[String: Any]] { (raw["sources"] as? [[String: Any]])! }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var basis: String? { (raw["basis"] as? String) }
    public var indexType: String? { (raw["indexType"] as? String) }
    public var input: [String: Any]? { (raw["input"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var overallGrade: String? { (raw["overallGrade"] as? String) }
    public var overallScore: Double? { vastuDouble(raw["overallScore"]) }
    public var strongestZone: String? { (raw["strongestZone"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var weakestZone: String? { (raw["weakestZone"] as? String) }
    public var zoneWeightingNote: String? { (raw["zoneWeightingNote"] as? String) }
    public var scoring: VastuZoneWiseScoreDataScoring { VastuZoneWiseScoreDataScoring(raw: raw["scoring"] as! [String: Any]) }
    public var notAssessed: [VastuZoneWiseScoreDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuZoneWiseScoreDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
}

public struct VastuTypedResponse<Data: VastuData> { public let success: Bool; public let data: Data; public let raw: [String: Any]; public var billing: [String: Any] { raw["billing"] as! [String: Any] } }

public struct VastuAssessmentsResponse {
    public let success: Bool
    public let data: VastuAssessmentData
    public let raw: [String: Any]
    public var billing: [String: Any]? { raw["billing"] as? [String: Any] }
}

public struct VastuAssessmentsBatchResponse {
    public let success: Bool
    public let data: VastuAssessmentBatchData
    public let raw: [String: Any]
}


public struct VastuContract<Request: VastuRequest, Data: VastuData> { public let operation: VastuOperation; fileprivate let decode: ([String: Any]) -> Data }

public enum VastuContracts {
    public static let arCountedScanQuality = VastuContract<VastuArCountedScanQualityRequest, VastuArScanQualityData>(operation: .arScanQuality, decode: VastuArScanQualityData.init)






    public static let arDeityIcons = VastuContract<VastuArDeityIconsRequest, VastuArDeityIconsData>(operation: .arDeityIcons, decode: VastuArDeityIconsData.init)

    public static let arRoomCapture = VastuContract<VastuArRoomCaptureRequest, VastuArRoomCaptureData>(operation: .arRoomCapture, decode: VastuArRoomCaptureData.init)

    public static let arYantraMeshes = VastuContract<VastuArYantraMeshesRequest, VastuArYantraMeshesData>(operation: .arYantraMeshes, decode: VastuArYantraMeshesData.init)

    public static let arZoneTextures = VastuContract<VastuArZoneTexturesRequest, VastuArZoneTexturesData>(operation: .arZoneTextures, decode: VastuArZoneTexturesData.init)

    public static let arAnchorRecommendations = VastuContract<VastuArAnchorRecommendationsRequest, VastuArAnchorRecommendationsData>(operation: .arAnchorRecommendations, decode: VastuArAnchorRecommendationsData.init)

    public static let arHeatmapRaster = VastuContract<VastuArHeatmapRasterRequest, VastuArHeatmapRasterData>(operation: .arHeatmapRaster, decode: VastuArHeatmapRasterData.init)


    public static let arScanQuality = VastuContract<VastuArScanQualityRequest, VastuArScanQualityData>(operation: .arScanQuality, decode: VastuArScanQualityData.init)

    public static let arTrueNorthCalibrate = VastuContract<VastuArTrueNorthCalibrateRequest, VastuArTrueNorthData>(operation: .arTrueNorthCalibrate, decode: VastuArTrueNorthData.init)

    static let assessments = VastuContract<VastuAssessmentsRequest, VastuAssessmentData>(operation: .assessments, decode: VastuAssessmentData.init)

    static let assessmentsBatch = VastuContract<VastuAssessmentsBatchRequest, VastuAssessmentBatchData>(operation: .assessmentsBatch, decode: VastuAssessmentBatchData.init)

    public static let auditFloorPlan = VastuContract<VastuAuditFloorPlanRequest, VastuFloorPlanAuditData>(operation: .auditFloorPlan, decode: VastuFloorPlanAuditData.init)

    public static let auditFloorPlanDetailed = VastuContract<VastuAuditFloorPlanDetailedRequest, VastuDetailedFloorPlanAuditData>(operation: .auditFloorPlanDetailed, decode: VastuDetailedFloorPlanAuditData.init)

    public static let auditSingleRoom = VastuContract<VastuAuditSingleRoomRequest, VastuSingleRoomAuditData>(operation: .auditSingleRoom, decode: VastuSingleRoomAuditData.init)

    public static let compareBeforeAfterRemedy = VastuContract<VastuCompareBeforeAfterRemedyRequest, VastuRemedyComparisonData>(operation: .compareBeforeAfterRemedy, decode: VastuRemedyComparisonData.init)

    public static let compoundWallAnalysis = VastuContract<VastuCompoundWallAnalysisRequest, VastuWallAnalysisData>(operation: .compoundWallAnalysis, decode: VastuWallAnalysisData.init)

    public static let directionAuspiciousFacing = VastuContract<VastuDirectionAuspiciousFacingRequest, VastuAuspiciousFacingData>(operation: .directionAuspiciousFacing, decode: VastuAuspiciousFacingData.init)

    public static let directionCorrect = VastuContract<VastuDirectionCorrectRequest, VastuDirectionCorrectData>(operation: .directionCorrect, decode: VastuDirectionCorrectData.init)

    public static let directionDeclination = VastuContract<VastuDirectionDeclinationRequest, VastuDirectionDeclinationData>(operation: .directionDeclination, decode: VastuDirectionDeclinationData.init)

    public static let directionSunPath = VastuContract<VastuDirectionSunPathRequest, VastuSunPathData>(operation: .directionSunPath, decode: VastuSunPathData.init)

    public static let directionZoneFromBearing = VastuContract<VastuDirectionZoneFromBearingRequest, VastuBearingZoneData>(operation: .directionZoneFromBearing, decode: VastuBearingZoneData.init)

    public static let elementsBalanceSuggest = VastuContract<VastuElementsBalanceSuggestRequest, VastuElementBalanceData>(operation: .elementsBalanceSuggest, decode: VastuElementBalanceData.init)

    public static let elementsDistribution = VastuContract<VastuElementsDistributionRequest, VastuElementDistributionData>(operation: .elementsDistribution, decode: VastuElementDistributionData.init)

    public static let entranceObstructionCheck = VastuContract<VastuEntranceObstructionCheckRequest, VastuObstructionData>(operation: .entranceObstructionCheck, decode: VastuObstructionData.init)

    public static let entrancePada = VastuContract<VastuEntrancePadaRequest, VastuEntrancePadaData>(operation: .entrancePada, decode: VastuEntrancePadaData.init)

    public static let entranceRecommend = VastuContract<VastuEntranceRecommendRequest, VastuEntranceRecommendData>(operation: .entranceRecommend, decode: VastuEntranceRecommendData.init)

    public static let floorLevelAnalysis = VastuContract<VastuFloorLevelAnalysisRequest, VastuLevelAnalysisData>(operation: .floorLevelAnalysis, decode: VastuLevelAnalysisData.init)

    public static let fusionChart = VastuContract<VastuFusionChartRequest, VastuFusionChartData>(operation: .fusionChart, decode: VastuFusionChartData.init)

    public static let mandalaProject81Pada = VastuContract<VastuMandalaProject81PadaRequest, VastuMandalaProjectionData>(operation: .mandalaProject81Pada, decode: VastuMandalaProjectionData.init)

    public static let mandalaProject9Zone = VastuContract<VastuMandalaProject9ZoneRequest, VastuMandalaProjectionData>(operation: .mandalaProject9Zone, decode: VastuMandalaProjectionData.init)

    public static let mandalaProjectBrahmasthan = VastuContract<VastuMandalaProjectBrahmasthanRequest, VastuBrahmasthanProjectionData>(operation: .mandalaProjectBrahmasthan, decode: VastuBrahmasthanProjectionData.init)

    public static let multiStoreyFloorRules = VastuContract<VastuMultiStoreyFloorRulesRequest, VastuFloorRulesData>(operation: .multiStoreyFloorRules, decode: VastuFloorRulesData.init)

    public static let placementBalcony = VastuContract<VastuPlacementBalconyRequest, VastuPlacementData>(operation: .placementBalcony, decode: VastuPlacementData.init)

    public static let placementBorewell = VastuContract<VastuPlacementBorewellRequest, VastuPlacementData>(operation: .placementBorewell, decode: VastuPlacementData.init)

    public static let placementGarden = VastuContract<VastuPlacementGardenRequest, VastuPlacementData>(operation: .placementGarden, decode: VastuPlacementData.init)

    public static let placementGeneratorElectrical = VastuContract<VastuPlacementGeneratorElectricalRequest, VastuPlacementData>(operation: .placementGeneratorElectrical, decode: VastuPlacementData.init)

    public static let placementMainGate = VastuContract<VastuPlacementMainGateRequest, VastuMainGateData>(operation: .placementMainGate, decode: VastuMainGateData.init)

    public static let placementOverheadTank = VastuContract<VastuPlacementOverheadTankRequest, VastuPlacementData>(operation: .placementOverheadTank, decode: VastuPlacementData.init)

    public static let placementSepticTank = VastuContract<VastuPlacementSepticTankRequest, VastuPlacementData>(operation: .placementSepticTank, decode: VastuPlacementData.init)

    public static let placementTree = VastuContract<VastuPlacementTreeRequest, VastuPlacementData>(operation: .placementTree, decode: VastuPlacementData.init)

    public static let placementWell = VastuContract<VastuPlacementWellRequest, VastuPlacementData>(operation: .placementWell, decode: VastuPlacementData.init)

    public static let placementWindow = VastuContract<VastuPlacementWindowRequest, VastuPlacementData>(operation: .placementWindow, decode: VastuPlacementData.init)

    public static let planAnalyze = VastuContract<VastuPlanAnalyzeRequest, VastuPlanAuditData>(operation: .planAnalyze, decode: VastuPlanAuditData.init)

    public static let planFromRequirements = VastuContract<VastuPlanFromRequirementsRequest, VastuPlanGenerateData>(operation: .planFromRequirements, decode: VastuPlanGenerateData.init)

    public static let planGenerate = VastuContract<VastuPlanGenerateRequest, VastuPlanGenerateData>(operation: .planGenerate, decode: VastuPlanGenerateData.init)

    public static let planOptimize = VastuContract<VastuPlanOptimizeRequest, VastuPlanOptimizeData>(operation: .planOptimize, decode: VastuPlanOptimizeData.init)

    public static let planReport = VastuContract<VastuPlanReportRequest, VastuPlanAuditData>(operation: .planReport, decode: VastuPlanAuditData.init)

    public static let planUpload = VastuContract<VastuPlanUploadRequest, VastuPlanAuditData>(operation: .planUpload, decode: VastuPlanAuditData.init)

    public static let plotExtensionsCuts = VastuContract<VastuPlotExtensionsCutsRequest, VastuPlotExtensionsCutsData>(operation: .plotExtensionsCuts, decode: VastuPlotExtensionsCutsData.init)

    public static let plotOrientation = VastuContract<VastuPlotOrientationRequest, VastuPlotOrientationData>(operation: .plotOrientation, decode: VastuPlotOrientationData.init)

    public static let plotRatio = VastuContract<VastuPlotRatioRequest, VastuPlotRatioData>(operation: .plotRatio, decode: VastuPlotRatioData.init)

    public static let plotRoadOrientation = VastuContract<VastuPlotRoadOrientationRequest, VastuRoadOrientationData>(operation: .plotRoadOrientation, decode: VastuRoadOrientationData.init)

    public static let plotShape = VastuContract<VastuPlotShapeRequest, VastuPlotShapeData>(operation: .plotShape, decode: VastuPlotShapeData.init)

    public static let plotSlope = VastuContract<VastuPlotSlopeRequest, VastuPlotSlopeData>(operation: .plotSlope, decode: VastuPlotSlopeData.init)

    public static let referenceColorsByZone = VastuContract<VastuNoRequest, VastuZoneReferenceData>(operation: .referenceColorsByZone, decode: VastuZoneReferenceData.init)

    public static let referenceDefectsCatalog = VastuContract<VastuNoRequest, VastuCatalogReferenceData>(operation: .referenceDefectsCatalog, decode: VastuCatalogReferenceData.init)

    public static let referenceDirections16 = VastuContract<VastuNoRequest, VastuDirectionsReferenceData>(operation: .referenceDirections16, decode: VastuDirectionsReferenceData.init)

    public static let referenceDirections32 = VastuContract<VastuNoRequest, VastuDirections32ReferenceData>(operation: .referenceDirections32, decode: VastuDirections32ReferenceData.init)

    public static let referenceDirections8 = VastuContract<VastuNoRequest, VastuDirectionsReferenceData>(operation: .referenceDirections8, decode: VastuDirectionsReferenceData.init)

    public static let referenceGateObstructions = VastuContract<VastuNoRequest, VastuCatalogReferenceData>(operation: .referenceGateObstructions, decode: VastuCatalogReferenceData.init)

    public static let referenceMandala45Devatas = VastuContract<VastuNoRequest, VastuMandalaReferenceData>(operation: .referenceMandala45Devatas, decode: VastuMandalaReferenceData.init)

    public static let referenceMandala64Pada = VastuContract<VastuNoRequest, VastuMandalaReferenceData>(operation: .referenceMandala64Pada, decode: VastuMandalaReferenceData.init)

    public static let referenceMandala9Zone = VastuContract<VastuNoRequest, VastuMandalaReferenceData>(operation: .referenceMandala9Zone, decode: VastuMandalaReferenceData.init)

    public static let referenceMaterialsByZone = VastuContract<VastuNoRequest, VastuZoneReferenceData>(operation: .referenceMaterialsByZone, decode: VastuZoneReferenceData.init)

    public static let referenceRemediesCatalog = VastuContract<VastuNoRequest, VastuCatalogReferenceData>(operation: .referenceRemediesCatalog, decode: VastuCatalogReferenceData.init)

    public static let roomBedroom = VastuContract<VastuRoomBedroomRequest, VastuRoomData>(operation: .roomBedroom, decode: VastuRoomData.init)

    public static let roomDining = VastuContract<VastuRoomDiningRequest, VastuRoomData>(operation: .roomDining, decode: VastuRoomData.init)

    public static let roomKitchen = VastuContract<VastuRoomKitchenRequest, VastuRoomData>(operation: .roomKitchen, decode: VastuRoomData.init)

    public static let roomLiving = VastuContract<VastuRoomLivingRequest, VastuRoomData>(operation: .roomLiving, decode: VastuRoomData.init)

    public static let roomPooja = VastuContract<VastuRoomPoojaRequest, VastuRoomData>(operation: .roomPooja, decode: VastuRoomData.init)

    public static let roomStaircase = VastuContract<VastuRoomStaircaseRequest, VastuRoomData>(operation: .roomStaircase, decode: VastuRoomData.init)

    public static let roomStore = VastuContract<VastuRoomStoreRequest, VastuRoomData>(operation: .roomStore, decode: VastuRoomData.init)

    public static let roomStudy = VastuContract<VastuRoomStudyRequest, VastuRoomData>(operation: .roomStudy, decode: VastuRoomData.init)

    public static let roomToilet = VastuContract<VastuRoomToiletRequest, VastuRoomData>(operation: .roomToilet, decode: VastuRoomData.init)

    public static let roomWaterStorage = VastuContract<VastuRoomWaterStorageRequest, VastuRoomData>(operation: .roomWaterStorage, decode: VastuRoomData.init)

    public static let scoreComplianceIndex = VastuContract<VastuScoreComplianceIndexRequest, VastuComplianceIndexData>(operation: .scoreComplianceIndex, decode: VastuComplianceIndexData.init)

    public static let scoreOverall = VastuContract<VastuScoreOverallRequest, VastuOverallScoreData>(operation: .scoreOverall, decode: VastuOverallScoreData.init)

    public static let scoreZoneWise = VastuContract<VastuScoreZoneWiseRequest, VastuZoneWiseScoreData>(operation: .scoreZoneWise, decode: VastuZoneWiseScoreData.init)

    public static let specializedCommercial = VastuContract<VastuSpecializedCommercialRequest, VastuSpecializedAuditData>(operation: .specializedCommercial, decode: VastuSpecializedAuditData.init)

    public static let specializedEducational = VastuContract<VastuSpecializedEducationalRequest, VastuSpecializedAuditData>(operation: .specializedEducational, decode: VastuSpecializedAuditData.init)

    public static let specializedFactory = VastuContract<VastuSpecializedFactoryRequest, VastuSpecializedAuditData>(operation: .specializedFactory, decode: VastuSpecializedAuditData.init)

    public static let specializedHospital = VastuContract<VastuSpecializedHospitalRequest, VastuSpecializedAuditData>(operation: .specializedHospital, decode: VastuSpecializedAuditData.init)

    public static let specializedResidential = VastuContract<VastuSpecializedResidentialRequest, VastuSpecializedAuditData>(operation: .specializedResidential, decode: VastuSpecializedAuditData.init)

    public static let specializedRestaurant = VastuContract<VastuSpecializedRestaurantRequest, VastuSpecializedAuditData>(operation: .specializedRestaurant, decode: VastuSpecializedAuditData.init)

    public static let specializedTemple = VastuContract<VastuSpecializedTempleRequest, VastuSpecializedAuditData>(operation: .specializedTemple, decode: VastuSpecializedAuditData.init)

    public static let timingBhumiPujan = VastuContract<VastuTimingBhumiPujanRequest, VastuTimingData>(operation: .timingBhumiPujan, decode: VastuTimingData.init)

    public static let timingConstructionStart = VastuContract<VastuTimingConstructionStartRequest, VastuTimingData>(operation: .timingConstructionStart, decode: VastuTimingData.init)

    public static let timingGrihapravesh = VastuContract<VastuTimingGrihapraveshRequest, VastuTimingData>(operation: .timingGrihapravesh, decode: VastuTimingData.init)

    public static let timingVastuShanti = VastuContract<VastuTimingVastuShantiRequest, VastuTimingData>(operation: .timingVastuShanti, decode: VastuTimingData.init)

}

// END GENERATED VASTU CONTRACTS

/// Vastu Shastra: plot geometry, mandala projection, entrance/room/
/// placement rules, compliance audits, scoring, and floor-plan generation
/// (93 logical backend operations across the full domain — this first deliverable
/// ships the 12 client methods that reach all of them, including the two
/// escape hatches, `vastu` and `vastuReference`, for any op/table that
/// doesn't have its own named method). Mirrors
/// `sdks/android/src/main/kotlin/io/vedika/sdk/VastuService.kt` and
/// `sdks/flutter/lib/src/services/astrology_service.dart` (lines 206-312).
///
/// Vastu takes a BUILDING (plot polygon, room list, compass zone), never a
/// birth chart — do not pass birth-details params here.
/// Caller-owned idempotency keys may be retained across client or process restarts.
public final class VastuService {
    private static let base = "/v2/astrology/vastu"

    private unowned let client: VedikaClient

    init(client: VedikaClient) {
        self.client = client
    }

    /// Exact request and result types for one of the 93 mounted operations.
    public func vastuOperation<Request: VastuRequest, Data: VastuData>(
        _ contract: VastuContract<Request, Data>,
        request: Request,
        idempotencyKey: String? = nil
    ) async throws -> VastuTypedResponse<Data> {
        let params = request.dictionary
        let raw: [String: Any]
        if Self.isGetOp(contract.operation.rawValue) {
            raw = try await client.get("\(Self.base)/\(contract.operation.rawValue)", queryParams: Self.stringifyParams(params), idempotencyKey: idempotencyKey)
        } else {
            raw = try await client.post("\(Self.base)/\(contract.operation.rawValue)", body: params, idempotencyKey: idempotencyKey)
        }
        return VastuTypedResponse(success: raw["success"] as? Bool ?? false, data: contract.decode(raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    /// Any Vastu operation by its path suffix under `/v2/astrology/vastu/`,
    /// e.g. `vastu("score/overall", params: ["rooms": rooms])`.
    ///
    /// The 11 tables under `reference/` (10 original +
    /// `reference/gate-obstructions`) are GET-only (a POST returns 405)
    /// and `direction/declination` is a GET+POST dual whose verified path
    /// is GET-with-query, so both dispatch GET (params become query
    /// string); everything else is POST. Mirrors
    /// `VASTU_GET_REFERENCE_ROUTES` + `VASTU_DUAL_ROUTE` in
    /// `rust/vedika-api-rust/crates/vedika-v2/src/vastu.rs`.
    @discardableResult
    public func vastu(_ op: String, params: [String: Any] = [:], idempotencyKey: String? = nil) async throws -> [String: Any] {
        let path = Self.stripLeadingSlash(op)
        if Self.isGetOp(path) {
            return try await client.get(
                "\(Self.base)/\(path)", queryParams: Self.stringifyParams(params), idempotencyKey: idempotencyKey
            )
        }
        return try await client.post("\(Self.base)/\(path)", body: params, idempotencyKey: idempotencyKey)
    }

    /// Closed, typed Vastu operation surface.
    public func vastuScansSave(_ request: VastuScansSaveRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuScansSaveData> {
        let raw = try await client.post("\(Self.base)/scans/save", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuScansSaveData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuScansRetrieve(_ request: VastuScansRetrieveRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuScansRetrieveData> {
        let raw = try await client.post("\(Self.base)/scans/retrieve", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuScansRetrieveData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuScansList(_ request: VastuScansListRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuScansListData> {
        let raw = try await client.post("\(Self.base)/scans/list", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuScansListData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuScansDelete(_ request: VastuScansDeleteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuScansDeleteData> {
        let raw = try await client.post("\(Self.base)/scans/delete", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuScansDeleteData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuScansTimelapse(_ request: VastuScansTimelapseRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuScansTimelapseData> {
        let raw = try await client.post("\(Self.base)/scans/timelapse", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuScansTimelapseData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuOperation(
        _ operation: VastuOperation,
        request: VastuOperationRequest = VastuOperationRequest(),
        idempotencyKey: String? = nil
    ) async throws -> VastuOperationResult {
        let params = request.dictionary
        let raw: [String: Any]
        if Self.isGetOp(operation.rawValue) {
            raw = try await client.get(
                "\(Self.base)/\(operation.rawValue)", queryParams: Self.stringifyParams(params), idempotencyKey: idempotencyKey
            )
        } else {
            raw = try await client.post("\(Self.base)/\(operation.rawValue)", body: params, idempotencyKey: idempotencyKey)
        }
        return VastuOperationResult(raw: raw)
    }

    /// A GET reference table, e.g. `reference/mandala/9-zone`,
    /// `reference/mandala/45-devatas`, `reference/directions/8`,
    /// `reference/defects/catalog`, `reference/remedies/catalog`,
    /// `reference/gate-obstructions`.
    @discardableResult
    public func vastuReference(_ table: String, idempotencyKey: String? = nil) async throws -> [String: Any] {
        try await client.get("\(Self.base)/\(Self.stripLeadingSlash(table))", idempotencyKey: idempotencyKey)
    }

    /// Project a mandala onto a plot. `scheme` is `9-zone`, `81-pada` or
    /// `brahmasthan`. Body: `{plotPolygon, bearingDeg}`.
    @discardableResult
    public func vastuMandalaProject(_ scheme: String, params: [String: Any], idempotencyKey: String? = nil) async throws
        -> [String: Any]
    {
        try await client.post(
            "\(Self.base)/mandala/project/\(Self.stripLeadingSlash(scheme))", body: params, idempotencyKey: idempotencyKey
        )
    }

    /// Door-pada classifier. Requires both `plotPolygon` and `doorXY`.
    public func vastuEntrancePada(_ request: VastuEntrancePadaRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuEntrancePadaData>
    {
        try await vastuOperation(VastuContracts.entrancePada, request: request, idempotencyKey: idempotencyKey)
    }

    /// Entrance recommendation for an exact facing value.
    public func vastuEntranceRecommend(_ request: VastuEntranceRecommendRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuEntranceRecommendData>
    {
        try await vastuOperation(VastuContracts.entranceRecommend, request: request, idempotencyKey: idempotencyKey)
    }

    /// Score the quality of an AR room scan.
    /// Counted room telemetry; the existing Boolean request remains available.
    public func vastuArScanQuality(_ request: VastuArCountedScanQualityRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuArScanQualityData> {
        try await vastuOperation(VastuContracts.arCountedScanQuality, request: request, idempotencyKey: idempotencyKey)
    }

    public func vastuArScanQuality(_ request: VastuArScanQualityRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuArScanQualityData>
    {
        try await vastuOperation(VastuContracts.arScanQuality, request: request, idempotencyKey: idempotencyKey)
    }

    /// Calibrate an AR heading against true north.
    public func vastuArTrueNorthCalibrate(_ request: VastuArTrueNorthCalibrateRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuArTrueNorthData>
    {
        try await vastuOperation(VastuContracts.arTrueNorthCalibrate, request: request, idempotencyKey: idempotencyKey)
    }

    /// Exact assessment operation. Valid insufficient-data responses have no billing object.
    public func vastuAssessments(_ request: VastuAssessmentsRequest, idempotencyKey: String? = nil) async throws
        -> VastuAssessmentsResponse
    {
        let raw = try await client.post(
            "\(Self.base)/\(VastuOperation.assessments.rawValue)", body: request.dictionary, idempotencyKey: idempotencyKey
        )
        return VastuAssessmentsResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuAssessmentData(raw: raw["data"] as? [String: Any] ?? [:]),
            raw: raw
        )
    }

    /// Each result carries its own status and billing. The batch has no separate fee.
    public func vastuAssessmentsBatch(_ request: VastuAssessmentsBatchRequest, idempotencyKey: String) async throws -> VastuAssessmentsBatchResponse {
        let raw = try await client.post(
            "\(Self.base)/\(VastuOperation.assessmentsBatch.rawValue)", body: request.dictionary, idempotencyKey: idempotencyKey
        )
        return VastuAssessmentsBatchResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuAssessmentBatchData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw
        )
    }

    /// Single-room placement, e.g. `vastuRoom("kitchen", params: ["zone": "southeast"])`.
    /// `roomType`: kitchen, bedroom, pooja, toilet, staircase, study, living,
    /// dining, store, water-storage.
    @discardableResult
    public func vastuRoom(_ roomType: String, params: [String: Any], idempotencyKey: String? = nil) async throws -> [String: Any]
    {
        try await client.post(
            "\(Self.base)/room/\(Self.stripLeadingSlash(roomType))", body: params, idempotencyKey: idempotencyKey
        )
    }

    /// Site placement, e.g. `vastuPlacement("borewell", params: ["zone": "north-east"])`.
    @discardableResult
    public func vastuPlacement(_ feature: String, params: [String: Any], idempotencyKey: String? = nil) async throws
        -> [String: Any]
    {
        try await client.post(
            "\(Self.base)/placement/\(Self.stripLeadingSlash(feature))", body: params, idempotencyKey: idempotencyKey
        )
    }

    /// Compliance audit. `kind`: `single-room`, `floor-plan`,
    /// `floor-plan-detailed`. Body: `{rooms: [...], plot?}`.
    @discardableResult
    public func vastuAudit(_ kind: String, params: [String: Any], idempotencyKey: String? = nil) async throws -> [String: Any] {
        try await client.post("\(Self.base)/audit/\(Self.stripLeadingSlash(kind))", body: params, idempotencyKey: idempotencyKey)
    }

    /// Vastu score. `kind`: `overall`, `zone-wise`, `compliance-index`.
    @discardableResult
    public func vastuScore(_ kind: String, params: [String: Any], idempotencyKey: String? = nil) async throws -> [String: Any] {
        try await client.post("\(Self.base)/score/\(Self.stripLeadingSlash(kind))", body: params, idempotencyKey: idempotencyKey)
    }

    /// Generate up to 3 ranked floor plans from a plot + room programme.
    public func vastuPlanGenerate(_ request: VastuPlanGenerateRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuPlanGenerateData>
    {
        try await vastuOperation(VastuContracts.planGenerate, request: request, idempotencyKey: idempotencyKey)
    }

    /// Generate a floor plan from a high-level brief (BHK, bathrooms, parking...).
    public func vastuPlanFromRequirements(_ request: VastuPlanFromRequirementsRequest, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuPlanGenerateData>
    {
        try await vastuOperation(VastuContracts.planFromRequirements, request: request, idempotencyKey: idempotencyKey)
    }

    /// Magnetic declination (true-north correction) for a location. India grid.
    public func vastuDeclination(lat: Double, lon: Double, date: String? = nil, idempotencyKey: String? = nil) async throws
        -> VastuTypedResponse<VastuDirectionDeclinationData>
    {
        try await vastuOperation(
            VastuContracts.directionDeclination,
            request: VastuDirectionDeclinationRequest(lat: lat, lon: lon, date: date), idempotencyKey: idempotencyKey
        )
    }

    private static func isGetOp(_ path: String) -> Bool {
        path.hasPrefix("reference/") || path == "direction/declination"
    }

    /// Query params are stringified for GET; `nil`/`NSNull` values are
    /// dropped rather than sent as the literal string "null".
    private static func stringifyParams(_ params: [String: Any]) -> [String: String] {
        var result: [String: String] = [:]
        for (key, value) in params {
            if value is NSNull { continue }
            result[key] = "\(value)"
        }
        return result
    }

    /// Strips ALL leading slashes so `vastu("/score/overall", …)` and
    /// `vastu("score/overall", …)` both work.
    private static func stripLeadingSlash(_ s: String) -> String {
        var result = Substring(s)
        while result.hasPrefix("/") {
            result.removeFirst()
        }
        return String(result)
    }
}

public struct VastuScanResponse<Data: VastuData> {
    public let success: Bool
    public let data: Data
    public let raw: [String: Any]
    public var billing: [String: Any]? { raw["billing"] as? [String: Any] }
    public var meta: [String: Any]? { raw["meta"] as? [String: Any] }
}
