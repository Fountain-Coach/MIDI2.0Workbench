import Foundation
import Core

/// MIDIEndpoint.FunctionBlockInfoNotification (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointFunctionBlockInfoNotification: Equatable {
    public var form: UInt8
    public var active: UInt8
    public var functionblock: UInt8
    public var uihint: UInt8
    public var ismidi10: UInt8
    public var direction: UInt8
    public var firstgroup: UInt8
    public var grouplength: UInt8
    public var midicisupport: UInt8
    public var maxsysexstreams: UInt8
    public init(form: UInt8, active: UInt8, functionblock: UInt8, uihint: UInt8, ismidi10: UInt8, direction: UInt8, firstgroup: UInt8, grouplength: UInt8, midicisupport: UInt8, maxsysexstreams: UInt8) {
        precondition(form <= 3)
        precondition(active <= 1)
        precondition(functionblock <= 127)
        precondition(uihint <= 3)
        precondition(ismidi10 <= 3)
        precondition(direction <= 3)
        precondition(firstgroup <= 255)
        precondition(grouplength <= 255)
        precondition(midicisupport <= 127)
        precondition(maxsysexstreams <= 255)
        self.form = form
        self.active = active
        self.functionblock = functionblock
        self.uihint = uihint
        self.ismidi10 = ismidi10
        self.direction = direction
        self.firstgroup = firstgroup
        self.grouplength = grouplength
        self.midicisupport = midicisupport
        self.maxsysexstreams = maxsysexstreams
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, active: UInt8, functionblock: UInt8, uihint: UInt8, ismidi10: UInt8, direction: UInt8, firstgroup: UInt8, grouplength: UInt8, midicisupport: UInt8, maxsysexstreams: UInt8) {
        precondition(active <= 1)
        precondition(functionblock <= 127)
        precondition(uihint <= 3)
        precondition(ismidi10 <= 3)
        precondition(direction <= 3)
        precondition(firstgroup <= 255)
        precondition(grouplength <= 255)
        precondition(midicisupport <= 127)
        precondition(maxsysexstreams <= 255)
        self.form = formEnum.rawValue
        self.active = active
        self.functionblock = functionblock
        self.uihint = uihint
        self.ismidi10 = ismidi10
        self.direction = direction
        self.firstgroup = firstgroup
        self.grouplength = grouplength
        self.midicisupport = midicisupport
        self.maxsysexstreams = maxsysexstreams
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 15, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(form), offset: 4, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 17, offset: 6, width: 10); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(active), offset: 16, width: 1); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(functionblock), offset: 17, width: 7); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(uihint), offset: 26, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(ismidi10), offset: 28, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(direction), offset: 30, width: 2); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(firstgroup), offset: 32, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(grouplength), offset: 40, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(midicisupport), offset: 49, width: 7); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(maxsysexstreams), offset: 56, width: 8); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointFunctionBlockInfoNotification? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 17 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let active = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 1))
        let functionblock = UInt8(getBits128(ump.lo, ump.hi, offset: 17, width: 7))
        let uihint = UInt8(getBits128(ump.lo, ump.hi, offset: 26, width: 2))
        let ismidi10 = UInt8(getBits128(ump.lo, ump.hi, offset: 28, width: 2))
        let direction = UInt8(getBits128(ump.lo, ump.hi, offset: 30, width: 2))
        let firstgroup = UInt8(getBits128(ump.lo, ump.hi, offset: 32, width: 8))
        let grouplength = UInt8(getBits128(ump.lo, ump.hi, offset: 40, width: 8))
        let midicisupport = UInt8(getBits128(ump.lo, ump.hi, offset: 49, width: 7))
        let maxsysexstreams = UInt8(getBits128(ump.lo, ump.hi, offset: 56, width: 8))
        return MIDIEndpointFunctionBlockInfoNotification(form: form, active: active, functionblock: functionblock, uihint: uihint, ismidi10: ismidi10, direction: direction, firstgroup: firstgroup, grouplength: grouplength, midicisupport: midicisupport, maxsysexstreams: maxsysexstreams)
    }
}
