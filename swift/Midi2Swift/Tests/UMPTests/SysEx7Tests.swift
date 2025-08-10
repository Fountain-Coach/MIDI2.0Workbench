import XCTest
@testable import UMP

final class SysEx7Tests: XCTestCase {
    func testSysExCompleteVector() throws {
        let url = try locateVectors().appendingPathComponent("ump_sysex.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        guard let first = arr.first else { return }
        let d = first["decoded"] as! [String: Any]
        let group = UInt8(d["group"] as! Int)
        let bc = UInt8(d["byteCount"] as! Int)
        let b1 = UInt8(d["Byte1"] as! Int)
        let b2 = UInt8(d["Byte2"] as! Int)
        let b3 = UInt8(d["Byte3"] as! Int)
        let b4 = UInt8(d["Byte4"] as! Int)
        let b5 = UInt8(d["Byte5"] as! Int)
        let b6 = UInt8(d["Byte6"] as! Int)
        let msg = SysEx7Complete(group: group, byteCount: bc, bytes: (b1,b2,b3,b4,b5,b6))
        let raw = msg.encode().raw
        let rawHex = first["raw"] as! String
        let expected = UInt64(strtoul(rawHex.replacingOccurrences(of: "0x", with: ""), nil, 16))
        XCTAssertEqual(raw, expected)
        let round = SysEx7Complete.decode(.init(raw: raw))
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

