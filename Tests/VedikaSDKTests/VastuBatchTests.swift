import Foundation
import XCTest
@testable import VedikaSDK

final class VastuBatchTests: XCTestCase {
    private func request() -> VastuAssessmentsBatchRequest {
        VastuAssessmentsBatchRequest(items: [
            VastuAssessmentsBatchRequestItemsItem(id: "property-1", assessment: VastuAssessmentsRequest(inputSource: "plan-derived")),
            VastuAssessmentsBatchRequestItemsItem(id: "property-2", assessment: VastuAssessmentsRequest(inputSource: "seller-supplied")),
        ])
    }

    private let response = #"{"success":true,"data":{"results":[{"id":"property-1","status":200,"response":{"success":true,"data":{"status":"assessed","score":100}}},{"id":"property-2","status":400,"response":{"success":false,"error":"invalid assessment","code":"INVALID_INPUT"}}],"summary":{"total":2,"succeeded":1,"failed":1},"billingBasis":"existing assessment price per item","execution":"synchronous"}}"#

    func testReportAndDrawingOptionsPreserveValuesAndOmittedDefaults() {
        XCTAssertEqual(VastuPlanGenerateRequest(plot: VastuPlanGenerateRequestPlot(), includeSvg: false).dictionary["includeSvg"] as? Bool, false)
        XCTAssertEqual(VastuPlanFromRequirementsRequest(plot: VastuPlanFromRequirementsRequestPlot(), includeSvg: false).dictionary["includeSvg"] as? Bool, false)
        XCTAssertEqual(VastuPlanOptimizeRequest(rooms: [], includeSvg: false).dictionary["includeSvg"] as? Bool, false)
        XCTAssertNil(VastuPlanGenerateRequest(plot: VastuPlanGenerateRequestPlot()).dictionary["includeSvg"])
        let report = VastuPlanReportRequest(rooms: [], format: "html", brand: VastuPlanReportRequestBrand(reportTitle: "Title", generatedFor: "Customer"), reportTitle: "Top title", generatedFor: "Buyer", tenantName: "Tenant")
        let body = report.dictionary
        XCTAssertEqual(body["format"] as? String, "html")
        XCTAssertEqual(body["brand"] as? [String: String], ["reportTitle": "Title", "generatedFor": "Customer"])
        XCTAssertEqual(body["reportTitle"] as? String, "Top title")
        XCTAssertEqual(body["generatedFor"] as? String, "Buyer")
        XCTAssertEqual(body["tenantName"] as? String, "Tenant")
        XCTAssertEqual(Set(VastuPlanReportRequest(rooms: []).dictionary.keys), Set(["rooms"]))
    }

    func testBatchRejectsMissingOrBlankIdentityBeforeNetwork() async throws {
        let server = LoopbackHTTPServer()
        try server.start()
        defer { server.stop() }
        let client = try VedikaClient(apiKey: "vk_test", baseURL: server.baseURL)
        let keys: [String?] = [nil, "", "   "]
        for key in keys {
            do {
                _ = try await client.vastu.vastu("assessments/batch", params: request().dictionary, idempotencyKey: key)
                XCTFail("batch must reject missing or blank identity")
            } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
            do {
                _ = try await client.vastu.vastuOperation(VastuOperation.assessmentsBatch, idempotencyKey: key)
                XCTFail("typed operation must reject missing or blank identity")
            } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
            if let key {
                do {
                    _ = try await client.vastu.vastuAssessmentsBatch(request(), idempotencyKey: key)
                    XCTFail("named batch must reject blank identity")
                } catch let error as VedikaApiError { XCTAssertTrue(error.message.contains("Idempotency-Key")) }
            }
        }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testTypedBatchRetainsWireBodyAndSavedIdentityAcrossRetryAndClientRecreation() async throws {
        let server = LoopbackHTTPServer()
        try server.start()
        defer { server.stop() }
        server.enqueue(.init(status: 503, reason: "Unavailable", body: "{}"))
        server.enqueue(.init(body: response))
        server.enqueue(.init(body: response))
        for _ in 0..<2 {
            let client = try VedikaClient(apiKey: "vk_test", baseURL: server.baseURL)
            let result = try await client.vastu.vastuAssessmentsBatch(request(), idempotencyKey: "saved-batch-42")
            XCTAssertTrue(result.success)
            XCTAssertEqual(result.data.summary.total, 2)
            XCTAssertEqual(result.data.summary.failed, 1)
            XCTAssertEqual(result.data.results[0].id, "property-1")
            XCTAssertEqual(result.data.results[0].response.data?.score, 100)
            XCTAssertEqual(result.data.results[1].status, 400)
            XCTAssertFalse(result.data.results[1].response.success)
            XCTAssertNil(result.data.results[1].response.data)
            XCTAssertEqual(result.data.results[1].response.code, "INVALID_INPUT")
        }
        XCTAssertEqual(server.requests().count, 3)
        for wire in server.requests() {
            XCTAssertEqual(wire.method, "POST")
            XCTAssertEqual(wire.path, "/v2/astrology/vastu/assessments/batch")
            XCTAssertEqual(wire.headers.first { $0.key.lowercased() == "idempotency-key" }?.value, "saved-batch-42")
            let body = try JSONSerialization.jsonObject(with: wire.body) as! [String: Any]
            XCTAssertTrue(NSDictionary(dictionary: body).isEqual(to: request().dictionary))
        }
    }
}
