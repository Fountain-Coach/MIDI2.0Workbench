import Foundation

// MIDI Message Report (Begin/End)
public enum CIReportEvent: Equatable { case start, replyBegin, replyEnd, timeout, error }
public enum CIReportStatus: Equatable { case idle, requestSent, streaming, completed, failed }
public struct CIReportState: Equatable { public var status: CIReportStatus; public init(_ s: CIReportStatus = .idle) { status = s } }

@discardableResult
public func reduceReport(_ state: CIReportState, _ event: CIReportEvent) -> (CIReportState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start): s.status = .requestSent; return (s, [.none])
    case (.requestSent, .replyBegin): s.status = .streaming; return (s, [.none])
    case (.streaming, .replyEnd): s.status = .completed; return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error), (.streaming, .timeout), (.streaming, .error): s.status = .failed; return (s, [.none])
    default: return (s, [.none])
    }
}

// Subscription (simple request/reply)
public enum CISubEvent: Equatable { case start, reply, timeout, error }
public enum CISubStatus: Equatable { case idle, requestSent, completed, failed }
public struct CISubState: Equatable { public var status: CISubStatus; public init(_ s: CISubStatus = .idle) { status = s } }

@discardableResult
public func reduceSubscription(_ state: CISubState, _ event: CISubEvent) -> (CISubState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start): s.status = .requestSent; return (s, [.none])
    case (.requestSent, .reply): s.status = .completed; return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error): s.status = .failed; return (s, [.none])
    default: return (s, [.none])
    }
}
