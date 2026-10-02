import Foundation
import XCTest

@testable import VedikaSDK

/// Nightly real-consumer check against production. Skipped unless
/// `VEDIKA_PROD_SMOKE_KEY` is set, so ordinary `swift test` runs never touch
/// the network. Spends a few cents: one declination, one report upload and
/// one question. The job item is deliberately incomplete, so it is not charged.
final class ProdSmokeTests: XCTestCase {
    private var key: String {
        get throws {
            guard let key = ProcessInfo.processInfo.environment["VEDIKA_PROD_SMOKE_KEY"], !key.isEmpty else {
                throw XCTSkip("VEDIKA_PROD_SMOKE_KEY not set")
            }
            return key
        }
    }

    private static let pdf = Data((
        "%PDF-1.4\n1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj\n"
            + "2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj\n"
            + "3 0 obj<</Type/Page/Parent 2 0 R/MediaBox[0 0 612 792]/Contents 4 0 R/Resources<</Font<</F1 5 0 R>>>>>>endobj\n"
            + "4 0 obj<</Length 120>>stream\nBT /F1 11 Tf 40 760 Td (Vastu Report. Plot facing North. Kitchen in South-East. "
            + "Pooja room in North-East.) Tj ET\nendstream endobj\n"
            + "5 0 obj<</Type/Font/Subtype/Type1/BaseFont/Helvetica>>endobj\ntrailer<</Root 1 0 R>>\n%%EOF\n").utf8)

    func testDeclination() async throws {
        let client = try VedikaClient(apiKey: try key)
        let result = try await client.vastu.vastuDeclination(lat: 28.6139, lon: 77.209)
        XCTAssertTrue(result.success)
        XCTAssertNotNil(result.raw["billing"])
    }

    func testIncompleteJobCompletesUncharged() async throws {
        let client = try VedikaClient(apiKey: try key)
        let request = VastuJobsRequest(items: [VastuJobsRequestItem(
            id: "nightly-1",
            input: VastuAssessmentsRequest(inputSource: "seller-supplied", rooms: [.init(roomType: "kitchen", zone: "SE")]))])
        let key = UUID().uuidString
        let submitted = try await client.vastu.vastuJobSubmit(request, idempotencyKey: key)
        let again = try await client.vastu.vastuJobSubmit(request, idempotencyKey: key)
        XCTAssertEqual(again.data.jobId, submitted.data.jobId)
        var status = try await client.vastu.vastuJobStatus(submitted.data.jobId)
        for _ in 0..<30 where !["completed", "partial", "failed", "cancelled"].contains(status.data.status) {
            try await Task.sleep(nanoseconds: 5_000_000_000)
            status = try await client.vastu.vastuJobStatus(submitted.data.jobId)
        }
        XCTAssertEqual(status.data.status, "completed")
        XCTAssertEqual(status.data.billing.charged, 0)
        let items = try await client.vastu.vastuJobAllResults(submitted.data.jobId)
        XCTAssertEqual(items.count, 1)
    }

    func testUploadAndAskAboutTheReport() async throws {
        let client = try VedikaClient(apiKey: try key)
        let key = UUID().uuidString
        let upload = try await client.vastu.uploadVastuReport(Self.pdf, idempotencyKey: key)
        let id = try XCTUnwrap(upload["uploadId"] as? String)
        let replay = try await client.vastu.uploadVastuReport(Self.pdf, idempotencyKey: key)
        XCTAssertEqual(replay["uploadId"] as? String, id)
        let answer = try await client.vastu.askVastuReport(
            "Which direction is the kitchen in, per my report?", reportRef: VastuReportRef(id: id))
        let text = (answer["answer"] as? String ?? "")
            .replacingOccurrences(of: "\u{2011}", with: "-").replacingOccurrences(of: "\u{2010}", with: "-")
        XCTAssertTrue(text.range(of: "south-east", options: .caseInsensitive) != nil, text)
    }

    func testInvalidKeyIsRejected() async throws {
        _ = try key
        do {
            _ = try await VedikaClient(apiKey: "vk_live_invalid_key_for_nightly").vastu.vastuDeclination(lat: 1, lon: 1)
            XCTFail("an invalid key must be rejected")
        } catch {
            XCTAssertTrue("\(error)".lowercased().contains("auth") || "\(error)".contains("401"), "\(error)")
        }
    }
}
