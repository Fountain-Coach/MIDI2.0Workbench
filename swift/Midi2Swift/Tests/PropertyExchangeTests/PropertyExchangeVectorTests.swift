import XCTest
@testable import PropertyExchange

final class PropertyExchangeVectorTests: XCTestCase {
    func testPEVectors() throws {
        let url = try locateVectors().appendingPathComponent("profiles_pe.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for test in arr {
            let machine = (test["machine"] as! String).lowercased()
            let seq = test["sequence"] as! [String]
            let expect = (test["expect"] as! String).lowercased()
            if machine == "inquirygetpropertydata" {
                var st = PEGetState(.idle)
                for evStr in seq {
                    let ev: PEGetEvent = {
                        switch evStr.lowercased() {
                        case "start": return .start
                        case "replychunk": return .replyChunk
                        case "reply": return .reply
                        case "timeout": return .timeout
                        case "error": return .error
                        default: return .error
                        }
                    }()
                    (st, _) = reducePEGet(st, ev)
                }
                switch expect {
                case "completed": XCTAssertEqual(st.status, .completed)
                case "failed": XCTAssertEqual(st.status, .failed)
                default: XCTFail("Unknown expectation: \(expect)")
                }
            } else if machine == "inquirysetpropertydata" {
                var st = PESetState(.idle)
                for evStr in seq {
                    let ev: PESetEvent = {
                        switch evStr.lowercased() {
                        case "start": return .start
                        case "replychunk": return .replyChunk
                        case "reply": return .reply
                        case "timeout": return .timeout
                        case "error": return .error
                        default: return .error
                        }
                    }()
                    (st, _) = reducePESet(st, ev)
                }
                switch expect {
                case "completed": XCTAssertEqual(st.status, .completed)
                case "failed": XCTAssertEqual(st.status, .failed)
                default: XCTFail("Unknown expectation: \(expect)")
                }
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
}
