import Foundation

public enum CIEvent: Equatable {
    case start
    case reply
    case timeout
    case error
    case notify
}

public enum CIStatus: Equatable {
    case idle
    case requestSent
    case completed
    case failed
}

public struct CIAffect: Equatable {
    public static let none = CIAffect()
}

public struct CIState: Equatable {
    public var status: CIStatus
    public init(status: CIStatus = .idle) { self.status = status }
}

@discardableResult
public func reduce(_ state: CIState, _ event: CIEvent) -> (CIState, [CIAffect]) {
    var s = state
    switch (s.status, event) {
    case (.idle, .start):
        s.status = .requestSent
        return (s, [.none])
    case (.requestSent, .reply):
        s.status = .completed
        return (s, [.none])
    case (.requestSent, .timeout), (.requestSent, .error):
        s.status = .failed
        return (s, [.none])
    case (.idle, .notify):
        s.status = .completed
        return (s, [.none])
    default:
        return (s, [.none])
    }
}

