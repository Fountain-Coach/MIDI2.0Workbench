import Foundation
import Core

/// SystemRealTimeandSystemCommonMessages.Stop (UMP32)
/// Source: libs/messageTypes.js:68
public struct SystemRealTimeandSystemCommonMessagesStop: Equatable {
    public var group: UInt8
    public init(group: UInt8) {
        precondition(group <= 15)
        self.group = group
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(1), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(252), offset: 8, width: 8)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> SystemRealTimeandSystemCommonMessagesStop? {
        if getBits32(ump.raw, offset: 0, width: 4) != 1 { return nil }
        if getBits32(ump.raw, offset: 8, width: 8) != 252 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        return SystemRealTimeandSystemCommonMessagesStop(group: group)
    }
}
