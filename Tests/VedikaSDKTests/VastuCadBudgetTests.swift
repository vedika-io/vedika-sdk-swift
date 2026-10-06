import XCTest
@testable import VedikaSDK
final class VastuCadBudgetTests: XCTestCase {
    func testAllCADRequestsSerializeExactBudget() {
        let requests: [[String: Any]] = [
            VastuPlanImportDxfRequest(dxf: "synthetic", maxChargeUsd: "0.01").dictionary,
            VastuPlanExportDxfRequest(plan: [:], maxChargeUsd: "0.01").dictionary,
            VastuPlanImportIfcRequest(ifc: "synthetic", maxChargeUsd: "0.01").dictionary,
        ]
        for request in requests { XCTAssertEqual(request["maxChargeUsd"] as? String, "0.01") }
        XCTAssertNil(VastuPlanImportDxfRequest(dxf: "synthetic").dictionary["maxChargeUsd"])
    }
}
