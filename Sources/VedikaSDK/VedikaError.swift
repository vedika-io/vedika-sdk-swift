import Foundation

/// Base error for all Vedika API errors. Mirrors
/// `sdks/android/.../exceptions/VedikaExceptions.kt`'s `VedikaApiError` and
/// `sdks/flutter/lib/src/exceptions.dart`.
///
/// A class hierarchy (not an enum) on purpose: `catch let e as
/// VedikaApiError` matches any of the subclasses below too, the same
/// semantics as Kotlin's `Exception` hierarchy and Dart's `implements
/// Exception` chain that the other two SDKs rely on.
///
/// Only the 5 classes the Flutter SDK proved sufficient are ported here
/// (design note: "do not
/// build error-type parity beyond the 5 classes sdks/flutter already
/// defines"). Dart's 6th class, `VedikaSubscriptionError` (HTTP 403), is
/// intentionally NOT ported — a 403 falls through to the generic
/// `VedikaApiError` via `VedikaClient`'s response-status `switch` (its
/// `default` branch), same as any other unmapped 4xx status.
public class VedikaApiError: Error, CustomStringConvertible {
    /// Human-readable error message.
    public let message: String

    /// HTTP status code, if available.
    public let statusCode: Int?

    /// Raw response body, if available.
    public let body: [String: Any]?

    public init(_ message: String, statusCode: Int? = nil, body: [String: Any]? = nil) {
        self.message = message
        self.statusCode = statusCode
        self.body = body
    }

    public var description: String {
        "VedikaApiError(\(statusCode.map(String.init) ?? "nil")): \(message)"
    }
}

/// Thrown when the API key is invalid or missing (HTTP 401).
public final class VedikaAuthError: VedikaApiError {
    public init(_ message: String, body: [String: Any]? = nil) {
        super.init(message, statusCode: 401, body: body)
    }
}

/// Thrown when the wallet balance is insufficient (HTTP 402).
public final class VedikaInsufficientCredits: VedikaApiError {
    public init(_ message: String, body: [String: Any]? = nil) {
        super.init(message, statusCode: 402, body: body)
    }
}

/// Thrown when the rate limit is exceeded (HTTP 429).
public final class VedikaRateLimitError: VedikaApiError {
    /// Seconds until the rate limit resets, parsed from the `Retry-After` header.
    public let retryAfterSeconds: Int?

    public init(_ message: String, body: [String: Any]? = nil, retryAfterSeconds: Int? = nil) {
        self.retryAfterSeconds = retryAfterSeconds
        super.init(message, statusCode: 429, body: body)
    }
}

/// Thrown on server errors (HTTP 5xx).
public final class VedikaServerError: VedikaApiError {
    public override init(_ message: String, statusCode: Int? = nil, body: [String: Any]? = nil) {
        super.init(message, statusCode: statusCode, body: body)
    }
}
