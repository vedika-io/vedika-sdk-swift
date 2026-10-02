import Foundation

/// An uploaded report PDF to discuss, from `uploadVastuReport`.
public struct VastuReportRef: Sendable, Equatable {
    public let id: String
    public init(id: String) { self.id = id }
    var dictionary: [String: Any] { ["type": "upload", "id": id] }
}

extension VastuService {
    /// Upload a Vastu report PDF (up to 5 MiB, 40 pages, with a text layer) so
    /// later questions can cite it. Billed once per key; a retry with the same
    /// caller-retained `idempotencyKey` returns the original upload uncharged.
    ///
    /// - Returns: the response body, including `uploadId` (`vup_…`), `expiresAt`
    ///   and `billing`.
    @discardableResult
    public func uploadVastuReport(_ pdf: Data, filename: String = "report.pdf", idempotencyKey: String)
        async throws -> [String: Any]
    {
        guard VastuReportChat.isValidUploadKey(idempotencyKey) else {
            throw VedikaApiError("A caller-retained Idempotency-Key of 1 to 256 visible ASCII characters is required")
        }
        guard !pdf.isEmpty else {
            throw VedikaApiError("pdf must be the non-empty bytes of a PDF")
        }
        return try await client.postPDFUpload(
            "/api/v1/vastu/chat/uploads", pdf: pdf, filename: filename, idempotencyKey: idempotencyKey)
    }

    /// Ask a question about a Vastu report: pass exactly one of `report` (a
    /// response body from plan/analyze, plan/report, audit or score, up to
    /// 64 KB) or `reportRef` (an upload). A follow-up may pass only
    /// `conversationId`, which reuses the conversation's saved report.
    @discardableResult
    public func askVastuReport(
        _ question: String,
        report: [String: Any]? = nil,
        reportRef: VastuReportRef? = nil,
        conversationId: String? = nil,
        language: String? = nil,
        speed: String? = nil
    ) async throws -> [String: Any] {
        let body = try VastuReportChat.askBody(
            question: question, report: report, reportRef: reportRef,
            conversationId: conversationId, language: language, speed: speed)
        return try await client.post("/api/v1/astrology/query", body: body)
    }
}

enum VastuReportChat {
    static func isValidUploadKey(_ key: String) -> Bool {
        !key.isEmpty && key.utf8.count <= 256 && key.utf8.allSatisfy { (0x21...0x7E).contains($0) }
    }

    static func isValidUploadId(_ id: String) -> Bool {
        id.range(of: "^vup_[0-9a-f]{32}$", options: .regularExpression) != nil
    }

    static func askBody(
        question: String, report: [String: Any]?, reportRef: VastuReportRef?,
        conversationId: String?, language: String?, speed: String?
    ) throws -> [String: Any] {
        if report != nil && reportRef != nil {
            throw VedikaApiError("askVastuReport takes exactly one of report or reportRef, not both")
        }
        if let reportRef, !isValidUploadId(reportRef.id) {
            throw VedikaApiError("reportRef.id must be a vup_ id from uploadVastuReport")
        }
        if report == nil && reportRef == nil && (conversationId ?? "").isEmpty {
            throw VedikaApiError("askVastuReport needs a report, a reportRef or a conversationId that already holds one")
        }
        var body: [String: Any] = ["question": question]
        if let language { body["language"] = language }
        if let report { body["vastuContext"] = ["report": report] }
        if let reportRef { body["vastuContext"] = ["reportRef": reportRef.dictionary] }
        if let conversationId, !conversationId.isEmpty { body["conversationId"] = conversationId }
        if let speed { body["speed"] = speed }
        return body
    }

    /// One `file` part, `application/pdf`. The filename is sanitised so it
    /// cannot break out of its quoted header.
    static func multipartBody(pdf: Data, filename: String, boundary: String) -> Data {
        var safeName = ""
        for scalar in filename.unicodeScalars {
            safeName.unicodeScalars.append(["\r", "\n", "\"", "\\"].contains(scalar) ? "_" : scalar)
        }
        var body = Data()
        body.append(Data(("--\(boundary)\r\nContent-Disposition: form-data; name=\"file\"; filename=\"\(safeName)\"\r\n"
            + "Content-Type: application/pdf\r\n\r\n").utf8))
        body.append(pdf)
        body.append(Data("\r\n--\(boundary)--\r\n".utf8))
        return body
    }
}
