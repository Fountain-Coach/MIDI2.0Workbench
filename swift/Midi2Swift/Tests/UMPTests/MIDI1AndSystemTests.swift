import XCTest
@testable import UMP

final class MIDI1AndSystemTests: XCTestCase {
    func testProgramChangeVector() throws {
        let url = try locateVectors().appendingPathComponent("ump_utility.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        guard let first = arr.first else { return }
        let decoded = first["decoded"] as! [String: Any]
        let group = UInt8(decoded["group"] as! Int)
        let channel = UInt8(decoded["channel"] as! Int)
        let program = UInt8(decoded["program"] as! Int)
        let msg = M1ProgramChange(group: group, channel: channel, program: program)
        let raw = msg.encode().raw
        let rawHex = first["raw"] as! String
        let expected = UInt32(strtoul(rawHex.replacingOccurrences(of: "0x", with: ""), nil, 16))
        XCTAssertEqual(raw, expected)
        let round = M1ProgramChange.decode(.init(raw: raw))
        XCTAssertEqual(round, msg)
    }

    func testSystemMTCVector() throws {
        let url = try locateVectors().appendingPathComponent("ump_system.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        guard let first = arr.first else { return }
        let decoded = first["decoded"] as! [String: Any]
        let group = UInt8(decoded["group"] as! Int)
        let payload = UInt8(decoded["nnndddd"] as? Int ?? 0)
        let msg = SysMTCQuarterFrame(group: group, nnndddd: payload)
        let raw = msg.encode().raw
        let rawHex = first["raw"] as! String
        let expected = UInt32(strtoul(rawHex.replacingOccurrences(of: "0x", with: ""), nil, 16))
        XCTAssertEqual(raw, expected)
        let round = SysMTCQuarterFrame.decode(.init(raw: raw))
        XCTAssertEqual(round, msg)
    }

    private func locateVectors() throws -> URL {
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() }
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        let vectors = repoRoot.appendingPathComponent("vectors/golden")
        return vectors
    }
}

