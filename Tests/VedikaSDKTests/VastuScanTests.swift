import Foundation
import XCTest
@testable import VedikaSDK

final class VastuScanTests: XCTestCase {
    func testCountedScanQualityPreservesZeroAndLargeDeclaredCounts() {
        let request = VastuArCountedScanQualityRequest(roomsTagged: 0, roomCount: 0, expectedRoomCount: 1, coveragePercent: 0)
        XCTAssertEqual(request.dictionary["roomsTagged"] as? Int, 0)
        XCTAssertEqual(request.dictionary["roomCount"] as? Int, 0)
        XCTAssertEqual(request.dictionary["expectedRoomCount"] as? Int, 1)
        XCTAssertEqual(request.dictionary["coveragePercent"] as? Double, 0)
        XCTAssertEqual(VastuArScanQualityDataRoomCoverage(raw: ["expectedRoomCount": 9007199254740991]).expectedRoomCount, 9007199254740991)
    }

    func testScanInputRetainsZeroBearingAndNestedRoomData() {
        let request = VastuScansSaveRequest(scanId: "scan-000000000001", propertyId: "property-00000001", title: "Kitchen", retentionDays: 1,
            snapshot: VastuScanSnapshot(inputSource: "self-reported", rooms: [VastuScanSnapshotRoomsItem(roomType: "kitchen", zone: "SE")],
                plotPolygon: [[0, 0], [10, 0], [0, 10]], bearingDeg: 0))
        let snapshot = request.dictionary["snapshot"] as! [String: Any]
        XCTAssertEqual(snapshot["bearingDeg"] as? Double, 0)
        XCTAssertEqual((snapshot["rooms"] as? [[String: String]])?.first?["zone"], "SE")
        XCTAssertNil(snapshot["telemetry"])
        XCTAssertNil(VastuScansListRequest(requestId: "request-00000001", limit: 1).dictionary["cursor"])
    }

    func testScanListKeepsCallerIdentityAndPermitsUnbilledResponse() async throws {
        let server = LoopbackHTTPServer()
        try server.start()
        defer { server.stop() }
        server.enqueue(.init(body: #"{"success":true,"data":{"scans":[],"nextCursor":null}}"#))
        let client = try VedikaClient(apiKey: "vk_test", baseURL: server.baseURL)
        let result = try await client.vastu.vastuScansList(VastuScansListRequest(requestId: "request-00000001", limit: 1))
        XCTAssertTrue(result.success)
        XCTAssertNil(result.billing)
        XCTAssertNil(result.meta)
        XCTAssertTrue(result.data.scans.isEmpty)
        let wire = try XCTUnwrap(server.requests().first)
        XCTAssertEqual(wire.method, "POST")
        XCTAssertEqual(wire.path, "/v2/astrology/vastu/scans/list")
        // The server answers 422 to any retry header on scan operations.
        XCTAssertNil(wire.headers.first { $0.key.lowercased() == "idempotency-key" })
        let body = try JSONSerialization.jsonObject(with: wire.body) as! [String: Any]
        XCTAssertTrue(NSDictionary(dictionary: body).isEqual(to: ["requestId": "request-00000001", "limit": 1]))
    }

    func testScanOperationsRefuseACallerIdempotencyKeyBeforeSending() async throws {
        let client = try VedikaClient(apiKey: "vk_test")
        do {
            _ = try await client.vastu.vastuScansList(VastuScansListRequest(requestId: "request-00000001", limit: 1), idempotencyKey: "retained-scan-list")
            XCTFail("a caller key on a scan operation must be refused")
        } catch let error as VedikaApiError {
            XCTAssertTrue(error.message.contains("requestId"))
        }
        XCTAssertTrue(usesBodyIdentity("/v2/vastu/scans/timelapse"))
        XCTAssertFalse(usesBodyIdentity("/v2/vastu/assessments"))
    }
}
