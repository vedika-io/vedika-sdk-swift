import XCTest

@testable import VedikaSDK

/// `FloorMerge` builds the `ar/capture-merge` request from finished floor scans
/// and refuses a bad link before any request is made. Requests go to the
/// loopback server only: no real network, no spend.
final class FloorMergeTests: XCTestCase {
    private let square: [[Double]] = [[0, 0], [6, 0], [6, 5], [0, 5]]
    private var server: LoopbackHTTPServer!

    override func setUpWithError() throws {
        server = LoopbackHTTPServer()
        try server.start()
    }

    override func tearDown() {
        server.stop()
        server = nil
    }

    private func capture(_ id: String, floor: Int, referenceFrame: String = "true", closed: Bool = true) -> VastuRoomCapture {
        VastuRoomCapture(
            schema: "vedika.roomCapture/1", captureId: id, capturedAtEpoch: 1_789_000_000,
            device: VastuRoomCaptureDevice(platform: "ios", method: "arkit-hit", depth: "none"),
            frame: VastuRoomCaptureFrame(
                units: "metres", axes: "+X east,+Y true north",
                north: VastuRoomCaptureFrameNorth(
                    referenceFrame: referenceFrame, headingSource: "arkit-true-heading", declinationProvenance: "fixture",
                    yawSamples: 17, compassConfidence: 0.9)),
            outline: VastuRoomCaptureOutline(polygon: square),
            rooms: [VastuRoomCaptureRoomsItem(id: "r-\(id)", label: "kitchen", labelSource: "user", polygon: square, areaM2: 30, floorIndex: floor)],
            quality: VastuRoomCaptureQuality(polygonClosure: closed, pointCloudDensityBasis: "none", roomCount: 1, roomsTagged: 1),
            attestation: "caller-reported")
    }

    /// Stair points: the same horizontal spot, shifted on the upper plan by (dx, dy).
    private func stairs(dx: Double = -1.2, dy: Double = -0.4, noise: Double = 0) -> [SharedFloorPoint] {
        [
            SharedFloorPoint(reference: FloorPoint(x: 2, y: 1), next: FloorPoint(x: 2 + dx, y: 1 + dy)),
            SharedFloorPoint(reference: FloorPoint(x: 2, y: 3), next: FloorPoint(x: 2 + dx, y: 3 + dy + noise)),
            SharedFloorPoint(reference: FloorPoint(x: 4, y: 2), next: FloorPoint(x: 4 + dx, y: 2 + dy)),
        ]
    }

    private func twoFloors(points: [SharedFloorPoint]? = nil, toleranceM: Double = 0.05, kind: FloorLinkKind = .stair) -> FloorMergeInput {
        FloorMergeInput(
            scans: [FloorScan(capture: capture("ground", floor: 0), elevationM: 0), FloorScan(capture: capture("first", floor: 1), elevationM: 3.2)],
            links: [FloorLink(toCaptureId: "first", kind: kind, points: points ?? stairs())],
            toleranceM: toleranceM)
    }

    private func assertRefused(_ expected: FloorMergeRefusal, _ input: FloorMergeInput, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertThrowsError(try FloorMerge.prepare(input), file: file, line: line) { error in
            XCTAssertEqual((error as? FloorMergeRefused)?.reason, expected, "\(error)", file: file, line: line)
        }
    }

    // MARK: request shape

    func testTwoFloorsBecomeExplicitFloorFramesAndNoCrossFloorApiLink() throws {
        let prepared = try FloorMerge.prepare(twoFloors())
        let body = prepared.request.dictionary
        XCTAssertEqual(Set(body.keys), ["captures", "links", "floors", "toleranceM"])
        // The API only links captures on one floor, so the stair points become a floor frame.
        XCTAssertEqual((body["links"] as? [Any])?.count, 0)
        XCTAssertEqual(body["toleranceM"] as? Double, 0.05)
        let captures = try XCTUnwrap(body["captures"] as? [[String: Any]])
        XCTAssertEqual(captures.count, 2)
        XCTAssertEqual(Set(captures[0].keys), ["id", "floorIndex", "payload"])
        XCTAssertEqual(captures[0]["id"] as? String, "ground")
        XCTAssertEqual(captures[1]["floorIndex"] as? Int, 1)

        let floors = try XCTUnwrap(body["floors"] as? [[String: Any]])
        XCTAssertEqual(Set(floors[0].keys), ["floorIndex", "elevationM", "originXY", "bearingDeg"])
        XCTAssertEqual(floors[0]["originXY"] as? [Double], [0, 0])
        // originXY = reference point minus the same point on the upper plan.
        let origin = try XCTUnwrap(floors[1]["originXY"] as? [Double])
        XCTAssertEqual(origin[0], 1.2, accuracy: 1e-9)
        XCTAssertEqual(origin[1], 0.4, accuracy: 1e-9)
        XCTAssertEqual(floors[1]["floorIndex"] as? Int, 1)
        XCTAssertEqual(floors[1]["elevationM"] as? Double, 3.2)
        XCTAssertEqual(floors[1]["bearingDeg"] as? Double, 0)
        XCTAssertNil(body["maxChargeUsd"])
    }

