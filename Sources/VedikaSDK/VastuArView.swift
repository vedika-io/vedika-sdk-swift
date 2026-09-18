// Vastu AR Compass — iOS native sensor bridge (2026-08-13).
//
// ## Why this whole file is gated `#if os(iOS)`
// This package's platform floor is BOTH `.iOS(.v15)` and `.macOS(.v12)` (see
// `Package.swift`) — every other file in this target (`VedikaClient`,
// `VastuService`, `VedikaConfig`, `OriginPolicy`) is Foundation-only and
// compiles identically on both. This file cannot be: `UIKit` doesn't exist
// on macOS, and — more fundamentally — Core Location's own headers mark
// `CLLocationManager.startUpdatingHeading()`/`stopUpdatingHeading()`
// `API_UNAVAILABLE(macos)` (verified directly against the installed iOS SDK
// headers, `CoreLocation.framework/Headers/CLLocationManager.h`, this pass —
// there is no compass API on macOS to call in the first place, independent
// of UIKit). `swift build` run on a Mac (no `-sdk`/`--destination` override)
// targets macOS by default, so without this guard adding this file would
// break the WHOLE package's plain `swift build`, not just fail to be useful
// there. Verified both ways this pass: `swift build` (macOS target) stays
// green with this file gated out; `xcrun -sdk iphoneos swiftc -typecheck
// -target arm64-apple-ios15.0` on this file alone typechecks its real iOS
// content.
#if os(iOS)

import Foundation
import UIKit
import WebKit
import CoreLocation
import CryptoKit

/// Vastu AR Compass — hosts the bundled shared AR engine in a `WKWebView`
/// and drives its heading from
/// `CLLocationManager`'s own compass (`CLHeading.trueHeading`) instead of
/// the web page's own `DeviceOrientationEvent` path — the whole point of
/// this bridge (see the task this shipped under: "iOS web DeviceOrientation
/// is unreliable").
///
/// ## `trueHeading` is THE clean iOS path
/// Unlike Android (which must compute true heading itself via
/// `GeomagneticField` — see `VastuArView.kt`'s own header), iOS's
/// `CLHeading.trueHeading` is ALREADY true-north-corrected by Core
/// Location internally, using the device's live location fix — no manual
/// declination math needed on this platform at all. This is the single
/// biggest reason a native bridge is worth shipping for iOS specifically:
/// Safari/WKWebView's `DeviceOrientationEvent.webkitCompassHeading` (the web
/// path `heading-provider.js` otherwise uses) is MAGNETIC only and has no
/// declination correction of its own — see that module's header for how it
/// handles that gap today (never promotes the frame to `'true'` from
/// `webkitCompassHeading` alone). Routing through `CLLocationManager`
/// instead skips that gap entirely.
///
/// ## Zero Vastu content, zero heading math beyond what's documented above
/// (Rule 22 n/a — bearing plumbing only). All zone/compute/rendering stays
/// in the shared web engine (`ar-overlay.js` + `heading-provider.js`) loaded
/// inside `webView`; this class never reads or interprets a heading beyond
/// forwarding it.
///
/// ## The native -> web contract (see `js/vastu/native-bridge.js`)
/// 1. A `WKUserScript` injected at `.atDocumentStart` (below, in `init`)
///    sets `window.__VEDIKA_NATIVE__ = true` before the page's own module
///    scripts run — `.atDocumentStart` is WebKit's own hook for exactly
///    this ordering guarantee (fires after the document object exists, but
///    strictly before any of the page's own `<script>` content executes).
/// 2. On every accepted heading update, this class calls exactly:
///    `window.__vedikaNativeFusion.push(headingDeg, accuracyDeg, frame, {accuracyKind:"degrees"})`
///    via `webView.evaluateJavaScript(...)` — matching
///    `heading-provider.js`'s native-fusion contract exactly (see that
///    module's "`sample.frame` — frame-aware labeling" header). `frame` is
///    honest per-sample (2026-08-13 fix — see FIX 1 below), never a blanket
///    "this class always resolves true heading" claim:
///      - `"true"` — `newHeading.trueHeading >= 0`: Core Location itself
///        resolved true north for THIS sample (the clean path described
///        above). Same behavior as before this fix.
///      - `"magnetic"` — `newHeading.trueHeading < 0`: Core Location could
///        NOT resolve true north for this sample (needs a location fix —
///        see `didUpdateHeading` below). The PRE-FIX version of this class
///        pushed `magneticHeading` in this case with NO frame parameter at
///        all, which `heading-provider.js`'s pre-fix native branch then
///        labeled `referenceFrame = 'true'` unconditionally — a real false
///        true-north claim. Fixed: this fallback now pushes
///        `magneticHeading` labeled `"magnetic"`, and the web engine only
///        promotes it to `'true'` if it separately has a real resolved
///        declination to apply.
///
/// ## Required Info.plist keys (of the HOST APP, not this SDK target)
/// ```xml
/// <key>NSCameraUsageDescription</key>
/// <string>Used to show a live camera view behind the Vastu compass overlay.</string>
/// <key>NSLocationWhenInUseUsageDescription</key>
/// <string>Used to resolve true north for the compass and for Vastu declination/sun-calibration accuracy.</string>
/// ```
/// The bundled file runtime supports heading and manual entry; camera is denied
/// for its opaque file origin. A custom HTTPS page can request camera access.
/// Camera access itself works inside `WKWebView` (`getUserMedia`) on iOS
/// 14.3+ without any extra Info.plist entitlement beyond
/// `NSCameraUsageDescription` — verified against the WebKit
/// `WKUIDelegate.h` header this pass: `requestMediaCapturePermissionFor`
/// (implemented below) is the iOS 15+ delegate hook that lets THIS class
/// decide the WebView-level grant; the underlying OS permission prompt
/// (driven by `NSCameraUsageDescription`'s string) is presented by the
/// system the first time it's needed, same as any other camera-using code
/// path — this class does not (and cannot) skip that system prompt.
///
/// ## Location and orientation
/// Heading updates run independently of location authorization. A denied
/// location request retains magnetic compass samples; only location updates
/// and true-north resolution depend on location permission.
/// The window scene's interface orientation selects Core Location's public
/// `headingOrientation`, so the heading follows the displayed top edge in
/// portrait and landscape. Pure policy tests cover mapping and state changes;
/// the device checklist still owns physical sensor acceptance.
///
/// ## Usage (from the host app)
/// ```swift
/// let vastuAr = VastuArView()
/// present(vastuAr, animated: true) // or push/embed as a child view controller
/// // start()/stop() are called automatically from viewWillAppear/viewWillDisappear;
/// // call them directly too if embedding without the VC lifecycle (e.g. a
/// // raw UIView-only host driving vastuAr.webView itself).
/// ```
public final class VastuArView: UIViewController {

