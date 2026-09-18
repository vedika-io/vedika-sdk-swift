import Foundation
import XCTest
@testable import VedikaSDK

// Frozen responses come from the local Rust sandbox, not SDK-shaped mocks.
final class VastuResponseFixtureTests: XCTestCase {
    /// The canonical fixture, when this package is being tested from inside the
    /// monorepo. `nil` in a standalone checkout of the mirror repository.
    static var monorepoFixtureURL: URL? {
        var root = URL(fileURLWithPath: #filePath)
        for _ in 0..<5 { root.deleteLastPathComponent() }
        let url = root.appendingPathComponent("web/vedika-public/js/catalog/vastu-sandbox-demos.json")
        return FileManager.default.fileExists(atPath: url.path) ? url : nil
    }

    /// The copy shipped inside the test bundle, so the package tests itself when
    /// it is consumed as a standalone repository.
    static var bundledFixtureURL: URL {
        guard let url = Bundle.module.url(forResource: "vastu-sandbox-demos", withExtension: "json") else {
            fatalError("vastu-sandbox-demos.json is missing from the test bundle resources")
        }
        return url
    }

    /// The mirror's copy must never drift from the monorepo's. This can only run
    /// where the canonical file is reachable, which is exactly where drift would
    /// be introduced.
    func testBundledFixtureMatchesCanonical() throws {
        guard let canonical = Self.monorepoFixtureURL else {
            throw XCTSkip("canonical fixture is not reachable from a standalone checkout")
        }
        XCTAssertEqual(
            try Data(contentsOf: canonical),
            try Data(contentsOf: Self.bundledFixtureURL),
            "Tests/VedikaSDKTests/Resources/vastu-sandbox-demos.json has drifted from "
                + "web/vedika-public/js/catalog/vastu-sandbox-demos.json — re-copy it."
        )
    }

    func testEveryPublicGetterAgainstAllRustResponses() throws {
        let url = Self.monorepoFixtureURL ?? Self.bundledFixtureURL
        let corpus = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as! [String: Any]
        let demos = corpus["demos"] as! [String: [String: Any]]
        let types: [String: String] = [
            "vastu__reference_gate_obstructions": "VastuCatalogReferenceData",
            "vastu__entrance_obstruction_check": "VastuObstructionData",
            "vastu__direction_sun_path": "VastuSunPathData",
            "vastu__ar_true_north_calibrate": "VastuArTrueNorthData",
            "vastu__assessments_batch": "VastuAssessmentBatchData",
            "vastu__assessments": "VastuAssessmentData",
            "vastu__reference_mandala_9_zone": "VastuMandalaReferenceData",
            "vastu__reference_mandala_45_devatas": "VastuMandalaReferenceData",
            "vastu__reference_directions_8": "VastuDirectionsReferenceData",
            "vastu__reference_defects_catalog": "VastuCatalogReferenceData",
            "vastu__reference_remedies_catalog": "VastuCatalogReferenceData",
            "vastu__direction_declination": "VastuDirectionDeclinationData",
            "vastu__direction_correct": "VastuDirectionCorrectData",
            "vastu__direction_zone_from_bearing": "VastuBearingZoneData",
            "vastu__mandala_project_9_zone": "VastuMandalaProjectionData",
            "vastu__mandala_project_81_pada": "VastuMandalaProjectionData",
            "vastu__mandala_project_brahmasthan": "VastuBrahmasthanProjectionData",
            "vastu__audit_single_room": "VastuSingleRoomAuditData",
            "vastu__audit_floor_plan": "VastuFloorPlanAuditData",
            "vastu__audit_floor_plan_detailed": "VastuDetailedFloorPlanAuditData",
            "vastu__entrance_pada": "VastuEntrancePadaData",
            "vastu__ar_scan_quality": "VastuArScanQualityData",
            "vastu__plot_ratio": "VastuPlotRatioData",
            "vastu__plot_shape": "VastuPlotShapeData",
            "vastu__plot_extensions_cuts": "VastuPlotExtensionsCutsData",
            "vastu__plot_slope": "VastuPlotSlopeData",
            "vastu__plot_orientation": "VastuPlotOrientationData",
            "vastu__plot_road_orientation": "VastuRoadOrientationData",
            "vastu__reference_mandala_64_pada": "VastuMandalaReferenceData",
            "vastu__reference_directions_16": "VastuDirectionsReferenceData",
            "vastu__reference_directions_32": "VastuDirections32ReferenceData",
            "vastu__reference_colors_by_zone": "VastuZoneReferenceData",
            "vastu__reference_materials_by_zone": "VastuZoneReferenceData",
            "vastu__specialized_residential": "VastuSpecializedAuditData",
            "vastu__specialized_commercial": "VastuSpecializedAuditData",
            "vastu__specialized_temple": "VastuSpecializedAuditData",
            "vastu__specialized_factory": "VastuSpecializedAuditData",
            "vastu__specialized_hospital": "VastuSpecializedAuditData",
            "vastu__specialized_restaurant": "VastuSpecializedAuditData",
            "vastu__specialized_educational": "VastuSpecializedAuditData",
            "vastu__timing_bhumi_pujan": "VastuTimingData",
            "vastu__timing_grihapravesh": "VastuTimingData",
            "vastu__timing_construction_start": "VastuTimingData",
            "vastu__timing_vastu_shanti": "VastuTimingData",
            "vastu__entrance_recommend": "VastuEntranceRecommendData",
            "vastu__elements_distribution": "VastuElementDistributionData",
            "vastu__elements_balance_suggest": "VastuElementBalanceData",
            "vastu__direction_auspicious_facing": "VastuAuspiciousFacingData",
            "vastu__room_kitchen": "VastuRoomData",
            "vastu__room_bedroom": "VastuRoomData",
            "vastu__room_pooja": "VastuRoomData",
            "vastu__room_toilet": "VastuRoomData",
            "vastu__room_staircase": "VastuRoomData",
            "vastu__room_study": "VastuRoomData",
            "vastu__room_living": "VastuRoomData",
            "vastu__room_dining": "VastuRoomData",
            "vastu__room_store": "VastuRoomData",
            "vastu__room_water_storage": "VastuRoomData",
            "vastu__placement_borewell": "VastuPlacementData",
            "vastu__placement_septic_tank": "VastuPlacementData",
            "vastu__placement_overhead_tank": "VastuPlacementData",
            "vastu__placement_main_gate": "VastuMainGateData",
            "vastu__placement_tree": "VastuPlacementData",
            "vastu__placement_garden": "VastuPlacementData",
            "vastu__placement_balcony": "VastuPlacementData",
            "vastu__placement_window": "VastuPlacementData",
            "vastu__placement_well": "VastuPlacementData",
            "vastu__placement_generator_electrical": "VastuPlacementData",
            "vastu__score_overall": "VastuOverallScoreData",
            "vastu__score_zone_wise": "VastuZoneWiseScoreData",
            "vastu__score_compliance_index": "VastuComplianceIndexData",
            "vastu__multi_storey_floor_rules": "VastuFloorRulesData",
            "vastu__compound_wall_analysis": "VastuWallAnalysisData",
            "vastu__floor_level_analysis": "VastuLevelAnalysisData",
            "vastu__plan_generate": "VastuPlanGenerateData",
            "vastu__plan_from_requirements": "VastuPlanGenerateData",
            "vastu__plan_optimize": "VastuPlanOptimizeData",
            "vastu__plan_analyze": "VastuPlanAuditData",
            "vastu__plan_upload": "VastuPlanAuditData",
            "vastu__plan_report": "VastuPlanAuditData",
            "vastu__ar_heatmap_raster": "VastuArHeatmapRasterData",
            "vastu__ar_anchor_recommendations": "VastuArAnchorRecommendationsData",
            "vastu__ar_zone_textures": "VastuArZoneTexturesData",
            "vastu__ar_yantra_meshes": "VastuArYantraMeshesData",
            "vastu__ar_deity_icons": "VastuArDeityIconsData",
            "vastu__ar_room_capture": "VastuArRoomCaptureData",
            "vastu__scans_save": "VastuScansSaveData",
            "vastu__scans_retrieve": "VastuScansRetrieveData",
            "vastu__scans_list": "VastuScansListData",
            "vastu__scans_delete": "VastuScansDeleteData",
            "vastu__scans_timelapse": "VastuScansTimelapseData",
            "vastu__fusion_chart": "VastuFusionChartData",
            "vastu__compare_before_after_remedy": "VastuRemedyComparisonData",
        ]
        XCTAssertEqual(demos.count, 93)
        XCTAssertEqual(Set(types.values).count, 57)
        for (key, response) in demos {
            let raw = response["data"] as! [String: Any]
            let actual: [String: Any]
            switch types[key]! {
            case "VastuArAnchorRecommendationsData": actual = readVastuArAnchorRecommendationsData(VastuArAnchorRecommendationsData(raw: raw))
            case "VastuArRoomCaptureData": actual = readVastuArRoomCaptureData(VastuArRoomCaptureData(raw: raw))
            case "VastuArDeityIconsData": actual = readVastuArDeityIconsData(VastuArDeityIconsData(raw: raw))
            case "VastuArHeatmapRasterData": actual = readVastuArHeatmapRasterData(VastuArHeatmapRasterData(raw: raw))
            case "VastuArScanQualityData": actual = readVastuArScanQualityData(VastuArScanQualityData(raw: raw))
            case "VastuArTrueNorthData": actual = readVastuArTrueNorthData(VastuArTrueNorthData(raw: raw))
            case "VastuArYantraMeshesData": actual = readVastuArYantraMeshesData(VastuArYantraMeshesData(raw: raw))
            case "VastuArZoneTexturesData": actual = readVastuArZoneTexturesData(VastuArZoneTexturesData(raw: raw))
            case "VastuAssessmentBatchData": actual = readVastuAssessmentBatchData(VastuAssessmentBatchData(raw: raw))
            case "VastuAssessmentData": actual = readVastuAssessmentData(VastuAssessmentData(raw: raw))
            case "VastuAuspiciousFacingData": actual = readVastuAuspiciousFacingData(VastuAuspiciousFacingData(raw: raw))
            case "VastuBearingZoneData": actual = readVastuBearingZoneData(VastuBearingZoneData(raw: raw))
            case "VastuBrahmasthanProjectionData": actual = readVastuBrahmasthanProjectionData(VastuBrahmasthanProjectionData(raw: raw))
            case "VastuCatalogReferenceData": actual = readVastuCatalogReferenceData(VastuCatalogReferenceData(raw: raw))
            case "VastuComplianceIndexData": actual = readVastuComplianceIndexData(VastuComplianceIndexData(raw: raw))
            case "VastuDetailedFloorPlanAuditData": actual = readVastuDetailedFloorPlanAuditData(VastuDetailedFloorPlanAuditData(raw: raw))
            case "VastuDirectionCorrectData": actual = readVastuDirectionCorrectData(VastuDirectionCorrectData(raw: raw))
            case "VastuDirectionDeclinationData": actual = readVastuDirectionDeclinationData(VastuDirectionDeclinationData(raw: raw))
            case "VastuDirections32ReferenceData": actual = readVastuDirections32ReferenceData(VastuDirections32ReferenceData(raw: raw))
            case "VastuDirectionsReferenceData": actual = readVastuDirectionsReferenceData(VastuDirectionsReferenceData(raw: raw))
            case "VastuElementBalanceData": actual = readVastuElementBalanceData(VastuElementBalanceData(raw: raw))
            case "VastuElementDistributionData": actual = readVastuElementDistributionData(VastuElementDistributionData(raw: raw))
            case "VastuEntrancePadaData": actual = readVastuEntrancePadaData(VastuEntrancePadaData(raw: raw))
            case "VastuEntranceRecommendData": actual = readVastuEntranceRecommendData(VastuEntranceRecommendData(raw: raw))
            case "VastuFloorPlanAuditData": actual = readVastuFloorPlanAuditData(VastuFloorPlanAuditData(raw: raw))
            case "VastuFloorRulesData": actual = readVastuFloorRulesData(VastuFloorRulesData(raw: raw))
            case "VastuFusionChartData": actual = readVastuFusionChartData(VastuFusionChartData(raw: raw))
            case "VastuLevelAnalysisData": actual = readVastuLevelAnalysisData(VastuLevelAnalysisData(raw: raw))
            case "VastuMainGateData": actual = readVastuMainGateData(VastuMainGateData(raw: raw))
            case "VastuMandalaProjectionData": actual = readVastuMandalaProjectionData(VastuMandalaProjectionData(raw: raw))
            case "VastuMandalaReferenceData": actual = readVastuMandalaReferenceData(VastuMandalaReferenceData(raw: raw))
            case "VastuObstructionData": actual = readVastuObstructionData(VastuObstructionData(raw: raw))
            case "VastuOverallScoreData": actual = readVastuOverallScoreData(VastuOverallScoreData(raw: raw))
            case "VastuPlacementData": actual = readVastuPlacementData(VastuPlacementData(raw: raw))
            case "VastuPlanAuditData": actual = readVastuPlanAuditData(VastuPlanAuditData(raw: raw))
            case "VastuPlanGenerateData": actual = readVastuPlanGenerateData(VastuPlanGenerateData(raw: raw))
            case "VastuPlanOptimizeData": actual = readVastuPlanOptimizeData(VastuPlanOptimizeData(raw: raw))
            case "VastuPlotExtensionsCutsData": actual = readVastuPlotExtensionsCutsData(VastuPlotExtensionsCutsData(raw: raw))
            case "VastuPlotOrientationData": actual = readVastuPlotOrientationData(VastuPlotOrientationData(raw: raw))
            case "VastuPlotRatioData": actual = readVastuPlotRatioData(VastuPlotRatioData(raw: raw))
            case "VastuPlotShapeData": actual = readVastuPlotShapeData(VastuPlotShapeData(raw: raw))
            case "VastuPlotSlopeData": actual = readVastuPlotSlopeData(VastuPlotSlopeData(raw: raw))
            case "VastuRemedyComparisonData": actual = readVastuRemedyComparisonData(VastuRemedyComparisonData(raw: raw))
            case "VastuRoadOrientationData": actual = readVastuRoadOrientationData(VastuRoadOrientationData(raw: raw))
            case "VastuRoomData": actual = readVastuRoomData(VastuRoomData(raw: raw))
            case "VastuScanStoredData": actual = readVastuScanStoredData(VastuScanStoredData(raw: raw))
            case "VastuScansDeleteData": actual = readVastuScansDeleteData(VastuScansDeleteData(raw: raw))
            case "VastuScansListData": actual = readVastuScansListData(VastuScansListData(raw: raw))
            case "VastuScansRetrieveData": actual = readVastuScansRetrieveData(VastuScansRetrieveData(raw: raw))
            case "VastuScansSaveData": actual = readVastuScansSaveData(VastuScansSaveData(raw: raw))
            case "VastuScansTimelapseData": actual = readVastuScansTimelapseData(VastuScansTimelapseData(raw: raw))
            case "VastuSingleRoomAuditData": actual = readVastuSingleRoomAuditData(VastuSingleRoomAuditData(raw: raw))
            case "VastuSpecializedAuditData": actual = readVastuSpecializedAuditData(VastuSpecializedAuditData(raw: raw))
            case "VastuSunPathData": actual = readVastuSunPathData(VastuSunPathData(raw: raw))
            case "VastuTimingData": actual = readVastuTimingData(VastuTimingData(raw: raw))
            case "VastuWallAnalysisData": actual = readVastuWallAnalysisData(VastuWallAnalysisData(raw: raw))
            case "VastuZoneReferenceData": actual = readVastuZoneReferenceData(VastuZoneReferenceData(raw: raw))
            case "VastuZoneWiseScoreData": actual = readVastuZoneWiseScoreData(VastuZoneWiseScoreData(raw: raw))
            default: return XCTFail("Unmapped response: \(key)")
            }
            for (field, value) in actual {
                let expected = raw[field] ?? NSNull()
                XCTAssertTrue(equivalent(value, expected), "\(key).\(field): \(value) != \(expected)")
            }
        }
    }
}

/// The generated item wrappers (`...FindingsItem`, `...RoomByRoomItem`, and the rest)
/// are structs holding the response dictionary in `raw`. The parent readers put those
/// structs straight into their `[String: Any]`, so without this the comparison below
/// was struct-versus-dictionary and could never succeed — 22 array fields across 18
/// response types were asserted but never actually compared. Unwrapping `raw` makes
/// them real assertions.
private func rawBacked(_ value: Any) -> [String: Any]? {
    let mirror = Mirror(reflecting: value)
    guard mirror.displayStyle == .struct else { return nil }
    for child in mirror.children where child.label == "raw" {
        return child.value as? [String: Any]
    }
    return nil
}

private func equivalent(_ actual: Any, _ expected: Any) -> Bool {
    if let unwrapped = rawBacked(actual) {
        return equivalent(unwrapped, expected)
    }
    if let left = actual as? [String: Any], let right = expected as? [String: Any] {
        return Set(left.keys).union(right.keys).allSatisfy {
            equivalent(left[$0] ?? NSNull(), right[$0] ?? NSNull())
        }
    }
    if let left = actual as? [Any], let right = expected as? [Any] {
        return left.count == right.count && zip(left, right).allSatisfy { equivalent($0, $1) }
    }
    return NSDictionary(dictionary: ["value": actual]).isEqual(to: ["value": expected])
}

private func readVastuEntrancePadaDataPada(_ value: VastuEntrancePadaDataPada) -> [String: Any] {
    [
        "index": (value.index as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "quadrant": (value.quadrant as Any?) ?? NSNull(),
        "subIndex": (value.subIndex as Any?) ?? NSNull(),
        "bearingStart": (value.bearingStart as Any?) ?? NSNull(),
        "bearingEnd": (value.bearingEnd as Any?) ?? NSNull(),
        "auspiciousness": (value.auspiciousness as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "deityRosterName": (value.deityRosterName as Any?) ?? NSNull(),
        "deityNameClassification": (value.deityNameClassification as Any?) ?? NSNull(),
        "deityNameSource": (value.deityNameSource as Any?) ?? NSNull(),
        "deityPlacementClassification": (value.deityPlacementClassification as Any?) ?? NSNull(),
        "deityPlacementSource": (value.deityPlacementSource as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorPlanAuditDataDefectsItemIssueParams(_ value: VastuFloorPlanAuditDataDefectsItemIssueParams) -> [String: Any] {
    [
        "roomType": (value.roomType as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorPlanAuditDataDefectsItem(_ value: VastuFloorPlanAuditDataDefectsItem) -> [String: Any] {
    [
        "issueKey": (value.issueKey as Any?) ?? NSNull(),
        "issueParams": (value.issueParams.map(readVastuFloorPlanAuditDataDefectsItemIssueParams) as Any?) ?? NSNull(),
        "remedyKey": (value.remedyKey as Any?) ?? NSNull(),
        "remedyParams": (value.remedyParams as Any?) ?? NSNull(),
        "room": (value.room as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "issue": (value.issue as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "recommendedZone": (value.recommendedZone as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "code": (value.code as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorPlanAuditDataScoring(_ value: VastuFloorPlanAuditDataScoring) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "unit": (value.unit as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "comparisonBasis": (value.comparisonBasis as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "inputPlacementCount": (value.inputPlacementCount as Any?) ?? NSNull(),
        "uniquePlacementCount": (value.uniquePlacementCount as Any?) ?? NSNull(),
        "duplicatePlacementCount": (value.duplicatePlacementCount as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorPlanAuditDataTextParse(_ value: VastuFloorPlanAuditDataTextParse) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "transliterations": (value.transliterations as Any?) ?? NSNull(),
        "grammar": (value.grammar as Any?) ?? NSNull(),
        "coverage": (value.coverage as Any?) ?? NSNull(),
        "supportedLanguages": (value.supportedLanguages as Any?) ?? NSNull(),
        "roomVocabulary": (value.roomVocabulary as Any?) ?? NSNull(),
        "directionVocabulary": (value.directionVocabulary as Any?) ?? NSNull(),
        "unparsedClauses": (value.unparsedClauses as Any?) ?? NSNull(),
        "parsedClauseCount": (value.parsedClauseCount as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditDataDefectsItemIssueParams(_ value: VastuDetailedFloorPlanAuditDataDefectsItemIssueParams) -> [String: Any] {
    [
        "roomType": (value.roomType as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditDataDefectsItem(_ value: VastuDetailedFloorPlanAuditDataDefectsItem) -> [String: Any] {
    [
        "issueKey": (value.issueKey as Any?) ?? NSNull(),
        "issueParams": (value.issueParams.map(readVastuDetailedFloorPlanAuditDataDefectsItemIssueParams) as Any?) ?? NSNull(),
        "remedyKey": (value.remedyKey as Any?) ?? NSNull(),
        "remedyParams": (value.remedyParams as Any?) ?? NSNull(),
        "room": (value.room as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "issue": (value.issue as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "recommendedZone": (value.recommendedZone as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "code": (value.code as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditDataRemediationOrderItem(_ value: VastuDetailedFloorPlanAuditDataRemediationOrderItem) -> [String: Any] {
    [
        "actionKey": (value.actionKey as Any?) ?? NSNull(),
        "actionParams": (value.actionParams as Any?) ?? NSNull(),
        "room": (value.room as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "action": (value.action as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "code": (value.code as Any?) ?? NSNull(),
        "step": (value.step as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditDataScoring(_ value: VastuDetailedFloorPlanAuditDataScoring) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "unit": (value.unit as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "comparisonBasis": (value.comparisonBasis as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "inputPlacementCount": (value.inputPlacementCount as Any?) ?? NSNull(),
        "uniquePlacementCount": (value.uniquePlacementCount as Any?) ?? NSNull(),
        "duplicatePlacementCount": (value.duplicatePlacementCount as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditDataCompleteness(_ value: VastuDetailedFloorPlanAuditDataCompleteness) -> [String: Any] {
    [
        "status": (value.status as Any?) ?? NSNull(),
        "computedComponents": (value.computedComponents as Any?) ?? NSNull(),
        "missingInputs": (value.missingInputs as Any?) ?? NSNull(),
        "projectedCellCount": (value.projectedCellCount as Any?) ?? NSNull(),
        "physicalCoverageVerified": (value.physicalCoverageVerified as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsPointCloudDensity(_ value: VastuArScanQualityDataDimensionsPointCloudDensity) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsPolygonClosure(_ value: VastuArScanQualityDataDimensionsPolygonClosure) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsCompassConfidence(_ value: VastuArScanQualityDataDimensionsCompassConfidence) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsGpsConfidence(_ value: VastuArScanQualityDataDimensionsGpsConfidence) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsRoomsTagged(_ value: VastuArScanQualityDataDimensionsRoomsTagged) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensionsCoverage(_ value: VastuArScanQualityDataDimensionsCoverage) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataDimensions(_ value: VastuArScanQualityDataDimensions) -> [String: Any] {
    [
        "pointCloudDensity": (readVastuArScanQualityDataDimensionsPointCloudDensity(value.pointCloudDensity) as Any?) ?? NSNull(),
        "polygonClosure": (readVastuArScanQualityDataDimensionsPolygonClosure(value.polygonClosure) as Any?) ?? NSNull(),
        "compassConfidence": (readVastuArScanQualityDataDimensionsCompassConfidence(value.compassConfidence) as Any?) ?? NSNull(),
        "gpsConfidence": (readVastuArScanQualityDataDimensionsGpsConfidence(value.gpsConfidence) as Any?) ?? NSNull(),
        "roomsTagged": (readVastuArScanQualityDataDimensionsRoomsTagged(value.roomsTagged) as Any?) ?? NSNull(),
        "coverage": (readVastuArScanQualityDataDimensionsCoverage(value.coverage) as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityDataRoomCoverage(_ value: VastuArScanQualityDataRoomCoverage) -> [String: Any] {
    [
        "expectedRoomCount": (value.expectedRoomCount as Any?) ?? NSNull(),
        "percent": (value.percent as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "scope": (value.scope as Any?) ?? NSNull(),
    ]
}

private func readVastuMandalaReferenceDataZonesItem(_ value: VastuMandalaReferenceDataZonesItem) -> [String: Any] {
    [
        "remedyKey": (value.remedyKey as Any?) ?? NSNull(),
        "remedyParams": (value.remedyParams as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "element": (value.element as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "sourceClassification": (value.sourceClassification as Any?) ?? NSNull(),
        "remedyClassification": (value.remedyClassification as Any?) ?? NSNull(),
        "remedySource": (value.remedySource as Any?) ?? NSNull(),
        "prescribed": (value.prescribed as Any?) ?? NSNull(),
        "forbidden": (value.forbidden as Any?) ?? NSNull(),
        "deityClassification": (value.deityClassification as Any?) ?? NSNull(),
        "deitySource": (value.deitySource as Any?) ?? NSNull(),
        "elementClassification": (value.elementClassification as Any?) ?? NSNull(),
        "elementSource": (value.elementSource as Any?) ?? NSNull(),
        "verseBackedRooms": (value.verseBackedRooms as Any?) ?? NSNull(),
        "verseBackedRoomsSource": (value.verseBackedRoomsSource as Any?) ?? NSNull(),
    ]
}

private func readVastuCatalogReferenceDataDefectsItem(_ value: VastuCatalogReferenceDataDefectsItem) -> [String: Any] {
    [
        "labelKey": (value.labelKey as Any?) ?? NSNull(),
        "labelParams": (value.labelParams as Any?) ?? NSNull(),
        "code": (value.code as Any?) ?? NSNull(),
        "label": (value.label as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuCatalogReferenceDataRemediesItem(_ value: VastuCatalogReferenceDataRemediesItem) -> [String: Any] {
    [
        "remedyKey": (value.remedyKey as Any?) ?? NSNull(),
        "remedyParams": (value.remedyParams as Any?) ?? NSNull(),
        "defectCode": (value.defectCode as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
    ]
}

private func readVastuOverallScoreDataScoring(_ value: VastuOverallScoreDataScoring) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "unit": (value.unit as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "comparisonBasis": (value.comparisonBasis as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "inputPlacementCount": (value.inputPlacementCount as Any?) ?? NSNull(),
        "uniquePlacementCount": (value.uniquePlacementCount as Any?) ?? NSNull(),
        "duplicatePlacementCount": (value.duplicatePlacementCount as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuZoneWiseScoreDataScoring(_ value: VastuZoneWiseScoreDataScoring) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "unit": (value.unit as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "comparisonBasis": (value.comparisonBasis as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "inputPlacementCount": (value.inputPlacementCount as Any?) ?? NSNull(),
        "uniquePlacementCount": (value.uniquePlacementCount as Any?) ?? NSNull(),
        "duplicatePlacementCount": (value.duplicatePlacementCount as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuComplianceIndexDataScoring(_ value: VastuComplianceIndexDataScoring) -> [String: Any] {
    [
        "version": (value.version as Any?) ?? NSNull(),
        "unit": (value.unit as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "comparisonBasis": (value.comparisonBasis as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "inputPlacementCount": (value.inputPlacementCount as Any?) ?? NSNull(),
        "uniquePlacementCount": (value.uniquePlacementCount as Any?) ?? NSNull(),
        "duplicatePlacementCount": (value.duplicatePlacementCount as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuPlanAuditDataArtifact(_ value: VastuPlanAuditDataArtifact) -> [String: Any] {
    [
        "contentType": (value.contentType as Any?) ?? NSNull(),
        "filename": (value.filename as Any?) ?? NSNull(),
        "content": (value.content as Any?) ?? NSNull(),
    ]
}

private func readVastuSunPathDataInput(_ value: VastuSunPathDataInput) -> [String: Any] {
    [
        "lat": (value.lat as Any?) ?? NSNull(),
        "lon": (value.lon as Any?) ?? NSNull(),
        "date": (value.date as Any?) ?? NSNull(),
    ]
}

private func readVastuArTrueNorthDataInput(_ value: VastuArTrueNorthDataInput) -> [String: Any] {
    [
        "lat": (value.lat as Any?) ?? NSNull(),
        "lon": (value.lon as Any?) ?? NSNull(),
        "datetime": (value.datetime as Any?) ?? NSNull(),
        "deviceHeadingAtSunDeg": (value.deviceHeadingAtSunDeg as Any?) ?? NSNull(),
    ]
}

private func readVastuArTrueNorthDataHeadingQuality(_ value: VastuArTrueNorthDataHeadingQuality) -> [String: Any] {
    [
        "accuracyDeg": (value.accuracyDeg as Any?) ?? NSNull(),
        "sampleAgeMs": (value.sampleAgeMs as Any?) ?? NSNull(),
        "maxAccuracyDeg": (value.maxAccuracyDeg as Any?) ?? NSNull(),
        "maxSampleAgeMs": (value.maxSampleAgeMs as Any?) ?? NSNull(),
        "reliable": (value.reliable as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBadgeEligibility(_ value: VastuAssessmentBadgeEligibility) -> [String: Any] {
    [
        "inputSource": (value.inputSource as Any?) ?? NSNull(),
        "badge": (value.badge as Any?) ?? NSNull(),
        "eligible": (value.eligible as Any?) ?? NSNull(),
        "variant": (value.variant as Any?) ?? NSNull(),
        "confidence": (value.confidence as Any?) ?? NSNull(),
        "fullBadgeThreshold": (value.fullBadgeThreshold as Any?) ?? NSNull(),
        "minimumConfidence": (value.minimumConfidence as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentDataSourcesItem(_ value: VastuAssessmentDataSourcesItem) -> [String: Any] {
    [
        "source": (value.source as Any?) ?? NSNull(),
        "scope": (value.scope as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility(_ value: VastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility) -> [String: Any] {
    [
        "inputSource": (value.inputSource as Any?) ?? NSNull(),
        "badge": (value.badge as Any?) ?? NSNull(),
        "eligible": (value.eligible as Any?) ?? NSNull(),
        "variant": (value.variant as Any?) ?? NSNull(),
        "confidence": (value.confidence as Any?) ?? NSNull(),
        "fullBadgeThreshold": (value.fullBadgeThreshold as Any?) ?? NSNull(),
        "minimumConfidence": (value.minimumConfidence as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponseDataSourcesItem(_ value: VastuAssessmentBatchDataResultsItemResponseDataSourcesItem) -> [String: Any] {
    [
        "source": (value.source as Any?) ?? NSNull(),
        "scope": (value.scope as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponseData(_ value: VastuAssessmentBatchDataResultsItemResponseData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "score": (value.score as Any?) ?? NSNull(),
        "confidence": (value.confidence as Any?) ?? NSNull(),
        "badgeEligibility": (readVastuAssessmentBatchDataResultsItemResponseDataBadgeEligibility(value.badgeEligibility) as Any?) ?? NSNull(),
        "findings": (value.findings as Any?) ?? NSNull(),
        "maxScore": (value.maxScore as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "gradeLabel": (value.gradeLabel as Any?) ?? NSNull(),
        "scoreBreakdown": (value.scoreBreakdown as Any?) ?? NSNull(),
        "confidenceBasis": (value.confidenceBasis as Any?) ?? NSNull(),
        "entrance": (value.entrance as Any?) ?? NSNull(),
        "scanQuality": (value.scanQuality as Any?) ?? NSNull(),
        "zoneReference": (value.zoneReference as Any?) ?? NSNull(),
        "sources": (value.sources?.map(readVastuAssessmentBatchDataResultsItemResponseDataSourcesItem) as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "requiredConfidence": (value.requiredConfidence as Any?) ?? NSNull(),
        "missingData": (value.missingData as Any?) ?? NSNull(),
        "reScanSuggestions": (value.reScanSuggestions as Any?) ?? NSNull(),
        "charged": (value.charged as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "listingId": (value.listingId as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponseBilling(_ value: VastuAssessmentBatchDataResultsItemResponseBilling) -> [String: Any] {
    [
        "charged": (value.charged as Any?) ?? NSNull(),
        "currency": (value.currency as Any?) ?? NSNull(),
        "balanceBefore": (value.balanceBefore as Any?) ?? NSNull(),
        "balanceAfter": (value.balanceAfter as Any?) ?? NSNull(),
        "endpoint": (value.endpoint as Any?) ?? NSNull(),
        "category": (value.category as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponseMeta(_ value: VastuAssessmentBatchDataResultsItemResponseMeta) -> [String: Any] {
    [
        "source": (value.source as Any?) ?? NSNull(),
        "engine": (value.engine as Any?) ?? NSNull(),
        "version": (value.version as Any?) ?? NSNull(),
        "dataSource": (value.dataSource as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItemResponse(_ value: VastuAssessmentBatchDataResultsItemResponse) -> [String: Any] {
    [
        "success": (value.success as Any?) ?? NSNull(),
        "data": (value.data.map(readVastuAssessmentBatchDataResultsItemResponseData) as Any?) ?? NSNull(),
        "error": (value.error as Any?) ?? NSNull(),
        "code": (value.code as Any?) ?? NSNull(),
        "billing": (value.billing.map(readVastuAssessmentBatchDataResultsItemResponseBilling) as Any?) ?? NSNull(),
        "meta": (value.meta.map(readVastuAssessmentBatchDataResultsItemResponseMeta) as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataResultsItem(_ value: VastuAssessmentBatchDataResultsItem) -> [String: Any] {
    [
        "id": (value.id as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "response": (readVastuAssessmentBatchDataResultsItemResponse(value.response) as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchDataSummary(_ value: VastuAssessmentBatchDataSummary) -> [String: Any] {
    [
        "total": (value.total as Any?) ?? NSNull(),
        "succeeded": (value.succeeded as Any?) ?? NSNull(),
        "failed": (value.failed as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterDataZonesItem(_ value: VastuArHeatmapRasterDataZonesItem) -> [String: Any] {
    [
        "zone": (value.zone as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "disturbed": (value.disturbed as Any?) ?? NSNull(),
        "observed": (value.observed as Any?) ?? NSNull(),
        "roomCount": (value.roomCount as Any?) ?? NSNull(),
        "deityClassification": (value.deityClassification as Any?) ?? NSNull(),
        "deitySource": (value.deitySource as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterDataCompleteness(_ value: VastuArHeatmapRasterDataCompleteness) -> [String: Any] {
    [
        "status": (value.status as Any?) ?? NSNull(),
        "computedComponents": (value.computedComponents as Any?) ?? NSNull(),
        "missingInputs": (value.missingInputs as Any?) ?? NSNull(),
        "projectedCellCount": (value.projectedCellCount as Any?) ?? NSNull(),
        "physicalCoverageVerified": (value.physicalCoverageVerified as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterDataLegendDisturbed(_ value: VastuArHeatmapRasterDataLegendDisturbed) -> [String: Any] {
    [
        "color": (value.color as Any?) ?? NSNull(),
        "meaning": (value.meaning as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterDataLegendNeutral(_ value: VastuArHeatmapRasterDataLegendNeutral) -> [String: Any] {
    [
        "color": (value.color as Any?) ?? NSNull(),
        "meaning": (value.meaning as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterDataLegend(_ value: VastuArHeatmapRasterDataLegend) -> [String: Any] {
    [
        "disturbed": (readVastuArHeatmapRasterDataLegendDisturbed(value.disturbed) as Any?) ?? NSNull(),
        "neutral": (readVastuArHeatmapRasterDataLegendNeutral(value.neutral) as Any?) ?? NSNull(),
        "observed": (value.observed as Any?) ?? NSNull(),
    ]
}

private func readVastuArAnchorRecommendationsDataAnchorsItem(_ value: VastuArAnchorRecommendationsDataAnchorsItem) -> [String: Any] {
    [
        "id": (value.id as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "planPosition": (value.planPosition as Any?) ?? NSNull(),
        "worldPosition": (value.worldPosition as Any?) ?? NSNull(),
        "normal": (value.normal as Any?) ?? NSNull(),
        "insidePlot": (value.insidePlot as Any?) ?? NSNull(),
        "deityClassification": (value.deityClassification as Any?) ?? NSNull(),
        "deitySource": (value.deitySource as Any?) ?? NSNull(),
    ]
}

private func readVastuArZoneTexturesDataCellsItem(_ value: VastuArZoneTexturesDataCellsItem) -> [String: Any] {
    [
        "contentInsetPixels": (value.contentInsetPixels as Any?) ?? NSNull(),
        "devata": (value.devata as Any?) ?? NSNull(),
        "gltfUvBoundsTopLeft": (value.gltfUvBoundsTopLeft as Any?) ?? NSNull(),
        "maskBit": (value.maskBit as Any?) ?? NSNull(),
        "pixelBoundsExclusive": (value.pixelBoundsExclusive as Any?) ?? NSNull(),
        "usdUvBoundsBottomLeft": (value.usdUvBoundsBottomLeft as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
    ]
}

private func readVastuArYantraMeshesDataGeometry(_ value: VastuArYantraMeshesDataGeometry) -> [String: Any] {
    [
        "vertices": (value.vertices as Any?) ?? NSNull(),
        "triangles": (value.triangles as Any?) ?? NSNull(),
        "upAxis": (value.upAxis as Any?) ?? NSNull(),
        "northAxis": (value.northAxis as Any?) ?? NSNull(),
        "eastAxis": (value.eastAxis as Any?) ?? NSNull(),
        "units": (value.units as Any?) ?? NSNull(),
    ]
}

private func readVastuArDeityIconsDataIconsItem(_ value: VastuArDeityIconsDataIconsItem) -> [String: Any] {
    [
        "zone": (value.zone as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "kind": (value.kind as Any?) ?? NSNull(),
        "png": (value.png as Any?) ?? NSNull(),
        "svg": (value.svg as Any?) ?? NSNull(),
        "width": (value.width as Any?) ?? NSNull(),
        "height": (value.height as Any?) ?? NSNull(),
        "deityClassification": (value.deityClassification as Any?) ?? NSNull(),
        "deitySource": (value.deitySource as Any?) ?? NSNull(),
    ]
}

private func readVastuArAnchorRecommendationsData(_ value: VastuArAnchorRecommendationsData) -> [String: Any] {
    [
        "anchors": (value.anchors.map(readVastuArAnchorRecommendationsDataAnchorsItem) as Any?) ?? NSNull(),
        "omittedZones": (value.omittedZones as Any?) ?? NSNull(),
        "planToWorld": (value.planToWorld as Any?) ?? NSNull(),
        "bearingDeg": (value.bearingDeg as Any?) ?? NSNull(),
        "bearingAssumedNorth": (value.bearingAssumedNorth as Any?) ?? NSNull(),
        "physicalRegistrationVerified": (value.physicalRegistrationVerified as Any?) ?? NSNull(),
        "physicalNorthVerified": (value.physicalNorthVerified as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "physicalCoverageVerified": (value.physicalCoverageVerified as Any?) ?? NSNull(),
        "coordinateNote": (value.coordinateNote as Any?) ?? NSNull(),
        "omissionNote": (value.omissionNote as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureDataCaptureOutline(_ value: VastuArRoomCaptureDataCaptureOutline) -> [String: Any] {
    [
        "polygon": (value.polygon as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "width": (value.width as Any?) ?? NSNull(),
        "length": (value.length as Any?) ?? NSNull(),
        "areaM2": (value.areaM2 as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureDataCapture(_ value: VastuArRoomCaptureDataCapture) -> [String: Any] {
    [
        "captureId": (value.captureId as Any?) ?? NSNull(),
        "capturedAtEpoch": (value.capturedAtEpoch as Any?) ?? NSNull(),
        "device": (value.device as Any?) ?? NSNull(),
        "north": (value.north as Any?) ?? NSNull(),
        "floorIndex": (value.floorIndex as Any?) ?? NSNull(),
        "outline": (readVastuArRoomCaptureDataCaptureOutline(value.outline) as Any?) ?? NSNull(),
        "originShiftM": (value.originShiftM as Any?) ?? NSNull(),
        "roomCount": (value.roomCount as Any?) ?? NSNull(),
        "openingCount": (value.openingCount as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureDataRoomsItem(_ value: VastuArRoomCaptureDataRoomsItem) -> [String: Any] {
    [
        "id": (value.id as Any?) ?? NSNull(),
        "label": (value.label as Any?) ?? NSNull(),
        "roomType": (value.roomType as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "zoneBasis": (value.zoneBasis as Any?) ?? NSNull(),
        "areaM2": (value.areaM2 as Any?) ?? NSNull(),
        "centroid": (value.centroid as Any?) ?? NSNull(),
        "heightM": (value.heightM as Any?) ?? NSNull(),
        "openingCount": (value.openingCount as Any?) ?? NSNull(),
        "polygon": (value.polygon as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureDataDerivedRequests(_ value: VastuArRoomCaptureDataDerivedRequests) -> [String: Any] {
    [
        "planAnalyze": (value.planAnalyze as Any?) ?? NSNull(),
        "auditFloorPlanDetailed": (value.auditFloorPlanDetailed as Any?) ?? NSNull(),
        "scanQuality": (value.scanQuality as Any?) ?? NSNull(),
        "anchorRecommendations": (value.anchorRecommendations as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureDataCompleteness(_ value: VastuArRoomCaptureDataCompleteness) -> [String: Any] {
    [
        "acceptForAudit": (value.acceptForAudit as Any?) ?? NSNull(),
        "labelledRooms": (value.labelledRooms as Any?) ?? NSNull(),
        "unlabelledRooms": (value.unlabelledRooms as Any?) ?? NSNull(),
        "missing": (value.missing as Any?) ?? NSNull(),
        "warnings": (value.warnings as Any?) ?? NSNull(),
    ]
}

private func readVastuArRoomCaptureData(_ value: VastuArRoomCaptureData) -> [String: Any] {
    [
        "method": (value.method as Any?) ?? NSNull(),
        "schema": (value.schema as Any?) ?? NSNull(),
        "capture": (readVastuArRoomCaptureDataCapture(value.capture) as Any?) ?? NSNull(),
        "rooms": (value.rooms.map(readVastuArRoomCaptureDataRoomsItem) as Any?) ?? NSNull(),
        "derivedRequests": (readVastuArRoomCaptureDataDerivedRequests(value.derivedRequests) as Any?) ?? NSNull(),
        "planAnalysis": (value.planAnalysis as Any?) ?? NSNull(),
        "audit": (value.audit as Any?) ?? NSNull(),
        "scanQuality": (value.scanQuality as Any?) ?? NSNull(),
        "anchorRecommendations": (value.anchorRecommendations as Any?) ?? NSNull(),
        "completeness": (readVastuArRoomCaptureDataCompleteness(value.completeness) as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "captureVerification": (value.captureVerification as Any?) ?? NSNull(),
        "attestation": (value.attestation as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
    ]
}

private func readVastuArDeityIconsData(_ value: VastuArDeityIconsData) -> [String: Any] {
    [
        "icons": (value.icons.map(readVastuArDeityIconsDataIconsItem) as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
    ]
}

private func readVastuArHeatmapRasterData(_ value: VastuArHeatmapRasterData) -> [String: Any] {
    [
        "mask": (value.mask as Any?) ?? NSNull(),
        "texture": (value.texture as Any?) ?? NSNull(),
        "maskBitOrder": (value.maskBitOrder as Any?) ?? NSNull(),
        "zones": (value.zones.map(readVastuArHeatmapRasterDataZonesItem) as Any?) ?? NSNull(),
        "observedZones": (value.observedZones as Any?) ?? NSNull(),
        "unobservedZones": (value.unobservedZones as Any?) ?? NSNull(),
        "mandalaProjection": (value.mandalaProjection as Any?) ?? NSNull(),
        "bearingAssumedNorth": (value.bearingAssumedNorth as Any?) ?? NSNull(),
        "completeness": (readVastuArHeatmapRasterDataCompleteness(value.completeness) as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "physicalCoverageVerified": (value.physicalCoverageVerified as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "legend": (readVastuArHeatmapRasterDataLegend(value.legend) as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
    ]
}

private func readVastuArScanQualityData(_ value: VastuArScanQualityData) -> [String: Any] {
    [
        "grade": (value.grade as Any?) ?? NSNull(),
        "score": (value.score as Any?) ?? NSNull(),
        "missingData": (value.missingData as Any?) ?? NSNull(),
        "warnings": (value.warnings as Any?) ?? NSNull(),
        "reScanSuggestions": (value.reScanSuggestions as Any?) ?? NSNull(),
        "dimensions": (readVastuArScanQualityDataDimensions(value.dimensions) as Any?) ?? NSNull(),
        "acceptForAudit": (value.acceptForAudit as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "roomsTaggedCount": (value.roomsTaggedCount as Any?) ?? NSNull(),
        "unreportedDimensions": (value.unreportedDimensions as Any?) ?? NSNull(),
        "roomCount": (value.roomCount as Any?) ?? NSNull(),
        "roomCoverage": (readVastuArScanQualityDataRoomCoverage(value.roomCoverage) as Any?) ?? NSNull(),
        "scoreScope": (value.scoreScope as Any?) ?? NSNull(),
        "evidenceSource": (value.evidenceSource as Any?) ?? NSNull(),
        "sensorAttestation": (value.sensorAttestation as Any?) ?? NSNull(),
        "limitations": (value.limitations as Any?) ?? NSNull(),
    ]
}

private func readVastuArTrueNorthData(_ value: VastuArTrueNorthData) -> [String: Any] {
    [
        "input": (readVastuArTrueNorthDataInput(value.input) as Any?) ?? NSNull(),
        "sunAzimuthTrueDeg": (value.sunAzimuthTrueDeg as Any?) ?? NSNull(),
        "solarElevationDeg": (value.solarElevationDeg as Any?) ?? NSNull(),
        "offsetDeg": (value.offsetDeg as Any?) ?? NSNull(),
        "headingCorrection": (value.headingCorrection as Any?) ?? NSNull(),
        "reliable": (value.reliable as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "solarGeometryReliable": (value.solarGeometryReliable as Any?) ?? NSNull(),
        "headingQuality": (readVastuArTrueNorthDataHeadingQuality(value.headingQuality) as Any?) ?? NSNull(),
    ]
}

private func readVastuArYantraMeshesData(_ value: VastuArYantraMeshesData) -> [String: Any] {
    [
        "name": (value.name as Any?) ?? NSNull(),
        "format": (value.format as Any?) ?? NSNull(),
        "asset": (value.asset as Any?) ?? NSNull(),
        "dimensionsMetres": (value.dimensionsMetres as Any?) ?? NSNull(),
        "geometry": (readVastuArYantraMeshesDataGeometry(value.geometry) as Any?) ?? NSNull(),
        "ritualDesign": (value.ritualDesign as Any?) ?? NSNull(),
        "remedyEfficacyClaimed": (value.remedyEfficacyClaimed as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "assetId": (value.assetId as Any?) ?? NSNull(),
    ]
}

private func readVastuArZoneTexturesData(_ value: VastuArZoneTexturesData) -> [String: Any] {
    [
        "png": (value.png as Any?) ?? NSNull(),
        "svg": (value.svg as Any?) ?? NSNull(),
        "width": (value.width as Any?) ?? NSNull(),
        "height": (value.height as Any?) ?? NSNull(),
        "cells": (value.cells.map(readVastuArZoneTexturesDataCellsItem) as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "pixelBoundsConvention": (value.pixelBoundsConvention as Any?) ?? NSNull(),
        "gltfUvOrigin": (value.gltfUvOrigin as Any?) ?? NSNull(),
        "usdUvOrigin": (value.usdUvOrigin as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentBatchData(_ value: VastuAssessmentBatchData) -> [String: Any] {
    [
        "results": (value.results.map(readVastuAssessmentBatchDataResultsItem) as Any?) ?? NSNull(),
        "summary": (readVastuAssessmentBatchDataSummary(value.summary) as Any?) ?? NSNull(),
        "billingBasis": (value.billingBasis as Any?) ?? NSNull(),
        "execution": (value.execution as Any?) ?? NSNull(),
    ]
}

private func readVastuAssessmentData(_ value: VastuAssessmentData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "status": (value.status as Any?) ?? NSNull(),
        "score": (value.score as Any?) ?? NSNull(),
        "confidence": (value.confidence as Any?) ?? NSNull(),
        "badgeEligibility": (readVastuAssessmentBadgeEligibility(value.badgeEligibility) as Any?) ?? NSNull(),
        "findings": (value.findings as Any?) ?? NSNull(),
        "maxScore": (value.maxScore as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "gradeLabel": (value.gradeLabel as Any?) ?? NSNull(),
        "scoreBreakdown": (value.scoreBreakdown as Any?) ?? NSNull(),
        "confidenceBasis": (value.confidenceBasis as Any?) ?? NSNull(),
        "entrance": (value.entrance as Any?) ?? NSNull(),
        "scanQuality": (value.scanQuality as Any?) ?? NSNull(),
        "zoneReference": (value.zoneReference as Any?) ?? NSNull(),
        "sources": (value.sources?.map(readVastuAssessmentDataSourcesItem) as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "requiredConfidence": (value.requiredConfidence as Any?) ?? NSNull(),
        "missingData": (value.missingData as Any?) ?? NSNull(),
        "reScanSuggestions": (value.reScanSuggestions as Any?) ?? NSNull(),
        "charged": (value.charged as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "listingId": (value.listingId as Any?) ?? NSNull(),
    ]
}

private func readVastuAuspiciousFacingData(_ value: VastuAuspiciousFacingData) -> [String: Any] {
    [
        "purpose": (value.purpose as Any?) ?? NSNull(),
        "bestFacing": (value.bestFacing as Any?) ?? NSNull(),
        "bestZone": (value.bestZone as Any?) ?? NSNull(),
        "avoidFacing": (value.avoidFacing as Any?) ?? NSNull(),
        "verifiedPlacement": (value.verifiedPlacement as Any?) ?? NSNull(),
        "zoneComplianceCheck": (value.zoneComplianceCheck as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "rationale": (value.rationale as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuBearingZoneData(_ value: VastuBearingZoneData) -> [String: Any] {
    [
        "bearingDeg": (value.bearingDeg as Any?) ?? NSNull(),
        "zone": (value.zone as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "element": (value.element as Any?) ?? NSNull(),
        "prescribedRooms": (value.prescribedRooms as Any?) ?? NSNull(),
        "forbiddenRooms": (value.forbiddenRooms as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuBrahmasthanProjectionData(_ value: VastuBrahmasthanProjectionData) -> [String: Any] {
    [
        "centerPolygon": (value.centerPolygon as Any?) ?? NSNull(),
        "bufferPolygon": (value.bufferPolygon as Any?) ?? NSNull(),
        "centroid": (value.centroid as Any?) ?? NSNull(),
        "area": (value.area as Any?) ?? NSNull(),
        "forbiddenActions": (value.forbiddenActions as Any?) ?? NSNull(),
        "classicalSource": (value.classicalSource as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "bearingAssumedNorth": (value.bearingAssumedNorth as Any?) ?? NSNull(),
    ]
}

private func readVastuCatalogReferenceData(_ value: VastuCatalogReferenceData) -> [String: Any] {
    [
        "defectCount": (value.defectCount as Any?) ?? NSNull(),
        "defects": (value.defects?.map(readVastuCatalogReferenceDataDefectsItem) as Any?) ?? NSNull(),
        "remedyCount": (value.remedyCount as Any?) ?? NSNull(),
        "remedies": (value.remedies?.map(readVastuCatalogReferenceDataRemediesItem) as Any?) ?? NSNull(),
        "featureCount": (value.featureCount as Any?) ?? NSNull(),
        "features": (value.features as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "referenceVersion": (value.referenceVersion as Any?) ?? NSNull(),
    ]
}

private func readVastuComplianceIndexData(_ value: VastuComplianceIndexData) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "complianceIndex": (value.complianceIndex as Any?) ?? NSNull(),
        "drivingDefects": (value.drivingDefects as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "defectsSummary": (value.defectsSummary as Any?) ?? NSNull(),
        "indexLabel": (value.indexLabel as Any?) ?? NSNull(),
        "indexScale": (value.indexScale as Any?) ?? NSNull(),
        "indexScaleNote": (value.indexScaleNote as Any?) ?? NSNull(),
        "indexType": (value.indexType as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "scoring": (readVastuComplianceIndexDataScoring(value.scoring) as Any?) ?? NSNull(),
    ]
}

private func readVastuDetailedFloorPlanAuditData(_ value: VastuDetailedFloorPlanAuditData) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "totalRooms": (value.totalRooms as Any?) ?? NSNull(),
        "prescribedCount": (value.prescribedCount as Any?) ?? NSNull(),
        "defects": (value.defects.map(readVastuDetailedFloorPlanAuditDataDefectsItem) as Any?) ?? NSNull(),
        "devataHeatmap": (value.devataHeatmap as Any?) ?? NSNull(),
        "mandalaProjection": (value.mandalaProjection as Any?) ?? NSNull(),
        "remediationOrder": (value.remediationOrder.map(readVastuDetailedFloorPlanAuditDataRemediationOrderItem) as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "bearingAssumedNorth": (value.bearingAssumedNorth as Any?) ?? NSNull(),
        "gradeScale": (value.gradeScale as Any?) ?? NSNull(),
        "scoring": (readVastuDetailedFloorPlanAuditDataScoring(value.scoring) as Any?) ?? NSNull(),
        "completeness": (readVastuDetailedFloorPlanAuditDataCompleteness(value.completeness) as Any?) ?? NSNull(),
    ]
}

private func readVastuDirectionCorrectData(_ value: VastuDirectionCorrectData) -> [String: Any] {
    [
        "input": (value.input as Any?) ?? NSNull(),
        "magneticBearingDeg": (value.magneticBearingDeg as Any?) ?? NSNull(),
        "declinationDeg": (value.declinationDeg as Any?) ?? NSNull(),
        "trueBearingDeg": (value.trueBearingDeg as Any?) ?? NSNull(),
        "correctedZone": (value.correctedZone as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "correctedZoneIsMagnetic": (value.correctedZoneIsMagnetic as Any?) ?? NSNull(),
        "declinationCoverage": (value.declinationCoverage as Any?) ?? NSNull(),
    ]
}

private func readVastuDirectionDeclinationData(_ value: VastuDirectionDeclinationData) -> [String: Any] {
    [
        "lat": (value.lat as Any?) ?? NSNull(),
        "lon": (value.lon as Any?) ?? NSNull(),
        "date": (value.date as Any?) ?? NSNull(),
        "declinationDeg": (value.declinationDeg as Any?) ?? NSNull(),
        "interpretation": (value.interpretation as Any?) ?? NSNull(),
        "gridEpoch": (value.gridEpoch as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "declinationCoverage": (value.declinationCoverage as Any?) ?? NSNull(),
    ]
}

private func readVastuDirections32ReferenceData(_ value: VastuDirections32ReferenceData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "padaCount": (value.padaCount as Any?) ?? NSNull(),
        "padaWidthDeg": (value.padaWidthDeg as Any?) ?? NSNull(),
        "auspiciousCount": (value.auspiciousCount as Any?) ?? NSNull(),
        "avoidCount": (value.avoidCount as Any?) ?? NSNull(),
        "classicalDoorScheme": (value.classicalDoorScheme as Any?) ?? NSNull(),
        "padas": (value.padas as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "referenceVersion": (value.referenceVersion as Any?) ?? NSNull(),
    ]
}

private func readVastuDirectionsReferenceData(_ value: VastuDirectionsReferenceData) -> [String: Any] {
    [
        "directionCount": (value.directionCount as Any?) ?? NSNull(),
        "directions": (value.directions as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "sectorWidthDeg": (value.sectorWidthDeg as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "referenceVersion": (value.referenceVersion as Any?) ?? NSNull(),
    ]
}

private func readVastuElementBalanceData(_ value: VastuElementBalanceData) -> [String: Any] {
    [
        "derivedFrom": (value.derivedFrom as Any?) ?? NSNull(),
        "deficientElements": (value.deficientElements as Any?) ?? NSNull(),
        "excessElements": (value.excessElements as Any?) ?? NSNull(),
        "remedies": (value.remedies as Any?) ?? NSNull(),
        "balanced": (value.balanced as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
    ]
}

private func readVastuElementDistributionData(_ value: VastuElementDistributionData) -> [String: Any] {
    [
        "elementDistribution": (value.elementDistribution as Any?) ?? NSNull(),
        "idealModel": (value.idealModel as Any?) ?? NSNull(),
        "dominantElement": (value.dominantElement as Any?) ?? NSNull(),
        "deficientElements": (value.deficientElements as Any?) ?? NSNull(),
        "excessElements": (value.excessElements as Any?) ?? NSNull(),
        "zoneBreakdown": (value.zoneBreakdown as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "totalRooms": (value.totalRooms as Any?) ?? NSNull(),
        "weightingBasis": (value.weightingBasis as Any?) ?? NSNull(),
    ]
}

private func readVastuEntrancePadaData(_ value: VastuEntrancePadaData) -> [String: Any] {
    [
        "doorXY": (value.doorXY as Any?) ?? NSNull(),
        "plotCentroid": (value.plotCentroid as Any?) ?? NSNull(),
        "rawBearingDeg": (value.rawBearingDeg as Any?) ?? NSNull(),
        "trueBearingDeg": (value.trueBearingDeg as Any?) ?? NSNull(),
        "pada": (readVastuEntrancePadaDataPada(value.pada) as Any?) ?? NSNull(),
        "edgeRefined": (value.edgeRefined as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuEntranceRecommendData(_ value: VastuEntranceRecommendData) -> [String: Any] {
    [
        "facing": (value.facing as Any?) ?? NSNull(),
        "bestEntrancePada": (value.bestEntrancePada as Any?) ?? NSNull(),
        "recommendedPadas": (value.recommendedPadas as Any?) ?? NSNull(),
        "avoidPadas": (value.avoidPadas as Any?) ?? NSNull(),
        "facingCaution": (value.facingCaution as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "poojaPrescribedHere": (value.poojaPrescribedHere as Any?) ?? NSNull(),
        "prescribedRoomsAtFacing": (value.prescribedRoomsAtFacing as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorPlanAuditData(_ value: VastuFloorPlanAuditData) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "totalRooms": (value.totalRooms as Any?) ?? NSNull(),
        "prescribedCount": (value.prescribedCount as Any?) ?? NSNull(),
        "defects": (value.defects.map(readVastuFloorPlanAuditDataDefectsItem) as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "gradeScale": (value.gradeScale as Any?) ?? NSNull(),
        "scoring": (readVastuFloorPlanAuditDataScoring(value.scoring) as Any?) ?? NSNull(),
        "textParse": (value.textParse.map(readVastuFloorPlanAuditDataTextParse) as Any?) ?? NSNull(),
    ]
}

private func readVastuFloorRulesData(_ value: VastuFloorRulesData) -> [String: Any] {
    [
        "masterBedroomFloor": (value.masterBedroomFloor as Any?) ?? NSNull(),
        "floorRules": (value.floorRules as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "principle": (value.principle as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuFusionChartData(_ value: VastuFusionChartData) -> [String: Any] {
    [
        "ascendant": (value.ascendant as Any?) ?? NSNull(),
        "grahaDirections": (value.grahaDirections as Any?) ?? NSNull(),
        "favourableDirections": (value.favourableDirections as Any?) ?? NSNull(),
        "cautionDirections": (value.cautionDirections as Any?) ?? NSNull(),
        "methodology": (value.methodology as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuLevelAnalysisData(_ value: VastuLevelAnalysisData) -> [String: Any] {
    [
        "idealLevels": (value.idealLevels as Any?) ?? NSNull(),
        "observedAnalysis": (value.observedAnalysis as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "idealOrdering": (value.idealOrdering as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "principle": (value.principle as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuMainGateData(_ value: VastuMainGateData) -> [String: Any] {
    [
        "facing": (value.facing as Any?) ?? NSNull(),
        "padaScheme": (value.padaScheme as Any?) ?? NSNull(),
        "prescribedPadas": (value.prescribedPadas as Any?) ?? NSNull(),
        "rule": (value.rule as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "padaVerdict": (value.padaVerdict as Any?) ?? NSNull(),
        "feature": (value.feature as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "remedyType": (value.remedyType as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuMandalaProjectionData(_ value: VastuMandalaProjectionData) -> [String: Any] {
    [
        "cells": (value.cells as Any?) ?? NSNull(),
        "plotCentroid": (value.plotCentroid as Any?) ?? NSNull(),
        "bearingDeg": (value.bearingDeg as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "bearingAssumedNorth": (value.bearingAssumedNorth as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
    ]
}

private func readVastuMandalaReferenceData(_ value: VastuMandalaReferenceData) -> [String: Any] {
    [
        "zoneCount": (value.zoneCount as Any?) ?? NSNull(),
        "zones": (value.zones?.map(readVastuMandalaReferenceDataZonesItem) as Any?) ?? NSNull(),
        "devataCount": (value.devataCount as Any?) ?? NSNull(),
        "devatas": (value.devatas as Any?) ?? NSNull(),
        "cells": (value.cells as Any?) ?? NSNull(),
        "padaCount": (value.padaCount as Any?) ?? NSNull(),
        "grid": (value.grid as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "bearingDeg": (value.bearingDeg as Any?) ?? NSNull(),
        "brahmasthanPadas": (value.brahmasthanPadas as Any?) ?? NSNull(),
        "classBreakdown": (value.classBreakdown as Any?) ?? NSNull(),
        "devataSource": (value.devataSource as Any?) ?? NSNull(),
        "devataVerified": (value.devataVerified as Any?) ?? NSNull(),
        "mandala": (value.mandala as Any?) ?? NSNull(),
        "plotCentroid": (value.plotCentroid as Any?) ?? NSNull(),
        "projected": (value.projected as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "referenceVersion": (value.referenceVersion as Any?) ?? NSNull(),
    ]
}

private func readVastuObstructionData(_ value: VastuObstructionData) -> [String: Any] {
    [
        "input": (value.input as Any?) ?? NSNull(),
        "matchedFeature": (value.matchedFeature as Any?) ?? NSNull(),
        "effect": (value.effect as Any?) ?? NSNull(),
        "rangeChecked": (value.rangeChecked as Any?) ?? NSNull(),
        "inRange": (value.inRange as Any?) ?? NSNull(),
        "houseHeightMultiples": (value.houseHeightMultiples as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "source": (value.source as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
    ]
}

private func readVastuOverallScoreData(_ value: VastuOverallScoreData) -> [String: Any] {
    [
        "score": (value.score as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "placements": (value.placements as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "formula": (value.formula as Any?) ?? NSNull(),
        "gradeLabel": (value.gradeLabel as Any?) ?? NSNull(),
        "indexType": (value.indexType as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "maxScore": (value.maxScore as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "scoreBreakdown": (value.scoreBreakdown as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "scoring": (readVastuOverallScoreDataScoring(value.scoring) as Any?) ?? NSNull(),
    ]
}

private func readVastuPlacementData(_ value: VastuPlacementData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "feature": (value.feature as Any?) ?? NSNull(),
        "proposedZone": (value.proposedZone as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "idealZones": (value.idealZones as Any?) ?? NSNull(),
        "acceptableZones": (value.acceptableZones as Any?) ?? NSNull(),
        "forbiddenZones": (value.forbiddenZones as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "element": (value.element as Any?) ?? NSNull(),
        "elementVerified": (value.elementVerified as Any?) ?? NSNull(),
        "principle": (value.principle as Any?) ?? NSNull(),
        "reason": (value.reason as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "remedyType": (value.remedyType as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuPlanAuditData(_ value: VastuPlanAuditData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "facing": (value.facing as Any?) ?? NSNull(),
        "plotShape": (value.plotShape as Any?) ?? NSNull(),
        "overallScore": (value.overallScore as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "zoneCompliance": (value.zoneCompliance as Any?) ?? NSNull(),
        "roomByRoom": (value.roomByRoom as Any?) ?? NSNull(),
        "defects": (value.defects as Any?) ?? NSNull(),
        "remedies": (value.remedies as Any?) ?? NSNull(),
        "elementBalance": (value.elementBalance as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "printReady": (value.printReady as Any?) ?? NSNull(),
        "tracedGeometry": (value.tracedGeometry as Any?) ?? NSNull(),
        "gradeLabel": (value.gradeLabel as Any?) ?? NSNull(),
        "scoreDisclaimer": (value.scoreDisclaimer as Any?) ?? NSNull(),
        "artifact": (value.artifact.map(readVastuPlanAuditDataArtifact) as Any?) ?? NSNull(),
    ]
}

private func readVastuPlanGenerateData(_ value: VastuPlanGenerateData) -> [String: Any] {
    [
        "plot": (value.plot as Any?) ?? NSNull(),
        "entrance": (value.entrance as Any?) ?? NSNull(),
        "rooms": (value.rooms as Any?) ?? NSNull(),
        "mandala": (value.mandala as Any?) ?? NSNull(),
        "compliance": (value.compliance as Any?) ?? NSNull(),
        "openings": (value.openings as Any?) ?? NSNull(),
        "svg": (value.svg as Any?) ?? NSNull(),
        "variants": (value.variants as Any?) ?? NSNull(),
        "recommendedVariant": (value.recommendedVariant as Any?) ?? NSNull(),
        "architecturalRooms": (value.architecturalRooms as Any?) ?? NSNull(),
        "derivedRoomProgramme": (value.derivedRoomProgramme as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "requirements": (value.requirements as Any?) ?? NSNull(),
        "roomProgrammeNote": (value.roomProgrammeNote as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "variantCount": (value.variantCount as Any?) ?? NSNull(),
        "variantNote": (value.variantNote as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuPlanOptimizeData(_ value: VastuPlanOptimizeData) -> [String: Any] {
    [
        "before": (value.before as Any?) ?? NSNull(),
        "after": (value.after as Any?) ?? NSNull(),
        "improvement": (value.improvement as Any?) ?? NSNull(),
        "moves": (value.moves as Any?) ?? NSNull(),
        "mandala": (value.mandala as Any?) ?? NSNull(),
        "svg": (value.svg as Any?) ?? NSNull(),
        "compliance": (value.compliance as Any?) ?? NSNull(),
        "entrance": (value.entrance as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "openings": (value.openings as Any?) ?? NSNull(),
        "plot": (value.plot as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuPlotExtensionsCutsData(_ value: VastuPlotExtensionsCutsData) -> [String: Any] {
    [
        "directions": (value.directions as Any?) ?? NSNull(),
        "extensions": (value.extensions as Any?) ?? NSNull(),
        "cuts": (value.cuts as Any?) ?? NSNull(),
        "severeCuts": (value.severeCuts as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "actualPlotArea": (value.actualPlotArea as Any?) ?? NSNull(),
        "areaEfficiency": (value.areaEfficiency as Any?) ?? NSNull(),
        "idealRectangleArea": (value.idealRectangleArea as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
    ]
}

private func readVastuPlotOrientationData(_ value: VastuPlotOrientationData) -> [String: Any] {
    [
        "facing": (value.facing as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "doorPadaScheme": (value.doorPadaScheme as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "auspicious": (value.auspicious as Any?) ?? NSNull(),
        "deity": (value.deity as Any?) ?? NSNull(),
        "facingSanskrit": (value.facingSanskrit as Any?) ?? NSNull(),
        "gradeProvenance": (value.gradeProvenance as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
    ]
}

private func readVastuPlotRatioData(_ value: VastuPlotRatioData) -> [String: Any] {
    [
        "length": (value.length as Any?) ?? NSNull(),
        "width": (value.width as Any?) ?? NSNull(),
        "units": (value.units as Any?) ?? NSNull(),
        "unitsNote": (value.unitsNote as Any?) ?? NSNull(),
        "lengthM": (value.lengthM as Any?) ?? NSNull(),
        "widthM": (value.widthM as Any?) ?? NSNull(),
        "ratio": (value.ratio as Any?) ?? NSNull(),
        "category": (value.category as Any?) ?? NSNull(),
        "acceptable": (value.acceptable as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "classicalSource": (value.classicalSource as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "boundingFrame": (value.boundingFrame as Any?) ?? NSNull(),
    ]
}

private func readVastuPlotShapeData(_ value: VastuPlotShapeData) -> [String: Any] {
    [
        "shape": (value.shape as Any?) ?? NSNull(),
        "vertices": (value.vertices as Any?) ?? NSNull(),
        "area": (value.area as Any?) ?? NSNull(),
        "bboxArea": (value.bboxArea as Any?) ?? NSNull(),
        "fillRatio": (value.fillRatio as Any?) ?? NSNull(),
        "vastuGrade": (value.vastuGrade as Any?) ?? NSNull(),
        "notes": (value.notes as Any?) ?? NSNull(),
        "classicalSource": (value.classicalSource as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "boundingFrame": (value.boundingFrame as Any?) ?? NSNull(),
    ]
}

private func readVastuPlotSlopeData(_ value: VastuPlotSlopeData) -> [String: Any] {
    [
        "downSlopeDirection": (value.downSlopeDirection as Any?) ?? NSNull(),
        "classicalReference": (value.classicalReference as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "auspicious": (value.auspicious as Any?) ?? NSNull(),
        "effect": (value.effect as Any?) ?? NSNull(),
        "effectProvenance": (value.effectProvenance as Any?) ?? NSNull(),
        "idealRule": (value.idealRule as Any?) ?? NSNull(),
        "idealRuleProvenance": (value.idealRuleProvenance as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "remedyType": (value.remedyType as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
    ]
}

private func readVastuRemedyComparisonData(_ value: VastuRemedyComparisonData) -> [String: Any] {
    [
        "before": (value.before as Any?) ?? NSNull(),
        "after": (value.after as Any?) ?? NSNull(),
        "scoreDelta": (value.scoreDelta as Any?) ?? NSNull(),
        "scoring": (value.scoring as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "remediesApplied": (value.remediesApplied as Any?) ?? NSNull(),
        "roomChanges": (value.roomChanges as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuRoadOrientationData(_ value: VastuRoadOrientationData) -> [String: Any] {
    [
        "roadAnalysis": (value.roadAnalysis as Any?) ?? NSNull(),
        "beneficRoads": (value.beneficRoads as Any?) ?? NSNull(),
        "cautionRoads": (value.cautionRoads as Any?) ?? NSNull(),
        "veedhiShoola": (value.veedhiShoola as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "chaturMukhi": (value.chaturMukhi as Any?) ?? NSNull(),
        "hasNorthOrEastRoad": (value.hasNorthOrEastRoad as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
    ]
}

private func readVastuRoomData(_ value: VastuRoomData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "room": (value.room as Any?) ?? NSNull(),
        "placement": (value.placement as Any?) ?? NSNull(),
        "verdict": (value.verdict as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "idealZones": (value.idealZones as Any?) ?? NSNull(),
        "acceptableZones": (value.acceptableZones as Any?) ?? NSNull(),
        "forbiddenZones": (value.forbiddenZones as Any?) ?? NSNull(),
        "defect": (value.defect as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "remedyType": (value.remedyType as Any?) ?? NSNull(),
        "guidance": (value.guidance as Any?) ?? NSNull(),
        "citation": (value.citation as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "storageType": (value.storageType as Any?) ?? NSNull(),
    ]
}

private func readVastuScanStoredData(_ value: VastuScanStoredData) -> [String: Any] {
    [
        "schemaVersion": (value.schemaVersion as Any?) ?? NSNull(),
        "propertyId": (value.propertyId as Any?) ?? NSNull(),
        "snapshot": (value.snapshot as Any?) ?? NSNull(),
        "audit": (value.audit as Any?) ?? NSNull(),
        "scanQuality": (value.scanQuality as Any?) ?? NSNull(),
        "captureVerification": (value.captureVerification as Any?) ?? NSNull(),
        "geometryUnits": (value.geometryUnits as Any?) ?? NSNull(),
        "assessmentNote": (value.assessmentNote as Any?) ?? NSNull(),
    ]
}

private func readVastuScansDeleteData(_ value: VastuScansDeleteData) -> [String: Any] {
    [
        "scanId": (value.scanId as Any?) ?? NSNull(),
        "deleted": (value.deleted as Any?) ?? NSNull(),
        "deletionScope": (value.deletionScope as Any?) ?? NSNull(),
        "persistence": (value.persistence as Any?) ?? NSNull(),
        "previewNote": (value.previewNote as Any?) ?? NSNull(),
    ]
}

private func readVastuScansListData(_ value: VastuScansListData) -> [String: Any] {
    [
        "scans": (value.scans as Any?) ?? NSNull(),
        "nextCursor": (value.nextCursor as Any?) ?? NSNull(),
        "paginationNote": (value.paginationNote as Any?) ?? NSNull(),
        "persistence": (value.persistence as Any?) ?? NSNull(),
        "previewNote": (value.previewNote as Any?) ?? NSNull(),
    ]
}

private func readVastuScansRetrieveData(_ value: VastuScansRetrieveData) -> [String: Any] {
    [
        "scan": (value.scan as Any?) ?? NSNull(),
        "persistence": (value.persistence as Any?) ?? NSNull(),
        "previewNote": (value.previewNote as Any?) ?? NSNull(),
    ]
}

private func readVastuScansSaveData(_ value: VastuScansSaveData) -> [String: Any] {
    [
        "scan": (value.scan as Any?) ?? NSNull(),
        "replayed": (value.replayed as Any?) ?? NSNull(),
        "retentionNote": (value.retentionNote as Any?) ?? NSNull(),
        "persistence": (value.persistence as Any?) ?? NSNull(),
        "previewNote": (value.previewNote as Any?) ?? NSNull(),
    ]
}

private func readVastuScansTimelapseData(_ value: VastuScansTimelapseData) -> [String: Any] {
    [
        "propertyId": (value.propertyId as Any?) ?? NSNull(),
        "scans": (value.scans as Any?) ?? NSNull(),
        "comparisonNote": (value.comparisonNote as Any?) ?? NSNull(),
        "physicalChangeVerified": (value.physicalChangeVerified as Any?) ?? NSNull(),
        "persistence": (value.persistence as Any?) ?? NSNull(),
        "previewNote": (value.previewNote as Any?) ?? NSNull(),
    ]
}

private func readVastuSingleRoomAuditData(_ value: VastuSingleRoomAuditData) -> [String: Any] {
    [
        "input": (value.input as Any?) ?? NSNull(),
        "compliance": (value.compliance as Any?) ?? NSNull(),
        "severity": (value.severity as Any?) ?? NSNull(),
        "recommendedZone": (value.recommendedZone as Any?) ?? NSNull(),
        "remedy": (value.remedy as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "computed": (value.computed as Any?) ?? NSNull(),
        "classification": (value.classification as Any?) ?? NSNull(),
        "remedyKey": (value.remedyKey as Any?) ?? NSNull(),
        "remedyParams": (value.remedyParams as Any?) ?? NSNull(),
    ]
}

private func readVastuSpecializedAuditData(_ value: VastuSpecializedAuditData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "buildingType": (value.buildingType as Any?) ?? NSNull(),
        "score": (value.score as Any?) ?? NSNull(),
        "grade": (value.grade as Any?) ?? NSNull(),
        "scoringBasis": (value.scoringBasis as Any?) ?? NSNull(),
        "auditedRooms": (value.auditedRooms as Any?) ?? NSNull(),
        "idealCount": (value.idealCount as Any?) ?? NSNull(),
        "compliantCount": (value.compliantCount as Any?) ?? NSNull(),
        "defectCount": (value.defectCount as Any?) ?? NSNull(),
        "findings": (value.findings as Any?) ?? NSNull(),
        "remedies": (value.remedies as Any?) ?? NSNull(),
        "unknownRooms": (value.unknownRooms as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "provenance": (value.provenance as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "buildingDirection": (value.buildingDirection as Any?) ?? NSNull(),
    ]
}

private func readVastuSunPathData(_ value: VastuSunPathData) -> [String: Any] {
    [
        "input": (readVastuSunPathDataInput(value.input) as Any?) ?? NSNull(),
        "sunriseUtc": (value.sunriseUtc as Any?) ?? NSNull(),
        "sunriseAzimuthDeg": (value.sunriseAzimuthDeg as Any?) ?? NSNull(),
        "solarNoonUtc": (value.solarNoonUtc as Any?) ?? NSNull(),
        "solarNoonAzimuthDeg": (value.solarNoonAzimuthDeg as Any?) ?? NSNull(),
        "solarNoonElevationDeg": (value.solarNoonElevationDeg as Any?) ?? NSNull(),
        "sunsetUtc": (value.sunsetUtc as Any?) ?? NSNull(),
        "sunsetAzimuthDeg": (value.sunsetAzimuthDeg as Any?) ?? NSNull(),
        "declinationDeg": (value.declinationDeg as Any?) ?? NSNull(),
        "arc": (value.arc as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
    ]
}

private func readVastuTimingData(_ value: VastuTimingData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "activity": (value.activity as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "summary": (value.summary as Any?) ?? NSNull(),
        "auspiciousDates": (value.auspiciousDates as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "guidance": (value.guidance as Any?) ?? NSNull(),
        "foundationRite": (value.foundationRite as Any?) ?? NSNull(),
    ]
}

private func readVastuWallAnalysisData(_ value: VastuWallAnalysisData) -> [String: Any] {
    [
        "idealWalls": (value.idealWalls as Any?) ?? NSNull(),
        "observedAnalysis": (value.observedAnalysis as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "idealOrdering": (value.idealOrdering as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "principle": (value.principle as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
    ]
}

private func readVastuZoneReferenceData(_ value: VastuZoneReferenceData) -> [String: Any] {
    [
        "system": (value.system as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "zoneCount": (value.zoneCount as Any?) ?? NSNull(),
        "zones": (value.zones as Any?) ?? NSNull(),
        "note": (value.note as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "referenceVersion": (value.referenceVersion as Any?) ?? NSNull(),
    ]
}

private func readVastuZoneWiseScoreData(_ value: VastuZoneWiseScoreData) -> [String: Any] {
    [
        "zones": (value.zones as Any?) ?? NSNull(),
        "sources": (value.sources as Any?) ?? NSNull(),
        "verified": (value.verified as Any?) ?? NSNull(),
        "basis": (value.basis as Any?) ?? NSNull(),
        "indexType": (value.indexType as Any?) ?? NSNull(),
        "input": (value.input as Any?) ?? NSNull(),
        "meta": (value.meta as Any?) ?? NSNull(),
        "method": (value.method as Any?) ?? NSNull(),
        "overallGrade": (value.overallGrade as Any?) ?? NSNull(),
        "overallScore": (value.overallScore as Any?) ?? NSNull(),
        "strongestZone": (value.strongestZone as Any?) ?? NSNull(),
        "system": (value.system as Any?) ?? NSNull(),
        "tradition": (value.tradition as Any?) ?? NSNull(),
        "weakestZone": (value.weakestZone as Any?) ?? NSNull(),
        "zoneWeightingNote": (value.zoneWeightingNote as Any?) ?? NSNull(),
        "scoring": (readVastuZoneWiseScoreDataScoring(value.scoring) as Any?) ?? NSNull(),
    ]
}
