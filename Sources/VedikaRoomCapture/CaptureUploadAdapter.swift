import Foundation
import VedikaSDK

/// Durable bodies exclude short-lived attestation. If required, prepare a new
/// proof for the unchanged body on each attempt; retain the billing identity.
public enum CaptureUploadAdapter {
    /// Opt in at enqueue with `saveAfterUpload`. The outbox durably checkpoints
    /// the upload before the account save, including across an app restart.
    /// Bind prepareProof to "ar/room-capture" and prepareSaveProof to "scans/save"
    /// using NativeAttestation.digest or AppAttestCaptureProof.proof.
    public static func flush(_ outbox: CaptureOutbox, service: VastuService,
                             now: Date = Date(), isOnline: @Sendable () -> Bool,
                             prepareProof: (@Sendable ([String: Any]) async throws -> VastuDeviceAttestation)? = nil,
                             prepareSaveProof: (@Sendable ([String: Any]) async throws -> VastuDeviceAttestation)? = nil) async throws {
        try await outbox.flush(now: now, isOnline: isOnline,
            save: { entry in try await save(entry, service: service, prepareProof: prepareSaveProof) },
            upload: { entry in try await upload(entry, service: service, prepareProof: prepareProof) })
    }

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

    /// Saves the exact queued capture, not the API's capture summary. Fresh
    /// attestation binds the complete save body with operation "scans/save".
    /// A preview-only response never marks a durable account save as synced.
    public static func save(_ entry: QueuedCapture, service: VastuService,
                            prepareProof: (([String: Any]) async throws -> VastuDeviceAttestation)? = nil) async throws -> CaptureUploadResult {
        guard entry.uploadCompleted == true, let options = entry.saveAfterUpload,
              let uploadBody = try JSONSerialization.jsonObject(with: entry.body) as? [String: Any],
              uploadBody["deviceAttestation"] == nil,
              let capture = uploadBody["capture"] as? [String: Any] else { return .rejected }
        var body = try options.body(capture: capture)
        if let prepareProof { body["deviceAttestation"] = try await prepareProof(body).dictionary }
        do {
            let response = try await service.vastu("scans/save", params: body)
            guard response["success"] as? Bool == true,
                  let data = response["data"] as? [String: Any],
                  data["persistence"] as? String == "account-store",
                  let scan = data["scan"] as? [String: Any],
                  scan["scanId"] as? String == options.scanId else { return .rejected }
            return .accepted
        } catch let error as VedikaApiError {
            if error.statusCode == 409 { return .conflict }
            if error.statusCode == 429 || (error.statusCode ?? 0) >= 500 || error.statusCode == nil { return .retryable }
            return .rejected
        }
    }
}
