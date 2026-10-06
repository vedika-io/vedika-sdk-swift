import XCTest
@testable import VedikaSDK

final class PortfolioTests: XCTestCase {
    func testAttributionSurvivesAssessmentSerialization() throws {
        let request = VastuAssessmentsRequest(inputSource: "plan-derived", propertyId: "p1", tenantRef: "t1")
        let wire = try JSONSerialization.jsonObject(with: JSONSerialization.data(withJSONObject: request.dictionary)) as! [String: Any]
        XCTAssertEqual(wire["propertyId"] as? String, "p1")
        XCTAssertEqual(wire["tenantRef"] as? String, "t1")
        XCTAssertNil(VastuAssessmentsRequest(inputSource: "plan-derived").dictionary["tenantRef"])
    }
    func testCapRemovalIsExplicitNullAndPortfolioContractsAreTyped() {
        let request = VastuPortfolioBudgetsSetRequest(tenantRef: "t1", capUsd: nil)
        XCTAssertTrue(request.dictionary["capUsd"] is NSNull)
        XCTAssertEqual(VastuContracts.portfolioBudgetsSet.operation, .portfolioBudgetsSet)
        XCTAssertEqual(VastuPortfolioCompareRequest(propertyIds: ["p1", "p2"]).dictionary["propertyIds"] as? [String], ["p1", "p2"])
    }
}
