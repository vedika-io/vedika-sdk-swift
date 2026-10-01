import Foundation

/// One item to queue: a unique `id` (1-128 bytes, no surrounding spaces) and its assessment `input`.
public struct VastuJobsRequestItem: VastuEncodable {
    public var id: String
    public var input: VastuAssessmentsRequest
    public init(id: String, input: VastuAssessmentsRequest) { self.id = id; self.input = input }
    public var dictionary: [String: Any] { ["id": id, "input": input.dictionary] }
}

/// Queue 1 to 1,000 assessments (`POST /v2/astrology/vastu/jobs`). The submit
/// needs a caller-retained idempotency key: the same key and body return the
/// same job, a different body under the same key is refused with 409.
public struct VastuJobsRequest: VastuRequest {
    public var items: [VastuJobsRequestItem]
    /// An active webhook on this account that receives the job's final event.
    public var webhookId: String?
    public init(items: [VastuJobsRequestItem], webhookId: String? = nil) { self.items = items; self.webhookId = webhookId }
    public var dictionary: [String: Any] {
        var result: [String: Any] = ["operation": "assessments", "items": items.map { $0.dictionary }]
        if let webhookId { result["webhookId"] = webhookId }
        return result
    }
}

/// One finished item. `status` is the HTTP status the single-item call would have returned.
public struct VastuJobResultItem {
    public let raw: [String: Any]
    public init(raw: [String: Any]) { self.raw = raw }
    public var id: String { (raw["id"] as? String)! }
    public var index: Int { vastuJobInt(raw["index"])! }
    public var status: Int { vastuJobInt(raw["status"])! }
    /// Failure code such as INVALID_INPUT or INSUFFICIENT_BALANCE; nil on success.
    public var code: String? { raw["code"] as? String }
    /// The exact single-item response envelope, including its billing block.
    public var response: [String: Any] { (raw["response"] as? [String: Any]) ?? [:] }
}

private func vastuJobInt(_ value: Any?) -> Int? { (value as? NSNumber)?.intValue }

extension VastuJobResultsData {
    /// The finished items of this page, typed.
    public var items: [VastuJobResultItem] {
        ((raw["results"] as? [[String: Any]]) ?? []).map { VastuJobResultItem(raw: $0) }
    }
}

public struct VastuJobSubmitResponse {
    public let success: Bool
    public let data: VastuJobSubmitData
    public let raw: [String: Any]
}

public struct VastuJobStatusResponse {
    public let success: Bool
    public let data: VastuJobStatusData
    public let raw: [String: Any]
}

public struct VastuJobResultsResponse {
    public let success: Bool
    public let data: VastuJobResultsData
    public let raw: [String: Any]
}

/// A job id as the server issues it: `vjob_` and 32 lowercase hex digits.
func isValidVastuJobId(_ value: String) -> Bool {
    let bytes = Array(value.utf8)
    guard bytes.count == 37, bytes.starts(with: Array("vjob_".utf8)) else { return false }
    return bytes.dropFirst(5).allSatisfy { ($0 >= 48 && $0 <= 57) || ($0 >= 97 && $0 <= 102) }
}

func requireVastuJobId(_ value: String) throws -> String {
    guard isValidVastuJobId(value) else {
        throw VedikaApiError("jobId must be the vjob_... id returned when the job was submitted")
    }
    return value
}

/// The shape of a job path under `/v2/astrology/vastu/`:
/// `jobs/{id}` and `jobs/{id}/results` are GET, `jobs/{id}/cancel` is POST.
func vastuJobPath(_ path: String) -> (id: String, suffix: String)? {
    let parts = path.split(separator: "/", omittingEmptySubsequences: false).map(String.init)
    guard parts.count >= 2, parts.count <= 3, parts[0] == "jobs" else { return nil }
    if parts.count == 3 && parts[2] != "results" && parts[2] != "cancel" { return nil }
    return (parts[1], parts.count == 3 ? parts[2] : "")
}
