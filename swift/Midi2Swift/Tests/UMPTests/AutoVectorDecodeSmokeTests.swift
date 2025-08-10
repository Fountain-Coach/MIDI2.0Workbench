import XCTest
@testable import UMP

final class AutoVectorDecodeSmokeTests: XCTestCase {
    func testDecodeSelectedTypesFromAutoVectors() throws {
        let url = try locateVectors().appendingPathComponent("auto_vectors.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        let groups = Dictionary(grouping: arr, by: { $0["name"] as! String })

        // UMP32
        try decode32(groups, name: "Utility Messages.JR Clock") { raw in
            XCTAssertNotNil(UtilityMessagesJRClock.decode(.init(raw: raw)))
        }
        try decode32(groups, name: "System Real Time and System Common Messages.Timing Clock") { raw in
            XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesTimingClock.decode(.init(raw: raw)))
        }
        try decode32(groups, name: "MIDI 1.0 Channel Voice Messages.Pitch Bend") { raw in
            XCTAssertNotNil(MIDI10ChannelVoiceMessagesPitchBend.decode(.init(raw: raw)))
        }

        // UMP64
        try decode64(groups, name: "MIDI 2.0 Channel Voice Messages.Control Change Message") { raw in
            XCTAssertNotNil(MIDI20ChannelVoiceMessagesControlChangeMessage.decode(.init(raw: raw)))
        }
        try decode64(groups, name: "SysEx.System Exclusive End Packet") { raw in
            XCTAssertNotNil(SysExSystemExclusiveEndPacket.decode(.init(raw: raw)))
        }
        try decode64(groups, name: "SysEx8 and MDS.System Exclusive 8 Start Packet") { raw in
            XCTAssertNotNil(SysEx8andMDSSystemExclusive8StartPacket.decode(.init(raw: raw)))
        }

        // UMP128
        try decode128(groups, name: "MIDI Endpoint.MIDI Endpoint Info Notify") { lo, hi in
            XCTAssertNotNil(MIDIEndpointMIDIEndpointInfoNotify.decode(.init(lo: lo, hi: hi)))
        }
    }

    private func locateVectors() throws -> URL {
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() }
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        let vectors = repoRoot.appendingPathComponent("vectors/golden")
        return vectors
    }

    private func decode32(_ groups: [String: [[String: Any]]], name: String, _ body: (UInt32) -> Void) throws {
        guard let vectors = groups[name] else { throw XCTSkip("No vectors for \(name)") }
        for v in vectors.prefix(2) { // sample a couple
            let rawHex = v["raw"] as! String
            let raw = parseHex32(rawHex)
            body(raw)
        }
    }

    private func decode64(_ groups: [String: [[String: Any]]], name: String, _ body: (UInt64) -> Void) throws {
        guard let vectors = groups[name] else { throw XCTSkip("No vectors for \(name)") }
        for v in vectors.prefix(2) {
            let rawHex = v["raw"] as! String
            let raw = parseHex64(rawHex)
            body(raw)
        }
    }

    private func decode128(_ groups: [String: [[String: Any]]], name: String, _ body: (UInt64, UInt64) -> Void) throws {
        guard let vectors = groups[name] else { throw XCTSkip("No vectors for \(name)") }
        for v in vectors.prefix(2) {
            let rawHex = v["raw"] as! String
            let (lo, hi) = parseHex128(rawHex)
            body(lo, hi)
        }
    }

    private func parseHex32(_ s: String) -> UInt32 {
        let clean = s.replacingOccurrences(of: "0x", with: "")
        return UInt32(strtoul(clean, nil, 16))
    }
    private func parseHex64(_ s: String) -> UInt64 {
        let clean = s.replacingOccurrences(of: "0x", with: "")
        return strtoull(clean, nil, 16)
    }
    private func parseHex128(_ s: String) -> (UInt64, UInt64) {
        let clean = s.replacingOccurrences(of: "0x", with: "").uppercased()
        let padded = String(repeating: "0", count: max(0, 32 - clean.count)) + clean
        let hiStr = String(padded.prefix(padded.count - 16))
        let loStr = String(padded.suffix(16))
        let lo = strtoull(loStr, nil, 16)
        let hi = strtoull(hiStr, nil, 16)
        return (lo, hi)
    }
}

