import Foundation
import CI

// Property Exchange Get (chunked)
public enum PEGetEvent: Equatable { case start, replyChunk, reply /*end*/, timeout, error }
public enum PEGetStatus: Equatable { case idle, requestSent, chunking, completed, failed }
public struct PEGetState: Equatable {
    public var status: PEGetStatus
    public var chunks: Int
    public init(_ s: PEGetStatus = .idle, chunks: Int = 0) { self.status = s; self.chunks = chunks }
}

@discardableResult
public func reducePEGet(_ state: PEGetState, _ event: PEGetEvent) -> (PEGetState, [CIAffect]) {
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
public enum PESetEvent: Equatable { case start, replyChunk, reply /*end*/, timeout, error }
public enum PESetStatus: Equatable { case idle, requestSent, chunking, completed, failed }
public struct PESetState: Equatable {
    public var status: PESetStatus
    public var chunks: Int
    public init(_ s: PESetStatus = .idle, chunks: Int = 0) { self.status = s; self.chunks = chunks }
}

@discardableResult
public func reducePESet(_ state: PESetState, _ event: PESetEvent) -> (PESetState, [CIAffect]) {
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
