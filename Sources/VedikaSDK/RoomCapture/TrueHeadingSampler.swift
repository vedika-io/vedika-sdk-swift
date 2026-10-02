// True-north sampling for the RoomPlan/ARKit capture path, gated `#if
// os(iOS)` exactly like `VastuArView.swift`'s Core Location bridge (see that
// file's header for why: `CLLocationManager.startUpdatingHeading()` is
// `API_UNAVAILABLE(macos)`, so this file would break a plain `swift build`
// on macOS without the guard).
//
// Design doc §2 ("One coordinate pipeline for every platform") and §3
// ("iOS... Heading: the heading samples need camera poses"): collect at
// least `RoomCaptureModel.minNorthSamples` samples over at least
// `RoomCaptureModel.minNorthMs`, each pairing `CLHeading.trueHeading` with
// the AR camera's forward vector at that instant. `trueHeading` is only
// used when it is `>= 0` (Core Location's documented sentinel for "no true
// heading available", e.g. no location fix yet) — a hard rule in this
// lane: a magnetic reading is never relabeled as true. When `trueHeading`
// is unavailable, samples are still collected from `magneticHeading` so a
// capture can still be built, just honestly marked `headingFrame:
// "magnetic"` (see `RoomCaptureGeometry.northRotation`, which then reports
// `frame.north.referenceFrame: "magnetic"` regardless of what the caller
// passed in, exactly like `sdks/fixtures/vastu-room-capture/magnetic-frame.json`).
//
// UNVERIFIED ON A DEVICE: the iOS Simulator has no compass, so this file's
// actual sampling behaviour (as opposed to its compile-time shape) has not
// run. `sdks/ios-acceptance`'s 2026-09-23 lab notes (see that module's
// README) found the *existing* `VastuArView.swift` compass path needed two
// fixes for exactly this kind of gap (heading-filter-off + report-once);
// the same class of defect is plausible here and would only surface on a
// real device.
#if os(iOS)
import CoreLocation
import Foundation

@available(iOS 14.0, *)
public protocol TrueHeadingSamplerDelegate: AnyObject {
    /// One heading sample, ready to hand to a capture controller's
    /// `addHeadingSample`/`addNorthSample`. `isTrue` is `false` whenever
    /// `CLHeading.trueHeading < 0` — see the header above.
    func trueHeadingSampler(_ sampler: TrueHeadingSampler, didSample headingDeg: Double, isTrue: Bool)
    func trueHeadingSampler(_ sampler: TrueHeadingSampler, didFailWith error: Error)
}

/// Wraps `CLLocationManager`'s heading updates: starts them, filters out
/// samples with `headingAccuracy < 0` (uncalibrated, per
/// `VastuArView.swift`'s own precedent), and reports each one plus whether
/// it is true north or only magnetic.
@available(iOS 14.0, *)
@MainActor
public final class TrueHeadingSampler: NSObject {

    public weak var delegate: TrueHeadingSamplerDelegate?

    private let manager: CLLocationManager
    private(set) public var lastDeclinationDeg: Double?

    public override init() {
        self.manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }

    public static var headingAvailable: Bool { CLLocationManager.headingAvailable() }

    /// Requests when-in-use location (needed for `trueHeading`) if not
    /// already authorized, then starts heading updates. A caller with no
    /// location grant still gets magnetic-only samples.
    public func start() {
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingHeading()
    }

    public func stop() {
        manager.stopUpdatingHeading()
    }
}

@available(iOS 14.0, *)
// `@preconcurrency`: same unmarked-ObjC-protocol/`@MainActor`-class pattern
// as `ARKitCornerCaptureController`'s `ARSessionDelegate` conformance.
extension TrueHeadingSampler: @preconcurrency CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else { return } // uncalibrated; see VastuArView.swift's own filter
        if newHeading.trueHeading >= 0 {
            lastDeclinationDeg = RoomCaptureGeometry.circularDiff(newHeading.magneticHeading, newHeading.trueHeading)
            delegate?.trueHeadingSampler(self, didSample: newHeading.trueHeading, isTrue: true)
        } else {
            delegate?.trueHeadingSampler(self, didSample: newHeading.magneticHeading, isTrue: false)
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.trueHeadingSampler(self, didFailWith: error)
    }
}
#endif
