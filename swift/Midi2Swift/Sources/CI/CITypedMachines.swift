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

// Property Exchange Get (chunked)
public enum CIPEGetEvent: Equatable { case start, replyChunk, reply /*end*/, timeout, error }
public enum CIPEGetStatus: Equatable { case idle, requestSent, chunking, completed, failed }
public struct CIPEGetState: Equatable { public var status: CIPEGetStatus; public var chunks: Int; public init(_ s: CIPEGetStatus = .idle, chunks: Int = 0) { status = s; self.chunks = chunks } }

@discardableResult
public func reducePEGet(_ state: CIPEGetState, _ event: CIPEGetEvent) -> (CIPEGetState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start): s.status = .requestSent; return (s, [.none])
    case (.requestSent, .replyChunk): s.status = .chunking; s.chunks += 1; return (s, [.none])
    case (.chunking, .replyChunk): s.chunks += 1; return (s, [.none])
    case (.chunking, .reply), (.requestSent, .reply): s.status = .completed; return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error), (.chunking, .timeout), (.chunking, .error): s.status = .failed; return (s, [.none])
    default: return (s, [.none])
    }
}

// Property Exchange Set (chunked)
public enum CIPESetEvent: Equatable { case start, replyChunk, reply /*end*/, timeout, error }
public enum CIPESetStatus: Equatable { case idle, requestSent, chunking, completed, failed }
public struct CIPESetState: Equatable { public var status: CIPESetStatus; public var chunks: Int; public init(_ s: CIPESetStatus = .idle, chunks: Int = 0) { status = s; self.chunks = chunks } }

@discardableResult
public func reducePESet(_ state: CIPESetState, _ event: CIPESetEvent) -> (CIPESetState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start): s.status = .requestSent; return (s, [.none])
    case (.requestSent, .replyChunk): s.status = .chunking; s.chunks += 1; return (s, [.none])
    case (.chunking, .replyChunk): s.chunks += 1; return (s, [.none])
    case (.chunking, .reply), (.requestSent, .reply): s.status = .completed; return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error), (.chunking, .timeout), (.chunking, .error): s.status = .failed; return (s, [.none])
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
