import Foundation

/// Configuration for the Vedika Intelligence API client. Mirrors
/// `sdks/android/src/main/kotlin/io/vedika/sdk/VedikaConfig.kt` and
/// `sdks/flutter/lib/src/config.dart`.
public struct VedikaConfig {
    /// Default base URL for the API.
    public static let defaultBaseURL = "https://api.vedika.io"

    /// Default request timeout, in seconds.
    public static let defaultTimeout: TimeInterval = 30

    /// Your Vedika API key (format: `vk_live_*` or `vk_ent_*`).
    public let apiKey: String

    /// Base URL for the API. Defaults to `https://api.vedika.io`.
    public let baseURL: String

    /// Request timeout, in seconds. Defaults to 30.
    public let timeout: TimeInterval

    /// Legacy compatibility option. It cannot enable remote HTTP or custom origins.
    public let allowInsecureHttp: Bool

    public init(
        apiKey: String,
        baseURL: String = VedikaConfig.defaultBaseURL,
        timeout: TimeInterval = VedikaConfig.defaultTimeout,
        allowInsecureHttp: Bool = false
    ) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.timeout = timeout
        self.allowInsecureHttp = allowInsecureHttp
    }
}