    /// Optional remote page. The initializer defaults to bundled offline resources.
    public static let defaultArURL = URL(string: "https://vedika.io/vastu-ar/")!

    /// The hosted WebView. Exposed for a host that wants to embed just the
    /// view (not this whole `UIViewController`) — `loadView()` below also
    /// uses this same instance as `self.view`.
    public let webView: WKWebView

    private let arURL: URL
    private let locationManager = CLLocationManager()
    private var showingLoadFailure = false

    /// Guards against double-registering the location/heading listeners if
    /// both the automatic VC-lifecycle hooks and a host's own explicit
    /// `start()` call fire (e.g. a host that both presents this VC AND
    /// calls `start()` itself defensively) — same guard shape as
    /// `VastuArView.kt`'s `started` flag on the Android side.
    private var headingActive = false

    /// Fires `pushError` exactly once per authorization-gap episode, not on
    /// every single heading sample while `trueHeading` stays unresolved —
    /// same "report once" shape as `VastuArView.kt`'s
    /// `reportedNoLocationOnce`, to avoid flooding the JS bridge.
    private var reportedTrueHeadingGapOnce = false

    /// Called when a custom page fails to load. The default runtime is bundled.
    public var onLoadFailed: (() -> Void)?

    /// b2c#23 / ar#20: rendered in place of the AR page on a main-frame
    /// navigation failure (see the `WKNavigationDelegate` extension below) so
    /// a cold offline start shows an honest, first-party message instead of
    /// the platform's own blank/default error page. Deliberately plain
    /// (system font, no external CSS/JS/image fetch) — anything it loaded
    /// over the network would fail for the exact same reason the AR page
    /// did.
    private static let offlineFallbackHTML = """
        <html><head><meta name="viewport" content="width=device-width, initial-scale=1">
        <style>body{font-family:-apple-system,sans-serif;text-align:center;padding:32px;color:#333}</style>
        </head><body>
        <h3>Vastu AR is unavailable offline</h3>
        <p>This view needs a network connection to load. Reconnect and reopen this screen to try again.</p>
        </body></html>
        """

