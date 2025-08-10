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

// Chunked reply (optional chunks before final reply)
public enum CIChunkEvent: Equatable { case start, replyChunk, reply, timeout, error }
public enum CIChunkStatus: Equatable { case idle, requestSent, chunking, completed, failed }
public struct CIChunkState: Equatable { public var status: CIChunkStatus; public init(_ s: CIChunkStatus = .idle) { status = s } }

@discardableResult
public func reduceChunked(_ state: CIChunkState, _ event: CIChunkEvent) -> (CIChunkState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start): s.status = .requestSent; return (s, [.none])
    case (.requestSent, .replyChunk): s.status = .chunking; return (s, [.none])
    case (.chunking, .replyChunk): return (s, [.none])
    case (.requestSent, .reply), (.chunking, .reply): s.status = .completed; return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error), (.chunking, .timeout), (.chunking, .error): s.status = .failed; return (s, [.none])
    default: return (s, [.none])
    }
}

// Notify-only (single notify transitions to completed)
public enum CINotifyEvent: Equatable { case notify }
public enum CINotifyStatus: Equatable { case completed }
public struct CINotifyState: Equatable { public var status: CINotifyStatus = .completed; public init() {} }

@discardableResult
public func reduceNotify(_ state: CINotifyState, _ event: CINotifyEvent) -> (CINotifyState, [CIAffect]) {
    // stateless; always completed
    return (state, [.none])
}
