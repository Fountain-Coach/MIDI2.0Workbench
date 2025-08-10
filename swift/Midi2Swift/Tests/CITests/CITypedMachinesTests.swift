import XCTest
@testable import CI

final class CITypedMachinesTests: XCTestCase {
    func testReportAndSubscription() throws {
        let url = try locateVectors().appendingPathComponent("ci_statechart.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]

        // MIDI Message Report
        for test in arr where (test["machine"] as? String)?.contains("InquiryMIDIMessageReport") == true {
            let seq = test["sequence"] as! [String]
            var st = CIReportState(.idle)
            for evStr in seq {
                let ev: CIReportEvent = {
                    switch evStr.lowercased() {
                    case "start": return .start
                    case "replybegin": return .replyBegin
                    case "replyend": return .replyEnd
                    case "timeout": return .timeout
                    case "error": return .error
                    default: return .error
                    }
                }()
                (st, _) = reduceReport(st, ev)
            }
            let expect = (test["expect"] as! String).lowercased()
            switch expect {
            case "completed": XCTAssertEqual(st.status, .completed)
            case "failed": XCTAssertEqual(st.status, .failed)
            default: XCTFail("Unknown expectation: \(expect)")
            }
        }

        // Subscription (simple request/reply)
        for test in arr where (test["machine"] as? String)?.hasSuffix("Subscription") == true {
            let seq = test["sequence"] as! [String]
            var st = CISubState(.idle)
            for evStr in seq {
                let ev: CISubEvent = {
                    switch evStr.lowercased() {
                    case "start": return .start
                    case "reply": return .reply
                    case "timeout": return .timeout
                    case "error": return .error
                    default: return .error
                    }
                }()
                (st, _) = reduceSubscription(st, ev)
            }
            let expect = (test["expect"] as! String).lowercased()
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
