import Foundation

/// Credential-routing hardening (R-004): `URLSession` follows HTTP
/// redirects and re-sends the `Authorization` header to whatever origin a
/// 3xx response names — that is the platform DEFAULT, not an opt-in, and it
/// must be overridden. This delegate refuses every redirect by calling the
/// completion handler with `nil`: per Apple's documented behavior, the 3xx
/// response is then delivered to the caller as the task's own final
/// response (`VedikaClient.handleResponse` turns that into a thrown
/// `VedikaApiError`) instead of a second request ever being sent. The API
/// key is provably never forwarded to the redirect target because there is
/// no second request.
///
/// Mirrors `OkHttpClient.Builder().followRedirects(false)` (Android) and
/// Dart's `http.Request.followRedirects = false` (Flutter) — the two
/// platform-proven precedents in this repo for HTTP stacks that can't hook
/// a Node-only `axios.beforeRedirect`.
final class RedirectRefusingDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void
    ) {
        completionHandler(nil)
    }
}
