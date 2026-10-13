import Foundation
import XCTest
@testable import VedikaRoomCapture
#if os(iOS) && canImport(ARKit)
import ARKit
#endif

final class RemedyFloorOverlayTests: XCTestCase {
    private func fixture() throws -> [String: Any] {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "native-1.4.0-contract", withExtension: "json"))
        return try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any])
    }
    private func cases() throws -> [[String: Any]] { try XCTUnwrap(try fixture()["geometryCases"] as? [[String: Any]]) }
    private func overlay(_ row: [String: Any]) throws -> RemedyFloorOverlay {
        try RemedyFloorOverlay(capture: XCTUnwrap(row["capture"] as? [String: Any]),
            response: XCTUnwrap(row["response"] as? [String: Any]), catalog: row["catalog"] as? [String: Any] ?? [:])
    }
    private func pose(yaw: Double = 0, x: Double = 0, y: Double = 0, z: Double = 0) throws -> FloorAnchorPose {
        let c = cos(yaw), s = sin(yaw)
        return try FloorAnchorPose(columns: [c,0,-s,0, 0,1,0,0, s,0,c,0, x,y,z,1])
    }
    private func assertPoint(_ a: SIMD3<Double>, _ b: SIMD3<Double>, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(a.x, b.x, accuracy: 1e-8, file: file, line: line)
        XCTAssertEqual(a.y, b.y, accuracy: 1e-8, file: file, line: line)
        XCTAssertEqual(a.z, b.z, accuracy: 1e-8, file: file, line: line)
    }

    func testLiveAndConcaveRemedyMarkersMatchThePublicWebGeometryOracle() throws {
        for row in try cases() {
            let result = try overlay(row), expected = try XCTUnwrap(row["expected"] as? [[String: Any]])
            XCTAssertEqual(result.placements.count, expected.count, row["name"] as? String ?? "")
            XCTAssertEqual(result.polygons.count, expected.count)
            for (marker, oracle) in zip(result.placements, expected) {
                let xy = try XCTUnwrap(oracle["point"] as? [Double])
                XCTAssertEqual(marker.point.x, xy[0], accuracy: 1e-9)
                XCTAssertEqual(marker.point.y, xy[1], accuracy: 1e-9)
                XCTAssertEqual(marker.id, oracle["id"] as? String)
                XCTAssertEqual(marker.roomId, oracle["roomId"] as? String)
                XCTAssertEqual(marker.zone, oracle["zone"] as? String)
                XCTAssertEqual(marker.advice, oracle["advice"] as? String)
                XCTAssertEqual(marker.source, oracle["source"] as? String)
                XCTAssertEqual(marker.number, oracle["number"] as? Int)
            }
        }
    }

    func testNoAdviceIsCreatedWhenTheLiveResponseHasNoRemedies() throws {
        let f = try fixture(), request = try XCTUnwrap(f["captureRequest"] as? [String: Any])
        let result = try RemedyFloorOverlay(capture: XCTUnwrap(request["capture"] as? [String: Any]),
            response: XCTUnwrap(f["uploadResponse"] as? [String: Any]), catalog: XCTUnwrap(f["catalog"] as? [String: Any]))
        XCTAssertTrue(result.placements.isEmpty); XCTAssertTrue(result.polygons.isEmpty)
    }

    func testRemediesUseOriginalFloorAnchorAndRestorePoseAcrossFiveYaws() throws {
        let row = try XCTUnwrap(try cases().first), result = try overlay(row)
        let capture = try XCTUnwrap(row["capture"] as? [String: Any])
        let frame = try XCTUnwrap(capture["frame"] as? [String: Any])
        let plan = try XCTUnwrap(frame["planToWorld"] as? [String: Any])
        let origin = try XCTUnwrap(plan["origin"] as? [Double]), x = try XCTUnwrap(plan["xAxis"] as? [Double]), y = try XCTUnwrap(plan["yAxis"] as? [Double])
        XCTAssertFalse(result.placements.isEmpty)
        for yaw in [0.0, .pi / 4, .pi / 2, .pi, 4.06] {
            let original = try pose(yaw: yaw, x: 4, y: 0.5, z: -3)
            let transform = try FloorPlanAnchorTransform(origin: origin, xAxis: x, yAxis: y, originalAnchor: original)
            let restored = try pose(yaw: yaw + 0.4, x: -7, y: 0.8, z: 2)
            for (marker, polygon) in zip(result.placements, result.polygons) {
                let expected = SIMD3(origin[0], origin[1], origin[2]) +
                    SIMD3(x[0], x[1], x[2]) * marker.point.x + SIMD3(y[0], y[1], y[2]) * marker.point.y
                let local = try transform.anchorPoint(east: marker.point.x, north: marker.point.y)
                assertPoint(original.worldPoint(local), expected)
                let center = polygon.points.reduce(SIMD2<Double>(repeating: 0), +) / Double(polygon.points.count)
                let pinned = try transform.anchorPoint(east: center.x, north: center.y)
                assertPoint(restored.worldPoint(pinned), restored.worldPoint(local))
                // Moving the camera never changes the marker's anchor point.
                for step in 0..<12 {
                    let camera = try pose(yaw: Double(step) / 3, x: Double(step), y: 1.6, z: Double(step) / 2)
                    assertPoint(camera.worldPoint(camera.localPoint(original.worldPoint(local))), expected)
                }
            }
        }
    }

    func testConcaveRemedySquaresNeverEnterTheUnscannedCutout() throws {
        let row = try XCTUnwrap(try cases().first { $0["name"] as? String == "concave-room-and-global-deduplication" })
        let result = try overlay(row)
        XCTAssertEqual(result.placements.count, 2) // duplicate audit/plan defect removed
        XCTAssertNil(result.placements.last?.roomId) // global advice retained
        for polygon in result.polygons {
            for p in polygon.points {
                XCTAssertTrue(p.x >= 0 && p.x <= 6 && p.y >= 0 && p.y <= 6)
                XCTAssertTrue(p.x <= 2 || p.x >= 4 || p.y <= 2)
            }
        }
    }

    func testMissingRemedySourceNeverBorrowsThePlacementCitation() throws {
        let row = try XCTUnwrap(try cases().first), capture = try XCTUnwrap(row["capture"] as? [String: Any])
        let response: [String: Any] = ["success": true, "data": ["rooms": [], "audit": ["defects": [
            ["roomId": "r1", "issue": "Synthetic issue", "remedy": "Synthetic advice", "source": "Placement citation only"]]]]]
        let result = try RemedyFloorOverlay(capture: capture, response: response)
        let marker = try XCTUnwrap(result.placements.first)
        XCTAssertEqual(marker.source, ""); XCTAssertEqual(marker.sourceLabel, "Remedy source not supplied.")
        XCTAssertEqual(marker.advice, "Synthetic advice")
    }

    func testUnknownCaptureFailedResponseInvalidUnitsAndGeometryRefuse() throws {
        let row = try XCTUnwrap(try cases().first), capture = try XCTUnwrap(row["capture"] as? [String: Any])
        var response = try XCTUnwrap(row["response"] as? [String: Any])
        response["success"] = false
        XCTAssertThrowsError(try RemedyFloorOverlay(capture: capture, response: response))
        response = ["data": ["capture": ["captureId": "another-capture"]]]
        XCTAssertThrowsError(try RemedyFloorOverlay(capture: capture, response: response))
        var invalid = capture; var frame = try XCTUnwrap(capture["frame"] as? [String: Any]); frame["units"] = "feet"; invalid["frame"] = frame
        XCTAssertThrowsError(try RemedyFloorOverlay(capture: invalid, response: [:]))
        let booleans = try JSONSerialization.jsonObject(with: Data("[[true,0],[1,0],[0,1]]".utf8))
        let invalidPolygons: [Any] = [[], [[0,0],[1,1],[2,2]], booleans, [[Double.nan,0],[1,0],[0,1]]]
        for polygon in invalidPolygons {
            invalid = capture; invalid["outline"] = ["polygon": polygon]
            XCTAssertThrowsError(try RemedyFloorOverlay(capture: invalid, response: [:]))
        }
        invalid = capture
        var outline = try XCTUnwrap(capture["outline"] as? [String: Any]); outline["holes"] = [[[0,0],[1,0],[0,1]]]; invalid["outline"] = outline
        XCTAssertThrowsError(try RemedyFloorOverlay(capture: invalid, response: [:]))
    }

    func testRemedyVisibilityUsesTheSameRelocalizationAndFreshFrameGates() {
        let anchor = UUID(), session = UUID(), north = UUID()
        var map = OverlayRelocalizationGate(), tracking = FloorOverlayTrackingGuard(sessionId: session, northRevision: north)
        for frame in 1...3 {
            let t = Double(frame), allowed = map.observe(trackingNormal: true, expectedAnchorIds: [anchor],
                restoredAnchorIds: [anchor], reprojectionErrorsPixels: [2], frameTimestamp: t)
            XCTAssertEqual(tracking.observe(timestamp: t, now: t + 0.01, trackingNormal: true,
                anchorPresent: true, relocalized: allowed, sessionId: session, northRevision: north), frame == 3)
        }
        XCTAssertFalse(tracking.observe(timestamp: 3, now: 3.02, trackingNormal: true,
            anchorPresent: true, relocalized: true, sessionId: session, northRevision: north))
        XCTAssertFalse(map.observe(trackingNormal: false, expectedAnchorIds: [anchor],
            restoredAnchorIds: [anchor], reprojectionErrorsPixels: [2], frameTimestamp: 4))
        XCTAssertFalse(tracking.observe(timestamp: 4, now: 4.01, trackingNormal: false,
            anchorPresent: true, relocalized: false, sessionId: session, northRevision: north))
        XCTAssertFalse(tracking.overlaysAllowed)
        XCTAssertFalse(tracking.observe(timestamp: 5, now: 5.25, trackingNormal: true,
            anchorPresent: true, relocalized: true, sessionId: session, northRevision: north))
        XCTAssertFalse(tracking.observe(timestamp: 6, now: 6.01, trackingNormal: true,
            anchorPresent: true, relocalized: true, sessionId: session, northRevision: UUID()))
    }

    #if os(iOS) && canImport(ARKit)
    @MainActor
    func testIOSRemedyRendererUsesFloorGeometryAndStartsHidden() throws {
        if #available(iOS 16.0, *) {
            let row = try XCTUnwrap(try cases().first), remedies = try overlay(row)
            let id = UUID(), original = try pose()
            let transform = try FloorPlanAnchorTransform(origin: [0,0,0], xAxis: [1,0,0], yAxis: [0,0,-1], originalAnchor: original)
            let reference = LocalWorldMapReference(fileName: "synthetic-local-reference", sha256: "fixture", anchorIds: [id])
            let renderer = try PinnedFloorOverlayRenderer(session: ARSession(), anchorId: id, reference: reference,
                sessionId: UUID(), northRevision: UUID(), transform: transform, remedies: remedies)
            let root = try XCTUnwrap(renderer.view.scene.rootNode.childNodes.first)
            XCTAssertTrue(root.isHidden); XCTAssertEqual(root.childNodes.count, remedies.polygons.count * 2)
            renderer.invalidate(); XCTAssertTrue(root.isHidden)
        } else { throw XCTSkip("Renderer requires iOS 16+") }
    }
    #endif
}
