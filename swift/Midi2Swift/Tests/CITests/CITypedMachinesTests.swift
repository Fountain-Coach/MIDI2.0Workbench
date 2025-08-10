import XCTest
@testable import CI

final class CITypedMachinesTests: XCTestCase {
    func testAllFromVectors() throws {
        let url = try locateVectors().appendingPathComponent("ci_statechart.json")
        let data = try Data(contentsOf: url)
        let arr = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]

        for test in arr {
            let name = (test["machine"] as? String) ?? ""
            let seq = (test["sequence"] as? [String]) ?? []
            let expect = (test["expect"] as? String)?.lowercased() ?? "completed"

            if name.contains("InquiryMIDIMessageReport") || seq.contains(where: { $0.lowercased().contains("replybegin") || $0.lowercased().contains("replyend") }) {
                // Report begin/end
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
                switch expect {
                case "completed": XCTAssertEqual(st.status, .completed, name)
                case "failed": XCTAssertEqual(st.status, .failed, name)
                default: XCTFail("Unknown expectation: \(expect)")
                }
                continue
            }

            if seq == ["Notify"] || name.contains("Notify") || name.contains("ReportMessage") || name.contains("NAK") || name.contains("ACK") {
                // Notify-only
                var st = CINotifyState()
                for _ in seq { (st, _) = reduceNotify(st, .notify) }
                XCTAssertEqual(st.status, .completed, name)
                continue
            }

            if seq.contains("ReplyChunk") {
                // Chunked reply
                var st = CIChunkState(.idle)
                for evStr in seq {
                    let ev: CIChunkEvent = {
                        switch evStr.lowercased() {
                        case "start": return .start
                        case "replychunk": return .replyChunk
                        case "reply": return .reply
                        case "timeout": return .timeout
                        case "error": return .error
                        default: return .error
                        }
                    }()
                    (st, _) = reduceChunked(st, ev)
                }
                switch expect {
                case "completed": XCTAssertEqual(st.status, .completed, name)
                case "failed": XCTAssertEqual(st.status, .failed, name)
                default: XCTFail("Unknown expectation: \(expect)")
                }
                continue
            }

            // Default: simple subscription (Start/Reply or Start/Timeout)
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
            switch expect {
            case "completed": XCTAssertEqual(st.status, .completed, name)
            case "failed": XCTAssertEqual(st.status, .failed, name)
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
