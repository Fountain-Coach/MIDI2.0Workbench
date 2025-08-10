import Foundation
import Core

/// MIDIEndpoint.MIDIEndpointInfoNotify (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointMIDIEndpointInfoNotify: Equatable {
    public var form: UInt8
    public var umpversionmajor: UInt8
    public var umpversionminor: UInt8
    public var staticfunctionblocks: UInt8
    public var numberoffunctionblocks: UInt8
    public init(form: UInt8, umpversionmajor: UInt8, umpversionminor: UInt8, staticfunctionblocks: UInt8, numberoffunctionblocks: UInt8) {
        precondition(form <= 3)
        precondition(umpversionmajor <= 255)
        precondition(umpversionminor <= 255)
        precondition(staticfunctionblocks <= 1)
        precondition(numberoffunctionblocks <= 127)
        self.form = form
        self.umpversionmajor = umpversionmajor
        self.umpversionminor = umpversionminor
        self.staticfunctionblocks = staticfunctionblocks
        self.numberoffunctionblocks = numberoffunctionblocks
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, umpversionmajor: UInt8, umpversionminor: UInt8, staticfunctionblocks: UInt8, numberoffunctionblocks: UInt8) {
        precondition(umpversionmajor <= 255)
        precondition(umpversionminor <= 255)
        precondition(staticfunctionblocks <= 1)
        precondition(numberoffunctionblocks <= 127)
        self.form = formEnum.rawValue
        self.umpversionmajor = umpversionmajor
        self.umpversionminor = umpversionminor
        self.staticfunctionblocks = staticfunctionblocks
        self.numberoffunctionblocks = numberoffunctionblocks
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 15, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(form), offset: 4, width: 2)
        (lo, hi) = setBits128(lo, hi, 1, offset: 6, width: 10)
        (lo, hi) = setBits128(lo, hi, UInt64(umpversionmajor), offset: 16, width: 8)
        (lo, hi) = setBits128(lo, hi, UInt64(umpversionminor), offset: 24, width: 8)
        (lo, hi) = setBits128(lo, hi, UInt64(staticfunctionblocks), offset: 32, width: 1)
        (lo, hi) = setBits128(lo, hi, UInt64(numberoffunctionblocks), offset: 33, width: 7)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointMIDIEndpointInfoNotify? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 1 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let umpversionmajor = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        let umpversionminor = UInt8(getBits128(ump.lo, ump.hi, offset: 24, width: 8))
        let staticfunctionblocks = UInt8(getBits128(ump.lo, ump.hi, offset: 32, width: 1))
        let numberoffunctionblocks = UInt8(getBits128(ump.lo, ump.hi, offset: 33, width: 7))
        return MIDIEndpointMIDIEndpointInfoNotify(form: form, umpversionmajor: umpversionmajor, umpversionminor: umpversionminor, staticfunctionblocks: staticfunctionblocks, numberoffunctionblocks: numberoffunctionblocks)
    }
}
