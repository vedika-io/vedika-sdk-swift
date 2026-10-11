# Vedika Swift SDK

Native Swift client for the [Vedika](https://vedika.io) astrology API, covering the
Vastu surface and the AR view. URLSession only — no external dependencies.

This repository is a mirror. The source of truth is `sdks/swift/` in the Vedika
monorepo; the package lives here at the repository root because SwiftPM cannot
resolve a package from a subdirectory of a larger repository.

## Install

```swift
.package(url: "https://github.com/vedika-io/vedika-sdk-swift.git", from: "1.3.1")
```

Then add `VedikaSDK` to your target's dependencies. For the coached RoomPlan
screen, encrypted offline capture queue and overlay relocalization gate, also add
`.product(name: "VedikaRoomCapture", package: "vedika-sdk-swift")` and
`import VedikaRoomCapture`.

`RoomCaptureScanView` and `RoomCaptureScanModel` require iOS 16+ and RoomPlan.
`CaptureOutbox`, `CaptureKeychain`, `CaptureSyncState`, `QueuedCapture`,
`CaptureUploadAdapter`, `OverlayRelocalizationGate`, `CaptureLocalMetadata` and
`LocalWorldMapReference` are in `VedikaRoomCapture`. `LocalWorldMapStore`,
`LocalWorldMapStore.evaluate` and `RelocalizedOverlay` are iOS-only.
`NativeAttestation`, `NativeAttestationChallenge` and `AttestationCanonicalJSON`
provide challenge/body binding; `AppAttestCaptureProof` requires iOS DeviceCheck.
Physical scanning, compass accuracy and map restoration still require device
acceptance. Synthetic replay does not prove physical accuracy.

Platforms: iOS 15+, macOS 12+ (`URLSession.data(for:)` async needs that floor).

## Use

```swift
import VedikaSDK

let client = VedikaClient(config: VedikaConfig(apiKey: "vk_live_..."))
let audit = try await client.vastu.auditSingleRoom(roomType: "kitchen", zone: "NE")
print(audit.score ?? 0)
```

## iPhone room scanner (1.1.0)

`VedikaSDK` now includes a native room scanner for iOS. It captures a room with
RoomPlan on LiDAR iPhones and falls back to ARKit plane raycasts (corners tapped by
hand) elsewhere, then uploads a `vedika.roomCapture/1` through the existing Vastu
client. `RoomCaptureAvailability.currentPath()` tells you which path a device can run.
The geometry core is plain Swift and is tested on macOS. The RoomPlan and ARKit parts
are iOS-only and need a physical device with LiDAR for the RoomPlan path.

Add `NSCameraUsageDescription` (and `NSLocationWhenInUseUsageDescription` for the true
heading sample) to your app's Info.plist.

## Ask about a report PDF (1.3.0)

```swift
let upload = try await client.vastu.uploadVastuReport(pdfData, idempotencyKey: savedKey)
let answer = try await client.vastu.askVastuReport(
    "Is my kitchen placement good?",
    reportRef: VastuReportRef(id: upload["uploadId"] as! String))
```

Keep `savedKey` and reuse it on a retry: the upload is billed once per key.
Follow-ups pass `conversationId` from the first answer.

## Keys

**Never ship a key inside an app you distribute.** Anything in a shipped binary or a
web page is readable by anyone who has it, and calls are billed to that key's account.
Route requests through a server you control and keep the key there.

The client refuses to help you do otherwise: the base URL must be HTTPS or a real
loopback address, and it does not follow cross-origin redirects with credentials
attached.

## Tests

```sh
swift test
```

The suite runs against frozen responses captured from the API, plus a bundled
dependency-free loopback HTTP server, so it needs no network access and no API key.

## License

MIT — see `LICENSE`.
