import Foundation
import Core

/// MIDIEndpoint.StreamConfigurationNotify (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointStreamConfigurationNotify: Equatable {
    public var form: UInt8
    public var _protocol: UInt8
    public init(form: UInt8, _protocol: UInt8) {
        precondition(form <= 3)
        precondition(_protocol <= 255)
        self.form = form
        self._protocol = _protocol
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, _protocol: UInt8) {
        precondition(_protocol <= 255)
        self.form = formEnum.rawValue
        self._protocol = _protocol
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 15, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(form), offset: 4, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 6, offset: 6, width: 10); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(_protocol), offset: 16, width: 8); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointStreamConfigurationNotify? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 6 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let _protocol = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        return MIDIEndpointStreamConfigurationNotify(form: form, _protocol: _protocol)
    }
}