    func testStatedErrorIsTheSharedPointResidual() throws {
        let exact = try FloorMerge.prepare(twoFloors()).registration
        XCTAssertEqual(exact.rmsResidualM, 0, accuracy: 1e-9)
        XCTAssertEqual(exact.maxResidualM, 0, accuracy: 1e-9)
        XCTAssertEqual(exact.pairResiduals.count, 1)
        XCTAssertEqual(exact.pairResiduals[0].fromCaptureId, "ground")
        XCTAssertEqual(exact.pairResiduals[0].toCaptureId, "first")
        XCTAssertEqual(exact.pairResiduals[0].controlCount, 3)

        // One point 3 cm off: the mean shift absorbs part of it, so the residuals are small and stated.
        let noisy = try FloorMerge.prepare(twoFloors(points: stairs(noise: 0.03))).registration
        XCTAssertTrue((0.015...0.03).contains(noisy.maxResidualM))
        XCTAssertTrue(noisy.rmsResidualM > 0 && noisy.rmsResidualM <= noisy.maxResidualM)
        XCTAssertTrue(noisy.describe().contains("not survey accuracy"))
    }

    func testMaxChargeIsForwardedAsGiven() throws {
        var input = twoFloors()
        input.maxChargeUsd = "0.50"
        XCTAssertEqual(try FloorMerge.prepare(input).request.dictionary["maxChargeUsd"] as? String, "0.50")
    }

    func testThreeFloorsLinkEachUpperFloorToTheReference() throws {
        let input = FloorMergeInput(
            scans: [
                FloorScan(capture: capture("g", floor: 0), elevationM: 0),
                FloorScan(capture: capture("f1", floor: 1), elevationM: 3.2),
                FloorScan(capture: capture("f2", floor: 2), elevationM: 6.4),
            ],
            links: [
                FloorLink(toCaptureId: "f2", kind: .door, points: stairs(dx: -2, dy: 0)),
                FloorLink(toCaptureId: "f1", kind: .stair, points: stairs()),
            ])
        let floors = try XCTUnwrap(try FloorMerge.prepare(input).request.dictionary["floors"] as? [[String: Any]])
        XCTAssertEqual(floors.count, 3)
        XCTAssertEqual(try XCTUnwrap(floors[2]["originXY"] as? [Double])[0], 2.0, accuracy: 1e-9)
        XCTAssertEqual(try XCTUnwrap(floors[1]["originXY"] as? [Double])[0], 1.2, accuracy: 1e-9)
    }

    // MARK: refusals, all thrown before any request

    func testRefusesFewerThanTwoFloors() {
        var input = twoFloors()
        input.scans = [FloorScan(capture: capture("ground", floor: 0), elevationM: 0)]
        input.links = []
        assertRefused(.tooFewFloors, input)
    }

    func testRefusesDuplicateFloorIndexCaptureIdAndElevation() {
        var sameFloor = twoFloors()
        sameFloor.scans = [FloorScan(capture: capture("ground", floor: 0), elevationM: 0), FloorScan(capture: capture("first", floor: 0), elevationM: 3.2)]
        assertRefused(.duplicateFloorIndex, sameFloor)
        var sameId = twoFloors()
        sameId.scans = [FloorScan(capture: capture("ground", floor: 0), elevationM: 0), FloorScan(capture: capture("ground", floor: 1), elevationM: 3.2)]
        assertRefused(.duplicateCaptureId, sameId)
        var sameElevation = twoFloors()
        sameElevation.scans = [FloorScan(capture: capture("ground", floor: 0), elevationM: 0), FloorScan(capture: capture("first", floor: 1), elevationM: 0)]
        assertRefused(.duplicateElevation, sameElevation)
    }

