import CoreFoundation
import CryptoKit
import Foundation
import VedikaSDK

public enum NativeAttestationError: Error { case invalidJSON, unsafeNumber, invalidChallenge, unsupported, expired, emptyProof }

/// RFC 8785 ordering and escaping. No Unicode normalization is applied.
public enum AttestationCanonicalJSON {
    public static func encode(_ value: Any) throws -> String {
        if value is NSNull { return "null" }
        if let value = value as? String { return quote(value) }
        if let number = value as? NSNumber {
            if CFGetTypeID(number) == CFBooleanGetTypeID() { return number.boolValue ? "true" : "false" }
            let x = number.doubleValue
            guard x.isFinite else { throw NativeAttestationError.unsafeNumber }
            let kind = String(cString: number.objCType)
            if !["d", "f"].contains(kind), abs(x) > 9_007_199_254_740_991 { throw NativeAttestationError.unsafeNumber }
            return esNumber(x)
        }
        if let array = value as? [Any] { return "[" + (try array.map(encode)).joined(separator: ",") + "]" }
        if let object = value as? [String: Any] {
            let keys = object.keys.sorted { $0.utf16.lexicographicallyPrecedes($1.utf16) }
            return "{" + (try keys.map { quote($0) + ":" + (try encode(object[$0]!)) }).joined(separator: ",") + "}"
        }
        throw NativeAttestationError.invalidJSON
    }

    private static func quote(_ value: String) -> String {
        var out = "\""
        for scalar in value.unicodeScalars {
            switch scalar.value {
            case 34: out += "\\\""
            case 92: out += "\\\\"
            case 8: out += "\\b"
            case 9: out += "\\t"
            case 10: out += "\\n"
            case 12: out += "\\f"
            case 13: out += "\\r"
            case 0..<32: out += String(format: "\\u%04x", scalar.value)
            default: out.unicodeScalars.append(scalar)
            }
        }
        return out + "\""
    }

    private static func esNumber(_ x: Double) -> String {
        if x == 0 { return "0" }
        let parts = String(abs(x)).lowercased().split(separator: "e")
        let mantissa = String(parts[0]); let exponent = parts.count > 1 ? Int(parts[1])! : 0
        let dot = mantissa.firstIndex(of: ".").map { mantissa.distance(from: mantissa.startIndex, to: $0) } ?? mantissa.count
        var digits = mantissa.replacingOccurrences(of: ".", with: "")
        var n = dot + exponent
        while digits.first == "0" { digits.removeFirst(); n -= 1 }
        while digits.count > 1, digits.last == "0" { digits.removeLast() }
        let k = digits.count; let body: String
        if k <= n && n <= 21 { body = digits + String(repeating: "0", count: n - k) }
        else if n > 0 && n <= 21 { let i = digits.index(digits.startIndex, offsetBy: n); body = digits[..<i] + "." + digits[i...] }
        else if n > -6 && n <= 0 { body = "0." + String(repeating: "0", count: -n) + digits }
        else {
            let fraction = k > 1 ? "." + String(digits.dropFirst()) : ""
            let sign = n - 1 >= 0 ? "+" : "-"
            body = String(digits.prefix(1)) + fraction + "e" + sign + String(abs(n - 1))
        }
        return (x < 0 ? "-" : "") + body
    }
}

public struct NativeAttestationChallenge: Sendable {
    public let value: String
    public let expiresAt: Date
    public let platform: String
    public init(value: String, expiresAt: Date, platform: String) throws {
        guard ["ios", "android"].contains(platform), !value.isEmpty,
              value.utf8.allSatisfy({ (65...90).contains($0) || (97...122).contains($0) || (48...57).contains($0) || $0 == 45 || $0 == 95 }) else {
            throw NativeAttestationError.invalidChallenge
        }
        self.value = value; self.expiresAt = expiresAt; self.platform = platform
    }
    public func check(now: Date = Date()) throws { guard now < expiresAt else { throw NativeAttestationError.expired } }
}

public enum NativeAttestation {
    public static func digest(operation: String, challenge: NativeAttestationChallenge,
                              body: [String: Any], now: Date = Date()) throws -> Data {
        try challenge.check(now: now)
        guard ["ar/room-capture", "ar/scan-quality", "scans/save"].contains(operation) else { throw NativeAttestationError.invalidJSON }
        var unsigned = body; unsigned.removeValue(forKey: "deviceAttestation")
        let canonical = try AttestationCanonicalJSON.encode(unsigned)
        return Data(SHA256.hash(data: Data("vedika-attest-v1\n\(operation)\n\(challenge.value)\n\(canonical)".utf8)))
    }
    public static func playRequestHash(_ digest: Data) -> String {
        digest.base64EncodedString().replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "=", with: "")
    }
    public static func challenge(service: VastuService, platform: String) async throws -> NativeAttestationChallenge {
        guard ["ios", "android"].contains(platform) else { throw NativeAttestationError.invalidChallenge }
        let response = try await service.vastuOperation(VastuContracts.arAttestationChallenge, request: VastuArAttestationChallengeRequest(platform: platform))
        guard let value = response.data.challenge, let expiry = response.data.expiresAtEpoch,
              response.data.raw["singleUse"] as? Bool == true else { throw NativeAttestationError.invalidChallenge }
        let result = try NativeAttestationChallenge(value: value, expiresAt: Date(timeIntervalSince1970: Double(expiry)), platform: platform)
        try result.check(); return result
    }
}

#if os(iOS) && canImport(DeviceCheck)
import DeviceCheck

/// Persist keyId in the buyer app's Keychain. Enrollment state changes only
/// after a successful SERVER verification, never after Apple's callback alone.
@available(iOS 14.0, *)
public enum AppAttestCaptureProof {
    public static func generateKey() async throws -> String {
        guard DCAppAttestService.shared.isSupported else { throw NativeAttestationError.unsupported }
        return try await withCheckedThrowingContinuation { continuation in
            DCAppAttestService.shared.generateKey { key, error in
                if let error { continuation.resume(throwing: error) }
                else if let key { continuation.resume(returning: key) }
                else { continuation.resume(throwing: NativeAttestationError.emptyProof) }
            }
        }
    }
    public static func proof(keyId: String, enrolled: Bool, operation: String,
                             challenge: NativeAttestationChallenge, body: [String: Any]) async throws -> VastuDeviceAttestation {
        guard challenge.platform == "ios", DCAppAttestService.shared.isSupported else { throw NativeAttestationError.unsupported }
        let digest = try NativeAttestation.digest(operation: operation, challenge: challenge, body: body)
        let bytes: Data = try await withCheckedThrowingContinuation { continuation in
            let completion: @Sendable (Data?, Error?) -> Void = { data, error in
                if let error { continuation.resume(throwing: error) }
                else if let data, !data.isEmpty { continuation.resume(returning: data) }
                else { continuation.resume(throwing: NativeAttestationError.emptyProof) }
            }
            if enrolled { DCAppAttestService.shared.generateAssertion(keyId, clientDataHash: digest, completionHandler: completion) }
            else { DCAppAttestService.shared.attestKey(keyId, clientDataHash: digest, completionHandler: completion) }
        }
        try challenge.check()
        return VastuDeviceAttestation(platform: "ios", challenge: challenge.value, keyId: keyId,
            attestationObject: enrolled ? nil : bytes.base64EncodedString(), assertion: enrolled ? bytes.base64EncodedString() : nil)
    }
}
#endif
