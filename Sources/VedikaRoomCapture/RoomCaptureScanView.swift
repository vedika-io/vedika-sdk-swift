#if os(iOS) && canImport(RoomPlan)
import ARKit
import CoreLocation
import Foundation
import RoomPlan
import SwiftUI
import VedikaSDK

@available(iOS 16.0, *)
@MainActor
public final class RoomCaptureScanModel: NSObject, ObservableObject {
    @Published public private(set) var status = "Walk slowly. Keep walls and openings in view."
    @Published public private(set) var room: CapturedRoom?
    @Published public private(set) var magneticHeadingDeg: Double?
    @Published public private(set) var headingAccuracyDeg: Double?
    @Published public private(set) var north: ConfirmedCaptureNorth?
    @Published public private(set) var declinationDeg: Double?
    public private(set) var view: RoomCaptureView?
    private let location = CLLocationManager()
    private var samples: [RoomCaptureHeadingSample] = []
    private var sampleDates: [Date] = []
    private var firstHeadingAt: Date?
    private var lastHeadingAt: Date?
    private var provenance = ""
    private var replay = false
    public override init() {
        super.init(); location.delegate = self; location.headingOrientation = .portrait; location.headingFilter = kCLHeadingFilterNone
        if !RoomPlan.RoomCaptureSession.isSupported { status = "RoomPlan needs LiDAR. Replay a synthetic room on this device." }
    }
    public var supported: Bool { RoomPlan.RoomCaptureSession.isSupported }
    public func start() {
        guard supported else { status = "RoomPlan needs a LiDAR device. Replay the synthetic room below."; return }
        samples = []; sampleDates = []; firstHeadingAt = nil; lastHeadingAt = nil; north = nil; room = nil; declinationDeg = nil; magneticHeadingDeg = nil; headingAccuracyDeg = nil; replay = false
        let scan = RoomCaptureView(frame: .zero); scan.delegate = self; view = scan
        var config = RoomPlan.RoomCaptureSession.Configuration(); config.isCoachingEnabled = true
        scan.captureSession.run(configuration: config)
        location.requestWhenInUseAuthorization(); location.startUpdatingLocation(); location.startUpdatingHeading()
        status = "Scanning. Move around the room; hold the phone steady for north samples."
    }
    public func finish() { view?.captureSession.stop(); location.stopUpdatingHeading(); location.stopUpdatingLocation(); status = "Processing walls and openings…" }
    public func stop() { view?.captureSession.stop(); location.stopUpdatingHeading(); location.stopUpdatingLocation() }
    public func loadReplay(_ data: Data) throws {
        stop(); room = try RoomPlanAdapter.decode(data); replay = true; view = nil; north = nil
        // Fixed inputs are simulator test data, never physical measurements.
        samples = (0..<RoomCaptureModel.minNorthSamples).map { _ in RoomCaptureHeadingSample(headingDeg: 0, forward: Vec3(x: 0, y: 0, z: -1)) }
        declinationDeg = 0; provenance = "fixture"; headingAccuracyDeg = nil; magneticHeadingDeg = nil
        status = "Synthetic fixture replay. Review the room label and simulated north."
    }
    public func resolveDeclination(service: VastuService) async throws {
        guard !replay, let fix = location.location, fix.horizontalAccuracy >= 0,
              fix.horizontalAccuracy <= 100, abs(fix.timestamp.timeIntervalSinceNow) < 60 else {
            throw RoomCaptureError("Wait for a recent location fix before requesting declination")
        }
        let response = try await service.vastuDeclination(lat: fix.coordinate.latitude, lon: fix.coordinate.longitude)
        guard response.data.computed, let degrees = response.data.declinationDeg, degrees.isFinite else {
            throw RoomCaptureError("No computed API declination at this location")
        }
        declinationDeg = degrees; provenance = "live"
        north = nil; status = "API declination loaded. Confirm the indicated north direction."
    }
    public func confirmNorth() throws {
        guard let degrees = declinationDeg else { throw RoomCaptureError("Load API declination first") }
        if !replay {
            guard let first = firstHeadingAt, let last = lastHeadingAt, last.timeIntervalSince(first) * 1000 >= Double(RoomCaptureModel.minNorthMs),
                  let accuracy = headingAccuracyDeg, accuracy >= 0, accuracy <= 15 else { throw RoomCaptureError("Hold steady for calibrated heading samples over three seconds") }
        }
        north = try ConfirmedCaptureNorth(magneticSamples: samples, declinationDeg: degrees, provenance: provenance, userConfirmed: true)
        status = "North confirmed. Choose the room type and confirm its perimeter."
    }
    public func reviewedCapture(label: String) throws -> VastuRoomCapture {
        guard let room, let north else { throw RoomCaptureError("Complete the scan and confirm north first") }
        return try RoomPlanAdapter.capture(room: room, captureId: UUID().uuidString, label: label, north: north)
    }
    public func report(_ error: Error) { status = String(describing: error) }
}

