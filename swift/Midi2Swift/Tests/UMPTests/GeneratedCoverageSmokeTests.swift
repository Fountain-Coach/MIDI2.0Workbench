import XCTest
@testable import UMP

final class GeneratedCoverageSmokeTests: XCTestCase {
    func testAutoVectorsForSelectedGeneratedTypes() throws {
        let url = try locateVectors().appendingPathComponent("auto_vectors.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]

        // Group vectors by name for quick lookup
        let groups = Dictionary(grouping: arr, by: { $0["name"] as! String })

        // MIDI 1.0 CV Note On (UMP32)
        if let vectors = groups["MIDI 1.0 Channel Voice Messages.Note On"] {
            for v in vectors.prefix(2) { // sample
                let rawHex = v["raw"] as! String
                let raw = parseHex32(rawHex)
                let decoded = v["decoded"] as! [String: Any]
                let msg = MIDI10ChannelVoiceMessagesNoteOn(
                    group: UInt8(decoded["group"] as! Int),
                    channel: UInt8(decoded["channel"] as! Int),
                    notenumber: UInt8(decoded["noteNumber"] as! Int),
                    velocity: UInt8(decoded["value"] as? Int ?? decoded["velocity"] as? Int ?? 0)
                )
                XCTAssertEqual(msg.encode().raw, raw)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesNoteOn.decode(.init(raw: raw)))
            }
        }

        // MIDI 2.0 CV Note On (UMP64)
        if let vectors = groups["MIDI 2.0 Channel Voice Messages.Note On"] {
            for v in vectors.prefix(2) {
                let rawHex = v["raw"] as! String
                let raw = parseHex64(rawHex)
                let d = v["decoded"] as! [String: Any]
                let msg = MIDI20ChannelVoiceMessagesNoteOn(
                    group: UInt8(d["group"] as! Int),
                    channel: UInt8(d["channel"] as! Int),
                    notenumber: UInt8(d["noteNumber"] as! Int),
                    attributetype: UInt8(d["attributeType"] as! Int),
                    velocity: UInt16(d["velocity"] as! Int),
                    attribute: UInt16(d["attribute"] as! Int)
                )
                XCTAssertEqual(msg.encode().raw, raw)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesNoteOn.decode(.init(raw: raw)))
            }
        }

        // SysEx7 Complete (UMP64) using targeted sysex vector
        do {
            let syx = try locateVectors().appendingPathComponent("ump_sysex.json")
            let sdata = try Data(contentsOf: syx)
            let sarr = try JSONSerialization.jsonObject(with: sdata) as! [[String: Any]]
            if let first = sarr.first {
                let rawHex = first["raw"] as! String
                let raw = parseHex64(rawHex)
                XCTAssertNotNil(SysExCompleteSystemExclusiveMessageinOnePacket.decode(.init(raw: raw)))
            }
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

    private func parseHex32(_ s: String) -> UInt32 {
        let clean = s.replacingOccurrences(of: "0x", with: "")
        return UInt32(strtoul(clean, nil, 16))
    }
    private func parseHex64(_ s: String) -> UInt64 {
        let clean = s.replacingOccurrences(of: "0x", with: "")
        return UInt64(strtoul(clean, nil, 16))
    }
}

