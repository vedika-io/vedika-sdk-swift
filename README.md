# Vedika Swift SDK

Native Swift client for the [Vedika](https://vedika.io) astrology API, covering the
Vastu surface and the AR view. URLSession only — no external dependencies.

This repository is a mirror. The source of truth is `sdks/swift/` in the Vedika
monorepo; the package lives here at the repository root because SwiftPM cannot
resolve a package from a subdirectory of a larger repository.

## Install

```swift
.package(url: "https://github.com/vedika-io/vedika-sdk-swift.git", from: "1.0.2")
```

Then add `VedikaSDK` to your target's dependencies.

Platforms: iOS 15+, macOS 12+ (`URLSession.data(for:)` async needs that floor).

## Use

```swift
import VedikaSDK

let client = VedikaClient(config: VedikaConfig(apiKey: "vk_live_..."))
let audit = try await client.vastu.auditSingleRoom(roomType: "kitchen", zone: "NE")
print(audit.score ?? 0)
```

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
