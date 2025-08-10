import Foundation
import Core

/// SysEx.SystemExclusiveContinuePacket (UMP64)
/// Source: libs/messageTypes.js:68
public struct SysExSystemExclusiveContinuePacket: Equatable {
    public var group: UInt8
    public var bytecount: UInt8
    public var byte1: UInt8
    public var byte2: UInt8
    public var byte3: UInt8
    public var byte4: UInt8
    public var byte5: UInt8
    public var byte6: UInt8
    public init(group: UInt8, bytecount: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8) {
        precondition(group <= 15)
        precondition(bytecount <= 15)
        precondition(byte1 <= 127)
        precondition(byte2 <= 127)
        precondition(byte3 <= 127)
        precondition(byte4 <= 127)
        precondition(byte5 <= 127)
        precondition(byte6 <= 127)
        self.group = group
        self.bytecount = bytecount
        self.byte1 = byte1
        self.byte2 = byte2
        self.byte3 = byte3
        self.byte4 = byte4
        self.byte5 = byte5
        self.byte6 = byte6
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(3), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(2), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(bytecount)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(byte1)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(byte2)), offset: 25, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(byte3)), offset: 33, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(byte4)), offset: 41, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(byte5)), offset: 49, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(byte6)), offset: 57, width: 7)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> SysExSystemExclusiveContinuePacket? {
        if getBits(ump.raw, offset: 0, width: 4) != 3 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 2 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let bytecount = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let byte1 = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let byte2 = UInt8(getBits(ump.raw, offset: 25, width: 7))
        let byte3 = UInt8(getBits(ump.raw, offset: 33, width: 7))
        let byte4 = UInt8(getBits(ump.raw, offset: 41, width: 7))
        let byte5 = UInt8(getBits(ump.raw, offset: 49, width: 7))
        let byte6 = UInt8(getBits(ump.raw, offset: 57, width: 7))
        return SysExSystemExclusiveContinuePacket(group: group, bytecount: bytecount, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6)
    }
}
