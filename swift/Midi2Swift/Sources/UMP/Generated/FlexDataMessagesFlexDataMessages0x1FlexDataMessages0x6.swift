import Foundation
import Core

/// FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x6 (UMP128)
/// Source: libs/messageTypes.js:68
public struct FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6: Equatable {
    public var channel: UInt8
    public var group: UInt8
    public var form: UInt8
    public init(channel: UInt8, group: UInt8, form: UInt8) {
        precondition(channel <= 15)
        precondition(group <= 15)
        precondition(form <= 3)
        self.channel = channel
        self.group = group
        self.form = form
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(channel: UInt8, group: UInt8, formEnum: Form) {
        precondition(channel <= 15)
        precondition(group <= 15)
        self.form = formEnum.rawValue
        self.channel = channel
        self.group = group
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 13, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(channel), offset: 4, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(group), offset: 8, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(form), offset: 12, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 1, offset: 16, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 6, offset: 24, width: 8); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 13 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 16, width: 8) != 1 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 24, width: 8) != 6 { return nil }
        let channel = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
        let group = UInt8(getBits128(ump.lo, ump.hi, offset: 8, width: 4))
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 2))
        return FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(channel: channel, group: group, form: form)
    }
}