    func testRefusesALinkToAnUnknownFloor() {
        var unknown = twoFloors()
        unknown.links = [FloorLink(toCaptureId: "second", kind: .stair, points: stairs())]
        assertRefused(.unknownFloorLink, unknown)
        let three = FloorMergeInput(
            scans: [
                FloorScan(capture: capture("g", floor: 0), elevationM: 0),
                FloorScan(capture: capture("f1", floor: 1), elevationM: 3.2),
                FloorScan(capture: capture("f2", floor: 2), elevationM: 6.4),
            ],
            links: [FloorLink(toCaptureId: "f1", kind: .stair, points: stairs()), FloorLink(toCaptureId: "g", kind: .stair, points: stairs())])
        // A link naming the reference floor itself is unknown.
        assertRefused(.unknownFloorLink, three)
        var none = three
        none.links = [FloorLink(toCaptureId: "f1", kind: .stair, points: stairs())]
        assertRefused(.missingLink, none)
        var dup = three
        dup.links = [FloorLink(toCaptureId: "f1", kind: .stair, points: stairs()), FloorLink(toCaptureId: "f1", kind: .stair, points: stairs())]
        assertRefused(.duplicateLink, dup)
    }

    func testRefusesTooFewSharedPoints() {
        assertRefused(.tooFewPoints, twoFloors(points: Array(stairs().prefix(2))))
        assertRefused(.tooFewPoints, twoFloors(points: []))
    }

    func testRefusesNonFiniteCoordinates() {
        for bad in [Double.nan, Double.infinity, -Double.infinity] {
            var reference = stairs()
            reference[1] = SharedFloorPoint(reference: FloorPoint(x: bad, y: 3), next: reference[1].next)
            assertRefused(.nonFinitePoint, twoFloors(points: reference))
            var next = stairs()
            next[2] = SharedFloorPoint(reference: next[2].reference, next: FloorPoint(x: 1, y: bad))
            assertRefused(.nonFinitePoint, twoFloors(points: next))
        }
    }

    func testRefusesPointsOutsideTheirOwnFloorAndCoincidentPoints() {
        var outside = stairs()
        outside[0] = SharedFloorPoint(reference: FloorPoint(x: 9, y: 9), next: outside[0].next)
        assertRefused(.pointOutsideFloor, twoFloors(points: outside))
        let p = SharedFloorPoint(reference: FloorPoint(x: 2, y: 2), next: FloorPoint(x: 1, y: 1))
        assertRefused(.noBaseline, twoFloors(points: [p, p, p]))
    }

    func testRefusesAMisreadLinkAboveTolerance() throws {
        // One floor's points disagree by 0.5 m: the merge must not be sent.
        var bad = stairs()
        bad[1] = SharedFloorPoint(reference: bad[1].reference, next: FloorPoint(x: bad[1].next.x + 0.5, y: bad[1].next.y))
        assertRefused(.errorAboveTolerance, twoFloors(points: bad))
        // The same spread is accepted when the caller states a wide enough tolerance.
        _ = try FloorMerge.prepare(twoFloors(points: bad, toleranceM: 1))
    }

    func testRefusesAScanThatCannotBeStacked() {
        var magnetic = twoFloors()
        magnetic.scans[1] = FloorScan(capture: capture("first", floor: 1, referenceFrame: "magnetic"), elevationM: 3.2)
        assertRefused(.unsupportedCapture, magnetic)
        var open = twoFloors()
        open.scans[1] = FloorScan(capture: capture("first", floor: 1, closed: false), elevationM: 3.2)
        assertRefused(.unsupportedCapture, open)
    }

    func testRefusesBadToleranceElevationAndMaxCharge() {
        assertRefused(.badTolerance, twoFloors(toleranceM: 0))
        assertRefused(.badTolerance, twoFloors(toleranceM: .nan))
        assertRefused(.badTolerance, twoFloors(toleranceM: 1.5))
        var nan = twoFloors()
        nan.scans[1] = FloorScan(capture: capture("first", floor: 1), elevationM: .nan)
        assertRefused(.badElevation, nan)
        var charge = twoFloors()
        charge.maxChargeUsd = "-1"
        assertRefused(.badMaxCharge, charge)
    }

