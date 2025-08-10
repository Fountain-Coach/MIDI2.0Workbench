import XCTest
@testable import CI

final class CIStateMachineTests: XCTestCase {
    func testSequencesFromVectors() throws {
        let url = try locateVectors().appendingPathComponent("ci_statechart.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for test in arr {
            let seq = test["sequence"] as! [String]
            let expect = (test["expect"] as! String).lowercased()
            var st = CIState(status: .idle)
            for evStr in seq {
                let ev: CIEvent = {
                    switch evStr.lowercased() {
                    case "start": return .start
                    case "reply": return .reply
                    case "timeout": return .timeout
                    case "error": return .error
                    case "notify": return .notify
                    default: return .notify
                    }
                }()
                (st, _) = reduce(st, ev)
            }
            switch expect {
            case "completed": XCTAssertEqual(st.status, .completed)
            case "failed": XCTAssertEqual(st.status, .failed)
            default: XCTFail("Unknown expectation: \(expect)")
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
}

