import Foundation

public enum VastuOperation: String, CaseIterable, Sendable {
    case remediationTasksUpsert = "remediation/tasks/upsert"
    case remediationTasksList = "remediation/tasks/list"
    case remediationTasksDelete = "remediation/tasks/delete"
    case remediationReassess = "remediation/reassess"
    case merchantCatalogUpload = "merchant/catalog/upload"
    case merchantCatalogGet = "merchant/catalog/get"
    case merchantCatalogDelete = "merchant/catalog/delete"
    case merchantRemedies = "merchant/remedies"
    case portfolioSearch = "portfolio/search"
    case portfolioCompare = "portfolio/compare"
    case portfolioAnalytics = "portfolio/analytics"
    case portfolioUsage = "portfolio/usage"
    case portfolioUsageExport = "portfolio/usage/export"
    case portfolioBudgetsSet = "portfolio/budgets/set"
    case portfolioBudgetsGet = "portfolio/budgets/get"
    case drawingSheet = "report/drawing-sheet"
    case propertiesCreate = "properties/create"
    case propertiesUpdate = "properties/update"
    case propertiesCollaborationGet = "properties/collaboration/get"
    case propertiesCollaborationInvite = "properties/collaboration/invite"
    case propertiesCollaborationRevoke = "properties/collaboration/revoke"
    case propertiesCollaborationMembers = "properties/collaboration/members"
    case propertiesCollaborationComment = "properties/collaboration/comment"
    case propertiesCollaborationReview = "properties/collaboration/review"
    case propertiesCollaborationUpdate = "properties/collaboration/update"
    case propertiesActivityList = "properties/activity/list"
    case propertiesActivityExport = "properties/activity/export"
    case propertiesGet = "properties/get"
    case propertiesList = "properties/list"
    case propertiesDelete = "properties/delete"
    case propertiesLinkScan = "properties/link-scan"
    case archiveTier = "archive/tier"
    case archiveExport = "archive/export"
    case archiveDelete = "archive/delete"
    case archiveSummary = "archive/summary"
    case feedListings = "feed/listings"
    case quoteCalculate = "quote/calculate"

    case scansTimelapse = "scans/timelapse"
    case scansDelete = "scans/delete"
    case scansList = "scans/list"
    case scansRetrieve = "scans/retrieve"
    case scansSave = "scans/save"
    case arDeityIcons = "ar/deity-icons"
    case arCaptureMerge = "ar/capture-merge"
    case plotFromSurvey = "plot/from-survey"
    case arRoomCapture = "ar/room-capture"
    case arAttestationChallenge = "ar/attestation/challenge"
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
    case planCompareVersions = "plan/compare-versions"
    case receiptVerify = "receipt/verify"
    case rulesVersions = "rules/versions"
    case planAnalyze = "plan/analyze"
    case planImportDxf = "plan/import-dxf"
    case planExportDxf = "plan/export-dxf"
    case planExportIfc = "plan/export-ifc"
    case planConvertUnits = "plan/convert-units"
    case planImportIfc = "plan/import-ifc"
    case planImportImage = "plan/import-image"
    case planImportPdf = "plan/import-pdf"
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
    case jobs = "jobs"
    case jobsId = "jobs/{id}"
    case jobsIdResults = "jobs/{id}/results"
    case jobsIdCancel = "jobs/{id}/cancel"
}