@available(iOS 16.0, *)
extension RoomCaptureScanModel: @preconcurrency CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        headingAccuracyDeg = heading.headingAccuracy; magneticHeadingDeg = heading.magneticHeading
        guard heading.headingAccuracy >= 0, heading.headingAccuracy <= 15,
              abs(heading.timestamp.timeIntervalSinceNow) < 0.25,
              let frame = view?.captureSession.arSession.currentFrame,
              case .normal = frame.camera.trackingState else { north = nil; return }
        // Core Location portrait headings measure the PHONE TOP (+Y), not
        // the camera forward (-Z). Pair the same physical axis with AR pose.
        let forward = frame.camera.transform.columns.1
        guard abs(ProcessInfo.processInfo.systemUptime - frame.timestamp) < 0.25,
              hypot(forward.x, forward.z) > 0.2 else {
            north = nil; status = "Tilt the phone so its top points along the floor, then hold steady."; return
        }
        samples.append(RoomCaptureHeadingSample(headingDeg: heading.magneticHeading,
            forward: Vec3(x: Double(forward.x), y: Double(forward.y), z: Double(forward.z))))
        sampleDates.append(heading.timestamp)
        if samples.count > 120 { samples.removeFirst(); sampleDates.removeFirst() }
        firstHeadingAt = sampleDates.first; lastHeadingAt = sampleDates.last
        north = nil
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { report(error); north = nil }
}
@available(iOS 16.0, *)
extension RoomCaptureScanModel: @preconcurrency NSCoding {
    public func encode(with coder: NSCoder) {}
    public convenience init?(coder: NSCoder) { return nil }
}
@available(iOS 16.0, *)
extension RoomCaptureScanModel: @preconcurrency RoomCaptureViewDelegate {
    public func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        if let error { report(error); return false }; return true
    }
    public func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        if let error { report(error); return }; room = processedResult; status = "Scan ready. Review labels and true north."
    }
}
@available(iOS 16.0, *)
private struct CaptureViewport: UIViewRepresentable {
    let view: RoomCaptureView
    func makeUIView(context: Context) -> RoomCaptureView { view }
    func updateUIView(_ uiView: RoomCaptureView, context: Context) {}
}

/// The host provides its authenticated service and owns queue/upload policy.
/// No credentials or automatic paid request is embedded in this scanning UI.
@available(iOS 16.0, *)
public struct RoomCaptureScanView: View {
    @StateObject private var model = RoomCaptureScanModel()
    @State private var label = "living"
    private let service: VastuService?
    private let replayData: Data?
    private let onReviewed: (VastuRoomCapture) -> Void
    public init(service: VastuService? = nil, replayData: Data? = nil, onReviewed: @escaping (VastuRoomCapture) -> Void) {
        self.service = service; self.replayData = replayData; self.onReviewed = onReviewed
    }
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Capture a room").font(.largeTitle.weight(.semibold))
                Text(model.status).accessibilityIdentifier("captureStatus")
                if let scan = model.view { CaptureViewport(view: scan).frame(height: 320) }
                if model.supported { Button("Start LiDAR scan") { model.start() }; Button("Finish scan") { model.finish() } }
                if let replayData { Button("Replay synthetic room") { attempt { try model.loadReplay(replayData) } }.accessibilityIdentifier("replayRoom") }
                if let accuracy = model.headingAccuracyDeg { Text("Compass accuracy: ±\(accuracy, specifier: "%.1f")°") }
                if let service { Button("Load API declination") { Task { do { try await model.resolveDeclination(service: service) } catch { model.report(error) } } } }
                if let degrees = model.declinationDeg {
                    if let magnetic = model.magneticHeadingDeg { Text("Phone-top heading from true north: \((magnetic + degrees + 360).truncatingRemainder(dividingBy: 360), specifier: "%.1f")°") }
                    Text("Magnetic → true correction: \(degrees, specifier: "%.2f")°")
                    Button("Confirm north direction") { attempt { try model.confirmNorth() } }.accessibilityIdentifier("confirmNorth")
                }
                if model.room != nil {
                    Picker("Room type", selection: $label) { ForEach(RoomPlanAdapter.roomTypes, id: \.self) { Text($0).tag($0) } }.pickerStyle(.menu)
                    Text("This outline is the scanned room's perimeter. The review covers this room.").font(.footnote)
                    Button("Confirm label and perimeter") { attempt { onReviewed(try model.reviewedCapture(label: label)) } }
                        .disabled(model.north == nil).accessibilityIdentifier("confirmRoom")
                }
            }.padding(24).frame(maxWidth: 700, alignment: .leading).frame(maxWidth: .infinity)
        }.background(Color(red: 0.98, green: 0.98, blue: 0.97)).foregroundStyle(Color.primary)
            .preferredColorScheme(.light).onDisappear { model.stop() }
    }
    private func attempt(_ work: () throws -> Void) { do { try work() } catch { model.report(error) } }
}
#endif
