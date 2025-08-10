import XCTest
@testable import UMP

final class StreamAndData128Tests: XCTestCase {
    func testStreamMessages() throws {
        let url = try locateVectors().appendingPathComponent("ump_utility_stream.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for test in arr {
            let name = test["name"] as! String
            let rawHex = test["raw"] as! String
            let decoded = test["decoded"] as! [String: Any]
            switch name {
            case "MIDIEndpoint.StreamConfigurationRequest":
                let form = UInt8(decoded["form"] as! Int)
                let proto = UInt8(decoded["protocol"] as! Int)
                let msg = MIDIEndpointStreamConfigurationRequest(form: form, _protocol: proto)
                let raw = msg.encode()
                let (lo, hi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, lo)
                XCTAssertEqual(raw.hi, hi)
                XCTAssertNotNil(MIDIEndpointStreamConfigurationRequest.decode(raw))
            case "MIDIEndpoint.StartofSequenceMessage":
                let form = UInt8(decoded["form"] as! Int)
                let msg = MIDIEndpointStartofSequenceMessage(form: form)
                let raw = msg.encode()
                let (lo, hi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, lo)
                XCTAssertEqual(raw.hi, hi)
                XCTAssertNotNil(MIDIEndpointStartofSequenceMessage.decode(raw))
            default:
                XCTFail("Unknown stream message: \(name)")
            }
        }
    }

    func testData128Messages() throws {
        let url = try locateVectors().appendingPathComponent("ump_sysex8.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for test in arr {
            let name = test["name"] as! String
            let rawHex = test["raw"] as! String
            let decoded = test["decoded"] as! [String: Any]
            switch name {
            case "SysEx8andMDS.MixedDataSetHeader":
                let group = UInt8(decoded["group"] as! Int)
                let bytecount = UInt8(decoded["bytecount"] as! Int)
                let mdsid = UInt8(decoded["mdsid"] as! Int)
                let valid = UInt8(decoded["numberofvalidbytesinthismessagechunk"] as! Int)
                let total = UInt16(decoded["numberofchunksinmixeddataset"] as! Int)
                let thischunk = UInt16(decoded["numberofthischunk"] as! Int)
                let manufacturerid = UInt16(decoded["manufacturerid"] as! Int)
                let deviceid = UInt16(decoded["deviceid"] as! Int)
                let subid1 = UInt16(decoded["subid1"] as! Int)
                let subid2 = UInt16(decoded["subid2"] as! Int)
                let msg = SysEx8andMDSMixedDataSetHeader(
                    group: group,
                    bytecount: bytecount,
                    mdsid: mdsid,
                    numberofvalidbytesinthismessagechunk: valid,
                    numberofchunksinmixeddataset: total,
                    numberofthischunk: thischunk,
                    manufacturerid: manufacturerid,
                    deviceid: deviceid,
                    subid1: subid1,
                    subid2: subid2)
                let raw = msg.encode()
                let (lo, hi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, lo)
                XCTAssertEqual(raw.hi, hi)
                XCTAssertNotNil(SysEx8andMDSMixedDataSetHeader.decode(raw))
            default:
                XCTFail("Unknown data128 message: \(name)")
            }
        }
    }

    private func locateVectors() throws -> URL {
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() }
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        return repoRoot.appendingPathComponent("vectors/golden")
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
