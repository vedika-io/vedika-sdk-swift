import Foundation
import VedikaSDK

/// Durable bodies exclude short-lived attestation. If required, prepare a new
/// proof for the unchanged body on each attempt; retain the billing identity.
public enum CaptureUploadAdapter {
    public static func upload(_ entry: QueuedCapture, service: VastuService,
                              prepareProof: (([String: Any]) async throws -> VastuDeviceAttestation)? = nil) async throws -> CaptureUploadResult {
        guard var body = try JSONSerialization.jsonObject(with: entry.body) as? [String: Any],
              let capture = body["capture"] as? [String: Any], let id = capture["captureId"] as? String,
              body["deviceAttestation"] == nil else { return .rejected }
        if let prepareProof { body["deviceAttestation"] = try await prepareProof(body).dictionary }
        do {
            let response = try await service.vastu("ar/room-capture", params: body, idempotencyKey: entry.idempotencyKey)
            guard response["success"] as? Bool == true, let data = response["data"] as? [String: Any],
                  let returned = data["capture"] as? [String: Any], returned["captureId"] as? String == id else { return .rejected }
            return .accepted
        } catch let error as VedikaApiError {
            if error.statusCode == 409 { return .conflict }
            if error.statusCode == 429 || (error.statusCode ?? 0) >= 500 || error.statusCode == nil { return .retryable }
            return .rejected
        }
    }
}
