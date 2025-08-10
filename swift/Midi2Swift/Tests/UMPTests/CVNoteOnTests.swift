import XCTest
@testable import UMP

final class CVNoteOnTests: XCTestCase {
    func testGoldenVectors() throws {
        let vectorsURL = try locateVectors().appendingPathComponent("ump_channel_voice.json")
        let data = try Data(contentsOf: vectorsURL)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for entry in arr {
            guard let decoded = entry["decoded"] as? [String: Any] else { continue }
            let group = UInt8(decoded["group"] as! Int)
            let channel = UInt8(decoded["channel"] as! Int)
            let noteNumber = UInt8(decoded["noteNumber"] as! Int)
            let attributeType = UInt8(decoded["attributeType"] as! Int)
            let velocity = UInt16(decoded["velocity"] as! Int)
            let attribute = UInt16(decoded["attribute"] as! Int)

            let msg = CVNoteOn(group: group, channel: channel, noteNumber: noteNumber, attributeType: attributeType, velocity: velocity, attribute: attribute)
            let raw = msg.encode().raw

            if let rawHex = entry["raw"] as? String {
                let expected = UInt64(strtoul(rawHex.replacingOccurrences(of: "0x", with: ""), nil, 16))
                XCTAssertEqual(raw, expected, "Case \(entry["case"] ?? "?")")
            }

            // decode round-trip
            let dec = CVNoteOn.decode(.init(raw: raw))
            XCTAssertNotNil(dec)
            XCTAssertEqual(dec, msg)
        }
    }

    private func locateVectors() throws -> URL {
        // This test file path: .../swift/Midi2Swift/Tests/UMPTests/CVNoteOnTests.swift
        // Repo root is two levels up from package dir
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() } // remove /Tests/UMPTests/CVNoteOnTests.swift
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        let vectors = repoRoot.appendingPathComponent("vectors/golden")
        return vectors
    }
}