    public init(arURL: URL? = nil) {
        let target = arURL ?? Bundle.module.url(forResource: "index", withExtension: "html", subdirectory: "VastuRuntime")!
        precondition(arURL == nil || VastuArPolicy.secureOrigin(target) != nil, "AR URL must use HTTPS without user information")
        self.arURL = target

        let flagScript = WKUserScript(
            source: Self.guardedScript("window.__VEDIKA_NATIVE__ = true;", target: target),
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        let contentController = WKUserContentController()
        contentController.addUserScript(flagScript)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        // Camera preview inside the page must play inline, not force
        // fullscreen takeover, and must start without a SECOND native-side
        // tap gesture (the page's own "Start AR" button is the one real
        // user gesture already required).
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []

        self.webView = WKWebView(frame: .zero, configuration: configuration)

        super.init(nibName: nil, bundle: nil)

        webView.uiDelegate = self
        webView.navigationDelegate = self
        locationManager.delegate = self
    }

    @available(*, unavailable, message: "VastuArView does not support storyboard/XIB instantiation -- use init(arURL:).")
    public required init?(coder: NSCoder) {
        fatalError("VastuArView does not support storyboard/XIB instantiation -- use init(arURL:).")
    }

    public override func loadView() {
        view = webView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        if arURL.isFileURL {
            verifyRuntime()
            webView.loadFileURL(arURL, allowingReadAccessTo: arURL.deletingLastPathComponent())
        } else { webView.load(URLRequest(url: arURL)) }
    }

    private func verifyRuntime() {
        let directory = arURL.deletingLastPathComponent()
        guard let data = try? Data(contentsOf: directory.appendingPathComponent("manifest.json")),
              let manifest = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              manifest["formatVersion"] as? Int == 1,
              let files = manifest["files"] as? [String: String],
              Set(files.keys) == Set(["index.html", "runtime.js", "hud-mandala.png"]) else {
            preconditionFailure("Missing or invalid bundled Vastu runtime manifest")
        }
        for (name, digest) in files {
            guard let bytes = try? Data(contentsOf: directory.appendingPathComponent(name)),
                  SHA256.hash(data: bytes).map({ String(format: "%02x", $0) }).joined() == digest else {
                preconditionFailure("Missing or corrupt bundled Vastu runtime resource")
            }
        }
    }

    private static func guardedScript(_ script: String, target: URL) -> String {
        let value = target.isFileURL ? target.absoluteString : "https://\(target.host!)" + ((target.port == nil || target.port == 443) ? "" : ":\(target.port!)")
        let encoded = String(data: try! JSONSerialization.data(withJSONObject: [value]), encoding: .utf8)!
        let property = target.isFileURL ? "location.href.split('#')[0]" : "location.origin"
        return "if (window.top === window && \(property) === \(encoded)[0]) { \(script) }"
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeadingOrientation()
    }

    private func updateHeadingOrientation() {
        guard let interface = webView.window?.windowScene?.interfaceOrientation,
              let raw = VastuArPolicy.headingOrientation(interfaceOrientation: interface.rawValue),
              let orientation = CLDeviceOrientation(rawValue: Int32(raw)) else { return }
        locationManager.headingOrientation = orientation
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        start()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        stop()
        super.viewWillDisappear(animated)
    }

    /// Begins location/heading updates. Idempotent (see `headingActive`).
    /// Safe to call before authorization is resolved -- `requestWhenInUseAuthorization()`
    /// is itself a no-op once the user has already decided, and
    /// `locationManagerDidChangeAuthorization` picks up an eventual grant.
    public func start() {
        guard !headingActive else { return }
        guard CLLocationManager.headingAvailable() else {
            pushError("CLLocationManager.headingAvailable() is false on this device -- no compass hardware. Use manual North entry.")
            return
        }
        headingActive = true
        updateHeadingOrientation()
        updateSensorSubscriptions()
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    private func updateSensorSubscriptions() {
        let status = locationManager.authorizationStatus
        let updates = VastuArPolicy.updates(
            active: headingActive,
            hasCompass: CLLocationManager.headingAvailable(),
            locationAuthorized: status == .authorizedWhenInUse || status == .authorizedAlways
        )
        if updates.heading { locationManager.startUpdatingHeading() }
        else { locationManager.stopUpdatingHeading() }
        if updates.location { locationManager.startUpdatingLocation() }
        else { locationManager.stopUpdatingLocation() }
    }

    /// Stops location/heading updates. Idempotent.
    public func stop() {
        guard headingActive else { return }
        headingActive = false
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }

    // MARK: - WebView bridge calls

    /// `window.__vedikaNativeFusion` may not exist yet on the very first
    /// callback if Core Location fires before the page's own module scripts
    /// finished evaluating -- guarded on the JS side (see the
    /// `if (window.__vedikaNativeFusion)` check) so an early call is a
    /// harmless no-op, never a thrown `ReferenceError`. `frame` MUST be
    /// `"true"` or `"magnetic"` (2026-08-13 fix) -- see class doc "native ->
    /// web contract"; this class only ever passes one of those two literals
    /// (see `didUpdateHeading`), never a third value. `accuracyDeg` is
    /// a Core Location degree estimate. Quality metadata keeps it distinct
    /// from Android's sensor classes in the shared web engine.
    private func pushSample(headingDeg: Double, accuracyDeg: Double, frame: String) {
        let js = "if (window.__vedikaNativeFusion) { window.__vedikaNativeFusion.push(\(headingDeg), \(accuracyDeg), \"\(frame)\", {accuracyKind:\"degrees\"}); }"
        guard VastuArPolicy.trustedPage(webView.url, expected: arURL) else { return }
        webView.evaluateJavaScript(Self.guardedScript(js, target: arURL), completionHandler: nil)
    }

    private func pushError(_ message: String) {
        let escaped = message
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        let js = "if (window.__vedikaNativeFusion) { window.__vedikaNativeFusion.pushError(\"\(escaped)\"); }"
        guard VastuArPolicy.trustedPage(webView.url, expected: arURL) else { return }
        webView.evaluateJavaScript(Self.guardedScript(js, target: arURL), completionHandler: nil)
    }
}

// MARK: - CLLocationManagerDelegate

extension VastuArView: CLLocationManagerDelegate {

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateSensorSubscriptions()
        if headingActive && (manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted) {
            pushError("Location access is disabled. Compass readings use magnetic north when available.")
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard headingActive else { return }
        guard let sample = VastuArPolicy.sample(
            trueHeading: newHeading.trueHeading,
            magneticHeading: newHeading.magneticHeading,
            accuracy: newHeading.headingAccuracy
        ) else {
            pushError("Compass reading is invalid or too uncertain. Hold steady and calibrate the device.")
            return
        }
        if sample.frame == "true" {
            reportedTrueHeadingGapOnce = false
        } else if !reportedTrueHeadingGapOnce {
            reportedTrueHeadingGapOnce = true
            pushError("True north is unavailable. Showing magnetic north until a location fix resolves it.")
        }
        pushSample(headingDeg: sample.degrees, accuracyDeg: sample.accuracy, frame: sample.frame)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        pushError("CLLocationManager error: \(error.localizedDescription)")
    }
}

// MARK: - WKNavigationDelegate

extension VastuArView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let isFallback = showingLoadFailure && navigationAction.request.url?.absoluteString == "about:blank"
        let trusted = navigationAction.targetFrame?.isMainFrame == true &&
            (isFallback || VastuArPolicy.trustedPage(navigationAction.request.url, expected: arURL))
        decisionHandler(trusted ? .allow : .cancel)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(navigationResponse.isForMainFrame && VastuArPolicy.trustedPage(navigationResponse.response.url, expected: arURL) ? .allow : .cancel)
    }


