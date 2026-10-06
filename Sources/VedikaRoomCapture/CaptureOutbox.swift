import CryptoKit
import Foundation
import Security

public enum CaptureSyncState: String, Codable, Sendable { case unsynced, synced, failed }

public struct QueuedCapture: Codable, Sendable, Equatable {
    public let requestId: String
    public let idempotencyKey: String
    public let body: Data
    public let bodySHA256: String
    public let localMetadata: CaptureLocalMetadata?
    public var state: CaptureSyncState
    public var attempts: Int
    public var nextAttemptAt: Date
    public var failure: String?
}

public enum CaptureUploadResult: Sendable {
    case accepted
    /// Supply this only after server readback confirms BOTH identity and body.
    /// An HTTP 409 alone is a conflict, never a successful replay.
    case duplicate(requestId: String, bodySHA256: String)
    case retryable
    case conflict
    case rejected
}

public enum CaptureStoreError: Error { case keychain(OSStatus), corruptKey, capacity, duplicateIdentity, invalidBody }

/// The key never enters preferences or the capture file. ThisDeviceOnly avoids
/// restoring ciphertext onto another device without its key.
public enum CaptureKeychain {
    public static func key(service: String, account: String = "capture-outbox-v1") throws -> SymmetricKey {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service, kSecAttrAccount as String: account]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query.merging([kSecReturnData as String: true, kSecMatchLimit as String: kSecMatchLimitOne]) { _, b in b } as CFDictionary, &item)
        if status == errSecSuccess {
            guard let data = item as? Data, data.count == 32 else { throw CaptureStoreError.corruptKey }
            return SymmetricKey(data: data)
        }
        guard status == errSecItemNotFound else { throw CaptureStoreError.keychain(status) }
        let data = SymmetricKey(size: .bits256).withUnsafeBytes { Data($0) }
        let add = SecItemAdd(query.merging([kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly]) { _, b in b } as CFDictionary, nil)
        if add == errSecDuplicateItem {
            var existing: CFTypeRef?
            let read = SecItemCopyMatching(query.merging([kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne]) { _, b in b } as CFDictionary, &existing)
            guard read == errSecSuccess else { throw CaptureStoreError.keychain(read) }
            guard let bytes = existing as? Data, bytes.count == 32 else { throw CaptureStoreError.corruptKey }
            return SymmetricKey(data: bytes)
        }
        guard add == errSecSuccess else { throw CaptureStoreError.keychain(add) }
        return SymmetricKey(data: data)
    }
}

