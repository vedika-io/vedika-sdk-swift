import Foundation

struct VastuArHeading {
    let degrees: Double
    let accuracy: Double
    let frame: String
}

/// Platform-free decisions shared by the iOS adapter and SwiftPM tests.
enum VastuArPolicy {
    static func secureOrigin(_ url: URL?) -> String? {
        guard let url, url.scheme == "https", let host = url.host, !host.isEmpty,
              url.user == nil, url.password == nil else { return nil }
        return "https:\(host.lowercased()):\(url.port ?? 443)"
    }

    static func trustedPage(_ url: URL?, expected: URL) -> Bool {
        guard let url else { return false }
        if expected.isFileURL { return url.isFileURL && url.standardizedFileURL == expected.standardizedFileURL }
        guard let origin = secureOrigin(url) else { return false }
        return origin == secureOrigin(expected)
    }

    static func updates(active: Bool, hasCompass: Bool, locationAuthorized: Bool) -> (heading: Bool, location: Bool) {
        (active && hasCompass, active && locationAuthorized)
    }

    // UIInterfaceOrientation reverses the landscape names relative to physical
    // orientation; its raw values already match Core Location's physical enum.
    static func headingOrientation(interfaceOrientation: Int) -> Int? {
        (1...4).contains(interfaceOrientation) ? interfaceOrientation : nil
    }

    // SDK refusal bound, not a manufacturer guarantee or device calibration.
    // Finer precision is gated separately by the shared web engine.
    private static let maximumAccuracyDegrees = 45.0

    static func sample(trueHeading: Double, magneticHeading: Double, accuracy: Double) -> VastuArHeading? {
        guard accuracy.isFinite, (0...maximumAccuracyDegrees).contains(accuracy), trueHeading.isFinite else { return nil }
        let isTrue = trueHeading >= 0
        let heading = isTrue ? trueHeading : magneticHeading
        guard heading.isFinite, (0..<360).contains(heading) else { return nil }
        return VastuArHeading(degrees: heading, accuracy: accuracy, frame: isTrue ? "true" : "magnetic")
    }
}
