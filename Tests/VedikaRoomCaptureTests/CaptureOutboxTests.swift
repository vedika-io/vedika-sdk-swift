import CryptoKit
import Foundation
import XCTest
@testable import VedikaRoomCapture

final class CaptureOutboxTests: XCTestCase {
    private func fixture() throws -> (URL, SymmetricKey) {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        addTeardownBlock { try? FileManager.default.removeItem(at: root) }
        return (root.appendingPathComponent("outbox.aesgcm"), SymmetricKey(size: .bits256))
    }
    private let body = Data("{\"capture\":{\"schema\":\"vedika.roomCapture/1\"}}".utf8)

    func testOfflineRestartBackoffAndReplayKeepIdentity() async throws {
        let (file, key) = try fixture(); let now = Date(timeIntervalSince1970: 1000)
        let queue = try CaptureOutbox(file: file, key: key)
        let record = try await queue.enqueue(body: body, requestId: "capture-001", idempotencyKey: "billing-001", now: now)
        try await queue.flush(now: now, isOnline: { false }) { _ in XCTFail("offline transport called"); return .accepted }
        let offline = await queue.records(); XCTAssertEqual(offline[0].attempts, 0)
        let disk = try Data(contentsOf: file)
        XCTAssertNil(String(data: disk, encoding: .utf8)); XCTAssertFalse(disk.range(of: body) != nil)
        let restarted = try CaptureOutbox(file: file, key: key)
        try await restarted.flush(now: now, isOnline: { true }) { entry in
            XCTAssertEqual(entry.idempotencyKey, record.idempotencyKey)
            throw URLError(.networkConnectionLost) // includes uncertain server outcome
        }
        try await restarted.flush(now: now.addingTimeInterval(1), isOnline: { true }) { _ in XCTFail("backoff ignored"); return .accepted }
        let again = try CaptureOutbox(file: file, key: key)
        try await again.flush(now: now.addingTimeInterval(2), isOnline: { true }) { entry in
            XCTAssertEqual(entry.requestId, record.requestId); XCTAssertEqual(entry.body, record.body)
            return .duplicate(requestId: entry.requestId, bodySHA256: entry.bodySHA256)
        }
        let synced = await again.records(); XCTAssertEqual(synced[0].state, .synced); XCTAssertEqual(synced[0].attempts, 2)
        let final = try CaptureOutbox(file: file, key: key); let finalRecords = await final.records()
        XCTAssertEqual(finalRecords[0].state, .synced)
        try await final.flush(now: now.addingTimeInterval(10), isOnline: { true }) { _ in XCTFail("synced item resent"); return .accepted }
    }

    func testConflictAndDuplicateWithDifferentBodyStayFailed() async throws {
        let (file, key) = try fixture(); let queue = try CaptureOutbox(file: file, key: key)
        let now = Date(timeIntervalSince1970: 1000)
        try await queue.enqueue(body: body, requestId: "one", idempotencyKey: "key-one", now: now)
        try await queue.enqueue(body: body, requestId: "two", idempotencyKey: "key-two", now: now)
        try await queue.flush(now: now, isOnline: { true }) { entry in
            entry.requestId == "one" ? .conflict : .duplicate(requestId: entry.requestId, bodySHA256: "different")
        }
        let records = await queue.records(); XCTAssertEqual(records.map(\.state), [.failed, .failed])
        XCTAssertEqual(records.map(\.failure), ["identity-conflict", "identity-conflict"])
    }

    func testIdentityCannotBeReusedForEditedCapture() async throws {
        let (file, key) = try fixture(); let queue = try CaptureOutbox(file: file, key: key)
        let record = try await queue.enqueue(body: body, requestId: "one", idempotencyKey: "billing")
        let same = try await queue.enqueue(body: body, requestId: "one", idempotencyKey: "billing")
        XCTAssertEqual(record, same)
        do { try await queue.enqueue(body: Data("{}".utf8), requestId: "one", idempotencyKey: "billing"); XCTFail("edited identity accepted") }
        catch CaptureStoreError.duplicateIdentity {}
    }

    func testTamperingOrWrongKeyNeverDropsQueue() async throws {
        let (file, key) = try fixture(); let queue = try CaptureOutbox(file: file, key: key)
        try await queue.enqueue(body: body)
        XCTAssertThrowsError(try CaptureOutbox(file: file, key: SymmetricKey(size: .bits256)))
        var bytes = try Data(contentsOf: file); bytes[bytes.count - 1] ^= 1; try bytes.write(to: file)
        XCTAssertThrowsError(try CaptureOutbox(file: file, key: key))
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
    }

    func testEnqueueDuringUploadDoesNotLoseNewRecord() async throws {
        let (file, key) = try fixture(); let queue = try CaptureOutbox(file: file, key: key)
        try await queue.enqueue(body: body, requestId: "one", idempotencyKey: "one")
        try await queue.flush(isOnline: { true }) { _ in
            try await queue.enqueue(body: Data("{}".utf8), requestId: "two", idempotencyKey: "two")
            return .accepted
        }
        let records = await queue.records(); XCTAssertEqual(records.map(\.state), [.synced, .unsynced])
        let reload = try CaptureOutbox(file: file, key: key); let loaded = await reload.records()
        XCTAssertEqual(records, loaded)
    }
}
