import Foundation
import Core

/// MIDIEndpoint.StartofSequenceMessage (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointStartofSequenceMessage: Equatable {
    public var form: UInt8
    public init(form: UInt8) {
        precondition(form <= 3)
        self.form = form
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form) {

        self.form = formEnum.rawValue

    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 15, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(form), offset: 4, width: 2)
        (lo, hi) = setBits128(lo, hi, 32, offset: 6, width: 10)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointStartofSequenceMessage? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 32 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        return MIDIEndpointStartofSequenceMessage(form: form)
    }
}
