import Foundation
import Core

/// SystemRealTimeandSystemCommonMessages.Continue (UMP32)
/// Source: libs/messageTypes.js:68
public struct SystemRealTimeandSystemCommonMessagesContinue: Equatable {
    public var group: UInt8
    public init(group: UInt8) {
        precondition(group <= 15)
        self.group = group
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(1), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(251), offset: 8, width: 8)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> SystemRealTimeandSystemCommonMessagesContinue? {
        if getBits32(ump.raw, offset: 0, width: 4) != 1 { return nil }
        if getBits32(ump.raw, offset: 8, width: 8) != 251 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        return SystemRealTimeandSystemCommonMessagesContinue(group: group)
    }
}