    // MARK: the call: key, no request on refusal, response check

    private func mergedResponse(rooms: [(String, Int)] = [("ground", 0), ("first", 1)]) -> LoopbackHTTPServer.StubResponse {
        let roomJSON = rooms.map { #"{"captureId":"\#($0.0)","floorIndex":\#($0.1)}"# }.joined(separator: ",")
        var response = LoopbackHTTPServer.StubResponse()
        response.body =
            #"{"success":true,"data":{"method":"capture-merge","frame":{},"rooms":[\#(roomJSON)],"outlines":[],"registrations":[],"#
            + #""pairResiduals":[],"unresolvedAlignmentErrors":[],"floorStack":[{"floorIndex":0,"elevationM":0},{"floorIndex":1,"elevationM":3.2}],"#
            + #""toleranceM":0.05,"alignmentMethod":"anchored-least-squares-rigid-2d"},"#
            + #""billing":{"charged":0.01,"currency":"USD"}}"#
        return response
    }

    private func makeService() throws -> VastuService { try VedikaClient(apiKey: "vk_test_x", baseURL: server.baseURL).vastu }

    func testMergePostsTheRequestWithTheCallersIdempotencyKeyAndReturnsTheStatedError() async throws {
        server.enqueue(mergedResponse())
        let result = try await FloorMerge.merge(service: makeService(), input: twoFloors(), idempotencyKey: "merge-key-0123")
        let requests = server.requests()
        XCTAssertEqual(requests.count, 1)
        let wire = try XCTUnwrap(requests.first)
        XCTAssertEqual(wire.method, "POST")
        XCTAssertEqual(wire.path, "/v2/astrology/vastu/ar/capture-merge")
        XCTAssertEqual(wire.headers.first { $0.key.lowercased() == "idempotency-key" }?.value, "merge-key-0123")
        let body = try XCTUnwrap(JSONSerialization.jsonObject(with: wire.body) as? [String: Any])
        XCTAssertEqual(Set(body.keys), ["captures", "links", "floors", "toleranceM"])
        XCTAssertEqual((body["floors"] as? [Any])?.count, 2)
        XCTAssertEqual(result.building.method, "capture-merge")
        XCTAssertEqual(result.building.floorStack.count, 2)
        XCTAssertEqual(result.building.rooms.count, 2)
        XCTAssertEqual(result.rmsResidualM, 0, accuracy: 1e-9)
        XCTAssertEqual(result.maxResidualM, 0, accuracy: 1e-9)
    }

    func testARefusedLinkMakesNoRequest() async throws {
        var bad = stairs()
        bad[1] = SharedFloorPoint(reference: bad[1].reference, next: FloorPoint(x: bad[1].next.x + 0.5, y: bad[1].next.y))
        let service = try makeService()
        do {
            _ = try await FloorMerge.merge(service: service, input: twoFloors(points: bad), idempotencyKey: "merge-key-0123")
            XCTFail("a link above tolerance must be refused")
        } catch let error as FloorMergeRefused {
            XCTAssertEqual(error.reason, .errorAboveTolerance)
        }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testAMissingOrMalformedIdempotencyKeyMakesNoRequest() async throws {
        let service = try makeService()
        for key in ["", "has space", "naïve", String(repeating: "k", count: 257)] {
            do {
                _ = try await FloorMerge.merge(service: service, input: twoFloors(), idempotencyKey: key)
                XCTFail("key \(key.debugDescription) must be refused")
            } catch let error as FloorMergeRefused {
                XCTAssertEqual(error.reason, .badIdempotencyKey)
            }
        }
        XCTAssertEqual(server.requests().count, 0)
    }

    func testAResultThatDoesNotMatchWhatWasSentIsNotReturned() async throws {
        server.enqueue(mergedResponse(rooms: [("ground", 0)]))
        let service = try makeService()
        do {
            _ = try await FloorMerge.merge(service: service, input: twoFloors(), idempotencyKey: "merge-key-0123")
            XCTFail("a merged building missing a floor's rooms must not be returned")
        } catch is FloorMergeResponseError {
        }
    }
}
