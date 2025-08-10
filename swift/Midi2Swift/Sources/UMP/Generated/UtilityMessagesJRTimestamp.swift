import Foundation
import Core

/// UtilityMessages.JRTimestamp (UMP32)
/// Source: libs/messageTypes.js:68
public struct UtilityMessagesJRTimestamp: Equatable {
    public var group: UInt8
    public init(group: UInt8) {
        precondition(group <= 15)
        self.group = group
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(0), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(2), offset: 8, width: 4)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> UtilityMessagesJRTimestamp? {
        if getBits32(ump.raw, offset: 0, width: 4) != 0 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 2 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        return UtilityMessagesJRTimestamp(group: group)
    }
}
