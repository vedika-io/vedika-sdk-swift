import Foundation
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Minimal, dependency-free loopback HTTP/1.1 server for the
/// credential-routing tests. Binds `127.0.0.1:0` (an OS-assigned ephemeral
/// port), accepts one connection at a time, records the request
/// (method/path/headers), and replies with the next queued response (or a
/// default 200 if the queue is empty).
///
/// This is the Swift-side equivalent of OkHttp's `MockWebServer`
/// (`sdks/android`'s `CredentialRoutingTest.kt`) — a real loopback socket,
/// not a `URLProtocol` stub, because the redirect-refusal property this
/// suite exists to prove is a real-wire behavior of `URLSession` +
/// `RedirectRefusingDelegate`; a request that never leaves the process
/// can't demonstrate that the second host is never contacted.
final class LoopbackHTTPServer {
    struct RecordedRequest {
        let method: String
        let path: String
        let headers: [String: String]
        let body: Data
    }

    struct StubResponse {
        var status: Int = 200
        var reason: String = "OK"
        var headers: [String: String] = ["Content-Type": "application/json"]
        var body: String = #"{"success":true,"data":{"ok":true}}"#

        static func redirect(to location: String) -> StubResponse {
            StubResponse(status: 302, reason: "Found", headers: ["Location": location], body: "")
        }
    }

    enum ServerError: Error {
        case socketFailed
        case bindFailed
        case listenFailed
    }

    private(set) var port: UInt16 = 0
    private var listenFD: Int32 = -1
    private let stateLock = NSLock()
    private var queuedResponses: [StubResponse] = []
    private var recorded: [RecordedRequest] = []
    private var shouldStop = false

    /// The base URL of this server, e.g. `http://127.0.0.1:54321`.
    var baseURL: String { "http://127.0.0.1:\(port)" }

    /// Starts the server on `127.0.0.1` with an OS-assigned port. Blocks
    /// until the socket is listening; the accept loop then runs on a
    /// background thread.
    func start() throws {
        let fd = socket(AF_INET, SOCK_STREAM, 0)
        guard fd >= 0 else { throw ServerError.socketFailed }
        listenFD = fd

        var reuse: Int32 = 1
        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(MemoryLayout<Int32>.size))

        var addr = sockaddr_in()
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = 0  // ask the OS for an ephemeral port
        addr.sin_addr.s_addr = inet_addr("127.0.0.1")
        #if canImport(Darwin)
        addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        #endif

        let bindResult = withUnsafePointer(to: &addr) { ptr -> Int32 in
            ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
                bind(fd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }
        guard bindResult == 0 else { throw ServerError.bindFailed }

        var boundAddr = sockaddr_in()
        var boundLen = socklen_t(MemoryLayout<sockaddr_in>.size)
        let nameResult = withUnsafeMutablePointer(to: &boundAddr) { ptr -> Int32 in
            ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
                getsockname(fd, sockaddrPtr, &boundLen)
            }
        }
        guard nameResult == 0 else { throw ServerError.bindFailed }
        port = UInt16(bigEndian: boundAddr.sin_port)

        guard listen(fd, 16) == 0 else { throw ServerError.listenFailed }

