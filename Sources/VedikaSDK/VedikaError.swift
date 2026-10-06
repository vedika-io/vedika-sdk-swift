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

    /// Machine-readable error `code` from the response body, for example
    /// `INSUFFICIENT_BALANCE` or `DAILY_LIMIT_EXCEEDED`, when the API sent one.
    public var code: String? { body?["code"] as? String }

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
///
/// A 402 is never retried: the call was refused before any charge. Add funds
/// (see `purchaseUrl`) and call again.
public final class VedikaInsufficientCredits: VedikaApiError {
    public init(_ message: String, body: [String: Any]? = nil) {
        super.init(message, statusCode: 402, body: body)
    }

    private func walletValue(_ key: String) -> Double? {
        let raw = (body?["wallet"] as? [String: Any])?[key] ?? body?[key]
        if let number = raw as? NSNumber { return number.doubleValue }
        if let text = raw as? String { return Double(text) }
        return nil
    }

    /// Amount this call needed, in USD (`wallet.required`).
    public var required: Double? { walletValue("required") }

    /// Wallet balance at the time of the call, in USD (`wallet.available`).
    public var available: Double? { walletValue("available") }

    /// How much more is needed, in USD (`wallet.deficit`).
    public var deficit: Double? { walletValue("deficit") }

    /// Where to add funds, when the API sent one.
    public var purchaseUrl: String? { body?["purchaseUrl"] as? String }
}

/// Thrown when a request is refused with HTTP 429.
///
/// A 429 has several causes, so decide from `code`, never from the rate-limit
/// response headers: they describe the per-minute limiter, which may not be
/// the one that refused the call.
public final class VedikaRateLimitError: VedikaApiError {
    /// Seconds to wait, from the body's `retryAfter`, falling back to the
    /// `Retry-After` header. Only meaningful when `isRetryable` is true.
    public let retryAfterSeconds: Int?

    public init(_ message: String, body: [String: Any]? = nil, retryAfterSeconds: Int? = nil) {
        self.retryAfterSeconds = retryAfterSeconds
        super.init(message, statusCode: 429, body: body)
    }

    /// True for `DAILY_LIMIT_EXCEEDED`: the daily allowance is spent and a
    /// retry will keep failing until it resets or the plan is upgraded.
    public var isDailyLimit: Bool { code == "DAILY_LIMIT_EXCEEDED" }

    /// True when waiting `retryAfterSeconds` and calling again can succeed.
    /// False for the daily and plan limits.
    public var isRetryable: Bool { code != "DAILY_LIMIT_EXCEEDED" && code != "PLAN_LIMIT_EXCEEDED" }

    /// Where to upgrade the plan, when the API sent one.
    public var upgradeUrl: String? { body?["upgradeUrl"] as? String }
}

/// Thrown when a call carried an idempotency key that the endpoint does not
/// accept (HTTP 422, `IDEMPOTENCY_NOT_SUPPORTED`) and the key was the caller's
/// own. No charge was attempted. Call again without `idempotencyKey`.
public final class VedikaIdempotencyNotSupportedError: VedikaApiError {
    public init(_ message: String, body: [String: Any]? = nil) {
        super.init(message, statusCode: 422, body: body)
    }
}

/// Thrown on server errors (HTTP 5xx).
public final class VedikaServerError: VedikaApiError {
    public override init(_ message: String, statusCode: Int? = nil, body: [String: Any]? = nil) {
        super.init(message, statusCode: statusCode, body: body)
    }
}
