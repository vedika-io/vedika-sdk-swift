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
        try await service.vastuOperation(
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
}
