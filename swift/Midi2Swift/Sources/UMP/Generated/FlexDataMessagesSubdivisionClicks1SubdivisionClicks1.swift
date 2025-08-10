import Foundation
import Core

/// FlexDataMessages.SubdivisionClicks1SubdivisionClicks1 (UMP128)
/// Source: libs/messageTypes.js:68
public struct FlexDataMessagesSubdivisionClicks1SubdivisionClicks1: Equatable {
    public var channel: UInt8
    public var group: UInt8
    public var form: UInt8
    public var subdivisionclicks1: UInt8
    public var subdivisionclicks2: UInt8
    public init(channel: UInt8, group: UInt8, form: UInt8, subdivisionclicks1: UInt8, subdivisionclicks2: UInt8) {
        precondition(channel <= 15)
        precondition(group <= 15)
        precondition(form <= 3)
        precondition(subdivisionclicks1 <= 255)
        precondition(subdivisionclicks2 <= 255)
        self.channel = channel
        self.group = group
        self.form = form
        self.subdivisionclicks1 = subdivisionclicks1
        self.subdivisionclicks2 = subdivisionclicks2
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(channel: UInt8, group: UInt8, formEnum: Form, subdivisionclicks1: UInt8, subdivisionclicks2: UInt8) {
        precondition(channel <= 15)
        precondition(group <= 15)
        precondition(subdivisionclicks1 <= 255)
        precondition(subdivisionclicks2 <= 255)
        self.form = formEnum.rawValue
        self.channel = channel
        self.group = group
        self.subdivisionclicks1 = subdivisionclicks1
        self.subdivisionclicks2 = subdivisionclicks2
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 13, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(channel), offset: 4, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(group), offset: 8, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(form), offset: 12, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 0, offset: 16, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 2, offset: 24, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(subdivisionclicks1), offset: 64, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(subdivisionclicks2), offset: 72, width: 8); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> FlexDataMessagesSubdivisionClicks1SubdivisionClicks1? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 13 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 16, width: 8) != 0 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 24, width: 8) != 2 { return nil }
        let channel = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
        let group = UInt8(getBits128(ump.lo, ump.hi, offset: 8, width: 4))
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 2))
        let subdivisionclicks1 = UInt8(getBits128(ump.lo, ump.hi, offset: 64, width: 8))
        let subdivisionclicks2 = UInt8(getBits128(ump.lo, ump.hi, offset: 72, width: 8))
        return FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(channel: channel, group: group, form: form, subdivisionclicks1: subdivisionclicks1, subdivisionclicks2: subdivisionclicks2)
    }
}