        let thread = Thread { [weak self] in
            self?.acceptLoop()
        }
        thread.name = "LoopbackHTTPServer-\(port)"
        thread.start()
    }

    /// Queues a response for the next incoming request, in FIFO order.
    func enqueue(_ response: StubResponse) {
        stateLock.lock()
        queuedResponses.append(response)
        stateLock.unlock()
    }

    /// All requests received so far, in arrival order.
    func requests() -> [RecordedRequest] {
        stateLock.lock()
        defer { stateLock.unlock() }
        return recorded
    }

    /// Stops accepting new connections and closes the listen socket.
    func stop() {
        stateLock.lock()
        shouldStop = true
        stateLock.unlock()
        if listenFD >= 0 {
            close(listenFD)
            listenFD = -1
        }
    }

    private func acceptLoop() {
        while true {
            stateLock.lock()
            let stop = shouldStop
            stateLock.unlock()
            if stop { break }

            var clientAddr = sockaddr_in()
            var clientLen = socklen_t(MemoryLayout<sockaddr_in>.size)
            let clientFD = withUnsafeMutablePointer(to: &clientAddr) { ptr -> Int32 in
                ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
                    accept(listenFD, sockaddrPtr, &clientLen)
                }
            }
            if clientFD < 0 {
                stateLock.lock()
                let stopping = shouldStop
                stateLock.unlock()
                if stopping { break }
                continue
            }
            handle(clientFD)
        }
    }

    private func handle(_ fd: Int32) {
        defer { close(fd) }
        guard let (method, path, headers, body) = readRequest(fd) else { return }
        stateLock.lock()
        recorded.append(RecordedRequest(method: method, path: path, headers: headers, body: body))
        let response = queuedResponses.isEmpty ? StubResponse() : queuedResponses.removeFirst()
        stateLock.unlock()
        writeResponse(fd, response)
    }

    private func readRequest(_ fd: Int32) -> (String, String, [String: String], Data)? {
        var buffer = Data()
        var chunk = [UInt8](repeating: 0, count: 4096)
        while range(of: "\r\n\r\n", in: buffer) == nil {
            let n = read(fd, &chunk, chunk.count)
            if n <= 0 { break }
            buffer.append(contentsOf: chunk[0..<n])
            if buffer.count > 1 << 20 { break }  // 1MB header guard
        }
        guard let headerEnd = range(of: "\r\n\r\n", in: buffer) else { return nil }
        let headerText = String(decoding: buffer[buffer.startIndex..<headerEnd.lowerBound], as: UTF8.self)
        var bodyBytes = Array(buffer[headerEnd.upperBound...])

        let lines = headerText.components(separatedBy: "\r\n")
        guard let requestLine = lines.first else { return nil }
        let parts = requestLine.split(separator: " ", maxSplits: 2)
        guard parts.count >= 2 else { return nil }
        let method = String(parts[0])
        let path = String(parts[1])

        var headers: [String: String] = [:]
        for line in lines.dropFirst() where !line.isEmpty {
            guard let colonIndex = line.firstIndex(of: ":") else { continue }
            let key = line[line.startIndex..<colonIndex].trimmingCharacters(in: .whitespaces)
            let value = line[line.index(after: colonIndex)...].trimmingCharacters(in: .whitespaces)
            headers[key] = value
        }

        // Drain any remaining request body per Content-Length so the client
        // is never left blocked mid-write when this connection closes.
        if let contentLengthValue = headers.first(where: { $0.key.lowercased() == "content-length" })?.value,
            let contentLength = Int(contentLengthValue)
        {
            while bodyBytes.count < contentLength {
                var extra = [UInt8](repeating: 0, count: 4096)
                let n = read(fd, &extra, extra.count)
                if n <= 0 { break }
                bodyBytes.append(contentsOf: extra[0..<n])
            }
        }

        return (method, path, headers, Data(bodyBytes))
    }

    private func writeResponse(_ fd: Int32, _ response: StubResponse) {
        var headers = response.headers
        headers["Content-Length"] = "\(response.body.utf8.count)"
        headers["Connection"] = "close"

        var text = "HTTP/1.1 \(response.status) \(response.reason)\r\n"
        for (key, value) in headers {
            text += "\(key): \(value)\r\n"
        }
        text += "\r\n"
        text += response.body

        let bytes = Array(text.utf8)
        bytes.withUnsafeBufferPointer { ptr in
            _ = write(fd, ptr.baseAddress, ptr.count)
        }
    }

    /// Byte-level search for `marker` inside `data`. Used instead of
    /// `Data.range(of:)` (which needs `Foundation`'s NSData bridging on
    /// some platforms) so header-boundary detection is dependency-minimal
    /// and predictable.
    private func range(of marker: String, in data: Data) -> Range<Data.Index>? {
        let markerBytes = Array(marker.utf8)
        guard !data.isEmpty, markerBytes.count <= data.count else { return nil }
        let dataBytes = Array(data)
        var i = 0
        while i <= dataBytes.count - markerBytes.count {
            if Array(dataBytes[i..<(i + markerBytes.count)]) == markerBytes {
                let start = data.index(data.startIndex, offsetBy: i)
                let end = data.index(start, offsetBy: markerBytes.count)
                return start..<end
            }
            i += 1
        }
        return nil
    }
}
