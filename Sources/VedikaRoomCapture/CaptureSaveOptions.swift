import Foundation
import VedikaSDK

/// An optional account save, frozen with the queued capture. `scanId` is the
/// save's retry identity; scan routes do not accept an Idempotency-Key header.
public struct CaptureSaveOptions: Codable, Sendable, Equatable {
    public let scanId: String
    public let propertyId: String
    public let title: String
    public let retentionDays: Int

    public init(scanId: String, propertyId: String, title: String, retentionDays: Int) throws {
        self.scanId = scanId; self.propertyId = propertyId
        self.title = title; self.retentionDays = retentionDays
        try validate()
    }

    public func request(capture: VastuRoomCapture) -> VastuScansSaveRequest {
        VastuScansSaveRequest(scanId: scanId, propertyId: propertyId, title: title,
            retentionDays: retentionDays,
            snapshot: VastuScanSnapshot(inputSource: "device-reported", capture: capture))
    }

    func validate() throws {
        for value in [scanId, propertyId] {
            guard (16...128).contains(value.utf8.count), value.utf8.allSatisfy({
                (48...57).contains($0) || (65...90).contains($0) ||
                (97...122).contains($0) || $0 == 95 || $0 == 45
            }) else { throw CaptureStoreError.invalidBody }
        }
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              title.utf8.count <= 160, (1...30).contains(retentionDays) else {
            throw CaptureStoreError.invalidBody
        }
    }

    func body(capture: [String: Any]) throws -> [String: Any] {
        try validate()
        return ["scanId": scanId, "propertyId": propertyId, "title": title,
                "retentionDays": retentionDays,
                "snapshot": ["inputSource": "device-reported", "capture": capture]]
    }
}
