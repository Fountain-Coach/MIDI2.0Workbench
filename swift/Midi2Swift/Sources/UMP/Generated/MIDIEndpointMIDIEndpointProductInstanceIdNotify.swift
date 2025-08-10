import Foundation
import Core

/// MIDIEndpoint.MIDIEndpointProductInstanceIdNotify (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointMIDIEndpointProductInstanceIdNotify: Equatable {
    public var form: UInt8
    public var byte1: UInt8
    public var byte2: UInt8
    public var byte3: UInt8
    public var byte4: UInt8
    public var byte5: UInt8
    public var byte6: UInt8
    public var byte7: UInt8
    public var byte8: UInt8
    public var byte9: UInt8
    public var byte10: UInt8
    public var byte11: UInt8
    public var byte12: UInt8
    public var byte13: UInt8
    public var byte14: UInt8
    public init(form: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8, byte7: UInt8, byte8: UInt8, byte9: UInt8, byte10: UInt8, byte11: UInt8, byte12: UInt8, byte13: UInt8, byte14: UInt8) {
        precondition(form <= 3)
        precondition(byte1 <= 255)
        precondition(byte2 <= 255)
        precondition(byte3 <= 255)
        precondition(byte4 <= 255)
        precondition(byte5 <= 255)
        precondition(byte6 <= 255)
        precondition(byte7 <= 255)
        precondition(byte8 <= 255)
        precondition(byte9 <= 255)
        precondition(byte10 <= 255)
        precondition(byte11 <= 255)
        precondition(byte12 <= 255)
        precondition(byte13 <= 255)
        precondition(byte14 <= 255)
        self.form = form
        self.byte1 = byte1
        self.byte2 = byte2
        self.byte3 = byte3
        self.byte4 = byte4
        self.byte5 = byte5
        self.byte6 = byte6
        self.byte7 = byte7
        self.byte8 = byte8
        self.byte9 = byte9
        self.byte10 = byte10
        self.byte11 = byte11
        self.byte12 = byte12
        self.byte13 = byte13
        self.byte14 = byte14
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8, byte7: UInt8, byte8: UInt8, byte9: UInt8, byte10: UInt8, byte11: UInt8, byte12: UInt8, byte13: UInt8, byte14: UInt8) {
        precondition(byte1 <= 255)
        precondition(byte2 <= 255)
        precondition(byte3 <= 255)
        precondition(byte4 <= 255)
        precondition(byte5 <= 255)
        precondition(byte6 <= 255)
        precondition(byte7 <= 255)
        precondition(byte8 <= 255)
        precondition(byte9 <= 255)
        precondition(byte10 <= 255)
        precondition(byte11 <= 255)
        precondition(byte12 <= 255)
        precondition(byte13 <= 255)
        precondition(byte14 <= 255)
        self.form = formEnum.rawValue
        self.byte1 = byte1
        self.byte2 = byte2
        self.byte3 = byte3
        self.byte4 = byte4
        self.byte5 = byte5
        self.byte6 = byte6
        self.byte7 = byte7
        self.byte8 = byte8
        self.byte9 = byte9
        self.byte10 = byte10
        self.byte11 = byte11
        self.byte12 = byte12
        self.byte13 = byte13
        self.byte14 = byte14
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 15, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(form), offset: 4, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 4, offset: 6, width: 10); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte1), offset: 16, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte2), offset: 24, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte3), offset: 32, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte4), offset: 40, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte5), offset: 48, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte6), offset: 56, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte7), offset: 64, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte8), offset: 72, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte9), offset: 80, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte10), offset: 88, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte11), offset: 96, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte12), offset: 104, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte13), offset: 112, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(byte14), offset: 120, width: 8); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointMIDIEndpointProductInstanceIdNotify? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 4 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let byte1 = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        let byte2 = UInt8(getBits128(ump.lo, ump.hi, offset: 24, width: 8))
        let byte3 = UInt8(getBits128(ump.lo, ump.hi, offset: 32, width: 8))
        let byte4 = UInt8(getBits128(ump.lo, ump.hi, offset: 40, width: 8))
        let byte5 = UInt8(getBits128(ump.lo, ump.hi, offset: 48, width: 8))
        let byte6 = UInt8(getBits128(ump.lo, ump.hi, offset: 56, width: 8))
        let byte7 = UInt8(getBits128(ump.lo, ump.hi, offset: 64, width: 8))
        let byte8 = UInt8(getBits128(ump.lo, ump.hi, offset: 72, width: 8))
        let byte9 = UInt8(getBits128(ump.lo, ump.hi, offset: 80, width: 8))
        let byte10 = UInt8(getBits128(ump.lo, ump.hi, offset: 88, width: 8))
        let byte11 = UInt8(getBits128(ump.lo, ump.hi, offset: 96, width: 8))
        let byte12 = UInt8(getBits128(ump.lo, ump.hi, offset: 104, width: 8))
        let byte13 = UInt8(getBits128(ump.lo, ump.hi, offset: 112, width: 8))
        let byte14 = UInt8(getBits128(ump.lo, ump.hi, offset: 120, width: 8))
        return MIDIEndpointMIDIEndpointProductInstanceIdNotify(form: form, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6, byte7: byte7, byte8: byte8, byte9: byte9, byte10: byte10, byte11: byte11, byte12: byte12, byte13: byte13, byte14: byte14)
    }
}