    /// Offline/navigation-failure fix (b2c#23 / ar#20). Covers a failure
    /// that happens BEFORE any content committed (typical of "no network at
    /// all" -- DNS/connection-refused/offline) -- `didFail` (below) covers a
    /// failure AFTER a response started arriving.
    public func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        if (error as NSError).code != NSURLErrorCancelled { handleMainFrameLoadFailure(webView) }
    }

    /// Covers a main-frame failure that happens after navigation committed
    /// (e.g. the connection drops mid-load).
    public func webView(
        _ webView: WKWebView,
        didFail navigation: WKNavigation!,
        withError error: Error
    ) {
        if (error as NSError).code != NSURLErrorCancelled { handleMainFrameLoadFailure(webView) }
    }

    private func handleMainFrameLoadFailure(_ webView: WKWebView) {
        guard !showingLoadFailure else { return }
        showingLoadFailure = true
        onLoadFailed?()
        webView.loadHTMLString(Self.offlineFallbackHTML, baseURL: nil)
    }
}

// MARK: - WKUIDelegate

extension VastuArView: WKUIDelegate {

    /// Origin-checked camera grant -- ONLY `.camera` requests (never
    /// `.microphone`/`.cameraAndMicrophone`; the page never requests audio)
    /// from the configured AR host are granted. Mirrors
    /// `VastuArView.kt`'s `onPermissionRequest` origin check exactly, same
    /// R-004-era credential-routing discipline this repo already applies to
    /// the SDK's own HTTP client (`RedirectRefusingDelegate.swift`) --
    /// applied here to a WebView permission grant instead of a redirect.
    ///
    /// If this delegate method is never implemented, WebKit's own default
    /// is `WKPermissionDecisionPrompt` (per the `WKUIDelegate.h` header) --
    /// implementing it and explicitly denying the non-`.camera` cases is a
    /// deliberate tightening, not merely filling in an unimplemented gap.
    @available(iOS 15.0, *)
    public func webView(
        _ webView: WKWebView,
        requestMediaCapturePermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo,
        type: WKMediaCaptureType,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
        let originURL = URL(string: "\(origin.protocol)://\(origin.host):\(origin.port == 0 ? 443 : origin.port)")
        let originIsExpected = !arURL.isFileURL && VastuArPolicy.trustedPage(originURL, expected: arURL)
        if originIsExpected, frame.isMainFrame, VastuArPolicy.trustedPage(webView.url, expected: arURL), type == .camera {
            decisionHandler(.grant)
        } else {
            decisionHandler(.deny)
        }
    }
}

#endif
