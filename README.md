# Vedika Swift SDK

Native Swift client for the [Vedika](https://vedika.io) astrology API, covering the
Vastu surface and the AR view. URLSession only — no external dependencies.

This repository is a mirror. The source of truth is `sdks/swift/` in the Vedika
monorepo; the package lives here at the repository root because SwiftPM cannot
resolve a package from a subdirectory of a larger repository.

## Install

Version 1.4.0 is a release candidate; its tag and release are pending. For candidate testing, replace the version requirement below with `branch: "ci/1.4.0-candidate"`.

```swift
.package(url: "https://github.com/vedika-io/vedika-sdk-swift.git", from: "1.4.0")
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

let client = try VedikaClient(apiKey: "vk_live_...")
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

## Pin zones to the floor (1.3.2)

`VedikaRoomCapture` adds `PinnedFloorOverlayRenderer`, which draws the returned
Vastu zone boundaries on the floor of a live AR session. Freeze a
`FloorPlanAnchorTransform` from the capture's `frame.planToWorld` (it already
holds the one north correction) and the original floor anchor's
`FloorAnchorPose`. Build `FloorOverlayPolygon` values from the zone boundaries
the API returned. Then create the renderer on the main actor with the same
session, the saved floor anchor ID and the map reference. Mount its `view` and
keep the renderer alive.

Each frame, the renderer moves the frozen geometry by the current floor anchor
pose. It hides the overlay when frames are stale or duplicated, the anchor or
landmarks are missing, the pose is invalid, tracking is lost or the map
disagrees. It shows again only after three matching frames of current physical
landmarks. Saved screen pixels are not observations. iOS only. Real-phone
accuracy is not yet measured.

## Save scans and pin remedies (1.4.0)

The existing typed `VastuScansSaveRequest`, `VastuScanResponse<VastuScansSaveData>`
and `RoomCaptureUploader.saveCapture` follow the account-save contract. A save
uses a retained `scanId` and identical content as its retry identity. The API
rejects `Idempotency-Key` headers on scan routes. Account saves are billed;
`data.persistence == "account-store"` confirms storage. `"preview-only"` is a
synthetic sandbox response and stores nothing.

Opt into saving an offline capture when enqueueing it:

```swift
let save = try CaptureSaveOptions(
    scanId: retainedScanId, propertyId: propertyId,
    title: "Living room", retentionDays: 7)
let body = try JSONSerialization.data(
    withJSONObject: VastuArRoomCaptureRequest(capture: capture).dictionary)
try await outbox.enqueue(body: body, idempotencyKey: retainedUploadKey,
                         saveAfterUpload: save)
try await CaptureUploadAdapter.flush(outbox, service: client.vastu,
                                    isOnline: { connectivityAvailable })
```

The encrypted queue freezes the save settings with the upload body. It checkpoints
upload success before saving; a save failure, cancellation or app restart retries
only the save with the same `scanId`. A conflict stays failed. Editing the capture
or save settings requires a new queue identity and a new scan ID. Never reuse a
scan ID for another capture, including after storage expires. `synced` means both operations
succeeded for an opted-in entry. Keep one owner per outbox file.


New outbox snapshots use an authenticated version-two format. Version 1.4.0 reads
older version-one queues; older SDKs refuse newer files. Keep queue files and keys
when upgrading. Finish a new queue before downgrading the app, or reopen it with
version 1.4.0 or later.

For registered apps, pass separate `prepareProof` and `prepareSaveProof` callbacks
to `CaptureUploadAdapter.flush`. Bind their unchanged bodies through
`NativeAttestation.digest` or `AppAttestCaptureProof.proof` using operation
`"ar/room-capture"` and `"scans/save"`, respectively. Fetch a fresh challenge for
each operation/attempt. Short-lived proofs are excluded from the durable file.
`CaptureSaveOptions.request(capture:)` also builds the existing typed save request.

To place returned remedies, build `RemedyFloorOverlay(capture:response:catalog:)`
from the original capture and its upload response. The adapter uses `rooms`,
`audit.defects`, `planAnalysis.defects`, `anchorRecommendations.anchors` and
optional remedy catalogs, matching the public floor scene. It preserves full
advice and its separate remedy source in `placements`; a missing remedy source
is explicitly reported. It creates no new advice or north correction. Concave
room markers remain inside the scanned polygon. Voids and multiple levels require
separate supported floor geometry.

On iOS 16+, pass `remedies:` to `PinnedFloorOverlayRenderer` with the existing
`FloorPlanAnchorTransform`, original `FloorAnchorPose`, saved floor anchor ID,
map reference, session ID and north revision. Optional zone polygons share that
same renderer. The renderer's per-frame relocalization, stale-frame and tracking
loss gates hide both zones and remedies when uncertain. Display full advice and
`sourceLabel` from `placements` alongside the numbered floor markers.
Geometry tests run on macOS; the ARKit renderer runs only on iOS.
Real-phone accuracy is not yet measured.

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
