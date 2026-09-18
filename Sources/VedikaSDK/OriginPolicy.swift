import Foundation
#if canImport(Network)
import Network
#endif

/// Credentials may use the official HTTPS origin or literal loopback HTTP only.
/// Validate before constructing the session; never resolve DNS to establish trust.
enum OriginPolicy {

    /// True only for genuine loopback: the literal `localhost`, the IPv6
    /// loopback `::1` (optionally bracketed, e.g. from a `[::1]:8080` host
    /// component), or a numeric IPv4 literal in `127.0.0.0/8` — decided by
    /// **address parsing only**, never DNS resolution.
    ///
    /// `Host`/`CFHost`/`getaddrinfo`-backed resolution is deliberately NOT
    /// used here: for a non-numeric hostname it would perform a real DNS
    /// lookup (a network call at client-construction time whose result
    /// varies by network/resolver), and it would wrongly treat an
    /// attacker-controlled name that merely *resolves* to 127.0.0.1 as
    /// loopback — the opposite-direction version of the exact bug this
    /// function exists to prevent. The adversarial case that must be
    /// rejected without any network lookup: `127.attacker.invalid` and
    /// `127.example.com` both start with the string `"127."`, but that's a
    /// DNS label, not an IPv4 octet — neither is loopback. `IPv4Address`/
    /// `IPv6Address` (Network.framework) are pure parsers — they fail to
    /// construct on a non-numeric string instead of resolving it.
    static func isLoopbackHost(_ host: String) -> Bool {
        var h = host.trimmingCharacters(in: .whitespaces).lowercased()
        if h.hasPrefix("["), h.hasSuffix("]"), h.count >= 2 {
            h.removeFirst()
            h.removeLast()
        }
        if h == "localhost" || h == "::1" {
            return true
        }
        if let ipv6 = IPv6Address(h) {
            return ipv6 == .loopback
        }
        if let ipv4 = IPv4Address(h) {
            // 127.0.0.0/8 — first octet fixed to the literal "127" only.
            // IPv4Address's initializer already rejects malformed octets
            // (non-numeric labels, out-of-range values, wrong label count)
            // during parsing, so a spoof DNS name like "127.attacker.invalid"
            // never reaches this point as a valid IPv4Address at all.
            return ipv4.rawValue.first == 127
        }
        return false
    }

    /// The legacy opt-in is retained for source compatibility and cannot bypass trust.
    static func assertSafeBaseURL(_ baseURL: String, allowInsecureHttp _: Bool) throws {
        guard let components = URLComponents(string: baseURL),
            let scheme = components.scheme?.lowercased(),
            let host = components.host, !host.isEmpty,
            components.user == nil, components.password == nil,
            components.path.isEmpty || components.path == "/",
            components.query == nil, components.fragment == nil,
            components.port == nil || (1...65535).contains(components.port!)
        else {
            throw VedikaConfigurationError.invalidBaseURL("")
        }
        if scheme == "https", host.lowercased() == "api.vedika.io",
            components.port == nil || components.port == 443 {
            return
        }
        if scheme == "http", isLoopbackHost(host) { return }
        if scheme != "http" && scheme != "https" {
            throw VedikaConfigurationError.unsupportedScheme("")
        }
        throw VedikaConfigurationError.insecureOrigin("")
    }
}

/// Origin policy errors never retain or print the supplied URL.
public enum VedikaConfigurationError: Error, CustomStringConvertible {
    case invalidBaseURL(String)
    case insecureOrigin(String)
    case unsupportedScheme(String)

    public var description: String {
        switch self {
        case .invalidBaseURL:
            return "baseURL must be a valid bare origin without credentials, path, query, or fragment"
        case .insecureOrigin:
            return "baseURL must use https://api.vedika.io or loopback http://; custom origins are not allowed"
        case .unsupportedScheme:
            return "baseURL must use the http or https scheme"
        }
    }
}
