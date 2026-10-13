import CryptoKit
import Foundation
import XCTest
import VedikaSDK
@testable import VedikaRoomCapture

final class CaptureSaveUploadTests: XCTestCase {
    private let scanId = "sample-scan-00001"
    private let propertyId = "sample-property-01"

    private func fixture() throws -> [String: Any] {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "native-1.4.0-contract", withExtension: "json"))
        return try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any])
    }
    private func uploadBody() throws -> Data {
        try JSONSerialization.data(withJSONObject: XCTUnwrap(try fixture()["captureRequest"]))
    }
    private func options(title: String = "Synthetic capture") throws -> CaptureSaveOptions {
        try CaptureSaveOptions(scanId: scanId, propertyId: propertyId, title: title, retentionDays: 7)
    }
    private func outbox() throws -> (CaptureOutbox, URL, SymmetricKey) {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        addTeardownBlock { try? FileManager.default.removeItem(at: root) }
        let file = root.appendingPathComponent("queue.aesgcm"), key = SymmetricKey(size: .bits256)
        return (try CaptureOutbox(file: file, key: key), file, key)
    }
    private func transport() throws -> (NativeLoopbackHTTPServer, VastuService) {
        let server = NativeLoopbackHTTPServer(); try server.start()
        addTeardownBlock { server.stop() }
        return (server, try VedikaClient(apiKey: "vk_test_native", baseURL: server.baseURL).vastu)
    }
    private func response(_ value: Any) throws -> NativeLoopbackHTTPServer.StubResponse {
        .init(body: String(decoding: try JSONSerialization.data(withJSONObject: value), as: UTF8.self))
    }
    /// Account-storage responses are simulated; the frozen live response is a
    /// preview and does not prove account persistence or a real-device scan.
    private func saved(scan: String? = nil, persistence: String = "account-store", replayed: Bool = false) -> NativeLoopbackHTTPServer.StubResponse {
        .init(body: "{\"success\":true,\"data\":{\"scan\":{\"scanId\":\"\(scan ?? scanId)\"},\"persistence\":\"\(persistence)\",\"replayed\":\(replayed)}}")
    }
    private func flush(_ queue: CaptureOutbox, service: VastuService, now: Date = Date()) async throws {
        try await CaptureUploadAdapter.flush(queue, service: service, now: now, isOnline: { true })
    }

    func testOptInSavesOriginalCaptureAfterUploadWithSeparateProofAndBodyIdentity() async throws {
        let (queue, _, _) = try outbox(), (server, service) = try transport()
        let body = try uploadBody(), save = try options()
        try await queue.enqueue(body: body, requestId: "upload-1", idempotencyKey: "retained-upload-1", saveAfterUpload: save)
        server.enqueue(try response(XCTUnwrap(try fixture()["uploadResponse"])))
        server.enqueue(saved())
        let challenge = try NativeAttestationChallenge(value: "save-challenge", expiresAt: .distantFuture, platform: "ios")
        try await CaptureUploadAdapter.flush(queue, service: service, isOnline: { true },
            prepareProof: { unsigned in
                XCTAssertNotNil(unsigned["capture"]); XCTAssertNil(unsigned["scanId"])
                return VastuDeviceAttestation(platform: "ios", challenge: "upload-challenge", assertion: "upload-proof")
            }, prepareSaveProof: { unsigned in
                XCTAssertNil(unsigned["deviceAttestation"])
                XCTAssertEqual(unsigned["scanId"] as? String, save.scanId)
                let digest = try NativeAttestation.digest(operation: "scans/save", challenge: challenge, body: unsigned)
                return VastuDeviceAttestation(platform: "ios", challenge: challenge.value,
                    assertion: digest.base64EncodedString())
            })
        let records = await queue.records(); XCTAssertEqual(records[0].state, .synced)
        XCTAssertEqual(records[0].uploadCompleted, true)
        let requests = server.requests(); XCTAssertEqual(requests.count, 2)
        XCTAssertEqual(requests.map(\.path), ["/v2/astrology/vastu/ar/room-capture", "/v2/astrology/vastu/scans/save"])
        XCTAssertEqual(requests[0].headers.first { $0.key.lowercased() == "idempotency-key" }?.value, "retained-upload-1")
        XCTAssertNil(requests[1].headers.first { $0.key.lowercased() == "idempotency-key" })
        let sent = try XCTUnwrap(JSONSerialization.jsonObject(with: requests[1].body) as? [String: Any])
        XCTAssertEqual(Set(sent.keys), ["scanId", "propertyId", "title", "retentionDays", "snapshot", "deviceAttestation"])
        let snapshot = try XCTUnwrap(sent["snapshot"] as? [String: Any])
        XCTAssertEqual(Set(snapshot.keys), ["inputSource", "capture"])
        XCTAssertEqual(snapshot["inputSource"] as? String, "device-reported")
        let original = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(try AttestationCanonicalJSON.encode(snapshot["capture"]!), try AttestationCanonicalJSON.encode(original["capture"]!))
        let proof = try XCTUnwrap(sent["deviceAttestation"] as? [String: Any])
        XCTAssertEqual(proof["assertion"] as? String,
            try NativeAttestation.digest(operation: "scans/save", challenge: challenge, body: sent).base64EncodedString())
        XCTAssertNotEqual(try NativeAttestation.digest(operation: "scans/save", challenge: challenge, body: sent),
            try NativeAttestation.digest(operation: "ar/room-capture", challenge: challenge, body: sent))
        var changed = sent; changed["title"] = "Edited"
        XCTAssertNotEqual(try NativeAttestation.digest(operation: "scans/save", challenge: challenge, body: sent),
            try NativeAttestation.digest(operation: "scans/save", challenge: challenge, body: changed))
    }

    func testSaveFailureRestartAndReplayNeverUploadAgain() async throws {
        let (queue, file, key) = try outbox(), (server, service) = try transport()
        let now = Date(timeIntervalSince1970: 1000), body = try uploadBody(), save = try options()
        try await queue.enqueue(body: body, requestId: "upload-1", idempotencyKey: "retained-upload-1", saveAfterUpload: save, now: now)
        server.enqueue(try response(XCTUnwrap(try fixture()["uploadResponse"])))
        for _ in 0..<3 { server.enqueue(.init(status: 503, reason: "Unavailable", body: "{\"success\":false,\"error\":\"Uncertain save outcome\"}")) }
        try await flush(queue, service: service, now: now)
        let pending = await queue.records()
        XCTAssertEqual(pending[0].state, .unsynced); XCTAssertEqual(pending[0].uploadCompleted, true)
        let restarted = try CaptureOutbox(file: file, key: key)
        try await flush(restarted, service: service, now: now.addingTimeInterval(1))
        XCTAssertEqual(server.requests().count, 4) // backoff retained
        server.enqueue(saved(replayed: true))
        try await flush(restarted, service: service, now: now.addingTimeInterval(2))
        let sent = server.requests()
        XCTAssertEqual(sent.filter { $0.path.hasSuffix("ar/room-capture") }.count, 1)
        XCTAssertEqual(sent.filter { $0.path.hasSuffix("scans/save") }.count, 4)
        let saves = sent.filter { $0.path.hasSuffix("scans/save") }
        for request in saves {
            XCTAssertNil(request.headers.first { $0.key.lowercased() == "idempotency-key" })
            XCTAssertEqual(try AttestationCanonicalJSON.encode(JSONSerialization.jsonObject(with: request.body)),
                           try AttestationCanonicalJSON.encode(JSONSerialization.jsonObject(with: saves[0].body)))
        }
        let done = await restarted.records(); XCTAssertEqual(done[0].state, .synced)
        XCTAssertEqual(done[0].saveAfterUpload, save)
        try await flush(restarted, service: service, now: now.addingTimeInterval(30))
        XCTAssertEqual(server.requests().count, 5)
    }

    func testConflictFailsAndExplicitRetryKeepsSuccessfulUploadCheckpoint() async throws {
        let (queue, _, _) = try outbox(), (server, service) = try transport()
        try await queue.enqueue(body: uploadBody(), requestId: "upload-1", saveAfterUpload: options())
        server.enqueue(try response(XCTUnwrap(try fixture()["uploadResponse"])))
        server.enqueue(.init(status: 409, reason: "Conflict", body: "{\"success\":false,\"error\":\"identity conflict\"}"))
        try await flush(queue, service: service)
        let failed = await queue.records(); XCTAssertEqual(failed[0].state, .failed)
        XCTAssertEqual(failed[0].failure, "identity-conflict")
        try await queue.retry(requestId: "upload-1")
        server.enqueue(saved(replayed: true)); try await flush(queue, service: service)
        XCTAssertEqual(server.requests().count, 3)
        XCTAssertEqual(server.requests().last?.path, "/v2/astrology/vastu/scans/save")
        let done = await queue.records(); XCTAssertEqual(done[0].state, .synced)
    }

    func testFrozenPreviewResponseWrongIdentityAndInvalidInputNeverReportStored() async throws {
        for answer in [try response(XCTUnwrap(try fixture()["savePreviewResponse"])), saved(scan: "different-scan-01"),
                       .init(status: 400, reason: "Bad Request", body: "{\"success\":false,\"error\":\"invalid input\"}")] {
            let (queue, _, _) = try outbox(), (server, service) = try transport()
            try await queue.enqueue(body: uploadBody(), saveAfterUpload: options())
            server.enqueue(try response(XCTUnwrap(try fixture()["uploadResponse"]))); server.enqueue(answer)
            try await flush(queue, service: service)
            let records = await queue.records(); XCTAssertEqual(records[0].state, .failed)
            XCTAssertEqual(records[0].failure, "server-rejected")
            XCTAssertEqual(server.requests().count, 2)
            try await queue.removeSynced(); let kept = await queue.records(); XCTAssertEqual(kept.count, 1)
        }
    }

    func testSaveIsOptionalAndNeverRunsAfterRejectedUpload() async throws {
        let (plain, _, _) = try outbox(), (server, service) = try transport()
        try await plain.enqueue(body: uploadBody())
        server.enqueue(try response(XCTUnwrap(try fixture()["uploadResponse"]))); try await flush(plain, service: service)
        let done = await plain.records(); XCTAssertEqual(done[0].state, .synced)
        XCTAssertEqual(server.requests().count, 1)
        let (savedQueue, _, _) = try outbox()
        try await savedQueue.enqueue(body: uploadBody(), saveAfterUpload: options())
        server.enqueue(.init(status: 400, reason: "Bad Request", body: "{\"success\":false,\"error\":\"invalid capture\"}"))
        try await flush(savedQueue, service: service)
        XCTAssertEqual(server.requests().count, 2)
        XCTAssertFalse(server.requests().contains { $0.path.hasSuffix("scans/save") })
    }

    func testFrozenSaveSettingsCannotChangeForAnExistingQueueIdentity() async throws {
        let (queue, file, key) = try outbox(), body = try uploadBody()
        let original = try await queue.enqueue(body: body, requestId: "same", idempotencyKey: "same", saveAfterUpload: options())
        let same = try await queue.enqueue(body: body, requestId: "same", idempotencyKey: "same", saveAfterUpload: options())
        XCTAssertEqual(original, same)
        do {
            try await queue.enqueue(body: body, requestId: "same", idempotencyKey: "same", saveAfterUpload: options(title: "Changed"))
            XCTFail("save identity/settings changed")
        } catch CaptureStoreError.duplicateIdentity {}
        let restarted = try CaptureOutbox(file: file, key: key), records = await restarted.records()
        XCTAssertEqual(records[0].saveAfterUpload, try options())
        let encrypted = try Data(contentsOf: file)
        XCTAssertNil(encrypted.range(of: Data(scanId.utf8)))
    }

    func testLegacyQueueDecodesAndMissingSaveHandlerCannotSilentlySucceed() async throws {
        let (queue, _, _) = try outbox()
        let record = try await queue.enqueue(body: uploadBody())
        var legacy = try XCTUnwrap(JSONSerialization.jsonObject(with: JSONEncoder().encode(record)) as? [String: Any])
        legacy.removeValue(forKey: "saveAfterUpload"); legacy.removeValue(forKey: "uploadCompleted")
        let decoded = try JSONDecoder().decode(QueuedCapture.self, from: JSONSerialization.data(withJSONObject: legacy))
        XCTAssertNil(decoded.saveAfterUpload); XCTAssertNil(decoded.uploadCompleted)
        let (opted, _, _) = try outbox()
        try await opted.enqueue(body: uploadBody(), saveAfterUpload: options())
        try await opted.flush(isOnline: { true }) { _ in XCTFail("missing save handler sent upload"); return .accepted }
        let failed = await opted.records(); XCTAssertEqual(failed[0].state, .failed)
        XCTAssertEqual(failed[0].failure, "save-handler-required")
    }

    func testDifferentUploadsCannotReuseAnAccountSaveIdentity() async throws {
        let (queue, _, _) = try outbox(), body = try uploadBody(), save = try options()
        try await queue.enqueue(body: body, requestId: "one", idempotencyKey: "one", saveAfterUpload: save)
        do {
            try await queue.enqueue(body: body, requestId: "two", idempotencyKey: "two", saveAfterUpload: save)
            XCTFail("another upload reused the scan ID")
        } catch CaptureStoreError.duplicateIdentity {}
        let kept = await queue.records(); XCTAssertEqual(kept.count, 1)
    }

    func testLegacyReaderCannotOpenNewSaveQueue() async throws {
        let (queue, file, key) = try outbox()
        try await queue.enqueue(body: uploadBody(), saveAfterUpload: options())
        let box = try AES.GCM.SealedBox(combined: Data(contentsOf: file))
        XCTAssertThrowsError(try AES.GCM.open(box, using: key, authenticating: Data("vedika.capture-outbox/1".utf8)))
        let restarted = try CaptureOutbox(file: file, key: key), records = await restarted.records()
        XCTAssertEqual(records[0].saveAfterUpload, try options())
    }

    func testVersionOneFileMigratesWithoutLosingCapture() async throws {
        let (queue, file, key) = try outbox()
        let record = try await queue.enqueue(body: uploadBody(), requestId: "old-upload", idempotencyKey: "old-key")
        var old = try XCTUnwrap(JSONSerialization.jsonObject(with: JSONEncoder().encode(record)) as? [String: Any])
        old.removeValue(forKey: "saveAfterUpload"); old.removeValue(forKey: "uploadCompleted")
        let plaintext = try JSONSerialization.data(withJSONObject: [old])
        let legacy = try AES.GCM.seal(plaintext, using: key, authenticating: Data("vedika.capture-outbox/1".utf8))
        try XCTUnwrap(legacy.combined).write(to: file)
        let migrated = try CaptureOutbox(file: file, key: key), records = await migrated.records()
        XCTAssertEqual(records[0].body, record.body); XCTAssertEqual(records[0].requestId, record.requestId)
        XCTAssertEqual(records[0].idempotencyKey, record.idempotencyKey)
        try await migrated.flush(isOnline: { true }) { _ in .accepted }
        let newBox = try AES.GCM.SealedBox(combined: Data(contentsOf: file))
        XCTAssertThrowsError(try AES.GCM.open(newBox, using: key, authenticating: Data("vedika.capture-outbox/1".utf8)))
        let reopened = try CaptureOutbox(file: file, key: key), done = await reopened.records()
        XCTAssertEqual(done[0].body, record.body); XCTAssertEqual(done[0].state, .synced)
    }

    func testCancellationAfterUploadPreservesCheckpointForSaveOnlyRetry() async throws {
        let (queue, file, key) = try outbox()
        try await queue.enqueue(body: uploadBody(), saveAfterUpload: options())
        do {
            try await queue.flush(isOnline: { true }, save: { _ in throw CancellationError() }, upload: { _ in .accepted })
            XCTFail("cancellation swallowed")
        } catch is CancellationError {}
        let restarted = try CaptureOutbox(file: file, key: key)
        try await restarted.flush(now: Date().addingTimeInterval(3), isOnline: { true }, save: { entry in
            XCTAssertEqual(entry.uploadCompleted, true); return .accepted
        }, upload: { _ in XCTFail("completed upload repeated"); return .accepted })
        let done = await restarted.records(); XCTAssertEqual(done[0].state, .synced)
    }

    func testInvalidSaveMetadataRefusedLocally() {
        for id in ["short", "invalid identifier", String(repeating: "x", count: 129)] {
            XCTAssertThrowsError(try CaptureSaveOptions(scanId: id, propertyId: propertyId, title: "Room", retentionDays: 1))
            XCTAssertThrowsError(try CaptureSaveOptions(scanId: scanId, propertyId: id, title: "Room", retentionDays: 1))
        }
        for title in ["  ", String(repeating: "é", count: 81)] {
            XCTAssertThrowsError(try options(title: title))
        }
        for days in [0, 31] {
            XCTAssertThrowsError(try CaptureSaveOptions(scanId: scanId, propertyId: propertyId, title: "Room", retentionDays: days))
        }
    }

    func testShortLivedProofCannotEnterTheDurableQueue() async throws {
        let (queue, _, _) = try outbox()
        var body = try XCTUnwrap(JSONSerialization.jsonObject(with: uploadBody()) as? [String: Any])
        body["deviceAttestation"] = ["assertion": "short-lived-synthetic-proof"]
        do {
            try await queue.enqueue(body: JSONSerialization.data(withJSONObject: body))
            XCTFail("short-lived proof persisted")
        } catch CaptureStoreError.invalidBody {}
        let records = await queue.records(); XCTAssertTrue(records.isEmpty)
    }
}
