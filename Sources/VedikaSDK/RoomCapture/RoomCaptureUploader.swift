import Foundation

/// Posts a `VastuRoomCapture` (built by `RoomCaptureGeometry`,
/// `RoomCaptureModel`, `RoomPlanCaptureController` or
/// `ARKitCornerCaptureController`) to `POST /v2/astrology/vastu/ar/room-capture`
/// through the SDK's existing client/auth path — the same
/// `VastuOperation`/`VastuContract`/`VedikaClient` machinery
/// `VastuService.swift` already generates for every other Vastu operation
/// (`VastuContracts.arRoomCapture`, `VastuArRoomCaptureRequest`,
/// `VastuArRoomCaptureData`). This type adds no new networking, no new auth,
/// and — like the rest of this SDK — never embeds or reads an API key
/// itself; `VedikaClient`/`VedikaConfig` own that.
///
/// This file is plain Foundation, no platform import: it works on both
/// macOS and iOS, and is exercised in `swift test` directly (see
/// `CredentialRoutingTests.swift`'s loopback-server pattern), unlike the
/// RoomPlan/ARKit capture controllers, which are iOS-only and device-only.
///
/// Vedika-Task: R-004
public struct RoomCaptureUploader {
    private let service: VastuService

    public init(service: VastuService) {
        self.service = service
    }

    /// Uploads a capture built from a `RoomCaptureSession`. `zoneResolution`
    /// mirrors `plan/analyze`'s own parameter (design doc §6, "How it maps
    /// onto the existing requests"); `deviceAttestation` is optional and
    /// only meaningful when the caller has already completed
    /// `ar/attestation/challenge`.
    public func upload(
        _ capture: VastuRoomCapture, zoneResolution: Int? = nil, deviceAttestation: VastuDeviceAttestation? = nil,
        idempotencyKey: String? = nil
    ) async throws -> VastuTypedResponse<VastuArRoomCaptureData> {
        // The server refuses a capture with no labelled room before any charge.
        // Say so here, with the way out, instead of after a round trip.
        guard capture.quality.roomsTagged > 0 else {
            throw RoomCaptureError(
                "Tag at least one room before uploading: name it with RoomCaptureSession.confirmed(label:outline:)")
        }
        return try await service.vastuOperation(
            VastuContracts.arRoomCapture,
            request: VastuArRoomCaptureRequest(capture: capture, zoneResolution: zoneResolution, deviceAttestation: deviceAttestation),
            idempotencyKey: idempotencyKey
        )
    }

    /// Builds from a `RoomCaptureSession` and uploads in one call.
    public func upload(
        session: RoomCaptureSession, zoneResolution: Int? = nil, deviceAttestation: VastuDeviceAttestation? = nil,
        idempotencyKey: String? = nil
    ) async throws -> VastuTypedResponse<VastuArRoomCaptureData> {
        let capture = try RoomCaptureGeometry.buildRoomCapture(session)
        return try await upload(capture, zoneResolution: zoneResolution, deviceAttestation: deviceAttestation, idempotencyKey: idempotencyKey)
    }

    /// Keeps a finished capture in the customer's account through
    /// `POST /v2/astrology/vastu/scans/save` (`snapshot.capture`). Only the
    /// capture JSON is stored; no mesh or camera image is ever uploaded.
    ///
    /// This call is billed (USD 0.005 per save) and needs account scan
    /// storage enabled on the deployment; otherwise the API answers
    /// `503 SCAN_STORAGE_DISABLED` before any charge.
    ///
    /// The caller supplies and retains `scanId` (16-128 characters of
    /// `A-Za-z0-9_-`, for example a UUID string). It is the retry identity:
    /// after a timeout or a `503`, call again with the SAME `scanId` and the
    /// SAME content so the save completes without a second charge. A changed
    /// body for a used `scanId` returns `409`. Scan routes take no
    /// `Idempotency-Key` (the API answers 422 to one), so this method has none.
    ///
    /// `retentionDays` is 1-30. `propertyId` groups the scans of one property
    /// and follows the same pattern as `scanId`. Check `data.persistence`:
    /// `account-store` means the scan was kept; `preview-only` (keyless
    /// sandbox) means nothing was stored.
    public func saveCapture(
        _ capture: VastuRoomCapture, scanId: String, propertyId: String, title: String, retentionDays: Int,
        deviceAttestation: VastuDeviceAttestation? = nil
    ) async throws -> VastuScanResponse<VastuScansSaveData> {
        guard Self.isValidScanIdentifier(scanId) else {
            throw VedikaApiError("scanId must be 16-128 characters of A-Z a-z 0-9 _ -")
        }
        guard Self.isValidScanIdentifier(propertyId) else {
            throw VedikaApiError("propertyId must be 16-128 characters of A-Z a-z 0-9 _ -")
        }
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, title.utf8.count <= 160 else {
            throw VedikaApiError("title must be nonblank and at most 160 UTF-8 bytes")
        }
        guard (1...30).contains(retentionDays) else {
            throw VedikaApiError("retentionDays must be 1-30")
        }
        return try await service.vastuScansSave(
            VastuScansSaveRequest(
                scanId: scanId, propertyId: propertyId, title: title, retentionDays: retentionDays,
                snapshot: VastuScanSnapshot(inputSource: "device-reported", capture: capture),
                deviceAttestation: deviceAttestation
            )
        )
    }

    private static func isValidScanIdentifier(_ value: String) -> Bool {
        guard (16...128).contains(value.utf8.count) else { return false }
        return value.utf8.allSatisfy { byte in
            (48...57).contains(byte) || (65...90).contains(byte) || (97...122).contains(byte) || byte == 95 || byte == 45
        }
    }
}