/// One actor owns one outbox file. Open it once per process. File writes are
/// atomic, authenticated AES-GCM snapshots; failed decryption is never treated
/// as an empty queue. A restart retries the SAME body and billing identity.
public actor CaptureOutbox {
    private let file: URL
    private let key: SymmetricKey
    private let aad = Data("vedika.capture-outbox/1".utf8)
    private var entries: [QueuedCapture]
    private var flushing = false
    private let maximumEntries: Int

    public init(file: URL, key: SymmetricKey, maximumEntries: Int = 100) throws {
        self.file = file; self.key = key; self.maximumEntries = maximumEntries
        if FileManager.default.fileExists(atPath: file.path) {
            let box = try AES.GCM.SealedBox(combined: Data(contentsOf: file))
            entries = try JSONDecoder().decode([QueuedCapture].self, from: AES.GCM.open(box, using: key, authenticating: aad))
        } else { entries = [] }
    }

    public func records() -> [QueuedCapture] { entries }

    @discardableResult
    public func enqueue(body: Data, requestId: String = UUID().uuidString,
                        idempotencyKey: String = UUID().uuidString, localMetadata: CaptureLocalMetadata? = nil,
                        now: Date = Date()) throws -> QueuedCapture {
        guard body.count <= 256 * 1024, !requestId.isEmpty, !idempotencyKey.isEmpty,
              let object = try? JSONSerialization.jsonObject(with: body), object is [String: Any] else {
            throw CaptureStoreError.invalidBody
        }
        let hash = Self.hash(body)
        if let old = entries.first(where: { $0.requestId == requestId || $0.idempotencyKey == idempotencyKey }) {
            guard old.requestId == requestId, old.idempotencyKey == idempotencyKey, old.body == body, old.localMetadata == localMetadata else {
                throw CaptureStoreError.duplicateIdentity
            }
            return old
        }
        guard entries.count < maximumEntries else { throw CaptureStoreError.capacity }
        let entry = QueuedCapture(requestId: requestId, idempotencyKey: idempotencyKey, body: body,
            bodySHA256: hash, localMetadata: localMetadata, state: .unsynced, attempts: 0, nextAttemptAt: now, failure: nil)
        var candidate = entries; candidate.append(entry)
        try persist(candidate); entries = candidate
        return entry
    }

    /// A caller invokes this after connectivity changes or app launch. No
    /// recurring job is installed. Transport errors retain the durable record.
    public func flush(now: Date = Date(), isOnline: @Sendable () -> Bool,
                      upload: @Sendable (QueuedCapture) async throws -> CaptureUploadResult) async throws {
        guard !flushing, isOnline() else { return }
        flushing = true; defer { flushing = false }
        let ids = entries.filter { $0.state == .unsynced && $0.nextAttemptAt <= now }.map(\.requestId)
        for id in ids {
            guard !Task.isCancelled, isOnline(), let index = entries.firstIndex(where: { $0.requestId == id }) else { break }
            var checkpoint = entries
            checkpoint[index].attempts += 1
            checkpoint[index].nextAttemptAt = now.addingTimeInterval(min(3600, 2 * pow(2, Double(checkpoint[index].attempts - 1))))
            try persist(checkpoint); entries = checkpoint
            let result: CaptureUploadResult
            do { result = try await upload(entries[index]) }
            catch is CancellationError { throw CancellationError() }
            catch { result = .retryable }
            // enqueue may run during the await; use the current snapshot.
            guard let current = entries.firstIndex(where: { $0.requestId == id }) else { continue }
            var updated = entries
            switch result {
            case .accepted: updated[current].state = .synced
            case let .duplicate(requestId, bodySHA256):
                if requestId == id && bodySHA256 == updated[current].bodySHA256 { updated[current].state = .synced }
                else { updated[current].state = .failed; updated[current].failure = "identity-conflict" }
            case .conflict: updated[current].state = .failed; updated[current].failure = "identity-conflict"
            case .rejected: updated[current].state = .failed; updated[current].failure = "server-rejected"
            case .retryable:
                if updated[current].attempts >= 8 { updated[current].state = .failed; updated[current].failure = "retry-limit" }
            }
            try persist(updated); entries = updated
        }
    }

    /// Explicit user retry preserves the body and identity, including on a
    /// conflict; changing the capture requires a new queued request.
    public func retry(requestId: String, now: Date = Date()) throws {
        guard let index = entries.firstIndex(where: { $0.requestId == requestId }), entries[index].state == .failed else { return }
        var updated = entries; updated[index].state = .unsynced
        updated[index].attempts = 0; updated[index].nextAttemptAt = now; updated[index].failure = nil
        try persist(updated); entries = updated
    }

    public func removeSynced() throws {
        let updated = entries.filter { $0.state != .synced }; try persist(updated); entries = updated
    }

    private func persist(_ snapshot: [QueuedCapture]) throws {
        let bytes = try JSONEncoder().encode(snapshot)
        let box = try AES.GCM.seal(bytes, using: key, authenticating: aad)
        try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
        #if os(iOS)
        try box.combined!.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
        #else
        try box.combined!.write(to: file, options: .atomic)
        #endif
        try FileManager.default.setAttributes([.posixPermissions: 0o600], ofItemAtPath: file.path)
    }

    public static func hash(_ data: Data) -> String { SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined() }
}