public struct VastuDrawingSheetRequestTitleBlock: VastuRequest {
    public var project: String
    public var architect: String
    public var drawingNumber: String?
    public var revision: String?
    public var date: String?
    public init(project: String, architect: String, drawingNumber: String? = nil, revision: String? = nil, date: String? = nil) { self.project = project; self.architect = architect; self.drawingNumber = drawingNumber; self.revision = revision; self.date = date }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = project as Any? { result["project"] = encodeVastu(value) }
        if let value = architect as Any? { result["architect"] = encodeVastu(value) }
        if let value = drawingNumber as Any? { result["drawingNumber"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDrawingSheetRequestFieldEvidenceItem: VastuRequest {
    public var label: String
    public var note: String?
    public var roomId: String?
    public var imageDataUrl: String?
    public init(label: String, note: String? = nil, roomId: String? = nil, imageDataUrl: String? = nil) { self.label = label; self.note = note; self.roomId = roomId; self.imageDataUrl = imageDataUrl }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = note as Any? { result["note"] = encodeVastu(value) }
        if let value = roomId as Any? { result["roomId"] = encodeVastu(value) }
        if let value = imageDataUrl as Any? { result["imageDataUrl"] = encodeVastu(value) }
        return result
    }
}

public struct VastuDrawingSheetRequest: VastuRequest {
    public var plan: [String: Any]
    public var titleBlock: VastuDrawingSheetRequestTitleBlock
    public var paperSize: String?
    public var scaleDenominator: Int?
    public var format: String?
    public var zoneOverlay: Bool?
    public var dimensions: Bool?
    public var fieldEvidence: [VastuDrawingSheetRequestFieldEvidenceItem]?
    public init(plan: [String: Any], titleBlock: VastuDrawingSheetRequestTitleBlock, paperSize: String? = nil, scaleDenominator: Int? = nil, format: String? = nil, zoneOverlay: Bool? = nil, dimensions: Bool? = nil, fieldEvidence: [VastuDrawingSheetRequestFieldEvidenceItem]? = nil) { self.plan = plan; self.titleBlock = titleBlock; self.paperSize = paperSize; self.scaleDenominator = scaleDenominator; self.format = format; self.zoneOverlay = zoneOverlay; self.dimensions = dimensions; self.fieldEvidence = fieldEvidence }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plan as Any? { result["plan"] = encodeVastu(value) }
        if let value = titleBlock as Any? { result["titleBlock"] = encodeVastu(value) }
        if let value = paperSize as Any? { result["paperSize"] = encodeVastu(value) }
        if let value = scaleDenominator as Any? { result["scaleDenominator"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        if let value = zoneOverlay as Any? { result["zoneOverlay"] = encodeVastu(value) }
        if let value = dimensions as Any? { result["dimensions"] = encodeVastu(value) }
        if let value = fieldEvidence as Any? { result["fieldEvidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuWorkspaceRequestDrawingTitleBlock: VastuRequest {
    public var project: String
    public var architect: String
    public var drawingNumber: String?
    public var revision: String?
    public var date: String?
    public init(project: String, architect: String, drawingNumber: String? = nil, revision: String? = nil, date: String? = nil) { self.project = project; self.architect = architect; self.drawingNumber = drawingNumber; self.revision = revision; self.date = date }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = project as Any? { result["project"] = encodeVastu(value) }
        if let value = architect as Any? { result["architect"] = encodeVastu(value) }
        if let value = drawingNumber as Any? { result["drawingNumber"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        return result
    }
}

public struct VastuWorkspaceRequestDrawingFieldEvidenceItem: VastuRequest {
    public var label: String
    public var note: String?
    public var roomId: String?
    public var imageDataUrl: String?
    public init(label: String, note: String? = nil, roomId: String? = nil, imageDataUrl: String? = nil) { self.label = label; self.note = note; self.roomId = roomId; self.imageDataUrl = imageDataUrl }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = note as Any? { result["note"] = encodeVastu(value) }
        if let value = roomId as Any? { result["roomId"] = encodeVastu(value) }
        if let value = imageDataUrl as Any? { result["imageDataUrl"] = encodeVastu(value) }
        return result
    }
}

public struct VastuWorkspaceRequestDrawing: VastuRequest {
    public var plan: [String: Any]
    public var titleBlock: VastuWorkspaceRequestDrawingTitleBlock
    public var paperSize: String?
    public var scaleDenominator: Int?
    public var format: String?
    public var zoneOverlay: Bool?
    public var dimensions: Bool?
    public var fieldEvidence: [VastuWorkspaceRequestDrawingFieldEvidenceItem]?
    public init(plan: [String: Any], titleBlock: VastuWorkspaceRequestDrawingTitleBlock, paperSize: String? = nil, scaleDenominator: Int? = nil, format: String? = nil, zoneOverlay: Bool? = nil, dimensions: Bool? = nil, fieldEvidence: [VastuWorkspaceRequestDrawingFieldEvidenceItem]? = nil) { self.plan = plan; self.titleBlock = titleBlock; self.paperSize = paperSize; self.scaleDenominator = scaleDenominator; self.format = format; self.zoneOverlay = zoneOverlay; self.dimensions = dimensions; self.fieldEvidence = fieldEvidence }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plan as Any? { result["plan"] = encodeVastu(value) }
        if let value = titleBlock as Any? { result["titleBlock"] = encodeVastu(value) }
        if let value = paperSize as Any? { result["paperSize"] = encodeVastu(value) }
        if let value = scaleDenominator as Any? { result["scaleDenominator"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        if let value = zoneOverlay as Any? { result["zoneOverlay"] = encodeVastu(value) }
        if let value = dimensions as Any? { result["dimensions"] = encodeVastu(value) }
        if let value = fieldEvidence as Any? { result["fieldEvidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuWorkspaceRequest: VastuRequest {
    public var propertyId: String?
    public var jobId: String?
    public var idempotencyKey: String?
    public var title: String?
    public var input: [String: Any]?
    public var outcome: String?
    public var webhookSecret: String?
    public var drawing: VastuWorkspaceRequestDrawing?
    public init(propertyId: String? = nil, jobId: String? = nil, idempotencyKey: String? = nil, title: String? = nil, input: [String: Any]? = nil, outcome: String? = nil, webhookSecret: String? = nil, drawing: VastuWorkspaceRequestDrawing? = nil) { self.propertyId = propertyId; self.jobId = jobId; self.idempotencyKey = idempotencyKey; self.title = title; self.input = input; self.outcome = outcome; self.webhookSecret = webhookSecret; self.drawing = drawing }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = jobId as Any? { result["jobId"] = encodeVastu(value) }
        if let value = idempotencyKey as Any? { result["idempotencyKey"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = input as Any? { result["input"] = encodeVastu(value) }
        if let value = outcome as Any? { result["outcome"] = encodeVastu(value) }
        if let value = webhookSecret as Any? { result["webhookSecret"] = encodeVastu(value) }
        if let value = drawing as Any? { result["drawing"] = encodeVastu(value) }
        return result
    }
}

public enum VastuWorkspaceOperation: String { case properties, jobs, get, list, reset, webhook, report }
public struct VastuPropertiesCreateRequestIds: VastuRequest {
    public var project: String
    public var building: String
    public var unit: String
    public var floor: String
    public var revision: String
    public init(project: String, building: String, unit: String, floor: String, revision: String) { self.project = project; self.building = building; self.unit = unit; self.floor = floor; self.revision = revision }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = project as Any? { result["project"] = encodeVastu(value) }
        if let value = building as Any? { result["building"] = encodeVastu(value) }
        if let value = unit as Any? { result["unit"] = encodeVastu(value) }
        if let value = floor as Any? { result["floor"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCreateRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String?
    public var ids: VastuPropertiesCreateRequestIds
    public var title: String
    public var data: [String: Any]
    public var retentionDays: Int
    public var linkedScanIds: [String]?
    public var linkedAssessmentIds: [String]?
    public var externalId: String?
    public init(propertyId: String? = nil, ids: VastuPropertiesCreateRequestIds, title: String, data: [String: Any], retentionDays: Int, linkedScanIds: [String]? = nil, linkedAssessmentIds: [String]? = nil, externalId: String? = nil, tenantRef: String? = nil) { self.propertyId = propertyId; self.ids = ids; self.title = title; self.data = data; self.retentionDays = retentionDays; self.linkedScanIds = linkedScanIds; self.linkedAssessmentIds = linkedAssessmentIds; self.externalId = externalId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ids as Any? { result["ids"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = data as Any? { result["data"] = encodeVastu(value) }
        if let value = retentionDays as Any? { result["retentionDays"] = encodeVastu(value) }
        if let value = linkedScanIds as Any? { result["linkedScanIds"] = encodeVastu(value) }
        if let value = linkedAssessmentIds as Any? { result["linkedAssessmentIds"] = encodeVastu(value) }
        if let value = externalId as Any? { result["externalId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPropertiesUpdateRequestIds: VastuRequest {
    public var project: String
    public var building: String
    public var unit: String
    public var floor: String
    public var revision: String
    public init(project: String, building: String, unit: String, floor: String, revision: String) { self.project = project; self.building = building; self.unit = unit; self.floor = floor; self.revision = revision }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = project as Any? { result["project"] = encodeVastu(value) }
        if let value = building as Any? { result["building"] = encodeVastu(value) }
        if let value = unit as Any? { result["unit"] = encodeVastu(value) }
        if let value = floor as Any? { result["floor"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesUpdateRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public var ids: VastuPropertiesUpdateRequestIds
    public var title: String
    public var data: [String: Any]
    public var retentionDays: Int
    public var linkedScanIds: [String]?
    public var linkedAssessmentIds: [String]?
    public var externalId: String?
    public init(propertyId: String, ids: VastuPropertiesUpdateRequestIds, title: String, data: [String: Any], retentionDays: Int, linkedScanIds: [String]? = nil, linkedAssessmentIds: [String]? = nil, externalId: String? = nil, tenantRef: String? = nil) { self.propertyId = propertyId; self.ids = ids; self.title = title; self.data = data; self.retentionDays = retentionDays; self.linkedScanIds = linkedScanIds; self.linkedAssessmentIds = linkedAssessmentIds; self.externalId = externalId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ids as Any? { result["ids"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = data as Any? { result["data"] = encodeVastu(value) }
        if let value = retentionDays as Any? { result["retentionDays"] = encodeVastu(value) }
        if let value = linkedScanIds as Any? { result["linkedScanIds"] = encodeVastu(value) }
        if let value = linkedAssessmentIds as Any? { result["linkedAssessmentIds"] = encodeVastu(value) }
        if let value = externalId as Any? { result["externalId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPropertiesCollaborationGetRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public init(propertyId: String, ownerId: String? = nil) { self.propertyId = propertyId; self.ownerId = ownerId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationInviteRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var accountId: String?
    public var email: String?
    public var role: String
    public var accept: Bool?
    public init(propertyId: String, ownerId: String? = nil, accountId: String? = nil, email: String? = nil, role: String, accept: Bool? = nil) { self.propertyId = propertyId; self.ownerId = ownerId; self.accountId = accountId; self.email = email; self.role = role; self.accept = accept }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = accountId as Any? { result["accountId"] = encodeVastu(value) }
        if let value = email as Any? { result["email"] = encodeVastu(value) }
        if let value = role as Any? { result["role"] = encodeVastu(value) }
        if let value = accept as Any? { result["accept"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationRevokeRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var accountId: String?
    public var invitationId: String?
    public init(propertyId: String, ownerId: String? = nil, accountId: String? = nil, invitationId: String? = nil) { self.propertyId = propertyId; self.ownerId = ownerId; self.accountId = accountId; self.invitationId = invitationId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = accountId as Any? { result["accountId"] = encodeVastu(value) }
        if let value = invitationId as Any? { result["invitationId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationMembersRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public init(propertyId: String, ownerId: String? = nil) { self.propertyId = propertyId; self.ownerId = ownerId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationCommentRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var assessmentId: String
    public var revision: String
    public var expectedContentHash: String
    public var text: String
    public init(propertyId: String, ownerId: String? = nil, assessmentId: String, revision: String, expectedContentHash: String, text: String) { self.propertyId = propertyId; self.ownerId = ownerId; self.assessmentId = assessmentId; self.revision = revision; self.expectedContentHash = expectedContentHash; self.text = text }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = assessmentId as Any? { result["assessmentId"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = expectedContentHash as Any? { result["expectedContentHash"] = encodeVastu(value) }
        if let value = text as Any? { result["text"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationReviewRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var assessmentId: String
    public var revision: String
    public var expectedContentHash: String
    public var decision: String
    public init(propertyId: String, ownerId: String? = nil, assessmentId: String, revision: String, expectedContentHash: String, decision: String) { self.propertyId = propertyId; self.ownerId = ownerId; self.assessmentId = assessmentId; self.revision = revision; self.expectedContentHash = expectedContentHash; self.decision = decision }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = assessmentId as Any? { result["assessmentId"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = expectedContentHash as Any? { result["expectedContentHash"] = encodeVastu(value) }
        if let value = decision as Any? { result["decision"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesCollaborationUpdateRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var revision: String
    public var expectedContentHash: String
    public var title: String
    public var data: [String: Any]
    public init(propertyId: String, ownerId: String? = nil, revision: String, expectedContentHash: String, title: String, data: [String: Any]) { self.propertyId = propertyId; self.ownerId = ownerId; self.revision = revision; self.expectedContentHash = expectedContentHash; self.title = title; self.data = data }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = expectedContentHash as Any? { result["expectedContentHash"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = data as Any? { result["data"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesActivityListRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var cursor: Int?
    public var limit: Int?
    public init(propertyId: String, ownerId: String? = nil, cursor: Int? = nil, limit: Int? = nil) { self.propertyId = propertyId; self.ownerId = ownerId; self.cursor = cursor; self.limit = limit }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = cursor as Any? { result["cursor"] = encodeVastu(value) }
        if let value = limit as Any? { result["limit"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesActivityExportRequest: VastuRequest {
    public var propertyId: String
    public var ownerId: String?
    public var cursor: Int?
    public var limit: Int?
    public init(propertyId: String, ownerId: String? = nil, cursor: Int? = nil, limit: Int? = nil) { self.propertyId = propertyId; self.ownerId = ownerId; self.cursor = cursor; self.limit = limit }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = ownerId as Any? { result["ownerId"] = encodeVastu(value) }
        if let value = cursor as Any? { result["cursor"] = encodeVastu(value) }
        if let value = limit as Any? { result["limit"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPropertiesGetRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public init(propertyId: String, tenantRef: String? = nil) { self.propertyId = propertyId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPropertiesListRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var limit: Int?
    public var cursor: String?
    public init(limit: Int? = nil, cursor: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.limit = limit; self.cursor = cursor ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = limit as Any? { result["limit"] = encodeVastu(value) }
        if let value = cursor as Any? { result["cursor"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPropertiesDeleteRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public init(propertyId: String, tenantRef: String? = nil) { self.propertyId = propertyId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPropertiesLinkScanRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public var addScanIds: [String]?
    public var addAssessmentIds: [String]?
    public var replace: Bool?
    public init(propertyId: String, addScanIds: [String]? = nil, addAssessmentIds: [String]? = nil, replace: Bool? = nil, tenantRef: String? = nil) { self.propertyId = propertyId; self.addScanIds = addScanIds; self.addAssessmentIds = addAssessmentIds; self.replace = replace ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = addScanIds as Any? { result["addScanIds"] = encodeVastu(value) }
        if let value = addAssessmentIds as Any? { result["addAssessmentIds"] = encodeVastu(value) }
        if let value = replace as Any? { result["replace"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArchiveTierRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public var months: Int
    public var preview: Bool?
    public init(propertyId: String, months: Int, preview: Bool? = nil, tenantRef: String? = nil) { self.propertyId = propertyId; self.months = months; self.preview = preview ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = months as Any? { result["months"] = encodeVastu(value) }
        if let value = preview as Any? { result["preview"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArchiveExportRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public init(propertyId: String, tenantRef: String? = nil) { self.propertyId = propertyId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArchiveDeleteRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public var confirmPropertyId: String
    public init(propertyId: String, confirmPropertyId: String, tenantRef: String? = nil) { self.propertyId = propertyId; self.confirmPropertyId = confirmPropertyId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = confirmPropertyId as Any? { result["confirmPropertyId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArchiveSummaryRequest: VastuRequest {
    public var tenantRef: String?

    public var propertyId: String
    public init(propertyId: String, tenantRef: String? = nil) { self.propertyId = propertyId ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuFeedListingsRequestRowsItemPlanAsset: VastuRequest {
    public var kind: String
    public var value: String
    public init(kind: String, value: String) { self.kind = kind; self.value = value }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = kind as Any? { result["kind"] = encodeVastu(value) }
        if let value = value as Any? { result["value"] = encodeVastu(value) }
        return result
    }
}

public struct VastuFeedListingsRequestRowsItem: VastuRequest {
    public var externalId: String
    public var revision: String
    public var project: String
    public var building: String
    public var unit: String
    public var floor: String
    public var title: String
    public var address: String?
    public var city: String?
    public var bearingDeg: Double?
    public var planAsset: VastuFeedListingsRequestRowsItemPlanAsset?
    public var retentionDays: Int?
    public init(externalId: String, revision: String, project: String, building: String, unit: String, floor: String, title: String, address: String? = nil, city: String? = nil, bearingDeg: Double? = nil, planAsset: VastuFeedListingsRequestRowsItemPlanAsset? = nil, retentionDays: Int? = nil) { self.externalId = externalId; self.revision = revision; self.project = project; self.building = building; self.unit = unit; self.floor = floor; self.title = title; self.address = address; self.city = city; self.bearingDeg = bearingDeg; self.planAsset = planAsset; self.retentionDays = retentionDays }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = externalId as Any? { result["externalId"] = encodeVastu(value) }
        if let value = revision as Any? { result["revision"] = encodeVastu(value) }
        if let value = project as Any? { result["project"] = encodeVastu(value) }
        if let value = building as Any? { result["building"] = encodeVastu(value) }
        if let value = unit as Any? { result["unit"] = encodeVastu(value) }
        if let value = floor as Any? { result["floor"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = address as Any? { result["address"] = encodeVastu(value) }
        if let value = city as Any? { result["city"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = planAsset as Any? { result["planAsset"] = encodeVastu(value) }
        if let value = retentionDays as Any? { result["retentionDays"] = encodeVastu(value) }
        return result
    }
}

public struct VastuFeedListingsRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var csv: String?
    public var rows: [VastuFeedListingsRequestRowsItem]?
    public var dryRun: Bool?
    public var skipDuplicates: Bool?
    public init(csv: String? = nil, rows: [VastuFeedListingsRequestRowsItem]? = nil, dryRun: Bool? = nil, skipDuplicates: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.csv = csv; self.rows = rows; self.dryRun = dryRun; self.skipDuplicates = skipDuplicates ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = csv as Any? { result["csv"] = encodeVastu(value) }
        if let value = rows as Any? { result["rows"] = encodeVastu(value) }
        if let value = dryRun as Any? { result["dryRun"] = encodeVastu(value) }
        if let value = skipDuplicates as Any? { result["skipDuplicates"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuQuoteCalculateRequestOperationsItem: VastuRequest {
    public var op: String
    public var quantity: Int?
    public var label: String?
    public init(op: String, quantity: Int? = nil, label: String? = nil) { self.op = op; self.quantity = quantity; self.label = label }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = op as Any? { result["op"] = encodeVastu(value) }
        if let value = quantity as Any? { result["quantity"] = encodeVastu(value) }
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        return result
    }
}

public struct VastuQuoteCalculateRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var workflowId: String?
    public var operations: [VastuQuoteCalculateRequestOperationsItem]?
    public var retentionMonths: Int?
    public var retentionStoredBytes: Int?
    public init(workflowId: String? = nil, operations: [VastuQuoteCalculateRequestOperationsItem]? = nil, retentionMonths: Int? = nil, retentionStoredBytes: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.workflowId = workflowId; self.operations = operations; self.retentionMonths = retentionMonths; self.retentionStoredBytes = retentionStoredBytes ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = workflowId as Any? { result["workflowId"] = encodeVastu(value) }
        if let value = operations as Any? { result["operations"] = encodeVastu(value) }
        if let value = retentionMonths as Any? { result["retentionMonths"] = encodeVastu(value) }
        if let value = retentionStoredBytes as Any? { result["retentionStoredBytes"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRemediationTasksUpsertRequestTaskEvidenceItem: VastuRequest {
    public var reference: String
    public var photoRef: String?
    public var note: String?
    public init(reference: String, photoRef: String? = nil, note: String? = nil) { self.reference = reference; self.photoRef = photoRef; self.note = note }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = reference as Any? { result["reference"] = encodeVastu(value) }
        if let value = photoRef as Any? { result["photoRef"] = encodeVastu(value) }
        if let value = note as Any? { result["note"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationTasksUpsertRequestTask: VastuRequest {
    public var taskId: String
    public var reportRef: String
    public var findingRef: String
    public var remedyKey: String
    public var title: String
    public var status: String
    public var assignee: String?
    public var dueDate: String?
    public var evidence: [VastuRemediationTasksUpsertRequestTaskEvidenceItem]?
    public init(taskId: String, reportRef: String, findingRef: String, remedyKey: String, title: String, status: String, assignee: String? = nil, dueDate: String? = nil, evidence: [VastuRemediationTasksUpsertRequestTaskEvidenceItem]? = nil) { self.taskId = taskId; self.reportRef = reportRef; self.findingRef = findingRef; self.remedyKey = remedyKey; self.title = title; self.status = status; self.assignee = assignee; self.dueDate = dueDate; self.evidence = evidence }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = taskId as Any? { result["taskId"] = encodeVastu(value) }
        if let value = reportRef as Any? { result["reportRef"] = encodeVastu(value) }
        if let value = findingRef as Any? { result["findingRef"] = encodeVastu(value) }
        if let value = remedyKey as Any? { result["remedyKey"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = status as Any? { result["status"] = encodeVastu(value) }
        if let value = assignee as Any? { result["assignee"] = encodeVastu(value) }
        if let value = dueDate as Any? { result["dueDate"] = encodeVastu(value) }
        if let value = evidence as Any? { result["evidence"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationTasksUpsertRequest: VastuRequest {
    public var expectedRevision: Int
    public var mutationId: String
    public var propertyId: String
    public var task: VastuRemediationTasksUpsertRequestTask
    public init(expectedRevision: Int, mutationId: String, propertyId: String, task: VastuRemediationTasksUpsertRequestTask) { self.expectedRevision = expectedRevision; self.mutationId = mutationId; self.propertyId = propertyId; self.task = task }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = expectedRevision as Any? { result["expectedRevision"] = encodeVastu(value) }
        if let value = mutationId as Any? { result["mutationId"] = encodeVastu(value) }
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = task as Any? { result["task"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationTasksListRequest: VastuRequest {
    public var propertyId: String
    public init(propertyId: String) { self.propertyId = propertyId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationTasksDeleteRequest: VastuRequest {
    public var id: String
    public var confirmId: String
    public init(id: String, confirmId: String) { self.id = id; self.confirmId = confirmId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = confirmId as Any? { result["confirmId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationReassessRequestPlanRoomsItem: VastuRequest {
    public var name: String?
    public var room: String?
    public var roomType: String?
    public var label: String?
    public var zone: String?
    public var direction: String?
    public var x: Double?
    public var y: Double?
    public var w: Double?
    public var h: Double?
    public var width: Double?
    public var height: Double?
    public var polygon: [Any]?
    public var outline: [Any]?
    public var area: Double?
    public var headingErrorDeg: Double?
    public var positionErrorM: Double?
    public init(name: String? = nil, room: String? = nil, roomType: String? = nil, label: String? = nil, zone: String? = nil, direction: String? = nil, x: Double? = nil, y: Double? = nil, w: Double? = nil, h: Double? = nil, width: Double? = nil, height: Double? = nil, polygon: [Any]? = nil, outline: [Any]? = nil, area: Double? = nil, headingErrorDeg: Double? = nil, positionErrorM: Double? = nil) { self.name = name; self.room = room; self.roomType = roomType; self.label = label; self.zone = zone; self.direction = direction; self.x = x; self.y = y; self.w = w; self.h = h; self.width = width; self.height = height; self.polygon = polygon; self.outline = outline; self.area = area; self.headingErrorDeg = headingErrorDeg; self.positionErrorM = positionErrorM }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = room as Any? { result["room"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = x as Any? { result["x"] = encodeVastu(value) }
        if let value = y as Any? { result["y"] = encodeVastu(value) }
        if let value = w as Any? { result["w"] = encodeVastu(value) }
        if let value = h as Any? { result["h"] = encodeVastu(value) }
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let value = height as Any? { result["height"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = outline as Any? { result["outline"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        if let value = headingErrorDeg as Any? { result["headingErrorDeg"] = encodeVastu(value) }
        if let value = positionErrorM as Any? { result["positionErrorM"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationReassessRequestPlanImportReview: VastuRequest {
    public var northKnown: Bool
    public var scaleKnown: Bool
    public var analysisReady: Bool
    public var coordinateFrame: String
    public var units: String
    public init(northKnown: Bool, scaleKnown: Bool, analysisReady: Bool, coordinateFrame: String, units: String) { self.northKnown = northKnown; self.scaleKnown = scaleKnown; self.analysisReady = analysisReady; self.coordinateFrame = coordinateFrame; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = northKnown as Any? { result["northKnown"] = encodeVastu(value) }
        if let value = scaleKnown as Any? { result["scaleKnown"] = encodeVastu(value) }
        if let value = analysisReady as Any? { result["analysisReady"] = encodeVastu(value) }
        if let value = coordinateFrame as Any? { result["coordinateFrame"] = encodeVastu(value) }
        if let value = units as Any? { result["units"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationReassessRequestPlan: VastuRequest {
    public var rooms: [VastuRemediationReassessRequestPlanRoomsItem]
    public var plot: [String: Any]?
    public var zoneResolution: Int?
    public var headingErrorDeg: Double?
    public var positionErrorM: Double?
    public var importReview: VastuRemediationReassessRequestPlanImportReview?
    public var merchantCatalogId: String?
    public init(rooms: [VastuRemediationReassessRequestPlanRoomsItem], plot: [String: Any]? = nil, zoneResolution: Int? = nil, headingErrorDeg: Double? = nil, positionErrorM: Double? = nil, importReview: VastuRemediationReassessRequestPlanImportReview? = nil, merchantCatalogId: String? = nil) { self.rooms = rooms; self.plot = plot; self.zoneResolution = zoneResolution; self.headingErrorDeg = headingErrorDeg; self.positionErrorM = positionErrorM; self.importReview = importReview; self.merchantCatalogId = merchantCatalogId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = zoneResolution as Any? { result["zoneResolution"] = encodeVastu(value) }
        if let value = headingErrorDeg as Any? { result["headingErrorDeg"] = encodeVastu(value) }
        if let value = positionErrorM as Any? { result["positionErrorM"] = encodeVastu(value) }
        if let value = importReview as Any? { result["importReview"] = encodeVastu(value) }
        if let value = merchantCatalogId as Any? { result["merchantCatalogId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuRemediationReassessRequest: VastuRequest {
    public var expectedRevision: Int
    public var mutationId: String
    public var propertyId: String
    public var taskId: String
    public var plan: VastuRemediationReassessRequestPlan
    public init(expectedRevision: Int, mutationId: String, propertyId: String, taskId: String, plan: VastuRemediationReassessRequestPlan) { self.expectedRevision = expectedRevision; self.mutationId = mutationId; self.propertyId = propertyId; self.taskId = taskId; self.plan = plan }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = expectedRevision as Any? { result["expectedRevision"] = encodeVastu(value) }
        if let value = mutationId as Any? { result["mutationId"] = encodeVastu(value) }
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = taskId as Any? { result["taskId"] = encodeVastu(value) }
        if let value = plan as Any? { result["plan"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMerchantCatalogUploadRequest: VastuRequest {
    public var expectedRevision: Int
    public var mutationId: String
    public var catalogId: String
    public var format: String
    public var content: Any
    public init(expectedRevision: Int, mutationId: String, catalogId: String, format: String, content: Any) { self.expectedRevision = expectedRevision; self.mutationId = mutationId; self.catalogId = catalogId; self.format = format; self.content = content }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = expectedRevision as Any? { result["expectedRevision"] = encodeVastu(value) }
        if let value = mutationId as Any? { result["mutationId"] = encodeVastu(value) }
        if let value = catalogId as Any? { result["catalogId"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        if let value = content as Any? { result["content"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMerchantCatalogGetRequest: VastuRequest {
    public var catalogId: String
    public init(catalogId: String) { self.catalogId = catalogId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = catalogId as Any? { result["catalogId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMerchantCatalogDeleteRequest: VastuRequest {
    public var id: String
    public var confirmId: String
    public init(id: String, confirmId: String) { self.id = id; self.confirmId = confirmId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = confirmId as Any? { result["confirmId"] = encodeVastu(value) }
        return result
    }
}

public struct VastuMerchantRemediesRequest: VastuRequest {
    public var catalogId: String
    public var remedyKeys: [String]
    public init(catalogId: String, remedyKeys: [String]) { self.catalogId = catalogId; self.remedyKeys = remedyKeys }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = catalogId as Any? { result["catalogId"] = encodeVastu(value) }
        if let value = remedyKeys as Any? { result["remedyKeys"] = encodeVastu(value) }
        return result
    }
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
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil

    public var roomType: String
    public var zone: String
    public init(roomType: String, zone: String) { self.roomType = roomType; self.zone = zone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = encodeVastu(v) }
        if let v = positionErrorM { result["positionErrorM"] = encodeVastu(v) }
        return result
    }
}

public struct VastuArHeatmapRasterRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var rooms: [VastuArHeatmapRasterRequestRoomsItem]
    public var plotPolygon: [[Double]]?
    public var bearingDeg: Double?
    public init(rooms: [VastuArHeatmapRasterRequestRoomsItem], plotPolygon: [[Double]]? = nil, bearingDeg: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var plotPolygon: [[Double]]
    public var bearingDeg: Double
    public var planToWorld: VastuArPlanToWorld
    public init(plotPolygon: [[Double]], bearingDeg: Double, planToWorld: VastuArPlanToWorld, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.planToWorld = planToWorld ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = planToWorld as Any? { result["planToWorld"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArZoneTexturesRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var zone: String?
    public init(zone: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArYantraMeshesRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var model: String
    public var format: String?
    public init(model: String, format: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.model = model; self.format = format ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = model as Any? { result["model"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArDeityIconsRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var zone: String?
    public init(zone: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var polygon: [[Double]]
    public var source: String
    public init(polygon: [[Double]], source: String = "traced", holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.polygon = polygon; self.source = source }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil

    public var id: String
    public var label: String?
    public var labelSource: String
    public var polygon: [[Double]]
    public var areaM2: Double
    public var floorIndex: Int
    public var heightM: Double?
    public var openings: [VastuRoomCaptureRoomsItemOpeningsItem]?
    public init(id: String, label: String?, labelSource: String, polygon: [[Double]], areaM2: Double, floorIndex: Int, heightM: Double? = nil, openings: [VastuRoomCaptureRoomsItemOpeningsItem]? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.id = id; self.label = label; self.labelSource = labelSource; self.polygon = polygon; self.areaM2 = areaM2; self.floorIndex = floorIndex; self.heightM = heightM; self.openings = openings }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = labelSource as Any? { result["labelSource"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = areaM2 as Any? { result["areaM2"] = encodeVastu(value) }
        if let value = heightM as Any? { result["heightM"] = encodeVastu(value) }
        if let value = floorIndex as Any? { result["floorIndex"] = encodeVastu(value) }
        if let value = openings as Any? { result["openings"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = encodeVastu(v) }
        if let v = positionErrorM { result["positionErrorM"] = encodeVastu(v) }
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

/// Optional native-app device attestation proof; see `VastuOperation.arAttestationChallenge`.
public struct VastuDeviceAttestation: VastuRequest {
    public var platform: String
    public var challenge: String
    public var keyId: String?
    public var attestationObject: String?
    public var assertion: String?
    public var integrityToken: String?
    public init(platform: String, challenge: String, keyId: String? = nil, attestationObject: String? = nil, assertion: String? = nil, integrityToken: String? = nil) { self.platform = platform; self.challenge = challenge; self.keyId = keyId; self.attestationObject = attestationObject; self.assertion = assertion; self.integrityToken = integrityToken }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = platform as Any? { result["platform"] = encodeVastu(value) }
        if let value = challenge as Any? { result["challenge"] = encodeVastu(value) }
        if let value = keyId as Any? { result["keyId"] = encodeVastu(value) }
        if let value = attestationObject as Any? { result["attestationObject"] = encodeVastu(value) }
        if let value = assertion as Any? { result["assertion"] = encodeVastu(value) }
        if let value = integrityToken as Any? { result["integrityToken"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArAttestationChallengeRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var platform: String
    public init(platform: String, propertyId: String? = nil, tenantRef: String? = nil) { self.platform = platform ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = platform as Any? { result["platform"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuArCaptureMergeRequestLinksItemControlPointsItem: VastuRequest {
    public var fromXY: [Double]
    public var toXY: [Double]
    public init(fromXY: [Double], toXY: [Double]) { self.fromXY = fromXY; self.toXY = toXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromXY as Any? { result["fromXY"] = encodeVastu(value) }
        if let value = toXY as Any? { result["toXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCaptureMergeRequestLinksItemSharedDoorsItem: VastuRequest {
    public var fromXY: [Double]
    public var toXY: [Double]
    public init(fromXY: [Double], toXY: [Double]) { self.fromXY = fromXY; self.toXY = toXY }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromXY as Any? { result["fromXY"] = encodeVastu(value) }
        if let value = toXY as Any? { result["toXY"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCaptureMergeRequestFloorsItem: VastuRequest {
    public var floorIndex: Int
    public var elevationM: Double
    public var originXY: [Double]
    public var bearingDeg: Double
    public init(floorIndex: Int, elevationM: Double, originXY: [Double], bearingDeg: Double) { self.floorIndex = floorIndex; self.elevationM = elevationM; self.originXY = originXY; self.bearingDeg = bearingDeg }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = floorIndex as Any? { result["floorIndex"] = encodeVastu(value) }
        if let value = elevationM as Any? { result["elevationM"] = encodeVastu(value) }
        if let value = originXY as Any? { result["originXY"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCaptureMergeRequestCapturesItem: VastuRequest {
    public var id: String
    public var floorIndex: Int
    public var payload: VastuRoomCapture
    public init(id: String, floorIndex: Int, payload: VastuRoomCapture) { self.id = id; self.floorIndex = floorIndex; self.payload = payload }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = floorIndex as Any? { result["floorIndex"] = encodeVastu(value) }
        if let value = payload as Any? { result["payload"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCaptureMergeRequestLinksItem: VastuRequest {
    public var fromCaptureId: String
    public var toCaptureId: String
    public var controlPoints: [VastuArCaptureMergeRequestLinksItemControlPointsItem]?
    public var sharedDoors: [VastuArCaptureMergeRequestLinksItemSharedDoorsItem]?
    public init(fromCaptureId: String, toCaptureId: String, controlPoints: [VastuArCaptureMergeRequestLinksItemControlPointsItem]? = nil, sharedDoors: [VastuArCaptureMergeRequestLinksItemSharedDoorsItem]? = nil) { self.fromCaptureId = fromCaptureId; self.toCaptureId = toCaptureId; self.controlPoints = controlPoints; self.sharedDoors = sharedDoors }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromCaptureId as Any? { result["fromCaptureId"] = encodeVastu(value) }
        if let value = toCaptureId as Any? { result["toCaptureId"] = encodeVastu(value) }
        if let value = controlPoints as Any? { result["controlPoints"] = encodeVastu(value) }
        if let value = sharedDoors as Any? { result["sharedDoors"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlotFromSurveyRequestControlPointsItem: VastuRequest {
    public var id: String
    public var xy: [Double]
    public init(id: String, xy: [Double]) { self.id = id; self.xy = xy }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = xy as Any? { result["xy"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArCaptureMergeRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var maxChargeUsd: String?
    public var captures: [VastuArCaptureMergeRequestCapturesItem]
    public var links: [VastuArCaptureMergeRequestLinksItem]
    public var floors: [VastuArCaptureMergeRequestFloorsItem]
    public var toleranceM: Double
    public init(captures: [VastuArCaptureMergeRequestCapturesItem], links: [VastuArCaptureMergeRequestLinksItem], floors: [VastuArCaptureMergeRequestFloorsItem], toleranceM: Double, maxChargeUsd: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.maxChargeUsd = maxChargeUsd; self.captures = captures; self.links = links; self.floors = floors; self.toleranceM = toleranceM ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = maxChargeUsd { result["maxChargeUsd"] = value }
        if let value = captures as Any? { result["captures"] = encodeVastu(value) }
        if let value = links as Any? { result["links"] = encodeVastu(value) }
        if let value = floors as Any? { result["floors"] = encodeVastu(value) }
        if let value = toleranceM as Any? { result["toleranceM"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotFromSurveyRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var maxChargeUsd: String?
    public var crs: String
    public var units: String
    public var boundary: [[Double]]
    public var controlPoints: [VastuPlotFromSurveyRequestControlPointsItem]?
    public var origin: [Double]?
    public init(crs: String, units: String, boundary: [[Double]], controlPoints: [VastuPlotFromSurveyRequestControlPointsItem]? = nil, origin: [Double]? = nil, maxChargeUsd: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.maxChargeUsd = maxChargeUsd; self.crs = crs; self.units = units; self.boundary = boundary; self.controlPoints = controlPoints; self.origin = origin ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = maxChargeUsd { result["maxChargeUsd"] = value }
        if let value = crs as Any? { result["crs"] = encodeVastu(value) }
        if let value = units as Any? { result["units"] = encodeVastu(value) }
        if let value = boundary as Any? { result["boundary"] = encodeVastu(value) }
        if let value = controlPoints as Any? { result["controlPoints"] = encodeVastu(value) }
        if let value = origin as Any? { result["origin"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuOptimizationConstraintsWetShaftsItem: VastuRequest {
    public var id: String
    public var polygon: [[Double]]
    public var roomIds: [String]?
    public var maxDistanceM: Double?
    public init(id: String, polygon: [[Double]], roomIds: [String]? = nil, maxDistanceM: Double? = nil) { self.id = id; self.polygon = polygon; self.roomIds = roomIds; self.maxDistanceM = maxDistanceM }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = roomIds as Any? { result["roomIds"] = encodeVastu(value) }
        if let value = maxDistanceM as Any? { result["maxDistanceM"] = encodeVastu(value) }
        return result
    }
}

public struct VastuOptimizationConstraintsPlumbingStacksItem: VastuRequest {
    public var id: String
    public var polygon: [[Double]]
    public var roomIds: [String]?
    public var maxDistanceM: Double?
    public init(id: String, polygon: [[Double]], roomIds: [String]? = nil, maxDistanceM: Double? = nil) { self.id = id; self.polygon = polygon; self.roomIds = roomIds; self.maxDistanceM = maxDistanceM }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = roomIds as Any? { result["roomIds"] = encodeVastu(value) }
        if let value = maxDistanceM as Any? { result["maxDistanceM"] = encodeVastu(value) }
        return result
    }
}

public struct VastuOptimizationConstraintsColumnsItem: VastuRequest {
    public var id: String?
    public var polygon: [[Double]]
    public init(id: String? = nil, polygon: [[Double]]) { self.id = id; self.polygon = polygon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuOptimizationConstraintsLoadBearingWallsItem: VastuRequest {
    public var id: String?
    public var polygon: [[Double]]
    public init(id: String? = nil, polygon: [[Double]]) { self.id = id; self.polygon = polygon }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = id as Any? { result["id"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        return result
    }
}

public struct VastuOptimizationConstraints: VastuRequest {
    public var lockedRooms: [String]?
    public var wetShafts: [VastuOptimizationConstraintsWetShaftsItem]?
    public var plumbingStacks: [VastuOptimizationConstraintsPlumbingStacksItem]?
    public var loadBearingWalls: [VastuOptimizationConstraintsLoadBearingWallsItem]?
    public var columns: [VastuOptimizationConstraintsColumnsItem]?
    public var minSizes: [String: Any]?
    public init(lockedRooms: [String]? = nil, wetShafts: [VastuOptimizationConstraintsWetShaftsItem]? = nil, plumbingStacks: [VastuOptimizationConstraintsPlumbingStacksItem]? = nil, loadBearingWalls: [VastuOptimizationConstraintsLoadBearingWallsItem]? = nil, columns: [VastuOptimizationConstraintsColumnsItem]? = nil, minSizes: [String: Any]? = nil) { self.lockedRooms = lockedRooms; self.wetShafts = wetShafts; self.plumbingStacks = plumbingStacks; self.loadBearingWalls = loadBearingWalls; self.columns = columns; self.minSizes = minSizes }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lockedRooms as Any? { result["lockedRooms"] = encodeVastu(value) }
        if let value = wetShafts as Any? { result["wetShafts"] = encodeVastu(value) }
        if let value = plumbingStacks as Any? { result["plumbingStacks"] = encodeVastu(value) }
        if let value = loadBearingWalls as Any? { result["loadBearingWalls"] = encodeVastu(value) }
        if let value = columns as Any? { result["columns"] = encodeVastu(value) }
        if let value = minSizes as Any? { result["minSizes"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArRoomCaptureRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil

    public var capture: VastuRoomCapture
    public var zoneResolution: Int?
    public var deviceAttestation: VastuDeviceAttestation?
    public init(capture: VastuRoomCapture, zoneResolution: Int? = nil, deviceAttestation: VastuDeviceAttestation? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.capture = capture; self.zoneResolution = zoneResolution; self.deviceAttestation = deviceAttestation ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = capture as Any? { result["capture"] = encodeVastu(value) }
        if let value = zoneResolution as Any? { result["zoneResolution"] = encodeVastu(value) }
        if let value = deviceAttestation as Any? { result["deviceAttestation"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = encodeVastu(v) }
        if let v = positionErrorM { result["positionErrorM"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var tenantRef: String?

    public var scanId: String
    public var propertyId: String
    public var title: String
    public var retentionDays: Int
    public var snapshot: VastuScanSnapshot
    public var deviceAttestation: VastuDeviceAttestation?
    public init(scanId: String, propertyId: String, title: String, retentionDays: Int, snapshot: VastuScanSnapshot, deviceAttestation: VastuDeviceAttestation? = nil, tenantRef: String? = nil) { self.scanId = scanId; self.propertyId = propertyId; self.title = title; self.retentionDays = retentionDays; self.snapshot = snapshot; self.deviceAttestation = deviceAttestation ; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        if let value = propertyId as Any? { result["propertyId"] = encodeVastu(value) }
        if let value = title as Any? { result["title"] = encodeVastu(value) }
        if let value = retentionDays as Any? { result["retentionDays"] = encodeVastu(value) }
        if let value = snapshot as Any? { result["snapshot"] = encodeVastu(value) }
        if let value = deviceAttestation as Any? { result["deviceAttestation"] = encodeVastu(value) }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuScansRetrieveRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var requestId: String
    public var scanId: String
    public init(requestId: String, scanId: String, propertyId: String? = nil, tenantRef: String? = nil) { self.requestId = requestId; self.scanId = scanId ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuScansListRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var requestId: String
    public var limit: Int
    public var cursor: String?
    public init(requestId: String, limit: Int, cursor: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.requestId = requestId; self.limit = limit; self.cursor = cursor ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = limit as Any? { result["limit"] = encodeVastu(value) }
        if let value = cursor as Any? { result["cursor"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuScansDeleteRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var scanId: String
    public init(scanId: String, propertyId: String? = nil, tenantRef: String? = nil) { self.scanId = scanId ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = scanId as Any? { result["scanId"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuScansTimelapseRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var requestId: String
    public var scanIds: [String]
    public init(requestId: String, scanIds: [String], propertyId: String? = nil, tenantRef: String? = nil) { self.requestId = requestId; self.scanIds = scanIds ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = requestId as Any? { result["requestId"] = encodeVastu(value) }
        if let value = scanIds as Any? { result["scanIds"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}


public struct VastuArScanQualityRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

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
    public var deviceAttestation: VastuDeviceAttestation?
    public init(pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Bool? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, roomCount: Int? = nil, expectedRoomCount: Int? = nil, pointCloudDensityPerM2: Double? = nil, polygonClosed: Bool? = nil, coveragePercent: Double? = nil, pointCloudDensityBasis: String? = nil, deviceAttestation: VastuDeviceAttestation? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.roomCount = roomCount; self.expectedRoomCount = expectedRoomCount; self.pointCloudDensityPerM2 = pointCloudDensityPerM2; self.polygonClosed = polygonClosed; self.coveragePercent = coveragePercent; self.pointCloudDensityBasis = pointCloudDensityBasis; self.deviceAttestation = deviceAttestation ; self.propertyId = propertyId; self.tenantRef = tenantRef }
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
        if let value = deviceAttestation as Any? { result["deviceAttestation"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var deviceAttestation: VastuDeviceAttestation?
    public init(pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Int? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, roomCount: Int? = nil, expectedRoomCount: Int? = nil, pointCloudDensityPerM2: Double? = nil, polygonClosed: Bool? = nil, coveragePercent: Double? = nil, pointCloudDensityBasis: String? = nil, deviceAttestation: VastuDeviceAttestation? = nil) { self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.roomCount = roomCount; self.expectedRoomCount = expectedRoomCount; self.pointCloudDensityPerM2 = pointCloudDensityPerM2; self.polygonClosed = polygonClosed; self.coveragePercent = coveragePercent; self.pointCloudDensityBasis = pointCloudDensityBasis; self.deviceAttestation = deviceAttestation }
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
        if let value = deviceAttestation as Any? { result["deviceAttestation"] = encodeVastu(value) }
        return result
    }
}

public struct VastuArTrueNorthCalibrateRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var lat: Double
    public var lon: Double
    public var datetime: String
    public var deviceHeadingAtSunDeg: Double
    public var deviceHeadingAccuracyDeg: Double?
    public var headingSampleAgeMs: Double?
    public init(lat: Double, lon: Double, datetime: String, deviceHeadingAtSunDeg: Double, deviceHeadingAccuracyDeg: Double? = nil, headingSampleAgeMs: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.lat = lat; self.lon = lon; self.datetime = datetime; self.deviceHeadingAtSunDeg = deviceHeadingAtSunDeg; self.deviceHeadingAccuracyDeg = deviceHeadingAccuracyDeg; self.headingSampleAgeMs = headingSampleAgeMs ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = deviceHeadingAtSunDeg as Any? { result["deviceHeadingAtSunDeg"] = encodeVastu(value) }
        if let value = deviceHeadingAccuracyDeg { result["deviceHeadingAccuracyDeg"] = value }
        if let value = headingSampleAgeMs { result["headingSampleAgeMs"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var rulesVersion: String? = nil
    public var receipt: Bool? = nil
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
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
    public init(inputSource: String, rooms: [VastuAssessmentsRequestRoomsItem]? = nil, plotPolygon: [[Double]]? = nil, doorXY: VastuPoint? = nil, bearingDeg: Double? = nil, confidence: Double? = nil, pointCloudDensity: Double? = nil, polygonClosure: Bool? = nil, roomsTagged: Bool? = nil, compassConfidence: Double? = nil, gpsConfidence: Double? = nil, scanDurationSec: Double? = nil, scannedAreaM2: Double? = nil, rulesVersion: String? = nil, receipt: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rulesVersion = rulesVersion; self.receipt = receipt; self.inputSource = inputSource; self.rooms = rooms; self.plotPolygon = plotPolygon; self.doorXY = doorXY; self.bearingDeg = bearingDeg; self.confidence = confidence; self.pointCloudDensity = pointCloudDensity; self.polygonClosure = polygonClosure; self.roomsTagged = roomsTagged; self.compassConfidence = compassConfidence; self.gpsConfidence = gpsConfidence; self.scanDurationSec = scanDurationSec; self.scannedAreaM2 = scannedAreaM2; self.propertyId = propertyId; self.tenantRef = tenantRef }
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
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = rulesVersion { result["rulesVersion"] = v }
        if let v = receipt { result["receipt"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var items: [VastuAssessmentsBatchRequestItemsItem]
    public init(items: [VastuAssessmentsBatchRequestItemsItem], propertyId: String? = nil, tenantRef: String? = nil) { self.items = items ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = ["items": items.map { $0.dictionary }]
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
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
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuAuditFloorPlanDetailedRequestRoomsItem]
    public var plotPolygon: [[Double]]?
    public var bearingDeg: Double?
    public init(rooms: [VastuAuditFloorPlanDetailedRequestRoomsItem], plotPolygon: [[Double]]? = nil, bearingDeg: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.rooms = rooms; self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuAuditFloorPlanRequestRoomsItem]?
    public var text: String?
    public init(rooms: [VastuAuditFloorPlanRequestRoomsItem]? = nil, text: String? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.rooms = rooms; self.text = text; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = text as Any? { result["text"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuAuditSingleRoomRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var roomType: String
    public var zone: String
    public init(roomType: String, zone: String, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.roomType = roomType; self.zone = zone; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var rooms: [VastuCompareBeforeAfterRemedyRequestRoomsItem]?
    public var text: String?
    public var remedies: [VastuCompareBeforeAfterRemedyRequestRemediesItem]
    public init(rooms: [VastuCompareBeforeAfterRemedyRequestRoomsItem]? = nil, text: String? = nil, remedies: [VastuCompareBeforeAfterRemedyRequestRemediesItem], propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.text = text; self.remedies = remedies ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = text as Any? { result["text"] = encodeVastu(value) }
        if let value = remedies as Any? { result["remedies"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuCompoundWallAnalysisRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var walls: VastuJsonObjectOrArray?
    public init(walls: VastuJsonObjectOrArray? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.walls = walls ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = walls as Any? { result["walls"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuDirectionAuspiciousFacingRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var purpose: String
    public var occupant: String?
    public init(purpose: String, occupant: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.purpose = purpose; self.occupant = occupant ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = purpose as Any? { result["purpose"] = encodeVastu(value) }
        if let value = occupant as Any? { result["occupant"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuDirectionCorrectRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var direction: String
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(direction: String, lat: Double, lon: Double, date: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.direction = direction; self.lat = lat; self.lon = lon; self.date = date ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuDirectionDeclinationRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(lat: Double, lon: Double, date: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.lat = lat; self.lon = lon; self.date = date ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuDirectionSunPathRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var lat: Double
    public var lon: Double
    public var date: String?
    public init(lat: Double, lon: Double, date: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.lat = lat; self.lon = lon; self.date = date ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuDirectionZoneFromBearingRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var bearingDeg: Double
    public init(bearingDeg: Double, propertyId: String? = nil, tenantRef: String? = nil) { self.bearingDeg = bearingDeg ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuElementsBalanceSuggestRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var distribution: [String: Any]?
    public var deficient: [String]?
    public var excess: [String]?
    public init(distribution: [String: Any]? = nil, deficient: [String]? = nil, excess: [String]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.distribution = distribution; self.deficient = deficient; self.excess = excess ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = distribution as Any? { result["distribution"] = encodeVastu(value) }
        if let value = deficient as Any? { result["deficient"] = encodeVastu(value) }
        if let value = excess as Any? { result["excess"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuElementsDistributionRequestRoomsItem]
    public init(rooms: [VastuElementsDistributionRequestRoomsItem], propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuEntranceObstructionCheckRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var feature: String
    public var houseHeightMeters: Double?
    public var distanceMeters: Double?
    public init(feature: String, houseHeightMeters: Double? = nil, distanceMeters: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.feature = feature; self.houseHeightMeters = houseHeightMeters; self.distanceMeters = distanceMeters ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = feature as Any? { result["feature"] = encodeVastu(value) }
        if let value = houseHeightMeters as Any? { result["houseHeightMeters"] = encodeVastu(value) }
        if let value = distanceMeters as Any? { result["distanceMeters"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuEntrancePadaRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var doorXY: [Double]
    public var bearingDeg: Double?
    public init(plotPolygon: [[Double]], doorXY: [Double], bearingDeg: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.doorXY = doorXY; self.bearingDeg = bearingDeg ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuEntranceRecommendRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var facing: String
    public init(facing: String, propertyId: String? = nil, tenantRef: String? = nil) { self.facing = facing ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuFloorLevelAnalysisRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var levels: VastuJsonObjectOrArray?
    public init(levels: VastuJsonObjectOrArray? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.levels = levels ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = levels as Any? { result["levels"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuFusionChartRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var datetime: String
    public var latitude: Double
    public var longitude: Double
    public var timezone: String?
    public var facing: String?
    public init(datetime: String, latitude: Double, longitude: Double, timezone: String? = nil, facing: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.datetime = datetime; self.latitude = latitude; self.longitude = longitude; self.timezone = timezone; self.facing = facing ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuMandalaProject81PadaRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuMandalaProject9ZoneRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuMandalaProjectBrahmasthanRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuMultiStoreyFloorRulesRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var floors: Int
    public init(floors: Int, propertyId: String? = nil, tenantRef: String? = nil) { self.floors = floors ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = floors as Any? { result["floors"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementBalconyRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementBorewellRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementGardenRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementGeneratorElectricalRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementMainGateRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var facing: String
    public var direction: String?
    public var zone: String?
    public var pada: Int?
    public init(facing: String, direction: String? = nil, zone: String? = nil, pada: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.facing = facing; self.direction = direction; self.zone = zone; self.pada = pada ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = pada as Any? { result["pada"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementOverheadTankRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementSepticTankRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementTreeRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementWellRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlacementWindowRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanAnalyzeRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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
    public var merchantCatalogId: String?
    public var rulesVersion: String? = nil
    public var receipt: Bool? = nil
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuPlanAnalyzeRequestRoomsItem]
    public var plot: [String: Any]?
    public var zoneResolution: Int?
        public init(rooms: [VastuPlanAnalyzeRequestRoomsItem], plot: [String: Any]? = nil, zoneResolution: Int? = nil, merchantCatalogId: String? = nil, rulesVersion: String? = nil, receipt: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.rulesVersion = rulesVersion; self.receipt = receipt; self.merchantCatalogId = merchantCatalogId; self.rooms = rooms; self.plot = plot; self.zoneResolution = zoneResolution; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = zoneResolution as Any? { result["zoneResolution"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let v = rulesVersion { result["rulesVersion"] = v }
        if let v = receipt { result["receipt"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var width: Double?
    public var length: Double?
    public var facing: String?
    public var polygon: [[Double]]?
    public var setbacks: VastuPlanFromRequirementsRequestPlotSetbacks?
    public init(width: Double? = nil, length: Double? = nil, facing: String? = nil, polygon: [[Double]]? = nil, setbacks: VastuPlanFromRequirementsRequestPlotSetbacks? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.width = width; self.length = length; self.facing = facing; self.polygon = polygon; self.setbacks = setbacks }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = setbacks as Any? { result["setbacks"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanFromRequirementsRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var plotPolygon: [Any]? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
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
        public init(plot: VastuPlanFromRequirementsRequestPlot, entrance: [String: Any]? = nil, rooms: [VastuPlanFromRequirementsRequestRoomsItem]? = nil, requirements: [String: Any]? = nil, parking: [String: Any]? = nil, staircase: [String: Any]? = nil, lift: [String: Any]? = nil, variants: Int? = nil, variantSvg: Bool? = nil, includeSvg: Bool? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.plot = plot; self.entrance = entrance; self.rooms = rooms; self.requirements = requirements; self.parking = parking; self.staircase = staircase; self.lift = lift; self.variants = variants; self.variantSvg = variantSvg; self.includeSvg = includeSvg; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
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
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var width: Double?
    public var length: Double?
    public var facing: String?
    public var polygon: [[Double]]?
    public var setbacks: VastuPlanGenerateRequestPlotSetbacks?
    public init(width: Double? = nil, length: Double? = nil, facing: String? = nil, polygon: [[Double]]? = nil, setbacks: VastuPlanGenerateRequestPlotSetbacks? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.width = width; self.length = length; self.facing = facing; self.polygon = polygon; self.setbacks = setbacks }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = setbacks as Any? { result["setbacks"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanGenerateRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var plotPolygon: [Any]? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
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
        public init(plot: VastuPlanGenerateRequestPlot, entrance: [String: Any]? = nil, rooms: [VastuPlanGenerateRequestRoomsItem]? = nil, requirements: [String: Any]? = nil, parking: [String: Any]? = nil, staircase: [String: Any]? = nil, lift: [String: Any]? = nil, variants: Int? = nil, variantSvg: Bool? = nil, includeSvg: Bool? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.plot = plot; self.entrance = entrance; self.rooms = rooms; self.requirements = requirements; self.parking = parking; self.staircase = staircase; self.lift = lift; self.variants = variants; self.variantSvg = variantSvg; self.includeSvg = includeSvg; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
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
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanOptimizeRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var plotPolygon: [Any]? = nil
    public var lockedRooms: [String]? = nil
    public var wetShafts: [[String: Any]]? = nil
    public var plumbingStacks: [[String: Any]]? = nil
    public var loadBearingWalls: [[String: Any]]? = nil
    public var columns: [[String: Any]]? = nil
    public var minSizes: [String: Any]? = nil

    public var constraints: VastuOptimizationConstraints? = nil
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuPlanOptimizeRequestRoomsItem]
    public var plot: [String: Any]?
    public var includeSvg: Bool?
        public init(rooms: [VastuPlanOptimizeRequestRoomsItem], plot: [String: Any]? = nil, includeSvg: Bool? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.rooms = rooms; self.plot = plot; self.includeSvg = includeSvg; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let includeSvg { result["includeSvg"] = includeSvg }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = constraints { result["constraints"] = v.dictionary }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = lockedRooms { result["lockedRooms"] = encodeVastu(v) }
        if let v = wetShafts { result["wetShafts"] = encodeVastu(v) }
        if let v = plumbingStacks { result["plumbingStacks"] = encodeVastu(v) }
        if let v = loadBearingWalls { result["loadBearingWalls"] = encodeVastu(v) }
        if let v = columns { result["columns"] = encodeVastu(v) }
        if let v = minSizes { result["minSizes"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanReportRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
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

public struct VastuPlanReportRequestCompositionCtaBlocksItem: VastuRequest {
    public var label: String
    public var link: String
    public var phone: String?
    public init(label: String, link: String, phone: String? = nil) { self.label = label; self.link = link; self.phone = phone }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = label as Any? { result["label"] = encodeVastu(value) }
        if let value = link as Any? { result["link"] = encodeVastu(value) }
        if let value = phone as Any? { result["phone"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanReportRequestComposition: VastuRequest {
    public var sections: [String]?
    public var intro: String?
    public var outro: String?
    public var ctaBlocks: [VastuPlanReportRequestCompositionCtaBlocksItem]?
    public init(sections: [String]? = nil, intro: String? = nil, outro: String? = nil, ctaBlocks: [VastuPlanReportRequestCompositionCtaBlocksItem]? = nil) { self.sections = sections; self.intro = intro; self.outro = outro; self.ctaBlocks = ctaBlocks }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = sections as Any? { result["sections"] = encodeVastu(value) }
        if let value = intro as Any? { result["intro"] = encodeVastu(value) }
        if let value = outro as Any? { result["outro"] = encodeVastu(value) }
        if let value = ctaBlocks as Any? { result["ctaBlocks"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanReportRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuPlanReportRequestRoomsItem]
    public var plot: [String: Any]?
    public var format: String?
    public var brand: VastuPlanReportRequestBrand?
    public var reportTitle: String?
    public var generatedFor: String?
    public var tenantName: String?
    public var composition: VastuPlanReportRequestComposition?
    public var merchantCatalogId: String?
        public init(rooms: [VastuPlanReportRequestRoomsItem], plot: [String: Any]? = nil, format: String? = nil, brand: VastuPlanReportRequestBrand? = nil, reportTitle: String? = nil, generatedFor: String? = nil, tenantName: String? = nil, headingErrorDeg: Double? = nil, positionErrorM: Double? = nil, composition: VastuPlanReportRequestComposition? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.rooms = rooms; self.plot = plot; self.format = format; self.brand = brand; self.reportTitle = reportTitle; self.generatedFor = generatedFor; self.tenantName = tenantName; self.headingErrorDeg = headingErrorDeg; self.positionErrorM = positionErrorM; self.composition = composition; self.merchantCatalogId = merchantCatalogId; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let value = format as Any? { result["format"] = encodeVastu(value) }
        if let value = brand as Any? { result["brand"] = encodeVastu(value) }
        if let value = reportTitle as Any? { result["reportTitle"] = encodeVastu(value) }
        if let value = generatedFor as Any? { result["generatedFor"] = encodeVastu(value) }
        if let value = tenantName as Any? { result["tenantName"] = encodeVastu(value) }
        if let value = headingErrorDeg as Any? { result["headingErrorDeg"] = encodeVastu(value) }
        if let value = positionErrorM as Any? { result["positionErrorM"] = encodeVastu(value) }
        if let value = composition as Any? { result["composition"] = encodeVastu(value) }
        if let value = merchantCatalogId as Any? { result["merchantCatalogId"] = encodeVastu(value) }
        if let format { result["format"] = format }
        if let brand { result["brand"] = brand.dictionary }
        if let reportTitle { result["reportTitle"] = reportTitle }
        if let generatedFor { result["generatedFor"] = generatedFor }
        if let tenantName { result["tenantName"] = tenantName }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanUploadRequestRoomsItem: VastuEncodable {
    public var multipolygons: [[String: Any]]?
    public var holes: [[[Double]]]?
    public var name: String
    public var roomType: String?
    public var zone: String?
    public var direction: String?
    public var polygon: [[Double]]?
    public var area: Double?
    public init(name: String, roomType: String? = nil, zone: String? = nil, direction: String? = nil, polygon: [[Double]]? = nil, area: Double? = nil, holes: [[[Double]]]? = nil, multipolygons: [[String: Any]]? = nil) { self.multipolygons = multipolygons; self.holes = holes; self.name = name; self.roomType = roomType; self.zone = zone; self.direction = direction; self.polygon = polygon; self.area = area }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = multipolygons { result["multipolygons"] = encodeVastu(value) }
        if let value = holes { result["holes"] = encodeVastu(value) }
        if let value = name as Any? { result["name"] = encodeVastu(value) }
        if let value = roomType as Any? { result["roomType"] = encodeVastu(value) }
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = polygon as Any? { result["polygon"] = encodeVastu(value) }
        if let value = area as Any? { result["area"] = encodeVastu(value) }
        return result
    }
}

public struct VastuPlanImportImageRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var fileBase64: String
    public var northBearingDeg: Double?
    public var scaleMetersPerUnit: Double?
        public var units: String?
    public var inputUnits: String?
    public var scaleInputUnitsPerUnit: Double?
    public init(fileBase64: String, northBearingDeg: Double? = nil, scaleMetersPerUnit: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil, inputUnits: String? = nil, scaleInputUnitsPerUnit: Double? = nil) { self.fileBase64 = fileBase64; self.northBearingDeg = northBearingDeg; self.scaleMetersPerUnit = scaleMetersPerUnit; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units; self.inputUnits = inputUnits; self.scaleInputUnitsPerUnit = scaleInputUnitsPerUnit }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        result["fileBase64"] = fileBase64
        if let value = northBearingDeg { result["northBearingDeg"] = value }
        if let value = scaleMetersPerUnit { result["scaleMetersPerUnit"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        if let value = units { result["units"] = value }
        if let value = inputUnits { result["inputUnits"] = value }
        if let value = scaleInputUnitsPerUnit { result["scaleInputUnitsPerUnit"] = value }
        return result
    }
}

public struct VastuPlanImportPdfRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var fileBase64: String
    public var northBearingDeg: Double?
    public var scaleMetersPerUnit: Double?
    public var units: String?
    public var inputUnits: String?
    public var scaleInputUnitsPerUnit: Double?
    public var page: Int
        public init(fileBase64: String, northBearingDeg: Double? = nil, scaleMetersPerUnit: Double? = nil, page: Int, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil, inputUnits: String? = nil, scaleInputUnitsPerUnit: Double? = nil) { self.fileBase64 = fileBase64; self.northBearingDeg = northBearingDeg; self.scaleMetersPerUnit = scaleMetersPerUnit; self.page = page; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units; self.inputUnits = inputUnits; self.scaleInputUnitsPerUnit = scaleInputUnitsPerUnit }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        result["fileBase64"] = fileBase64
        if let value = northBearingDeg { result["northBearingDeg"] = value }
        if let value = scaleMetersPerUnit { result["scaleMetersPerUnit"] = value }
        result["page"] = page
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        if let value = units { result["units"] = value }
        if let value = inputUnits { result["inputUnits"] = value }
        if let value = scaleInputUnitsPerUnit { result["scaleInputUnitsPerUnit"] = value }
        return result
    }
}

public struct VastuPlanUploadRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuPlanUploadRequestRoomsItem]?
    public var layout: [String: Any]?
    public var asciiGrid: String?
    public var plot: [String: Any]?
        public init(rooms: [VastuPlanUploadRequestRoomsItem]? = nil, layout: [String: Any]? = nil, asciiGrid: String? = nil, plot: [String: Any]? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.rooms = rooms; self.layout = layout; self.asciiGrid = asciiGrid; self.plot = plot; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = layout as Any? { result["layout"] = encodeVastu(value) }
        if let value = asciiGrid as Any? { result["asciiGrid"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotExtensionsCutsRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]?
    public var length: Double?
    public var width: Double?
    public init(plotPolygon: [[Double]]? = nil, length: Double? = nil, width: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.length = length; self.width = width ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = length as Any? { result["length"] = encodeVastu(value) }
        if let value = width as Any? { result["width"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotOrientationRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var facingBearingDeg: Double?
    public var bearingDeg: Double?
    public init(facingBearingDeg: Double? = nil, bearingDeg: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.facingBearingDeg = facingBearingDeg; self.bearingDeg = bearingDeg ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = facingBearingDeg as Any? { result["facingBearingDeg"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotRatioRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotRoadOrientationRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var roads: [String]?
    public var roadSides: [String]?
    public var veedhiShoola: String?
    public var tPointFrom: String?
    public var roadThrustFrom: String?
    public init(roads: [String]? = nil, roadSides: [String]? = nil, veedhiShoola: String? = nil, tPointFrom: String? = nil, roadThrustFrom: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.roads = roads; self.roadSides = roadSides; self.veedhiShoola = veedhiShoola; self.tPointFrom = tPointFrom; self.roadThrustFrom = roadThrustFrom ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = roads as Any? { result["roads"] = encodeVastu(value) }
        if let value = roadSides as Any? { result["roadSides"] = encodeVastu(value) }
        if let value = veedhiShoola as Any? { result["veedhiShoola"] = encodeVastu(value) }
        if let value = tPointFrom as Any? { result["tPointFrom"] = encodeVastu(value) }
        if let value = roadThrustFrom as Any? { result["roadThrustFrom"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotShapeRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var plotPolygon: [[Double]]
    public var bearingDeg: Double?
    public var doorXY: [Double]?
    public init(plotPolygon: [[Double]], bearingDeg: Double? = nil, doorXY: [Double]? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.plotPolygon = plotPolygon; self.bearingDeg = bearingDeg; self.doorXY = doorXY ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = plotPolygon as Any? { result["plotPolygon"] = encodeVastu(value) }
        if let value = bearingDeg as Any? { result["bearingDeg"] = encodeVastu(value) }
        if let value = doorXY as Any? { result["doorXY"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlotSlopeRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var slopeDirection: String?
    public var lowSide: String?
    public var lowCorner: String?
    public var slopeBearingDeg: Double?
    public init(slopeDirection: String? = nil, lowSide: String? = nil, lowCorner: String? = nil, slopeBearingDeg: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.slopeDirection = slopeDirection; self.lowSide = lowSide; self.lowCorner = lowCorner; self.slopeBearingDeg = slopeBearingDeg ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = slopeDirection as Any? { result["slopeDirection"] = encodeVastu(value) }
        if let value = lowSide as Any? { result["lowSide"] = encodeVastu(value) }
        if let value = lowCorner as Any? { result["lowCorner"] = encodeVastu(value) }
        if let value = slopeBearingDeg as Any? { result["slopeBearingDeg"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomBedroomRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomDiningRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomKitchenRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomLivingRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomPoojaRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomStaircaseRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomStoreRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomStudyRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomToiletRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuRoomWaterStorageRequest: VastuRequest {
    public var merchantCatalogId: String?
    public var propertyId: String?
    public var tenantRef: String?

    public var pointXY: [Double]? = nil
    public var plotPolygon: [[Double]]? = nil
    public var bearingDeg: Double? = nil

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var zone: String?
    public var direction: String?
    public var proposedZone: String?
    public var proposedDirection: String?
    public var placement: String?
    public var latitude: Double?
    public var longitude: Double?
    public init(zone: String? = nil, direction: String? = nil, proposedZone: String? = nil, proposedDirection: String? = nil, placement: String? = nil, latitude: Double? = nil, longitude: Double? = nil, merchantCatalogId: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.merchantCatalogId = merchantCatalogId; self.zone = zone; self.direction = direction; self.proposedZone = proposedZone; self.proposedDirection = proposedDirection; self.placement = placement; self.latitude = latitude; self.longitude = longitude; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = zone as Any? { result["zone"] = encodeVastu(value) }
        if let value = direction as Any? { result["direction"] = encodeVastu(value) }
        if let value = proposedZone as Any? { result["proposedZone"] = encodeVastu(value) }
        if let value = proposedDirection as Any? { result["proposedDirection"] = encodeVastu(value) }
        if let value = placement as Any? { result["placement"] = encodeVastu(value) }
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = pointXY { result["pointXY"] = encodeVastu(v) }
        if let v = plotPolygon { result["plotPolygon"] = encodeVastu(v) }
        if let v = bearingDeg { result["bearingDeg"] = encodeVastu(v) }
        if let value = merchantCatalogId { result["merchantCatalogId"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var rulesVersion: String? = nil
    public var receipt: Bool? = nil
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuScoreComplianceIndexRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreComplianceIndexRequestRoomsItem], plot: [String: Any]? = nil, rulesVersion: String? = nil, receipt: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rulesVersion = rulesVersion; self.receipt = receipt; self.rooms = rooms; self.plot = plot; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = rulesVersion { result["rulesVersion"] = v }
        if let v = receipt { result["receipt"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var rulesVersion: String? = nil
    public var receipt: Bool? = nil
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuScoreOverallRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreOverallRequestRoomsItem], plot: [String: Any]? = nil, rulesVersion: String? = nil, receipt: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rulesVersion = rulesVersion; self.receipt = receipt; self.rooms = rooms; self.plot = plot; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = rulesVersion { result["rulesVersion"] = v }
        if let v = receipt { result["receipt"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var rulesVersion: String? = nil
    public var receipt: Bool? = nil
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuScoreZoneWiseRequestRoomsItem]
    public var plot: [String: Any]?
    public init(rooms: [VastuScoreZoneWiseRequestRoomsItem], plot: [String: Any]? = nil, rulesVersion: String? = nil, receipt: Bool? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rulesVersion = rulesVersion; self.receipt = receipt; self.rooms = rooms; self.plot = plot; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = plot as Any? { result["plot"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let v = rulesVersion { result["rulesVersion"] = v }
        if let v = receipt { result["receipt"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedCommercialRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedCommercialRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedEducationalRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedEducationalRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedFactoryRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedFactoryRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedHospitalRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedHospitalRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedResidentialRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedResidentialRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedRestaurantRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedRestaurantRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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
    public var propertyId: String?
    public var tenantRef: String?

    public var headingErrorDeg: Double? = nil
    public var positionErrorM: Double? = nil
    public var rooms: [VastuSpecializedTempleRequestRoomsItem]
    public var facing: String?
    public var buildingFacing: String?
    public var lat: Double?
    public var lon: Double?
    public init(rooms: [VastuSpecializedTempleRequestRoomsItem], facing: String? = nil, buildingFacing: String? = nil, lat: Double? = nil, lon: Double? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.rooms = rooms; self.facing = facing; self.buildingFacing = buildingFacing; self.lat = lat; self.lon = lon ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = rooms as Any? { result["rooms"] = encodeVastu(value) }
        if let value = facing as Any? { result["facing"] = encodeVastu(value) }
        if let value = buildingFacing as Any? { result["buildingFacing"] = encodeVastu(value) }
        if let value = lat as Any? { result["lat"] = encodeVastu(value) }
        if let value = lon as Any? { result["lon"] = encodeVastu(value) }
        if let v = headingErrorDeg { result["headingErrorDeg"] = v }
        if let v = positionErrorM { result["positionErrorM"] = v }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuTimingBhumiPujanRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuTimingConstructionStartRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuTimingGrihapraveshRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuTimingVastuShantiRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var latitude: Double
    public var longitude: Double
    public var datetime: String?
    public var date: String?
    public var time: String?
    public var timezone: String?
    public var windowDays: Int?
    public init(latitude: Double, longitude: Double, datetime: String? = nil, date: String? = nil, time: String? = nil, timezone: String? = nil, windowDays: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.latitude = latitude; self.longitude = longitude; self.datetime = datetime; self.date = date; self.time = time; self.timezone = timezone; self.windowDays = windowDays ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = latitude as Any? { result["latitude"] = encodeVastu(value) }
        if let value = longitude as Any? { result["longitude"] = encodeVastu(value) }
        if let value = datetime as Any? { result["datetime"] = encodeVastu(value) }
        if let value = date as Any? { result["date"] = encodeVastu(value) }
        if let value = time as Any? { result["time"] = encodeVastu(value) }
        if let value = timezone as Any? { result["timezone"] = encodeVastu(value) }
        if let value = windowDays as Any? { result["windowDays"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
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

public struct VastuArAttestationChallengeDataDeviceAttestation {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var status: String { (raw["status"] as? String)! }
    public var platform: String { (raw["platform"] as? String)! }
}

public struct VastuArCaptureMergeDataPairResidualsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var controlCount: Int? { vastuInt(raw["controlCount"]) }
    public var rmsResidualM: Double { vastuDouble(raw["rmsResidualM"])! }
    public var maxResidualM: Double { vastuDouble(raw["maxResidualM"])! }
    public var fromCaptureId: String { (raw["fromCaptureId"] as? String)! }
    public var toCaptureId: String { (raw["toCaptureId"] as? String)! }
}

public struct VastuArCaptureMergeDataPricing {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var attributableCostUsd: String { (raw["attributableCostUsd"] as? String)! }
    public var markupMultiplier: Int { vastuInt(raw["markupMultiplier"])! }
    public var computedPriceUsd: String { (raw["computedPriceUsd"] as? String)! }
    public var settledChargeUsd: String { (raw["settledChargeUsd"] as? String)! }
    public var settlement: String { (raw["settlement"] as? String)! }
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

public struct VastuArRoomCaptureDataCaptureOutlineGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: Any? { (raw["polygon"] is NSNull ? nil : raw["polygon"]) }
    public var holes: [Any]? { (raw["holes"] as? [Any]) }
    public var multipolygons: [Any]? { (raw["multipolygons"] as? [Any]) }
}

public struct VastuArRoomCaptureDataCaptureOutline {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
    public var source: String { (raw["source"] as? String)! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var length: Double { vastuDouble(raw["length"])! }
    public var areaM2: Double { vastuDouble(raw["areaM2"])! }
    public var geometry: VastuArRoomCaptureDataCaptureOutlineGeometry? { (raw["geometry"] as? [String: Any]).map { VastuArRoomCaptureDataCaptureOutlineGeometry(raw: $0) } }
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
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
}

public struct VastuArRoomCaptureDataRoomsItemGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: Any? { (raw["polygon"] is NSNull ? nil : raw["polygon"]) }
    public var holes: [Any]? { (raw["holes"] as? [Any]) }
    public var multipolygons: [Any]? { (raw["multipolygons"] as? [Any]) }
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
    public var geometry: VastuArRoomCaptureDataRoomsItemGeometry? { (raw["geometry"] as? [String: Any]).map { VastuArRoomCaptureDataRoomsItemGeometry(raw: $0) } }
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

public struct VastuArScanQualityDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
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

public struct VastuArchiveDeleteDataErasureReceiptRemovedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var kind: String { (raw["kind"] as? String)! }
    public var recordId: String? { (raw["recordId"] as? String) }
    public var artifactId: String? { (raw["artifactId"] as? String) }
    public var artifactHash: String? { (raw["artifactHash"] as? String) }
    public var versionHash: String? { (raw["versionHash"] as? String) }
    public var deleteMarker: Bool? { vastuBool(raw["deleteMarker"]) }
    public var versionCount: Int? { vastuInt(raw["versionCount"]) }
    public var deleteMarkerCount: Int? { vastuInt(raw["deleteMarkerCount"]) }
    public var versionsSha256: String? { (raw["versionsSha256"] as? String) }
}

public struct VastuArchiveDeleteDataErasureReceiptRetainedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var kind: String { (raw["kind"] as? String)! }
    public var purpose: String { (raw["purpose"] as? String)! }
}

public struct VastuArchiveDeleteDataErasureReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var schemaVersion: Int { vastuInt(raw["schemaVersion"])! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var scope: String { (raw["scope"] as? String)! }
    public var completedAt: String { (raw["completedAt"] as? String)! }
    public var removed: [VastuArchiveDeleteDataErasureReceiptRemovedItem] { (raw["removed"] as! [[String: Any]]).map { VastuArchiveDeleteDataErasureReceiptRemovedItem(raw: $0) } }
    public var retained: [VastuArchiveDeleteDataErasureReceiptRetainedItem] { (raw["retained"] as! [[String: Any]]).map { VastuArchiveDeleteDataErasureReceiptRetainedItem(raw: $0) } }
    public var backupRetentionDays: Int { vastuInt(raw["backupRetentionDays"])! }
    public var backupPolicy: String { (raw["backupPolicy"] as? String)! }
    public var hashAlgorithm: String { (raw["hashAlgorithm"] as? String)! }
    public var receiptHash: String { (raw["receiptHash"] as? String)! }
    public var linkedScanIds: [String]? { (raw["linkedScanIds"] as? [String]) }
    public var linkedAssessmentIds: [String]? { (raw["linkedAssessmentIds"] as? [String]) }
    public var deletedByAccountHash: String { (raw["deletedByAccountHash"] as? String)! }
    public var deletedAtEpoch: Int { vastuInt(raw["deletedAtEpoch"])! }
    public var revisionId: String? { (raw["revisionId"] as? String) }
}

public struct VastuArchiveSummaryDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuArchiveTierDataIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuArchiveTierDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
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

public struct VastuAssessmentDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
}

public struct VastuBrahmasthanProjectionDataGridFrame {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var orientation: String? { (raw["orientation"] as? String) }
    public var fittedTo: String? { (raw["fittedTo"] as? String) }
    public var rotationDeg: Double? { vastuDouble(raw["rotationDeg"]) }
    public var gridBoxArea: Double? { vastuDouble(raw["gridBoxArea"]) }
    public var plotAreaShareOfGridBox: Double? { vastuDouble(raw["plotAreaShareOfGridBox"]) }
    public var note: String? { (raw["note"] as? String) }
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

public struct VastuCatalogReferenceDataZoneRemediesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var classification: String? { (raw["classification"] as? String) }
    public var source: String? { (raw["source"] as? String) }
}

public struct VastuChatUploadDataBilling {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var chargedCents: Int? { vastuInt(raw["chargedCents"]) }
    public var balanceAfterCents: Int? { vastuInt(raw["balanceAfterCents"]) }
    public var currency: String? { (raw["currency"] as? String) }
}

public struct VastuCompareVersionsDataChangesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var ruleId: String { (raw["ruleId"] as? String)! }
    public var before: Any { raw["before"]! }
    public var after: Any { raw["after"]! }
    public var reason: String { (raw["reason"] as? String)! }
    public var fromReason: [String: Any]? { (raw["fromReason"] as? [String: Any]) }
    public var toReason: [String: Any]? { (raw["toReason"] as? [String: Any]) }
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

public struct VastuComplianceIndexDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
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

public struct VastuDetailedFloorPlanAuditDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
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

public struct VastuFloorPlanAuditDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
}

public struct VastuFusionChartDataCautionDirectionsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var direction: String { (raw["direction"] as? String)! }
    public var deity: String? { (raw["deity"] as? String) }
    public var element: String? { (raw["element"] as? String) }
    public var ruledBy: String? { (raw["ruledBy"] as? String) }
    public var strengthPct: Double? { vastuDouble(raw["strengthPct"]) }
    public var rationale: String { (raw["rationale"] as? String)! }
    public var avoidUse: [String]? { (raw["avoidUse"] as? [String]) }
}

public struct VastuJobStatusDataCounts {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var succeeded: Int { vastuInt(raw["succeeded"])! }
    public var failed: Int { vastuInt(raw["failed"])! }
    public var pending: Int { vastuInt(raw["pending"])! }
    public var cancelled: Int { vastuInt(raw["cancelled"])! }
}

public struct VastuJobStatusDataBilling {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var currency: String { (raw["currency"] as? String)! }
    public var pricePerItem: Double { vastuDouble(raw["pricePerItem"])! }
    public var maxCharge: Double { vastuDouble(raw["maxCharge"])! }
    public var charged: Double { vastuDouble(raw["charged"])! }
    public var basis: String { (raw["basis"] as? String)! }
}

public struct VastuMandalaProjectionDataGridFrame {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var orientation: String? { (raw["orientation"] as? String) }
    public var fittedTo: String? { (raw["fittedTo"] as? String) }
    public var rotationDeg: Double? { vastuDouble(raw["rotationDeg"]) }
    public var gridBoxArea: Double? { vastuDouble(raw["gridBoxArea"]) }
    public var plotAreaShareOfGridBox: Double? { vastuDouble(raw["plotAreaShareOfGridBox"]) }
    public var note: String? { (raw["note"] as? String) }
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

public struct VastuMeasurementUncertaintyResultsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: Any? { (raw["id"] is NSNull ? nil : raw["id"]) }
    public var pointResult: [String: Any] { (raw["pointResult"] as? [String: Any])! }
    public var possibleZones: [String] { (raw["possibleZones"] as? [String])! }
    public var possiblePadas: [[String: Any]] { (raw["possiblePadas"] as? [[String: Any]])! }
    public var stable: Bool { vastuBool(raw["stable"])! }
    public var bearingMarginDeg: Double? { vastuDouble(raw["bearingMarginDeg"]) }
    public var headingErrorDeg: Double? { vastuDouble(raw["headingErrorDeg"]) }
    public var positionErrorM: Double? { vastuDouble(raw["positionErrorM"]) }
    public var method: String? { (raw["method"] as? String) }
}

public struct VastuMeasurementUncertaintyBounds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var headingErrorDeg: Double { vastuDouble(raw["headingErrorDeg"])! }
    public var positionErrorM: Double { vastuDouble(raw["positionErrorM"])! }
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

public struct VastuOverallScoreDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
}

public struct VastuPlanAuditDataRoomByRoomItemMappedItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var itemId: String { (raw["itemId"] as? String)! }
    public var kind: String { (raw["kind"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var availability: String { (raw["availability"] as? String)! }
    public var link: String? { (raw["link"] as? String) }
    public var referralRef: String? { (raw["referralRef"] as? String) }
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
    public var statedZone: String? { (raw["statedZone"] as? String) }
    public var zoneConflict: Bool? { vastuBool(raw["zoneConflict"]) }
    public var mappedItems: [VastuPlanAuditDataRoomByRoomItemMappedItemsItem]? { (raw["mappedItems"] as? [[String: Any]])?.map { VastuPlanAuditDataRoomByRoomItemMappedItemsItem(raw: $0) } }
}

public struct VastuPlanAuditDataDefectsItemMappedItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var itemId: String { (raw["itemId"] as? String)! }
    public var kind: String { (raw["kind"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var availability: String { (raw["availability"] as? String)! }
    public var link: String? { (raw["link"] as? String) }
    public var referralRef: String? { (raw["referralRef"] as? String) }
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
    public var mappedItems: [VastuPlanAuditDataDefectsItemMappedItemsItem]? { (raw["mappedItems"] as? [[String: Any]])?.map { VastuPlanAuditDataDefectsItemMappedItemsItem(raw: $0) } }
}

public struct VastuPlanAuditDataRemediesItemMappedItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var itemId: String { (raw["itemId"] as? String)! }
    public var kind: String { (raw["kind"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var availability: String { (raw["availability"] as? String)! }
    public var link: String? { (raw["link"] as? String) }
    public var referralRef: String? { (raw["referralRef"] as? String) }
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
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedyParams: [String: Any]? { (raw["remedyParams"] as? [String: Any]) }
    public var mappedItems: [VastuPlanAuditDataRemediesItemMappedItemsItem]? { (raw["mappedItems"] as? [[String: Any]])?.map { VastuPlanAuditDataRemediesItemMappedItemsItem(raw: $0) } }
}

public struct VastuPlanAuditDataTracedGeometryRegionGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: Any? { (raw["polygon"] is NSNull ? nil : raw["polygon"]) }
    public var holes: [Any]? { (raw["holes"] as? [Any]) }
    public var multipolygons: [Any]? { (raw["multipolygons"] as? [Any]) }
}

public struct VastuPlanAuditDataTracedGeometryRegionBrahmasthan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var pole: [Double]? { (raw["pole"] as? [Double]) }
    public var poleInside: Bool? { vastuBool(raw["poleInside"]) }
    public var basis: String? { (raw["basis"] as? String) }
    public var netArea: Double? { vastuDouble(raw["netArea"]) }
}

public struct VastuPlanAuditDataTracedGeometryRegionGridZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanAuditDataTracedGeometryRegionSectorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanAuditDataTracedGeometryRegion {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var geometry: VastuPlanAuditDataTracedGeometryRegionGeometry? { (raw["geometry"] as? [String: Any]).map { VastuPlanAuditDataTracedGeometryRegionGeometry(raw: $0) } }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var centroid: [Double]? { (raw["centroid"] as? [Double]) }
    public var centroidInside: Bool? { vastuBool(raw["centroidInside"]) }
    public var brahmasthan: VastuPlanAuditDataTracedGeometryRegionBrahmasthan? { (raw["brahmasthan"] as? [String: Any]).map { VastuPlanAuditDataTracedGeometryRegionBrahmasthan(raw: $0) } }
    public var gridZones: [VastuPlanAuditDataTracedGeometryRegionGridZonesItem]? { (raw["gridZones"] as? [[String: Any]])?.map { VastuPlanAuditDataTracedGeometryRegionGridZonesItem(raw: $0) } }
    public var sectors: [VastuPlanAuditDataTracedGeometryRegionSectorsItem]? { (raw["sectors"] as? [[String: Any]])?.map { VastuPlanAuditDataTracedGeometryRegionSectorsItem(raw: $0) } }
}

public struct VastuPlanAuditDataTracedGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var region: VastuPlanAuditDataTracedGeometryRegion? { (raw["region"] as? [String: Any]).map { VastuPlanAuditDataTracedGeometryRegion(raw: $0) } }
}

public struct VastuPlanAuditDataArtifact {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var contentType: String { (raw["contentType"] as? String)! }
    public var filename: String { (raw["filename"] as? String)! }
    public var content: String { (raw["content"] as? String)! }
    public var encoding: String? { (raw["encoding"] as? String) }
}

public struct VastuPlanAuditDataNotAssessedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var room: String { (raw["room"] as? String)! }
    public var zone: String { (raw["zone"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
    public var graded: Bool { vastuBool(raw["graded"])! }
}

public struct VastuPlanAuditDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
}

public struct VastuPlanGenerateDataPlotRegionGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: Any? { (raw["polygon"] is NSNull ? nil : raw["polygon"]) }
    public var holes: [Any]? { (raw["holes"] as? [Any]) }
    public var multipolygons: [Any]? { (raw["multipolygons"] as? [Any]) }
}

public struct VastuPlanGenerateDataPlotRegionBrahmasthan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var pole: [Double]? { (raw["pole"] as? [Double]) }
    public var poleInside: Bool? { vastuBool(raw["poleInside"]) }
    public var basis: String? { (raw["basis"] as? String) }
    public var netArea: Double? { vastuDouble(raw["netArea"]) }
}

public struct VastuPlanGenerateDataPlotRegionGridZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanGenerateDataPlotRegionSectorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanGenerateDataPlotRegion {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var geometry: VastuPlanGenerateDataPlotRegionGeometry? { (raw["geometry"] as? [String: Any]).map { VastuPlanGenerateDataPlotRegionGeometry(raw: $0) } }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var centroid: [Double]? { (raw["centroid"] as? [Double]) }
    public var centroidInside: Bool? { vastuBool(raw["centroidInside"]) }
    public var brahmasthan: VastuPlanGenerateDataPlotRegionBrahmasthan? { (raw["brahmasthan"] as? [String: Any]).map { VastuPlanGenerateDataPlotRegionBrahmasthan(raw: $0) } }
    public var gridZones: [VastuPlanGenerateDataPlotRegionGridZonesItem]? { (raw["gridZones"] as? [[String: Any]])?.map { VastuPlanGenerateDataPlotRegionGridZonesItem(raw: $0) } }
    public var sectors: [VastuPlanGenerateDataPlotRegionSectorsItem]? { (raw["sectors"] as? [[String: Any]])?.map { VastuPlanGenerateDataPlotRegionSectorsItem(raw: $0) } }
}

public struct VastuPlanImportDataPlanPlot {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
    public var width: Double? { vastuDouble(raw["width"]) }
    public var length: Double? { vastuDouble(raw["length"]) }
}

public struct VastuPlanImportDataPlanRoomsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var name: String { (raw["name"] as? String)! }
    public var roomType: String { (raw["roomType"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
}

public struct VastuPlanImportDataPlanOpeningsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var start: [Double] { (raw["start"] as? [Double])! }
    public var end: [Double] { (raw["end"] as? [Double])! }
    public var kind: String { (raw["kind"] as? String)! }
}

public struct VastuPlanImportDataPlanEntrance {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var start: [Double] { (raw["start"] as? [Double])! }
    public var end: [Double] { (raw["end"] as? [Double])! }
    public var kind: String { (raw["kind"] as? String)! }
}

public struct VastuPlanImportDataPlanImportReview {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var northKnown: Bool { vastuBool(raw["northKnown"])! }
    public var scaleKnown: Bool { vastuBool(raw["scaleKnown"])! }
    public var analysisReady: Bool { vastuBool(raw["analysisReady"])! }
    public var coordinateFrame: String { (raw["coordinateFrame"] as? String)! }
    public var units: String { (raw["units"] as? String)! }
}

public struct VastuPlanImportDataPlan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plot: VastuPlanImportDataPlanPlot { VastuPlanImportDataPlanPlot(raw: raw["plot"] as! [String: Any]) }
    public var rooms: [VastuPlanImportDataPlanRoomsItem] { (raw["rooms"] as! [[String: Any]]).map { VastuPlanImportDataPlanRoomsItem(raw: $0) } }
    public var openings: [VastuPlanImportDataPlanOpeningsItem] { (raw["openings"] as! [[String: Any]]).map { VastuPlanImportDataPlanOpeningsItem(raw: $0) } }
    public var entrance: VastuPlanImportDataPlanEntrance? { (raw["entrance"] as? [String: Any]).map { VastuPlanImportDataPlanEntrance(raw: $0) } }
    public var importReview: VastuPlanImportDataPlanImportReview { VastuPlanImportDataPlanImportReview(raw: raw["importReview"] as! [String: Any]) }
    public var units: String? { (raw["units"] as? String) }
}

public struct VastuPlanImportDataNorth {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var bearingDeg: Double? { vastuDouble(raw["bearingDeg"]) }
    public var confidence: Double { vastuDouble(raw["confidence"])! }
    public var source: String { (raw["source"] as? String)! }
}

public struct VastuPlanImportDataScale {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var metersPerUnit: Double? { vastuDouble(raw["metersPerUnit"]) }
    public var source: String { (raw["source"] as? String)! }
}

public struct VastuPlanImportDataDimensionsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var text: String { (raw["text"] as? String)! }
    public var start: [Double] { (raw["start"] as? [Double])! }
    public var end: [Double] { (raw["end"] as? [Double])! }
    public var confidence: Double { vastuDouble(raw["confidence"])! }
}

public struct VastuPlanImportDataNeedsReviewItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var field: String { (raw["field"] as? String)! }
    public var reason: String { (raw["reason"] as? String)! }
}

public struct VastuPlanImportDataSourceDocument {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var page: Int { vastuInt(raw["page"])! }
    public var pageCount: Int { vastuInt(raw["pageCount"])! }
}

public struct VastuPlanImportDataSource {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var method: String { (raw["method"] as? String)! }
    public var document: VastuPlanImportDataSourceDocument? { (raw["document"] as? [String: Any]).map { VastuPlanImportDataSourceDocument(raw: $0) } }
}

public struct VastuPlanImportDataUsage {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var inputTokens: Int { vastuInt(raw["inputTokens"])! }
    public var outputTokens: Int { vastuInt(raw["outputTokens"])! }
    public var computeMicros: Int { vastuInt(raw["computeMicros"])! }
    public var cpuMicros: Int { vastuInt(raw["cpuMicros"])! }
    public var deliveryBytes: Int { vastuInt(raw["deliveryBytes"])! }
}

public struct VastuPlanImportDataPricing {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var currency: String { (raw["currency"] as? String)! }
    public var attributableCost: String { (raw["attributableCost"] as? String)! }
    public var modelCost: String { (raw["modelCost"] as? String)! }
    public var computeCost: String { (raw["computeCost"] as? String)! }
    public var markup: Int { vastuInt(raw["markup"])! }
    public var price: String { (raw["price"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var walletRounding: String { (raw["walletRounding"] as? String)! }
    public var computedPrice: String { (raw["computedPrice"] as? String)! }
    public var deliveryCost: String { (raw["deliveryCost"] as? String)! }
}

public struct VastuPlanImportDxfDataPlanPlot {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var width: Double { vastuDouble(raw["width"])! }
    public var length: Double { vastuDouble(raw["length"])! }
    public var polygon: [[Double]]? { (raw["polygon"] as? [[Double]]) }
    public var units: String? { (raw["units"] as? String) }
}

public struct VastuPlanImportDxfDataPlanRoomsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var name: String { (raw["name"] as? String)! }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
    public var x: Double? { vastuDouble(raw["x"]) }
    public var y: Double? { vastuDouble(raw["y"]) }
    public var w: Double? { vastuDouble(raw["w"]) }
    public var h: Double? { vastuDouble(raw["h"]) }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var holes: [[[Double]]]? { (raw["holes"] as? [[[Double]]]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
    public var labelEntityId: String? { (raw["labelEntityId"] as? String) }
}

public struct VastuPlanImportDxfDataPlanOpeningsDoorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var type: String { (raw["type"] as? String)! }
    public var line: [[Double]] { (raw["line"] as? [[Double]])! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
}

public struct VastuPlanImportDxfDataPlanOpeningsWindowsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var type: String { (raw["type"] as? String)! }
    public var line: [[Double]] { (raw["line"] as? [[Double]])! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
}

public struct VastuPlanImportDxfDataPlanOpenings {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var doors: [VastuPlanImportDxfDataPlanOpeningsDoorsItem]? { (raw["doors"] as? [[String: Any]])?.map { VastuPlanImportDxfDataPlanOpeningsDoorsItem(raw: $0) } }
    public var windows: [VastuPlanImportDxfDataPlanOpeningsWindowsItem]? { (raw["windows"] as? [[String: Any]])?.map { VastuPlanImportDxfDataPlanOpeningsWindowsItem(raw: $0) } }
    public var units: String? { (raw["units"] as? String) }
}

public struct VastuPlanImportDxfDataPlan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plot: VastuPlanImportDxfDataPlanPlot { VastuPlanImportDxfDataPlanPlot(raw: raw["plot"] as! [String: Any]) }
    public var rooms: [VastuPlanImportDxfDataPlanRoomsItem] { (raw["rooms"] as! [[String: Any]]).map { VastuPlanImportDxfDataPlanRoomsItem(raw: $0) } }
    public var openings: VastuPlanImportDxfDataPlanOpenings? { (raw["openings"] as? [String: Any]).map { VastuPlanImportDxfDataPlanOpenings(raw: $0) } }
    public var trueNorthDeg: Double { vastuDouble(raw["trueNorthDeg"])! }
    public var orientationDeg: Double? { vastuDouble(raw["orientationDeg"]) }
    public var units: String { (raw["units"] as? String)! }
    public var cadMetadata: [String: Any]? { (raw["cadMetadata"] as? [String: Any]) }
}

public struct VastuPlanImportDxfDataMappingReportItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var entityId: String { (raw["entityId"] as? String)! }
    public var handle: String? { (raw["handle"] as? String) }
    public var stepId: Int? { vastuInt(raw["stepId"]) }
    public var entityType: String { (raw["entityType"] as? String)! }
    public var layer: String? { (raw["layer"] as? String) }
    public var role: String? { (raw["role"] as? String) }
    public var status: String { (raw["status"] as? String)! }
    public var planIds: [String]? { (raw["planIds"] as? [String]) }
    public var reason: String? { (raw["reason"] as? String) }
    public var parentId: String? { (raw["parentId"] as? String) }
}

public struct VastuPlanImportDxfDataReviewReasonsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String? { (raw["id"] as? String) }
    public var reason: String { (raw["reason"] as? String)! }
}

public struct VastuPlanImportIfcDataBuildingsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var name: String { (raw["name"] as? String)! }
}

public struct VastuPlanImportIfcDataStoreysItemPlanPlot {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var width: Double { vastuDouble(raw["width"])! }
    public var length: Double { vastuDouble(raw["length"])! }
    public var polygon: [[Double]]? { (raw["polygon"] as? [[Double]]) }
    public var units: String? { (raw["units"] as? String) }
}

public struct VastuPlanImportIfcDataStoreysItemPlanRoomsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var name: String { (raw["name"] as? String)! }
    public var polygon: [[Double]] { (raw["polygon"] as? [[Double]])! }
    public var x: Double? { vastuDouble(raw["x"]) }
    public var y: Double? { vastuDouble(raw["y"]) }
    public var w: Double? { vastuDouble(raw["w"]) }
    public var h: Double? { vastuDouble(raw["h"]) }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var holes: [[[Double]]]? { (raw["holes"] as? [[[Double]]]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
}

public struct VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var type: String { (raw["type"] as? String)! }
    public var line: [[Double]] { (raw["line"] as? [[Double]])! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
    public var name: String? { (raw["name"] as? String) }
    public var openingHeight: Double? { vastuDouble(raw["openingHeight"]) }
}

public struct VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var type: String { (raw["type"] as? String)! }
    public var line: [[Double]] { (raw["line"] as? [[Double]])! }
    public var width: Double { vastuDouble(raw["width"])! }
    public var centre: [Double]? { (raw["centre"] as? [Double]) }
    public var source: [String: Any]? { (raw["source"] as? [String: Any]) }
    public var name: String? { (raw["name"] as? String) }
    public var openingHeight: Double? { vastuDouble(raw["openingHeight"]) }
}

public struct VastuPlanImportIfcDataStoreysItemPlanOpenings {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var doors: [VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem]? { (raw["doors"] as? [[String: Any]])?.map { VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem(raw: $0) } }
    public var windows: [VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem]? { (raw["windows"] as? [[String: Any]])?.map { VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem(raw: $0) } }
    public var units: String? { (raw["units"] as? String) }
}

public struct VastuPlanImportIfcDataStoreysItemPlan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plot: VastuPlanImportIfcDataStoreysItemPlanPlot { VastuPlanImportIfcDataStoreysItemPlanPlot(raw: raw["plot"] as! [String: Any]) }
    public var rooms: [VastuPlanImportIfcDataStoreysItemPlanRoomsItem] { (raw["rooms"] as! [[String: Any]]).map { VastuPlanImportIfcDataStoreysItemPlanRoomsItem(raw: $0) } }
    public var openings: VastuPlanImportIfcDataStoreysItemPlanOpenings? { (raw["openings"] as? [String: Any]).map { VastuPlanImportIfcDataStoreysItemPlanOpenings(raw: $0) } }
    public var trueNorthDeg: Double { vastuDouble(raw["trueNorthDeg"])! }
    public var orientationDeg: Double? { vastuDouble(raw["orientationDeg"]) }
    public var units: String { (raw["units"] as? String)! }
    public var cadMetadata: [String: Any]? { (raw["cadMetadata"] as? [String: Any]) }
}

public struct VastuPlanImportIfcDataStoreysItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var name: String { (raw["name"] as? String)! }
    public var buildingId: String? { (raw["buildingId"] as? String) }
    public var elevationMetres: Double? { vastuDouble(raw["elevationMetres"]) }
    public var plan: VastuPlanImportIfcDataStoreysItemPlan { VastuPlanImportIfcDataStoreysItemPlan(raw: raw["plan"] as! [String: Any]) }
}

public struct VastuPlanImportIfcDataMappingReportItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var entityId: String { (raw["entityId"] as? String)! }
    public var handle: String? { (raw["handle"] as? String) }
    public var stepId: Int? { vastuInt(raw["stepId"]) }
    public var entityType: String { (raw["entityType"] as? String)! }
    public var layer: String? { (raw["layer"] as? String) }
    public var role: String? { (raw["role"] as? String) }
    public var status: String { (raw["status"] as? String)! }
    public var planIds: [String]? { (raw["planIds"] as? [String]) }
    public var reason: String? { (raw["reason"] as? String) }
    public var storeyId: String? { (raw["storeyId"] as? String) }
}

public struct VastuPlanImportIfcDataReviewReasonsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String? { (raw["id"] as? String) }
    public var reason: String { (raw["reason"] as? String)! }
}

public struct VastuPlanOptimizeDataPlotRegionGeometry {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var polygon: Any? { (raw["polygon"] is NSNull ? nil : raw["polygon"]) }
    public var holes: [Any]? { (raw["holes"] as? [Any]) }
    public var multipolygons: [Any]? { (raw["multipolygons"] as? [Any]) }
}

public struct VastuPlanOptimizeDataPlotRegionBrahmasthan {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var pole: [Double]? { (raw["pole"] as? [Double]) }
    public var poleInside: Bool? { vastuBool(raw["poleInside"]) }
    public var basis: String? { (raw["basis"] as? String) }
    public var netArea: Double? { vastuDouble(raw["netArea"]) }
}

public struct VastuPlanOptimizeDataPlotRegionGridZonesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanOptimizeDataPlotRegionSectorsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var zone: String? { (raw["zone"] as? String) }
    public var area: Double? { vastuDouble(raw["area"]) }
}

public struct VastuPlanOptimizeDataPlotRegion {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var geometry: VastuPlanOptimizeDataPlotRegionGeometry? { (raw["geometry"] as? [String: Any]).map { VastuPlanOptimizeDataPlotRegionGeometry(raw: $0) } }
    public var area: Double? { vastuDouble(raw["area"]) }
    public var centroid: [Double]? { (raw["centroid"] as? [Double]) }
    public var centroidInside: Bool? { vastuBool(raw["centroidInside"]) }
    public var brahmasthan: VastuPlanOptimizeDataPlotRegionBrahmasthan? { (raw["brahmasthan"] as? [String: Any]).map { VastuPlanOptimizeDataPlotRegionBrahmasthan(raw: $0) } }
    public var gridZones: [VastuPlanOptimizeDataPlotRegionGridZonesItem]? { (raw["gridZones"] as? [[String: Any]])?.map { VastuPlanOptimizeDataPlotRegionGridZonesItem(raw: $0) } }
    public var sectors: [VastuPlanOptimizeDataPlotRegionSectorsItem]? { (raw["sectors"] as? [[String: Any]])?.map { VastuPlanOptimizeDataPlotRegionSectorsItem(raw: $0) } }
}

public struct VastuPlotFromSurveyDataPricing {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var attributableCostUsd: String { (raw["attributableCostUsd"] as? String)! }
    public var markupMultiplier: Int { vastuInt(raw["markupMultiplier"])! }
    public var computedPriceUsd: String { (raw["computedPriceUsd"] as? String)! }
    public var settledChargeUsd: String { (raw["settledChargeUsd"] as? String)! }
    public var settlement: String { (raw["settlement"] as? String)! }
}

public struct VastuPortfolioAnalyticsDataAccountCounts {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertiesCreated: Int { vastuInt(raw["propertiesCreated"])! }
    public var propertiesAssessed: Int { vastuInt(raw["propertiesAssessed"])! }
    public var reportsDelivered: Int { vastuInt(raw["reportsDelivered"])! }
    public var returningProperties: Int { vastuInt(raw["returningProperties"])! }
}

public struct VastuPortfolioAnalyticsDataAccountDailyItemCounts {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertiesCreated: Int { vastuInt(raw["propertiesCreated"])! }
    public var propertiesAssessed: Int { vastuInt(raw["propertiesAssessed"])! }
    public var reportsDelivered: Int { vastuInt(raw["reportsDelivered"])! }
    public var returningProperties: Int { vastuInt(raw["returningProperties"])! }
}

public struct VastuPortfolioAnalyticsDataAccountDailyItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var date: String { (raw["date"] as? String)! }
    public var counts: VastuPortfolioAnalyticsDataAccountDailyItemCounts { VastuPortfolioAnalyticsDataAccountDailyItemCounts(raw: raw["counts"] as! [String: Any]) }
}

public struct VastuPortfolioAnalyticsDataAccount {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var counts: VastuPortfolioAnalyticsDataAccountCounts { VastuPortfolioAnalyticsDataAccountCounts(raw: raw["counts"] as! [String: Any]) }
    public var daily: [VastuPortfolioAnalyticsDataAccountDailyItem] { (raw["daily"] as! [[String: Any]]).map { VastuPortfolioAnalyticsDataAccountDailyItem(raw: $0) } }
    public var returningDefinition: String { (raw["returningDefinition"] as? String)! }
    public var deliveryDefinition: String { (raw["deliveryDefinition"] as? String)! }
    public var coverage: String { (raw["coverage"] as? String)! }
}

public struct VastuPortfolioBudgetsSetDataScope {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String? { (raw["propertyId"] as? String) }
    public var tenantRef: String? { (raw["tenantRef"] as? String) }
}

public struct VastuPortfolioCompareDataPropertiesItemAssessment {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var inputSource: String? { (raw["inputSource"] as? String) }
    public var ruleset: String? { (raw["ruleset"] as? String) }
    public var zoneDefects: [String]? { (raw["zoneDefects"] as? [String]) }
    public var kind: String? { (raw["kind"] as? String) }
}

public struct VastuPortfolioCompareDataPropertiesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var title: String { (raw["title"] as? String)! }
    public var city: String { (raw["city"] as? String)! }
    public var tags: [String] { (raw["tags"] as? [String])! }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var assessment: VastuPortfolioCompareDataPropertiesItemAssessment? { (raw["assessment"] as? [String: Any]).map { VastuPortfolioCompareDataPropertiesItemAssessment(raw: $0) } }
    public var assessedAtEpoch: Int? { vastuInt(raw["assessedAtEpoch"]) }
}

public struct VastuPortfolioSearchDataPropertiesItemAssessment {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var score: Int? { vastuInt(raw["score"]) }
    public var grade: String? { (raw["grade"] as? String) }
    public var inputSource: String? { (raw["inputSource"] as? String) }
    public var ruleset: String? { (raw["ruleset"] as? String) }
    public var zoneDefects: [String]? { (raw["zoneDefects"] as? [String]) }
    public var kind: String? { (raw["kind"] as? String) }
}

public struct VastuPortfolioSearchDataPropertiesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var title: String { (raw["title"] as? String)! }
    public var city: String { (raw["city"] as? String)! }
    public var tags: [String] { (raw["tags"] as? [String])! }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var assessment: VastuPortfolioSearchDataPropertiesItemAssessment? { (raw["assessment"] as? [String: Any]).map { VastuPortfolioSearchDataPropertiesItemAssessment(raw: $0) } }
    public var assessedAtEpoch: Int? { vastuInt(raw["assessedAtEpoch"]) }
}

public struct VastuPortfolioUsageDataGroupsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String? { (raw["propertyId"] as? String) }
    public var tenantRef: String? { (raw["tenantRef"] as? String) }
    public var calls: Int { vastuInt(raw["calls"])! }
    public var chargedUsd: String { (raw["chargedUsd"] as? String)! }
    public var pending: Int { vastuInt(raw["pending"])! }
}

public struct VastuPropertiesActivityExportDataEventsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var sequence: Int { vastuInt(raw["sequence"])! }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var action: String { (raw["action"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var previousHash: String { (raw["previousHash"] as? String)! }
    public var hash: String { (raw["hash"] as? String)! }
    public var details: [String: Any] { (raw["details"] as? [String: Any])! }
}

public struct VastuPropertiesActivityListDataEventsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var sequence: Int { vastuInt(raw["sequence"])! }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var action: String { (raw["action"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var previousHash: String { (raw["previousHash"] as? String)! }
    public var hash: String { (raw["hash"] as? String)! }
    public var details: [String: Any] { (raw["details"] as? [String: Any])! }
}

public struct VastuPropertiesCollaborationCommentDataComment {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var text: String { (raw["text"] as? String)! }
}

public struct VastuPropertiesCollaborationGetDataPropertyIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesCollaborationGetDataPropertyArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesCollaborationGetDataProperty {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesCollaborationGetDataPropertyIds { VastuPropertiesCollaborationGetDataPropertyIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesCollaborationGetDataPropertyArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesCollaborationGetDataPropertyArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
}

public struct VastuPropertiesCollaborationGetDataCommentsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var text: String { (raw["text"] as? String)! }
}

public struct VastuPropertiesCollaborationGetDataReviewsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var decision: String { (raw["decision"] as? String)! }
}

public struct VastuPropertiesCollaborationReviewDataReview {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var actorId: String { (raw["actorId"] as? String)! }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var at: Int { vastuInt(raw["at"])! }
    public var decision: String { (raw["decision"] as? String)! }
}

public struct VastuPropertiesCollaborationUpdateDataPropertyIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesCollaborationUpdateDataPropertyArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesCollaborationUpdateDataProperty {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesCollaborationUpdateDataPropertyIds { VastuPropertiesCollaborationUpdateDataPropertyIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesCollaborationUpdateDataPropertyArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesCollaborationUpdateDataPropertyArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
}

public struct VastuPropertiesCreateDataIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesCreateDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesDeleteDataErasureReceiptRemovedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var kind: String { (raw["kind"] as? String)! }
    public var recordId: String? { (raw["recordId"] as? String) }
    public var artifactId: String? { (raw["artifactId"] as? String) }
    public var artifactHash: String? { (raw["artifactHash"] as? String) }
    public var versionHash: String? { (raw["versionHash"] as? String) }
    public var deleteMarker: Bool? { vastuBool(raw["deleteMarker"]) }
    public var versionCount: Int? { vastuInt(raw["versionCount"]) }
    public var deleteMarkerCount: Int? { vastuInt(raw["deleteMarkerCount"]) }
    public var versionsSha256: String? { (raw["versionsSha256"] as? String) }
}

public struct VastuPropertiesDeleteDataErasureReceiptRetainedItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var kind: String { (raw["kind"] as? String)! }
    public var purpose: String { (raw["purpose"] as? String)! }
}

public struct VastuPropertiesDeleteDataErasureReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var schemaVersion: Int { vastuInt(raw["schemaVersion"])! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var scope: String { (raw["scope"] as? String)! }
    public var completedAt: String { (raw["completedAt"] as? String)! }
    public var removed: [VastuPropertiesDeleteDataErasureReceiptRemovedItem] { (raw["removed"] as! [[String: Any]]).map { VastuPropertiesDeleteDataErasureReceiptRemovedItem(raw: $0) } }
    public var retained: [VastuPropertiesDeleteDataErasureReceiptRetainedItem] { (raw["retained"] as! [[String: Any]]).map { VastuPropertiesDeleteDataErasureReceiptRetainedItem(raw: $0) } }
    public var backupRetentionDays: Int { vastuInt(raw["backupRetentionDays"])! }
    public var backupPolicy: String { (raw["backupPolicy"] as? String)! }
    public var hashAlgorithm: String { (raw["hashAlgorithm"] as? String)! }
    public var receiptHash: String { (raw["receiptHash"] as? String)! }
    public var linkedScanIds: [String]? { (raw["linkedScanIds"] as? [String]) }
    public var linkedAssessmentIds: [String]? { (raw["linkedAssessmentIds"] as? [String]) }
    public var deletedByAccountHash: String { (raw["deletedByAccountHash"] as? String)! }
    public var deletedAtEpoch: Int { vastuInt(raw["deletedAtEpoch"])! }
    public var revisionId: String? { (raw["revisionId"] as? String) }
}

public struct VastuPropertiesGetDataIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesGetDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesLinkScanDataIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesLinkScanDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesListDataPropertiesItemIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesListDataPropertiesItemArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuPropertiesListDataPropertiesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesListDataPropertiesItemIds { VastuPropertiesListDataPropertiesItemIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesListDataPropertiesItemArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesListDataPropertiesItemArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
}

public struct VastuPropertiesUpdateDataIds {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var project: String { (raw["project"] as? String)! }
    public var building: String { (raw["building"] as? String)! }
    public var unit: String { (raw["unit"] as? String)! }
    public var floor: String { (raw["floor"] as? String)! }
    public var revision: String { (raw["revision"] as? String)! }
}

public struct VastuPropertiesUpdateDataArchiveTier {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var months: Int { vastuInt(raw["months"])! }
    public var storedBytes: Int { vastuInt(raw["storedBytes"])! }
    public var priceCents: Int { vastuInt(raw["priceCents"])! }
    public var setAtEpoch: Int { vastuInt(raw["setAtEpoch"])! }
    public var retainUntilEpoch: Int { vastuInt(raw["retainUntilEpoch"])! }
}

public struct VastuQuoteCalculateDataLineItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var slug: String? { (raw["slug"] as? String) }
    public var label: String? { (raw["label"] as? String) }
    public var quantity: Int? { vastuInt(raw["quantity"]) }
    public var baseCostUsd: String? { (raw["baseCostUsd"] as? String) }
    public var totalPriceUsd: String? { (raw["totalPriceUsd"] as? String) }
    public var category: String? { (raw["category"] as? String) }
}

public struct VastuReceiptVerifyDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
    public var inputHash: String { (raw["inputHash"] as? String)! }
    public var resultHash: String { (raw["resultHash"] as? String)! }
    public var rulesVersion: String { (raw["rulesVersion"] as? String)! }
    public var score: Int { vastuInt(raw["score"])! }
    public var grade: String? { (raw["grade"] as? String) }
    public var sourceLabels: [String] { (raw["sourceLabels"] as? [String])! }
    public var timestamp: Int { vastuInt(raw["timestamp"])! }
}

public struct VastuRemediationTaskDataEvidenceItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var reference: String { (raw["reference"] as? String)! }
    public var photoRef: String? { (raw["photoRef"] as? String) }
    public var note: String? { (raw["note"] as? String) }
}

public struct VastuRemediationTaskDataReassessmentLinkRequest {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
}

public struct VastuRemediationTaskDataReassessmentLink {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var operation: String { (raw["operation"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var request: VastuRemediationTaskDataReassessmentLinkRequest { VastuRemediationTaskDataReassessmentLinkRequest(raw: raw["request"] as! [String: Any]) }
    public var resultPointer: String { (raw["resultPointer"] as? String)! }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var taskId: String { (raw["taskId"] as? String)! }
    public var assessmentId: String { (raw["assessmentId"] as? String)! }
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

public struct VastuSpecializedAuditDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
}

public struct VastuSunPathDataInput {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var lat: Double { vastuDouble(raw["lat"])! }
    public var lon: Double { vastuDouble(raw["lon"])! }
    public var date: String { (raw["date"] as? String)! }
}

public struct VastuWorkflowDataDataItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var itemId: String { (raw["itemId"] as? String)! }
    public var kind: String { (raw["kind"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var availability: String { (raw["availability"] as? String)! }
    public var link: String? { (raw["link"] as? String) }
    public var referralRef: String? { (raw["referralRef"] as? String) }
}

public struct VastuWorkflowDataData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String? { (raw["propertyId"] as? String) }
    public var catalogId: String? { (raw["catalogId"] as? String) }
    public var tasks: [String: VastuRemediationTaskData]? { (raw["tasks"] as? [String: Any])?.mapValues { VastuRemediationTaskData(raw: $0 as! [String: Any]) } }
    public var items: [VastuWorkflowDataDataItemsItem]? { (raw["items"] as? [[String: Any]])?.map { VastuWorkflowDataDataItemsItem(raw: $0) } }
}

public struct VastuWorkflowDataRemediesItemMappedItemsItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var itemId: String { (raw["itemId"] as? String)! }
    public var kind: String { (raw["kind"] as? String)! }
    public var label: String { (raw["label"] as? String)! }
    public var availability: String { (raw["availability"] as? String)! }
    public var link: String? { (raw["link"] as? String) }
    public var referralRef: String? { (raw["referralRef"] as? String) }
}

public struct VastuWorkflowDataRemediesItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var remedyKey: String? { (raw["remedyKey"] as? String) }
    public var remedy: String? { (raw["remedy"] as? String) }
    public var classification: String? { (raw["classification"] as? String) }
    public var source: String? { (raw["source"] as? String) }
    public var mappedItems: [VastuWorkflowDataRemediesItemMappedItemsItem]? { (raw["mappedItems"] as? [[String: Any]])?.map { VastuWorkflowDataRemediesItemMappedItemsItem(raw: $0) } }
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

public struct VastuZoneWiseScoreDataReceipt {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var format: String { (raw["format"] as? String)! }
    public var token: String { (raw["token"] as? String)! }
    public var verifyUrl: String { (raw["verifyUrl"] as? String)! }
    public var keyUrl: String { (raw["keyUrl"] as? String)! }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArAttestationChallengeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var challenge: String? { (raw["challenge"] as? String) }
    public var expiresAtEpoch: Int? { vastuInt(raw["expiresAtEpoch"]) }
    public var ttlSeconds: Int? { vastuInt(raw["ttlSeconds"]) }
    public var singleUse: Bool { vastuBool(raw["singleUse"])! }
    public var deviceAttestation: VastuArAttestationChallengeDataDeviceAttestation { VastuArAttestationChallengeDataDeviceAttestation(raw: raw["deviceAttestation"] as! [String: Any]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArCaptureMergeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var method: String { (raw["method"] as? String)! }
    public var frame: [String: Any] { (raw["frame"] as? [String: Any])! }
    public var rooms: [[String: Any]] { (raw["rooms"] as? [[String: Any]])! }
    public var outlines: [[String: Any]] { (raw["outlines"] as? [[String: Any]])! }
    public var registrations: [[String: Any]] { (raw["registrations"] as? [[String: Any]])! }
    public var pairResiduals: [VastuArCaptureMergeDataPairResidualsItem] { (raw["pairResiduals"] as! [[String: Any]]).map { VastuArCaptureMergeDataPairResidualsItem(raw: $0) } }
    public var unresolvedAlignmentErrors: [String] { (raw["unresolvedAlignmentErrors"] as? [String])! }
    public var floorStack: [[String: Any]] { (raw["floorStack"] as? [[String: Any]])! }
    public var toleranceM: Double { vastuDouble(raw["toleranceM"])! }
    public var alignmentMethod: String { (raw["alignmentMethod"] as? String)! }
    public var pricing: VastuArCaptureMergeDataPricing? { (raw["pricing"] as? [String: Any]).map { VastuArCaptureMergeDataPricing(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArDeityIconsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var icons: [VastuArDeityIconsDataIconsItem] { (raw["icons"] as! [[String: Any]]).map { VastuArDeityIconsDataIconsItem(raw: $0) } }
    public var verified: Bool { vastuBool(raw["verified"])! }
    public var provenance: Any { raw["provenance"]! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var deviceAttestation: Any { raw["deviceAttestation"]! }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var deviceAttestation: Any? { (raw["deviceAttestation"] is NSNull ? nil : raw["deviceAttestation"]) }
    public var deviceAttested: Bool? { vastuBool(raw["deviceAttested"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuArScanQualityDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuArScanQualityDataReceipt(raw: $0) } }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArchiveDeleteData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var deleted: Bool { vastuBool(raw["deleted"])! }
    public var exportDeleted: Bool { vastuBool(raw["exportDeleted"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var erasureStatus: String? { (raw["erasureStatus"] as? String) }
    public var erasureReceipt: VastuArchiveDeleteDataErasureReceipt? { (raw["erasureReceipt"] as? [String: Any]).map { VastuArchiveDeleteDataErasureReceipt(raw: $0) } }
    public var retryAfterEpoch: Int? { vastuInt(raw["retryAfterEpoch"]) }
    public var revisionId: String? { (raw["revisionId"] as? String) }
    public var replayed: Bool? { vastuBool(raw["replayed"]) }
}

public struct VastuArchiveExportData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var downloadUrl: String { (raw["downloadUrl"] as? String)! }
    public var expiresInSeconds: Int { vastuInt(raw["expiresInSeconds"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var sizeBytes: Int { vastuInt(raw["sizeBytes"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArchiveSummaryData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var archiveTier: VastuArchiveSummaryDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuArchiveSummaryDataArchiveTier(raw: $0) } }
    public var linkedScanCount: Int { vastuInt(raw["linkedScanCount"])! }
    public var linkedAssessmentCount: Int { vastuInt(raw["linkedAssessmentCount"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuArchiveTierData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String? { (raw["ownerId"] as? String) }
    public var ids: VastuArchiveTierDataIds? { (raw["ids"] as? [String: Any]).map { VastuArchiveTierDataIds(raw: $0) } }
    public var title: String? { (raw["title"] as? String) }
    public var data: [String: Any]? { (raw["data"] as? [String: Any]) }
    public var retentionDays: Int? { vastuInt(raw["retentionDays"]) }
    public var expiresAtEpoch: Int? { vastuInt(raw["expiresAtEpoch"]) }
    public var linkedScanIds: [String]? { (raw["linkedScanIds"] as? [String]) }
    public var linkedAssessmentIds: [String]? { (raw["linkedAssessmentIds"] as? [String]) }
    public var archiveTier: VastuArchiveTierDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuArchiveTierDataArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int? { vastuInt(raw["createdAtEpoch"]) }
    public var updatedAtEpoch: Int? { vastuInt(raw["updatedAtEpoch"]) }
    public var contentHash: String? { (raw["contentHash"] as? String) }
    public var months: Int? { vastuInt(raw["months"]) }
    public var storedBytes: Int? { vastuInt(raw["storedBytes"]) }
    public var meterCents: Int? { vastuInt(raw["meterCents"]) }
    public var actionCents: Int? { vastuInt(raw["actionCents"]) }
    public var totalCents: Int? { vastuInt(raw["totalCents"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuAssessmentBatchData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var results: [VastuAssessmentBatchDataResultsItem] { (raw["results"] as! [[String: Any]]).map { VastuAssessmentBatchDataResultsItem(raw: $0) } }
    public var summary: VastuAssessmentBatchDataSummary { VastuAssessmentBatchDataSummary(raw: raw["summary"] as! [String: Any]) }
    public var billingBasis: String { (raw["billingBasis"] as? String)! }
    public var execution: String { (raw["execution"] as? String)! }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var warnings: [[String: Any]]? { (raw["warnings"] as? [[String: Any]]) }
    public var zoneCheck: [String: Any]? { (raw["zoneCheck"] as? [String: Any]) }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuAssessmentDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuAssessmentDataReceipt(raw: $0) } }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var centroidBasis: String? { (raw["centroidBasis"] as? String) }
    public var centerPolygonCentre: [Double]? { (raw["centerPolygonCentre"] as? [Double]) }
    public var centreBasis: String? { (raw["centreBasis"] as? String) }
    public var centreOffset: Double? { vastuDouble(raw["centreOffset"]) }
    public var centreNote: String? { (raw["centreNote"] as? String) }
    public var gridFrame: VastuBrahmasthanProjectionDataGridFrame? { (raw["gridFrame"] as? [String: Any]).map { VastuBrahmasthanProjectionDataGridFrame(raw: $0) } }
    public var inPlotArea: Double? { vastuDouble(raw["inPlotArea"]) }
    public var inPlotFraction: Double? { vastuDouble(raw["inPlotFraction"]) }
    public var shareOfPlotArea: Double? { vastuDouble(raw["shareOfPlotArea"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var zoneRemedies: [VastuCatalogReferenceDataZoneRemediesItem]? { (raw["zoneRemedies"] as? [[String: Any]])?.map { VastuCatalogReferenceDataZoneRemediesItem(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuChatUploadData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var success: Bool { vastuBool(raw["success"])! }
    public var uploadId: String { (raw["uploadId"] as? String)! }
    public var pages: Int { vastuInt(raw["pages"])! }
    public var charsExtracted: Int { vastuInt(raw["charsExtracted"])! }
    public var expiresAt: String { (raw["expiresAt"] as? String)! }
    public var digestSha256: String { (raw["digestSha256"] as? String)! }
    public var pagesSkipped: Int? { vastuInt(raw["pagesSkipped"]) }
    public var textTruncated: Bool? { vastuBool(raw["textTruncated"]) }
    public var replayed: Bool? { vastuBool(raw["replayed"]) }
    public var billing: VastuChatUploadDataBilling? { (raw["billing"] as? [String: Any]).map { VastuChatUploadDataBilling(raw: $0) } }
    public var fileSha256: String { (raw["fileSha256"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuCompareVersionsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var inputHash: String { (raw["inputHash"] as? String)! }
    public var operation: String { (raw["operation"] as? String)! }
    public var fromVersion: String { (raw["fromVersion"] as? String)! }
    public var toVersion: String { (raw["toVersion"] as? String)! }
    public var fromAssessment: [String: Any] { (raw["fromAssessment"] as? [String: Any])! }
    public var toAssessment: [String: Any] { (raw["toAssessment"] as? [String: Any])! }
    public var changed: Bool { vastuBool(raw["changed"])! }
    public var changes: [VastuCompareVersionsDataChangesItem] { (raw["changes"] as! [[String: Any]]).map { VastuCompareVersionsDataChangesItem(raw: $0) } }
    public var retainedVersions: Int { vastuInt(raw["retainedVersions"])! }
    public var scope: String { (raw["scope"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuComplianceIndexDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuComplianceIndexDataReceipt(raw: $0) } }
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
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuDetailedFloorPlanAuditDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuDetailedFloorPlanAuditDataReceipt(raw: $0) } }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuDrawingSheetData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var html: String { (raw["html"] as? String)! }
    public var svg: String { (raw["svg"] as? String)! }
    public var paperSize: String { (raw["paperSize"] as? String)! }
    public var paperWidthMm: Double { vastuDouble(raw["paperWidthMm"])! }
    public var paperHeightMm: Double { vastuDouble(raw["paperHeightMm"])! }
    public var scaleDenominator: Int { vastuInt(raw["scaleDenominator"])! }
    public var metresToPaperMm: Double { vastuDouble(raw["metresToPaperMm"])! }
    public var planWidthMm: Double { vastuDouble(raw["planWidthMm"])! }
    public var planHeightMm: Double { vastuDouble(raw["planHeightMm"])! }
    public var trueNorthDeg: Double { vastuDouble(raw["trueNorthDeg"])! }
    public var fieldEvidenceCount: Int { vastuInt(raw["fieldEvidenceCount"])! }
    public var contentType: String? { (raw["contentType"] as? String) }
    public var pdfBase64: String? { (raw["pdfBase64"] as? String) }
    public var inputUnits: String { (raw["inputUnits"] as? String)! }
    public var units: String { (raw["units"] as? String)! }
    public var metresPerInputUnit: Double { vastuDouble(raw["metresPerInputUnit"])! }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuEntranceRecommendData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var facing: [String: Any] { (raw["facing"] as? [String: Any])! }
    public var bestEntrancePada: [String: Any] { (raw["bestEntrancePada"] as? [String: Any])! }
    public var bestEntranceIsUnfavourable: Bool? { vastuBool(raw["bestEntranceIsUnfavourable"]) }
    public var bestEntranceNote: String? { (raw["bestEntranceNote"] as? String) }
    public var recommendedPadas: [[String: Any]] { (raw["recommendedPadas"] as? [[String: Any]])! }
    public var avoidPadas: [[String: Any]] { (raw["avoidPadas"] as? [[String: Any]])! }
    public var facingCaution: [String: Any]? { (raw["facingCaution"] as? [String: Any]) }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var poojaPrescribedHere: [String: Any]? { (raw["poojaPrescribedHere"] as? [String: Any]) }
    public var prescribedRoomsAtFacing: [String]? { (raw["prescribedRoomsAtFacing"] as? [String]) }
    public var system: String? { (raw["system"] as? String) }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuFeedListingsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var accepted: Int { vastuInt(raw["accepted"])! }
    public var rejected: Int { vastuInt(raw["rejected"])! }
    public var skipped: Int { vastuInt(raw["skipped"])! }
    public var results: [[String: Any]] { (raw["results"] as? [[String: Any]])! }
    public var dryRun: Bool? { vastuBool(raw["dryRun"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuFloorPlanAuditDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuFloorPlanAuditDataReceipt(raw: $0) } }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuFusionChartData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var ascendant: [String: Any] { (raw["ascendant"] as? [String: Any])! }
    public var grahaDirections: [[String: Any]] { (raw["grahaDirections"] as? [[String: Any]])! }
    public var favourableDirections: [[String: Any]] { (raw["favourableDirections"] as? [[String: Any]])! }
    public var cautionDirections: [VastuFusionChartDataCautionDirectionsItem] { (raw["cautionDirections"] as! [[String: Any]]).map { VastuFusionChartDataCautionDirectionsItem(raw: $0) } }
    public var methodology: [String: Any] { (raw["methodology"] as? [String: Any])! }
    public var summary: String { (raw["summary"] as? String)! }
    public var sources: [String] { (raw["sources"] as? [String])! }
    public var meta: [String: Any]? { (raw["meta"] as? [String: Any]) }
    public var method: String? { (raw["method"] as? String) }
    public var system: String? { (raw["system"] as? String) }
    public var tradition: String? { (raw["tradition"] as? String) }
    public var verified: Bool? { vastuBool(raw["verified"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuJobResultsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var jobId: String { (raw["jobId"] as? String)! }
    public var jobStatus: String { (raw["jobStatus"] as? String)! }
    public var results: [Any] { (raw["results"] as? [Any])! }
    public var nextCursor: String? { (raw["nextCursor"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuJobStatusData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var jobId: String { (raw["jobId"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var operation: String { (raw["operation"] as? String)! }
    public var itemCount: Int { vastuInt(raw["itemCount"])! }
    public var counts: VastuJobStatusDataCounts { VastuJobStatusDataCounts(raw: raw["counts"] as! [String: Any]) }
    public var billing: VastuJobStatusDataBilling { VastuJobStatusDataBilling(raw: raw["billing"] as! [String: Any]) }
    public var cancelRequested: Bool { vastuBool(raw["cancelRequested"])! }
    public var webhookId: String? { (raw["webhookId"] as? String) }
    public var createdAt: Int { vastuInt(raw["createdAt"])! }
    public var updatedAt: Int { vastuInt(raw["updatedAt"])! }
    public var finishedAt: Int? { vastuInt(raw["finishedAt"]) }
    public var expiresAt: Int { vastuInt(raw["expiresAt"])! }
    public var resultsUrl: String { (raw["resultsUrl"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuJobSubmitData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var jobId: String { (raw["jobId"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var itemCount: Int { vastuInt(raw["itemCount"])! }
    public var maxCharge: Double { vastuDouble(raw["maxCharge"])! }
    public var replayed: Bool { vastuBool(raw["replayed"])! }
    public var preview: [Any]? { (raw["preview"] as? [Any]) }
    public var previewNote: String? { (raw["previewNote"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuMainGateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var facing: String { (raw["facing"] as? String)! }
    public var padaScheme: String { (raw["padaScheme"] as? String)! }
    public var prescribedPadas: [Int] { (raw["prescribedPadas"] as? [Int])! }
    public var facingAffectsPrescribedPadas: Bool? { vastuBool(raw["facingAffectsPrescribedPadas"]) }
    public var facingNote: String? { (raw["facingNote"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var gridFrame: VastuMandalaProjectionDataGridFrame? { (raw["gridFrame"] as? [String: Any]).map { VastuMandalaProjectionDataGridFrame(raw: $0) } }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuMeasurementUncertainty: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var pointResult: [String: Any] { (raw["pointResult"] as? [String: Any])! }
    public var results: [VastuMeasurementUncertaintyResultsItem] { (raw["results"] as! [[String: Any]]).map { VastuMeasurementUncertaintyResultsItem(raw: $0) } }
    public var stable: Bool { vastuBool(raw["stable"])! }
    public var bounds: VastuMeasurementUncertaintyBounds { VastuMeasurementUncertaintyBounds(raw: raw["bounds"] as! [String: Any]) }
    public var coordinateUnits: String? { (raw["coordinateUnits"] as? String) }
    public var rulesChanged: Bool { vastuBool(raw["rulesChanged"])! }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuOverallScoreDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuOverallScoreDataReceipt(raw: $0) } }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPlanAuditData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var system: String { (raw["system"] as? String)! }
    public var method: String { (raw["method"] as? String)! }
    public var input: [String: Any] { (raw["input"] as? [String: Any])! }
    public var facing: [String: Any] { (raw["facing"] as? [String: Any])! }
    public var plotShape: [String: Any]? { (raw["plotShape"] as? [String: Any]) }
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
    public var tracedGeometry: VastuPlanAuditDataTracedGeometry? { (raw["tracedGeometry"] as? [String: Any]).map { VastuPlanAuditDataTracedGeometry(raw: $0) } }
    public var gradeLabel: String? { (raw["gradeLabel"] as? String) }
    public var scoreDisclaimer: String? { (raw["scoreDisclaimer"] as? String) }
    public var artifact: VastuPlanAuditDataArtifact? { (raw["artifact"] as? [String: Any]).map { VastuPlanAuditDataArtifact(raw: $0) } }
    public var notAssessed: [VastuPlanAuditDataNotAssessedItem]? { (raw["notAssessed"] as? [[String: Any]])?.map { VastuPlanAuditDataNotAssessedItem(raw: $0) } }
    public var scoreNote: String? { (raw["scoreNote"] as? String) }
    public var warnings: [[String: Any]]? { (raw["warnings"] as? [[String: Any]]) }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuPlanAuditDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuPlanAuditDataReceipt(raw: $0) } }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
}

public struct VastuPlanConvertUnitsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plan: [String: Any] { (raw["plan"] as? [String: Any])! }
    public var inputUnits: String { (raw["inputUnits"] as? String)! }
    public var outputUnits: String { (raw["outputUnits"] as? String)! }
    public var scaleFactor: Double { vastuDouble(raw["scaleFactor"])! }
    public var canonicalUnits: String { (raw["canonicalUnits"] as? String)! }
    public var pricing: [String: Any]? { (raw["pricing"] as? [String: Any]) }
    public var units: String? { (raw["units"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
}

public struct VastuPlanExportDxfData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var dxf: String { (raw["dxf"] as? String)! }
    public var contentType: String { (raw["contentType"] as? String)! }
    public var fileName: String { (raw["fileName"] as? String)! }
    public var version: String { (raw["version"] as? String)! }
    public var unitsCode: Int { vastuInt(raw["unitsCode"])! }
    public var trueNorthDeg: Double { vastuDouble(raw["trueNorthDeg"])! }
    public var zones: Int { vastuInt(raw["zones"])! }
    public var roomCount: Int { vastuInt(raw["roomCount"])! }
    public var openingCount: Int { vastuInt(raw["openingCount"])! }
    public var dimensionCount: Int { vastuInt(raw["dimensionCount"])! }
    public var findingCount: Int { vastuInt(raw["findingCount"])! }
    public var needsReview: Bool { vastuBool(raw["needsReview"])! }
    public var pricing: [String: Any]? { (raw["pricing"] as? [String: Any]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
}

public struct VastuPlanExportIfcData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var ifc: String { (raw["ifc"] as? String)! }
    public var schema: String { (raw["schema"] as? String)! }
    public var contentType: String { (raw["contentType"] as? String)! }
    public var fileName: String { (raw["fileName"] as? String)! }
    public var outputUnits: String { (raw["outputUnits"] as? String)! }
    public var units: String? { (raw["units"] as? String) }
    public var roomCount: Int { vastuInt(raw["roomCount"])! }
    public var pricing: [String: Any]? { (raw["pricing"] as? [String: Any]) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
    public var canonicalUnits: String { (raw["canonicalUnits"] as? String)! }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
    public var plotRegion: VastuPlanGenerateDataPlotRegion? { (raw["plotRegion"] as? [String: Any]).map { VastuPlanGenerateDataPlotRegion(raw: $0) } }
}

public struct VastuPlanImportData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plan: VastuPlanImportDataPlan { VastuPlanImportDataPlan(raw: raw["plan"] as! [String: Any]) }
    public var north: VastuPlanImportDataNorth { VastuPlanImportDataNorth(raw: raw["north"] as! [String: Any]) }
    public var scale: VastuPlanImportDataScale { VastuPlanImportDataScale(raw: raw["scale"] as! [String: Any]) }
    public var dimensions: [VastuPlanImportDataDimensionsItem] { (raw["dimensions"] as! [[String: Any]]).map { VastuPlanImportDataDimensionsItem(raw: $0) } }
    public var confidence: [String: Any] { (raw["confidence"] as? [String: Any])! }
    public var needsReview: [VastuPlanImportDataNeedsReviewItem] { (raw["needsReview"] as! [[String: Any]]).map { VastuPlanImportDataNeedsReviewItem(raw: $0) } }
    public var analysisReady: Bool { vastuBool(raw["analysisReady"])! }
    public var source: VastuPlanImportDataSource { VastuPlanImportDataSource(raw: raw["source"] as! [String: Any]) }
    public var usage: VastuPlanImportDataUsage { VastuPlanImportDataUsage(raw: raw["usage"] as! [String: Any]) }
    public var pricing: VastuPlanImportDataPricing { VastuPlanImportDataPricing(raw: raw["pricing"] as! [String: Any]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
}

public struct VastuPlanImportDxfData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var plan: VastuPlanImportDxfDataPlan { VastuPlanImportDxfDataPlan(raw: raw["plan"] as! [String: Any]) }
    public var mappingReport: [VastuPlanImportDxfDataMappingReportItem] { (raw["mappingReport"] as! [[String: Any]]).map { VastuPlanImportDxfDataMappingReportItem(raw: $0) } }
    public var needsReview: Bool { vastuBool(raw["needsReview"])! }
    public var reviewReasons: [VastuPlanImportDxfDataReviewReasonsItem] { (raw["reviewReasons"] as! [[String: Any]]).map { VastuPlanImportDxfDataReviewReasonsItem(raw: $0) } }
    public var pricing: [String: Any]? { (raw["pricing"] as? [String: Any]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
}

public struct VastuPlanImportIfcData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var schema: String { (raw["schema"] as? String)! }
    public var buildings: [VastuPlanImportIfcDataBuildingsItem] { (raw["buildings"] as! [[String: Any]]).map { VastuPlanImportIfcDataBuildingsItem(raw: $0) } }
    public var storeys: [VastuPlanImportIfcDataStoreysItem] { (raw["storeys"] as! [[String: Any]]).map { VastuPlanImportIfcDataStoreysItem(raw: $0) } }
    public var trueNorthDeg: Double { vastuDouble(raw["trueNorthDeg"])! }
    public var mappingReport: [VastuPlanImportIfcDataMappingReportItem] { (raw["mappingReport"] as! [[String: Any]]).map { VastuPlanImportIfcDataMappingReportItem(raw: $0) } }
    public var needsReview: Bool { vastuBool(raw["needsReview"])! }
    public var reviewReasons: [VastuPlanImportIfcDataReviewReasonsItem] { (raw["reviewReasons"] as! [[String: Any]]).map { VastuPlanImportIfcDataReviewReasonsItem(raw: $0) } }
    public var pricing: [String: Any]? { (raw["pricing"] as? [String: Any]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var unmetConstraints: [[String: Any]]? { (raw["unmetConstraints"] as? [[String: Any]]) }
    public var initialConstraintViolations: [[String: Any]]? { (raw["initialConstraintViolations"] as? [[String: Any]]) }
    public var feasible: Bool? { vastuBool(raw["feasible"]) }
    public var search: [String: Any]? { (raw["search"] as? [String: Any]) }
    public var scoring: [String: Any]? { (raw["scoring"] as? [String: Any]) }
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var units: String? { (raw["units"] as? String) }
    public var inputUnits: String? { (raw["inputUnits"] as? String) }
    public var metresPerInputUnit: Double? { vastuDouble(raw["metresPerInputUnit"]) }
    public var plotRegion: VastuPlanOptimizeDataPlotRegion? { (raw["plotRegion"] as? [String: Any]).map { VastuPlanOptimizeDataPlotRegion(raw: $0) } }
}

public struct VastuPlotExtensionsCutsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var directions: [[String: Any]] { (raw["directions"] as? [[String: Any]])! }
    public var extensions: [String] { (raw["extensions"] as? [String])! }
    public var cuts: [String] { (raw["cuts"] as? [String])! }
    public var severeCuts: [String] { (raw["severeCuts"] as? [String])! }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPlotFromSurveyData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var method: String { (raw["method"] as? String)! }
    public var sourceCrs: String { (raw["sourceCrs"] as? String)! }
    public var sourceUnits: String { (raw["sourceUnits"] as? String)! }
    public var coordinateOrder: String { (raw["coordinateOrder"] as? String)! }
    public var frame: [String: Any] { (raw["frame"] as? [String: Any])! }
    public var plotPolygon: [[Double]] { (raw["plotPolygon"] as? [[Double]])! }
    public var controlPoints: [[String: Any]] { (raw["controlPoints"] as? [[String: Any]])! }
    public var areaM2: Double { vastuDouble(raw["areaM2"])! }
    public var gridConvergenceDeg: Double { vastuDouble(raw["gridConvergenceDeg"])! }
    public var boundaryGridConvergenceDeg: [Double] { (raw["boundaryGridConvergenceDeg"] as? [Double])! }
    public var trueNorthGridBearingDeg: Double { vastuDouble(raw["trueNorthGridBearingDeg"])! }
    public var maxDistanceFromOriginM: Double { vastuDouble(raw["maxDistanceFromOriginM"])! }
    public var pricing: VastuPlotFromSurveyDataPricing? { (raw["pricing"] as? [String: Any]).map { VastuPlotFromSurveyDataPricing(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rectangular: Bool? { vastuBool(raw["rectangular"]) }
    public var fillRatio: Double? { vastuDouble(raw["fillRatio"]) }
    public var ratioScope: String? { (raw["ratioScope"] as? String) }
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPortfolioAnalyticsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var fromEpoch: Int { vastuInt(raw["fromEpoch"])! }
    public var toEpoch: Int { vastuInt(raw["toEpoch"])! }
    public var account: VastuPortfolioAnalyticsDataAccount { VastuPortfolioAnalyticsDataAccount(raw: raw["account"] as! [String: Any]) }
    public var byTag: [String: Any] { (raw["byTag"] as? [String: Any])! }
}

public struct VastuPortfolioBudgetsGetData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var dimensions: [String: Any] { (raw["dimensions"] as? [String: Any])! }
    public var period: String { (raw["period"] as? String)! }
}

public struct VastuPortfolioBudgetsSetData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scope: VastuPortfolioBudgetsSetDataScope { VastuPortfolioBudgetsSetDataScope(raw: raw["scope"] as! [String: Any]) }
    public var capUsd: String? { (raw["capUsd"] as? String) }
    public var period: String { (raw["period"] as? String)! }
}

public struct VastuPortfolioCompareData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var properties: [VastuPortfolioCompareDataPropertiesItem] { (raw["properties"] as! [[String: Any]]).map { VastuPortfolioCompareDataPropertiesItem(raw: $0) } }
    public var comparableGroups: [String: Any] { (raw["comparableGroups"] as? [String: Any])! }
    public var crossRulesetRanking: Bool { vastuBool(raw["crossRulesetRanking"])! }
}

public struct VastuPortfolioSearchData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var properties: [VastuPortfolioSearchDataPropertiesItem] { (raw["properties"] as! [[String: Any]]).map { VastuPortfolioSearchDataPropertiesItem(raw: $0) } }
    public var total: Int { vastuInt(raw["total"])! }
    public var nextCursor: String? { (raw["nextCursor"] as? String) }
}

public struct VastuPortfolioUsageData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var fromEpoch: Int { vastuInt(raw["fromEpoch"])! }
    public var toEpoch: Int { vastuInt(raw["toEpoch"])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var groups: [VastuPortfolioUsageDataGroupsItem] { (raw["groups"] as! [[String: Any]]).map { VastuPortfolioUsageDataGroupsItem(raw: $0) } }
}

public struct VastuPortfolioUsageExportData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var csv: String { (raw["csv"] as? String)! }
    public var filename: String { (raw["filename"] as? String)! }
    public var contentType: String { (raw["contentType"] as? String)! }
}

public struct VastuPropertiesActivityExportData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var events: [VastuPropertiesActivityExportDataEventsItem] { (raw["events"] as! [[String: Any]]).map { VastuPropertiesActivityExportDataEventsItem(raw: $0) } }
    public var nextCursor: Int? { vastuInt(raw["nextCursor"]) }
    public var format: String { (raw["format"] as? String)! }
    public var content: String { (raw["content"] as? String)! }
}

public struct VastuPropertiesActivityListData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var events: [VastuPropertiesActivityListDataEventsItem] { (raw["events"] as! [[String: Any]]).map { VastuPropertiesActivityListDataEventsItem(raw: $0) } }
    public var nextCursor: Int? { vastuInt(raw["nextCursor"]) }
}

public struct VastuPropertiesCollaborationCommentData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var comment: VastuPropertiesCollaborationCommentDataComment { VastuPropertiesCollaborationCommentDataComment(raw: raw["comment"] as! [String: Any]) }
}

public struct VastuPropertiesCollaborationGetData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var property: VastuPropertiesCollaborationGetDataProperty { VastuPropertiesCollaborationGetDataProperty(raw: raw["property"] as! [String: Any]) }
    public var comments: [VastuPropertiesCollaborationGetDataCommentsItem] { (raw["comments"] as! [[String: Any]]).map { VastuPropertiesCollaborationGetDataCommentsItem(raw: $0) } }
    public var reviews: [VastuPropertiesCollaborationGetDataReviewsItem] { (raw["reviews"] as! [[String: Any]]).map { VastuPropertiesCollaborationGetDataReviewsItem(raw: $0) } }
}

public struct VastuPropertiesCollaborationInviteData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var invitationId: String { (raw["invitationId"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
}

public struct VastuPropertiesCollaborationMembersData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var members: [String: Any] { (raw["members"] as? [String: Any])! }
}

public struct VastuPropertiesCollaborationReviewData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var review: VastuPropertiesCollaborationReviewDataReview { VastuPropertiesCollaborationReviewDataReview(raw: raw["review"] as! [String: Any]) }
}

public struct VastuPropertiesCollaborationRevokeData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var accountId: String? { (raw["accountId"] as? String) }
    public var revoked: Bool { vastuBool(raw["revoked"])! }
    public var invitationId: String? { (raw["invitationId"] as? String) }
}

public struct VastuPropertiesCollaborationUpdateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var property: VastuPropertiesCollaborationUpdateDataProperty { VastuPropertiesCollaborationUpdateDataProperty(raw: raw["property"] as! [String: Any]) }
}

public struct VastuPropertiesCreateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesCreateDataIds { VastuPropertiesCreateDataIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesCreateDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesCreateDataArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPropertiesDeleteData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var deleted: Bool { vastuBool(raw["deleted"])! }
    public var erasureStatus: String? { (raw["erasureStatus"] as? String) }
    public var erasureReceipt: VastuPropertiesDeleteDataErasureReceipt? { (raw["erasureReceipt"] as? [String: Any]).map { VastuPropertiesDeleteDataErasureReceipt(raw: $0) } }
    public var retryAfterEpoch: Int? { vastuInt(raw["retryAfterEpoch"]) }
    public var exportDeleted: Bool? { vastuBool(raw["exportDeleted"]) }
    public var linkedScanIds: [String]? { (raw["linkedScanIds"] as? [String]) }
    public var linkedAssessmentIds: [String]? { (raw["linkedAssessmentIds"] as? [String]) }
    public var revisionId: String? { (raw["revisionId"] as? String) }
    public var replayed: Bool? { vastuBool(raw["replayed"]) }
}

public struct VastuPropertiesGetData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesGetDataIds { VastuPropertiesGetDataIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesGetDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesGetDataArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPropertiesLinkScanData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesLinkScanDataIds { VastuPropertiesLinkScanDataIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesLinkScanDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesLinkScanDataArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPropertiesListData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var properties: [VastuPropertiesListDataPropertiesItem] { (raw["properties"] as! [[String: Any]]).map { VastuPropertiesListDataPropertiesItem(raw: $0) } }
    public var nextCursor: String? { (raw["nextCursor"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuPropertiesUpdateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var propertyId: String { (raw["propertyId"] as? String)! }
    public var ownerId: String { (raw["ownerId"] as? String)! }
    public var ids: VastuPropertiesUpdateDataIds { VastuPropertiesUpdateDataIds(raw: raw["ids"] as! [String: Any]) }
    public var title: String { (raw["title"] as? String)! }
    public var data: [String: Any] { (raw["data"] as? [String: Any])! }
    public var retentionDays: Int { vastuInt(raw["retentionDays"])! }
    public var expiresAtEpoch: Int { vastuInt(raw["expiresAtEpoch"])! }
    public var linkedScanIds: [String] { (raw["linkedScanIds"] as? [String])! }
    public var linkedAssessmentIds: [String] { (raw["linkedAssessmentIds"] as? [String])! }
    public var archiveTier: VastuPropertiesUpdateDataArchiveTier? { (raw["archiveTier"] as? [String: Any]).map { VastuPropertiesUpdateDataArchiveTier(raw: $0) } }
    public var externalId: String? { (raw["externalId"] as? String) }
    public var createdAtEpoch: Int { vastuInt(raw["createdAtEpoch"])! }
    public var updatedAtEpoch: Int { vastuInt(raw["updatedAtEpoch"])! }
    public var contentHash: String { (raw["contentHash"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuQuoteCalculateData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var workflowId: String { (raw["workflowId"] as? String)! }
    public var currency: String { (raw["currency"] as? String)! }
    public var subtotal: String { (raw["subtotal"] as? String)! }
    public var total: String { (raw["total"] as? String)! }
    public var lineItems: [VastuQuoteCalculateDataLineItemsItem] { (raw["lineItems"] as! [[String: Any]]).map { VastuQuoteCalculateDataLineItemsItem(raw: $0) } }
    public var explanation: String { (raw["explanation"] as? String)! }
}

public struct VastuReceiptVerifyData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var valid: Bool { vastuBool(raw["valid"])! }
    public var receipt: VastuReceiptVerifyDataReceipt { VastuReceiptVerifyDataReceipt(raw: raw["receipt"] as! [String: Any]) }
    public var inputMatched: Bool? { vastuBool(raw["inputMatched"]) }
    public var charged: Double { vastuDouble(raw["charged"])! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuRemediationTaskData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var taskId: String { (raw["taskId"] as? String)! }
    public var reportRef: String { (raw["reportRef"] as? String)! }
    public var findingRef: String { (raw["findingRef"] as? String)! }
    public var remedyKey: String { (raw["remedyKey"] as? String)! }
    public var title: String { (raw["title"] as? String)! }
    public var status: String { (raw["status"] as? String)! }
    public var assignee: String? { (raw["assignee"] as? String) }
    public var dueDate: String? { (raw["dueDate"] as? String) }
    public var evidence: [VastuRemediationTaskDataEvidenceItem]? { (raw["evidence"] as? [[String: Any]])?.map { VastuRemediationTaskDataEvidenceItem(raw: $0) } }
    public var createdAt: Int? { vastuInt(raw["createdAt"]) }
    public var updatedAt: Int? { vastuInt(raw["updatedAt"]) }
    public var completedAt: Int? { vastuInt(raw["completedAt"]) }
    public var reassessment: [String: Any]? { (raw["reassessment"] as? [String: Any]) }
    public var reassessmentLink: VastuRemediationTaskDataReassessmentLink? { (raw["reassessmentLink"] as? [String: Any]).map { VastuRemediationTaskDataReassessmentLink(raw: $0) } }
    public var history: [[String: Any]]? { (raw["history"] as? [[String: Any]]) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var roomTypeApplied: String? { (raw["roomTypeApplied"] as? String) }
    public var roomTypeDefaulted: Bool? { vastuBool(raw["roomTypeDefaulted"]) }
    public var roomTypeNote: String? { (raw["roomTypeNote"] as? String) }
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuRuleVersionsData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var currentVersion: String { (raw["currentVersion"] as? String)! }
    public var retainedVersions: Int { vastuInt(raw["retainedVersions"])! }
    public var versions: [String] { (raw["versions"] as? [String])! }
    public var scope: String { (raw["scope"] as? String)! }
    public var scoringVersion: String { (raw["scoringVersion"] as? String)! }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuScansDeleteData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scanId: String { (raw["scanId"] as? String)! }
    public var deleted: Bool { vastuBool(raw["deleted"])! }
    public var deletionScope: String { (raw["deletionScope"] as? String)! }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuScansListData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scans: [Any] { (raw["scans"] as? [Any])! }
    public var nextCursor: String? { (raw["nextCursor"] as? String) }
    public var paginationNote: String? { (raw["paginationNote"] as? String) }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuScansRetrieveData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scan: Any { raw["scan"]! }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuScansSaveData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var scan: Any { raw["scan"]! }
    public var replayed: Bool { vastuBool(raw["replayed"])! }
    public var retentionNote: String? { (raw["retentionNote"] as? String) }
    public var persistence: String { (raw["persistence"] as? String)! }
    public var previewNote: String? { (raw["previewNote"] as? String) }
    public var deviceAttestation: Any? { (raw["deviceAttestation"] is NSNull ? nil : raw["deviceAttestation"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var uncertainty: VastuMeasurementUncertainty? { (raw["uncertainty"] as? [String: Any]).map { VastuMeasurementUncertainty(raw: $0) } }
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuSpecializedAuditDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuSpecializedAuditDataReceipt(raw: $0) } }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
}

public struct VastuWorkflowData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var revision: Int { vastuInt(raw["revision"])! }
    public var mutationId: String? { (raw["mutationId"] as? String) }
    public var contentHash: String? { (raw["contentHash"] as? String) }
    public var expiresAt: Int? { vastuInt(raw["expiresAt"]) }
    public var updatedAt: Int? { vastuInt(raw["updatedAt"]) }
    public var deleted: Bool? { vastuBool(raw["deleted"]) }
    public var data: VastuWorkflowDataData? { (raw["data"] as? [String: Any]).map { VastuWorkflowDataData(raw: $0) } }
    public var remedies: [VastuWorkflowDataRemediesItem]? { (raw["remedies"] as? [[String: Any]])?.map { VastuWorkflowDataRemediesItem(raw: $0) } }
    public var merchantCatalogId: String? { (raw["merchantCatalogId"] as? String) }
    public var merchantCatalogRevision: Int? { vastuInt(raw["merchantCatalogRevision"]) }
}

public struct VastuWorkspaceData: VastuData {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var record: [String: Any]? { (raw["record"] as? [String: Any]) }
    public var replayed: Bool? { vastuBool(raw["replayed"]) }
    public var records: [[String: Any]]? { (raw["records"] as? [[String: Any]]) }
    public var id: String? { (raw["id"] as? String) }
    public var title: String? { (raw["title"] as? String) }
    public var expiresAt: Int? { vastuInt(raw["expiresAt"]) }
    public var reset: Bool? { vastuBool(raw["reset"]) }
    public var deletedRecords: Int? { vastuInt(raw["deletedRecords"]) }
    public var payload: String? { (raw["payload"] as? String) }
    public var headers: [String: Any]? { (raw["headers"] as? [String: Any]) }
    public var deliveryMode: String? { (raw["deliveryMode"] as? String) }
    public var retentionDays: Int? { vastuInt(raw["retentionDays"]) }
    public var maxRecords: Int? { vastuInt(raw["maxRecords"]) }
    public var html: String? { (raw["html"] as? String) }
    public var svg: String? { (raw["svg"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
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
    public var rulesVersion: String? { (raw["rulesVersion"] as? String) }
    public var receipt: VastuZoneWiseScoreDataReceipt? { (raw["receipt"] as? [String: Any]).map { VastuZoneWiseScoreDataReceipt(raw: $0) } }
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
    public static let portfolioSearch = VastuContract<VastuPortfolioSearchRequest, VastuPortfolioSearchData>(operation: .portfolioSearch, decode: VastuPortfolioSearchData.init)
    public static let portfolioCompare = VastuContract<VastuPortfolioCompareRequest, VastuPortfolioCompareData>(operation: .portfolioCompare, decode: VastuPortfolioCompareData.init)
    public static let portfolioAnalytics = VastuContract<VastuPortfolioAnalyticsRequest, VastuPortfolioAnalyticsData>(operation: .portfolioAnalytics, decode: VastuPortfolioAnalyticsData.init)
    public static let portfolioUsage = VastuContract<VastuPortfolioUsageRequest, VastuPortfolioUsageData>(operation: .portfolioUsage, decode: VastuPortfolioUsageData.init)
    public static let portfolioUsageExport = VastuContract<VastuPortfolioUsageExportRequest, VastuPortfolioUsageExportData>(operation: .portfolioUsageExport, decode: VastuPortfolioUsageExportData.init)
    public static let portfolioBudgetsSet = VastuContract<VastuPortfolioBudgetsSetRequest, VastuPortfolioBudgetsSetData>(operation: .portfolioBudgetsSet, decode: VastuPortfolioBudgetsSetData.init)
    public static let portfolioBudgetsGet = VastuContract<VastuPortfolioBudgetsGetRequest, VastuPortfolioBudgetsGetData>(operation: .portfolioBudgetsGet, decode: VastuPortfolioBudgetsGetData.init)
    public static let drawingSheet = VastuContract<VastuDrawingSheetRequest, VastuDrawingSheetData>(operation: .drawingSheet, decode: VastuDrawingSheetData.init)
    public static let propertiesCreate = VastuContract<VastuPropertiesCreateRequest, VastuPropertiesCreateData>(operation: .propertiesCreate, decode: VastuPropertiesCreateData.init)
    public static let propertiesUpdate = VastuContract<VastuPropertiesUpdateRequest, VastuPropertiesUpdateData>(operation: .propertiesUpdate, decode: VastuPropertiesUpdateData.init)
    public static let propertiesCollaborationGet = VastuContract<VastuPropertiesCollaborationGetRequest, VastuPropertiesCollaborationGetData>(operation: .propertiesCollaborationGet, decode: VastuPropertiesCollaborationGetData.init)
    public static let propertiesCollaborationInvite = VastuContract<VastuPropertiesCollaborationInviteRequest, VastuPropertiesCollaborationInviteData>(operation: .propertiesCollaborationInvite, decode: VastuPropertiesCollaborationInviteData.init)
    public static let propertiesCollaborationRevoke = VastuContract<VastuPropertiesCollaborationRevokeRequest, VastuPropertiesCollaborationRevokeData>(operation: .propertiesCollaborationRevoke, decode: VastuPropertiesCollaborationRevokeData.init)
    public static let propertiesCollaborationMembers = VastuContract<VastuPropertiesCollaborationMembersRequest, VastuPropertiesCollaborationMembersData>(operation: .propertiesCollaborationMembers, decode: VastuPropertiesCollaborationMembersData.init)
    public static let propertiesCollaborationComment = VastuContract<VastuPropertiesCollaborationCommentRequest, VastuPropertiesCollaborationCommentData>(operation: .propertiesCollaborationComment, decode: VastuPropertiesCollaborationCommentData.init)
    public static let propertiesCollaborationReview = VastuContract<VastuPropertiesCollaborationReviewRequest, VastuPropertiesCollaborationReviewData>(operation: .propertiesCollaborationReview, decode: VastuPropertiesCollaborationReviewData.init)
    public static let propertiesCollaborationUpdate = VastuContract<VastuPropertiesCollaborationUpdateRequest, VastuPropertiesCollaborationUpdateData>(operation: .propertiesCollaborationUpdate, decode: VastuPropertiesCollaborationUpdateData.init)
    public static let propertiesActivityList = VastuContract<VastuPropertiesActivityListRequest, VastuPropertiesActivityListData>(operation: .propertiesActivityList, decode: VastuPropertiesActivityListData.init)
    public static let propertiesActivityExport = VastuContract<VastuPropertiesActivityExportRequest, VastuPropertiesActivityExportData>(operation: .propertiesActivityExport, decode: VastuPropertiesActivityExportData.init)
    public static let propertiesGet = VastuContract<VastuPropertiesGetRequest, VastuPropertiesGetData>(operation: .propertiesGet, decode: VastuPropertiesGetData.init)
    public static let propertiesList = VastuContract<VastuPropertiesListRequest, VastuPropertiesListData>(operation: .propertiesList, decode: VastuPropertiesListData.init)
    public static let propertiesDelete = VastuContract<VastuPropertiesDeleteRequest, VastuPropertiesDeleteData>(operation: .propertiesDelete, decode: VastuPropertiesDeleteData.init)
    public static let propertiesLinkScan = VastuContract<VastuPropertiesLinkScanRequest, VastuPropertiesLinkScanData>(operation: .propertiesLinkScan, decode: VastuPropertiesLinkScanData.init)
    public static let archiveTier = VastuContract<VastuArchiveTierRequest, VastuArchiveTierData>(operation: .archiveTier, decode: VastuArchiveTierData.init)
    public static let archiveExport = VastuContract<VastuArchiveExportRequest, VastuArchiveExportData>(operation: .archiveExport, decode: VastuArchiveExportData.init)
    public static let archiveDelete = VastuContract<VastuArchiveDeleteRequest, VastuArchiveDeleteData>(operation: .archiveDelete, decode: VastuArchiveDeleteData.init)
    public static let archiveSummary = VastuContract<VastuArchiveSummaryRequest, VastuArchiveSummaryData>(operation: .archiveSummary, decode: VastuArchiveSummaryData.init)
    public static let feedListings = VastuContract<VastuFeedListingsRequest, VastuFeedListingsData>(operation: .feedListings, decode: VastuFeedListingsData.init)
    public static let quoteCalculate = VastuContract<VastuQuoteCalculateRequest, VastuQuoteCalculateData>(operation: .quoteCalculate, decode: VastuQuoteCalculateData.init)

    public static let arCountedScanQuality = VastuContract<VastuArCountedScanQualityRequest, VastuArScanQualityData>(operation: .arScanQuality, decode: VastuArScanQualityData.init)






    public static let arDeityIcons = VastuContract<VastuArDeityIconsRequest, VastuArDeityIconsData>(operation: .arDeityIcons, decode: VastuArDeityIconsData.init)

    public static let arCaptureMerge = VastuContract<VastuArCaptureMergeRequest, VastuArCaptureMergeData>(operation: .arCaptureMerge, decode: VastuArCaptureMergeData.init)
    public static let plotFromSurvey = VastuContract<VastuPlotFromSurveyRequest, VastuPlotFromSurveyData>(operation: .plotFromSurvey, decode: VastuPlotFromSurveyData.init)
    public static let arRoomCapture = VastuContract<VastuArRoomCaptureRequest, VastuArRoomCaptureData>(operation: .arRoomCapture, decode: VastuArRoomCaptureData.init)
    public static let arAttestationChallenge = VastuContract<VastuArAttestationChallengeRequest, VastuArAttestationChallengeData>(operation: .arAttestationChallenge, decode: VastuArAttestationChallengeData.init)

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

    public static let planImportDxf = VastuContract<VastuPlanImportDxfRequest, VastuPlanImportDxfData>(operation: .planImportDxf, decode: VastuPlanImportDxfData.init)
    public static let planExportDxf = VastuContract<VastuPlanExportDxfRequest, VastuPlanExportDxfData>(operation: .planExportDxf, decode: VastuPlanExportDxfData.init)
    public static let planExportIfc = VastuContract<VastuPlanExportIfcRequest, VastuPlanExportIfcData>(operation: .planExportIfc, decode: VastuPlanExportIfcData.init)
    public static let planConvertUnits = VastuContract<VastuPlanConvertUnitsRequest, VastuPlanConvertUnitsData>(operation: .planConvertUnits, decode: VastuPlanConvertUnitsData.init)
    public static let planImportIfc = VastuContract<VastuPlanImportIfcRequest, VastuPlanImportIfcData>(operation: .planImportIfc, decode: VastuPlanImportIfcData.init)
    public static let planImportImage = VastuContract<VastuPlanImportImageRequest, VastuPlanImportData>(operation: .planImportImage, decode: VastuPlanImportData.init)

    public static let planImportPdf = VastuContract<VastuPlanImportPdfRequest, VastuPlanImportData>(operation: .planImportPdf, decode: VastuPlanImportData.init)

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
/// (100 logical backend operations across the full domain — this first deliverable
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
    public func vastuCompareVersions(fromVersion: String, toVersion: String, input: [String: Any], operation: String = "plan/analyze", idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuCompareVersionsData> {
        let raw = try await client.post("\(Self.base)/plan/compare-versions", body: ["fromVersion": fromVersion, "toVersion": toVersion, "input": input, "operation": operation], idempotencyKey: idempotencyKey)
        return VastuTypedResponse(success: raw["success"] as? Bool ?? false, data: VastuCompareVersionsData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuVerifyReceipt(token: String, input: [String: Any]? = nil) async throws -> VastuTypedResponse<VastuReceiptVerifyData> {
        var body: [String: Any] = ["token": token]
        if let input { body["input"] = input }
        let raw = try await client.post("\(Self.base)/receipt/verify", body: body)
        return VastuTypedResponse(success: raw["success"] as? Bool ?? false, data: VastuReceiptVerifyData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuRuleVersions() async throws -> VastuTypedResponse<VastuRuleVersionsData> {
        let raw = try await client.get("\(Self.base)/rules/versions")
        return VastuTypedResponse(success: raw["success"] as? Bool ?? false, data: VastuRuleVersionsData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    private static let base = "/v2/astrology/vastu"

    /// Strong on purpose. `VedikaClient.vastu` builds a fresh service per
    /// access instead of caching one, so there is no retain cycle, and a
    /// service (or a helper such as `RoomCaptureUploader`) obtained from a
    /// temporary client keeps that client alive instead of reading a
    /// released `unowned` reference and crashing.
    let client: VedikaClient

    init(client: VedikaClient) {
        self.client = client
    }

    /// Exact request and result types for one of the 100 mounted operations.
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
    /// string); everything else is POST, matching the
    /// server's route table.
    @discardableResult
    public func vastu(_ op: String, params: [String: Any] = [:], idempotencyKey: String? = nil) async throws -> [String: Any] {
        let path = Self.stripLeadingSlash(op)
        if path.hasPrefix("jobs/") {
            guard let job = vastuJobPath(path) else {
                throw VedikaApiError("Job paths are jobs/{jobId}, jobs/{jobId}/results and jobs/{jobId}/cancel")
            }
            _ = try requireVastuJobId(job.id)
        }
        if Self.isGetOp(path) {
            return try await client.get(
                "\(Self.base)/\(path)", queryParams: Self.stringifyParams(params), idempotencyKey: idempotencyKey
            )
        }
        return try await client.post("\(Self.base)/\(path)", body: params, idempotencyKey: idempotencyKey)
    }

    /// Closed, typed Vastu operation surface.
    public func vastuPortfolioSearch(_ request: VastuPortfolioSearchRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioSearchData> {
        let raw = try await client.post("\(Self.base)/portfolio/search", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioSearchData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioCompare(_ request: VastuPortfolioCompareRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioCompareData> {
        let raw = try await client.post("\(Self.base)/portfolio/compare", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioCompareData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioAnalytics(_ request: VastuPortfolioAnalyticsRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioAnalyticsData> {
        let raw = try await client.post("\(Self.base)/portfolio/analytics", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioAnalyticsData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioUsage(_ request: VastuPortfolioUsageRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioUsageData> {
        let raw = try await client.post("\(Self.base)/portfolio/usage", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioUsageData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioUsageExport(_ request: VastuPortfolioUsageExportRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioUsageExportData> {
        let raw = try await client.post("\(Self.base)/portfolio/usage/export", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioUsageExportData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioBudgetsSet(_ request: VastuPortfolioBudgetsSetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioBudgetsSetData> {
        let raw = try await client.post("\(Self.base)/portfolio/budgets/set", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioBudgetsSetData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPortfolioBudgetsGet(_ request: VastuPortfolioBudgetsGetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPortfolioBudgetsGetData> {
        let raw = try await client.post("\(Self.base)/portfolio/budgets/get", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPortfolioBudgetsGetData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuDrawingSheet(_ request: VastuDrawingSheetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuDrawingSheetData> {
        let raw = try await client.post("\(Self.base)/report/drawing-sheet", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuDrawingSheetData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuWorkspace(_ operation: VastuWorkspaceOperation, request: VastuWorkspaceRequest) async throws -> VastuScanResponse<VastuWorkspaceData> {
        let raw = try await client.post("/sandbox/v2/vastu/workspace/\(operation.rawValue)", body: request.dictionary)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkspaceData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCreate(_ request: VastuPropertiesCreateRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCreateData> {
        let raw = try await client.post("\(Self.base)/properties/create", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCreateData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPropertiesUpdate(_ request: VastuPropertiesUpdateRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesUpdateData> {
        let raw = try await client.post("\(Self.base)/properties/update", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesUpdateData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPropertiesCollaborationGet(_ request: VastuPropertiesCollaborationGetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationGetData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/get", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationGetData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationInvite(_ request: VastuPropertiesCollaborationInviteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationInviteData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/invite", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationInviteData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationRevoke(_ request: VastuPropertiesCollaborationRevokeRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationRevokeData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/revoke", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationRevokeData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationMembers(_ request: VastuPropertiesCollaborationMembersRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationMembersData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/members", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationMembersData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationComment(_ request: VastuPropertiesCollaborationCommentRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationCommentData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/comment", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationCommentData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationReview(_ request: VastuPropertiesCollaborationReviewRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationReviewData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/review", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationReviewData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesCollaborationUpdate(_ request: VastuPropertiesCollaborationUpdateRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesCollaborationUpdateData> {
        let raw = try await client.post("\(Self.base)/properties/collaboration/update", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesCollaborationUpdateData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesActivityList(_ request: VastuPropertiesActivityListRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesActivityListData> {
        let raw = try await client.post("\(Self.base)/properties/activity/list", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesActivityListData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesActivityExport(_ request: VastuPropertiesActivityExportRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesActivityExportData> {
        let raw = try await client.post("\(Self.base)/properties/activity/export", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesActivityExportData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }
    public func vastuPropertiesGet(_ request: VastuPropertiesGetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesGetData> {
        let raw = try await client.post("\(Self.base)/properties/get", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesGetData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPropertiesList(_ request: VastuPropertiesListRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesListData> {
        let raw = try await client.post("\(Self.base)/properties/list", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesListData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPropertiesDelete(_ request: VastuPropertiesDeleteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesDeleteData> {
        let raw = try await client.post("\(Self.base)/properties/delete", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesDeleteData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuPropertiesLinkScan(_ request: VastuPropertiesLinkScanRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuPropertiesLinkScanData> {
        let raw = try await client.post("\(Self.base)/properties/link-scan", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuPropertiesLinkScanData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuArchiveTier(_ request: VastuArchiveTierRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuArchiveTierData> {
        let raw = try await client.post("\(Self.base)/archive/tier", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuArchiveTierData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuArchiveExport(_ request: VastuArchiveExportRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuArchiveExportData> {
        let raw = try await client.post("\(Self.base)/archive/export", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuArchiveExportData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuArchiveDelete(_ request: VastuArchiveDeleteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuArchiveDeleteData> {
        let raw = try await client.post("\(Self.base)/archive/delete", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuArchiveDeleteData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuArchiveSummary(_ request: VastuArchiveSummaryRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuArchiveSummaryData> {
        let raw = try await client.post("\(Self.base)/archive/summary", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuArchiveSummaryData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuFeedListings(_ request: VastuFeedListingsRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuFeedListingsData> {
        let raw = try await client.post("\(Self.base)/feed/listings", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuFeedListingsData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuQuoteCalculate(_ request: VastuQuoteCalculateRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuQuoteCalculateData> {
        let raw = try await client.post("\(Self.base)/quote/calculate", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuQuoteCalculateData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuRemediationTasksUpsert(_ request: VastuRemediationTasksUpsertRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/remediation/tasks/upsert", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuRemediationTasksList(_ request: VastuRemediationTasksListRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/remediation/tasks/list", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuRemediationTasksDelete(_ request: VastuRemediationTasksDeleteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/remediation/tasks/delete", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuRemediationReassess(_ request: VastuRemediationReassessRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/remediation/reassess", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuMerchantCatalogUpload(_ request: VastuMerchantCatalogUploadRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/merchant/catalog/upload", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuMerchantCatalogGet(_ request: VastuMerchantCatalogGetRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/merchant/catalog/get", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuMerchantCatalogDelete(_ request: VastuMerchantCatalogDeleteRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/merchant/catalog/delete", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

    public func vastuMerchantRemedies(_ request: VastuMerchantRemediesRequest, idempotencyKey: String? = nil) async throws -> VastuScanResponse<VastuWorkflowData> {
        let raw = try await client.post("\(Self.base)/merchant/remedies", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuScanResponse(success: raw["success"] as? Bool ?? false, data: VastuWorkflowData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw)
    }

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
        if operation.rawValue.contains("{id}") {
            throw VedikaApiError(
                "\(operation.rawValue) carries a job id; use vastuJobStatus, vastuJobResults or vastuJobCancel")
        }
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

    /// Queue 1 to 1,000 assessments and get a jobId back at once (HTTP 202).
    ///
    /// `idempotencyKey` is mandatory and must be retained by the caller. Save
    /// it with this exact request: after a lost response or a restart, submit
    /// the same body with the same key and the original job comes back
    /// (`data.replayed` is true) instead of a second paid job. Each item is
    /// charged only after it succeeds.
    public func vastuJobSubmit(_ request: VastuJobsRequest, idempotencyKey: String) async throws -> VastuJobSubmitResponse {
        let raw = try await client.post("\(Self.base)/jobs", body: request.dictionary, idempotencyKey: idempotencyKey)
        return VastuJobSubmitResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuJobSubmitData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw
        )
    }

    /// Status, per-state counts and billing of a job. Free.
    public func vastuJobStatus(_ jobId: String) async throws -> VastuJobStatusResponse {
        let id = try requireVastuJobId(jobId)
        let raw = try await client.get("\(Self.base)/jobs/\(id)")
        return VastuJobStatusResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuJobStatusData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw
        )
    }

    /// One page (up to 50) of finished item results, in item order. Free.
    /// Cursor pagination only: pass the previous page's `data.nextCursor`; it
    /// is nil on the last page. See `vastuJobAllResults` to collect them all.
    public func vastuJobResults(_ jobId: String, cursor: String? = nil) async throws -> VastuJobResultsResponse {
        if let cursor, cursor.isEmpty || cursor.utf8.count > 32 {
            throw VedikaApiError("cursor must be the nextCursor of the previous page (1 to 32 characters)")
        }
        let id = try requireVastuJobId(jobId)
        let raw = try await client.get(
            "\(Self.base)/jobs/\(id)/results",
            queryParams: cursor.map { ["cursor": $0] } ?? [:]
        )
        return VastuJobResultsResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuJobResultsData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw
        )
    }

    /// Every finished item of a job, following `nextCursor` until it is nil.
    public func vastuJobAllResults(_ jobId: String) async throws -> [VastuJobResultItem] {
        var items: [VastuJobResultItem] = []
        var cursor: String?
        while true {
            let page = try await vastuJobResults(jobId, cursor: cursor).data
            items.append(contentsOf: page.items)
            guard let next = page.nextCursor else { return items }
            if next == cursor { throw VedikaApiError("The server returned the same results cursor twice") }
            cursor = next
        }
    }

    /// Stop a queued or running job. Items already charged stay charged; the rest are not run. Free.
    public func vastuJobCancel(_ jobId: String) async throws -> VastuJobStatusResponse {
        let id = try requireVastuJobId(jobId)
        let raw = try await client.post("\(Self.base)/jobs/\(id)/cancel", body: [:])
        return VastuJobStatusResponse(
            success: raw["success"] as? Bool ?? false,
            data: VastuJobStatusData(raw: raw["data"] as? [String: Any] ?? [:]), raw: raw
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
    public func vastuPlanImportDxf(_ request: VastuPlanImportDxfRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuPlanImportDxfData> {
        try await vastuOperation(VastuContracts.planImportDxf, request: request, idempotencyKey: idempotencyKey)
    }

    public func vastuPlanExportDxf(_ request: VastuPlanExportDxfRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuPlanExportDxfData> {
        try await vastuOperation(VastuContracts.planExportDxf, request: request, idempotencyKey: idempotencyKey)
    }

    public func vastuPlanExportIfc(_ request: VastuPlanExportIfcRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuPlanExportIfcData> {
        try await vastuOperation(VastuContracts.planExportIfc, request: request, idempotencyKey: idempotencyKey)
    }
    public func vastuPlanConvertUnits(_ request: VastuPlanConvertUnitsRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuPlanConvertUnitsData> {
        try await vastuOperation(VastuContracts.planConvertUnits, request: request, idempotencyKey: idempotencyKey)
    }
    public func vastuPlanImportIfc(_ request: VastuPlanImportIfcRequest, idempotencyKey: String? = nil) async throws -> VastuTypedResponse<VastuPlanImportIfcData> {
        try await vastuOperation(VastuContracts.planImportIfc, request: request, idempotencyKey: idempotencyKey)
    }

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
        if (path == "rules/versions" || path.hasPrefix("reference/")) || path == "direction/declination" { return true }
        guard let job = vastuJobPath(path) else { return false }
        return job.suffix != "cancel"
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

public struct VastuPlanImportDxfRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var dxf: String
    public var fileName: String?
    public var contentType: String?
    public var trueNorthDeg: Double?
    public var unitsOverride: Int?
    public var layerRoles: [String: String]?
    public init(dxf: String, fileName: String? = nil, contentType: String? = nil, trueNorthDeg: Double? = nil, unitsOverride: Int? = nil, layerRoles: [String: String]? = nil, maxChargeUsd: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.dxf = dxf; self.fileName = fileName; self.contentType = contentType; self.trueNorthDeg = trueNorthDeg; self.unitsOverride = unitsOverride; self.layerRoles = layerRoles; self.maxChargeUsd = maxChargeUsd ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var maxChargeUsd: String?
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        result["dxf"] = encodeVastu(dxf)
        if let value = fileName { result["fileName"] = encodeVastu(value) }
        if let value = contentType { result["contentType"] = encodeVastu(value) }
        if let value = trueNorthDeg { result["trueNorthDeg"] = encodeVastu(value) }
        if let value = unitsOverride { result["unitsOverride"] = encodeVastu(value) }
        if let value = layerRoles { result["layerRoles"] = encodeVastu(value) }
        if let value = maxChargeUsd { result["maxChargeUsd"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanExportDxfRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var units: String?
    public var plan: [String: Any]
    public var analysis: [String: Any]?
    public var zones: Int?
    public var unitsCode: Int?
    public var trueNorthDeg: Double?
        public init(plan: [String: Any], analysis: [String: Any]? = nil, zones: Int? = nil, unitsCode: Int? = nil, trueNorthDeg: Double? = nil, maxChargeUsd: String? = nil, propertyId: String? = nil, tenantRef: String? = nil, units: String? = nil) { self.plan = plan; self.analysis = analysis; self.zones = zones; self.unitsCode = unitsCode; self.trueNorthDeg = trueNorthDeg; self.maxChargeUsd = maxChargeUsd; self.propertyId = propertyId; self.tenantRef = tenantRef; self.units = units }
    public var maxChargeUsd: String?
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = units { result["units"] = encodeVastu(value) }
        result["plan"] = encodeVastu(plan)
        if let value = analysis { result["analysis"] = encodeVastu(value) }
        if let value = zones { result["zones"] = encodeVastu(value) }
        if let value = unitsCode { result["unitsCode"] = encodeVastu(value) }
        if let value = trueNorthDeg { result["trueNorthDeg"] = encodeVastu(value) }
        if let value = maxChargeUsd { result["maxChargeUsd"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanImportIfcRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?

    public var ifc: String
    public var trueNorthDeg: Double?
    public init(ifc: String, trueNorthDeg: Double? = nil, maxChargeUsd: String? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.ifc = ifc; self.trueNorthDeg = trueNorthDeg; self.maxChargeUsd = maxChargeUsd ; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var maxChargeUsd: String?
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        result["ifc"] = encodeVastu(ifc)
        if let value = trueNorthDeg { result["trueNorthDeg"] = encodeVastu(value) }
        if let value = maxChargeUsd { result["maxChargeUsd"] = encodeVastu(value) }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPortfolioSearchRequest: VastuRequest {
    public var city: String?
    public var tags: [String]?
    public var minScore: Int?
    public var maxScore: Int?
    public var zoneDefects: [String]?
    public var ruleset: String?
    public var inputSource: String?
    public var sort: String?
    public var limit: Int?
    public var cursor: String?
    public init(city: String? = nil, tags: [String]? = nil, minScore: Int? = nil, maxScore: Int? = nil, zoneDefects: [String]? = nil, ruleset: String? = nil, inputSource: String? = nil, sort: String? = nil, limit: Int? = nil, cursor: String? = nil) { self.city = city; self.tags = tags; self.minScore = minScore; self.maxScore = maxScore; self.zoneDefects = zoneDefects; self.ruleset = ruleset; self.inputSource = inputSource; self.sort = sort; self.limit = limit; self.cursor = cursor }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = city { result["city"] = value }
        if let value = tags { result["tags"] = value }
        if let value = minScore { result["minScore"] = value }
        if let value = maxScore { result["maxScore"] = value }
        if let value = zoneDefects { result["zoneDefects"] = value }
        if let value = ruleset { result["ruleset"] = value }
        if let value = inputSource { result["inputSource"] = value }
        if let value = sort { result["sort"] = value }
        if let value = limit { result["limit"] = value }
        if let value = cursor { result["cursor"] = value }
        return result
    }
}
public struct VastuPortfolioCompareRequest: VastuRequest {
    public var propertyIds: [String]
    public init(propertyIds: [String]) { self.propertyIds = propertyIds }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        result["propertyIds"] = propertyIds
        return result
    }
}
public struct VastuPortfolioAnalyticsRequest: VastuRequest {
    public var fromEpoch: Int?
    public var toEpoch: Int?
    public var tag: String?
    public var propertyId: String?
    public init(fromEpoch: Int? = nil, toEpoch: Int? = nil, tag: String? = nil, propertyId: String? = nil) { self.fromEpoch = fromEpoch; self.toEpoch = toEpoch; self.tag = tag; self.propertyId = propertyId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromEpoch { result["fromEpoch"] = value }
        if let value = toEpoch { result["toEpoch"] = value }
        if let value = tag { result["tag"] = value }
        if let value = propertyId { result["propertyId"] = value }
        return result
    }
}
public struct VastuPortfolioUsageRequest: VastuRequest {
    public var fromEpoch: Int?
    public var toEpoch: Int?
    public var propertyId: String?
    public var tenantRef: String?
    public init(fromEpoch: Int? = nil, toEpoch: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.fromEpoch = fromEpoch; self.toEpoch = toEpoch; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromEpoch { result["fromEpoch"] = value }
        if let value = toEpoch { result["toEpoch"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}
public struct VastuPortfolioUsageExportRequest: VastuRequest {
    public var fromEpoch: Int?
    public var toEpoch: Int?
    public var propertyId: String?
    public var tenantRef: String?
    public init(fromEpoch: Int? = nil, toEpoch: Int? = nil, propertyId: String? = nil, tenantRef: String? = nil) { self.fromEpoch = fromEpoch; self.toEpoch = toEpoch; self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = fromEpoch { result["fromEpoch"] = value }
        if let value = toEpoch { result["toEpoch"] = value }
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}
public struct VastuPortfolioBudgetsSetRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?
    public var capUsd: String?
    public init(propertyId: String? = nil, tenantRef: String? = nil, capUsd: String?) { self.propertyId = propertyId; self.tenantRef = tenantRef; self.capUsd = capUsd }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        result["capUsd"] = (capUsd as Any?) ?? NSNull()
        return result
    }
}
public struct VastuPortfolioBudgetsGetRequest: VastuRequest {
    public var propertyId: String?
    public var tenantRef: String?
    public init(propertyId: String? = nil, tenantRef: String? = nil) { self.propertyId = propertyId; self.tenantRef = tenantRef }
    public var dictionary: [String: Any] {
        var result: [String: Any] = [:]
        if let value = propertyId { result["propertyId"] = value }
        if let value = tenantRef { result["tenantRef"] = value }
        return result
    }
}

public struct VastuPlanExportIfcRequest: VastuRequest {
    public var plan: [String: Any]
    public var outputUnits: String?
    public var maxChargeUsd: String?
    public init(plan: [String: Any], outputUnits: String? = nil, maxChargeUsd: String? = nil) { self.plan=plan; self.outputUnits=outputUnits; self.maxChargeUsd=maxChargeUsd }
    public var dictionary: [String: Any] { var v: [String: Any] = ["plan":plan]; if let u=outputUnits {v["outputUnits"]=u}; if let c=maxChargeUsd {v["maxChargeUsd"]=c}; return v }
}
public struct VastuPlanConvertUnitsRequest: VastuRequest {
    public var plan: [String: Any]
    public var inputUnits: String
    public var outputUnits: String
    public init(plan: [String: Any], inputUnits: String, outputUnits: String) {self.plan=plan;self.inputUnits=inputUnits;self.outputUnits=outputUnits}
    public var dictionary: [String: Any] { ["plan":plan,"inputUnits":inputUnits,"outputUnits":outputUnits] }
}
