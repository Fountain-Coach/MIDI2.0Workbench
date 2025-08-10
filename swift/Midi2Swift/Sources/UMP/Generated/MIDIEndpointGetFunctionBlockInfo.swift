import Foundation
import Core

/// MIDIEndpoint.GetFunctionBlockInfo (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointGetFunctionBlockInfo: Equatable {
    public var form: UInt8
    public var functionblock: UInt8
    public var requestingafunctionblocknamenotification: UInt8
    public var requestingafunctionblockinfonotification: UInt8
    public init(form: UInt8, functionblock: UInt8, requestingafunctionblocknamenotification: UInt8, requestingafunctionblockinfonotification: UInt8) {
        precondition(form <= 3)
        precondition(functionblock <= 255)
        precondition(requestingafunctionblocknamenotification <= 1)
        precondition(requestingafunctionblockinfonotification <= 1)
        self.form = form
        self.functionblock = functionblock
        self.requestingafunctionblocknamenotification = requestingafunctionblocknamenotification
        self.requestingafunctionblockinfonotification = requestingafunctionblockinfonotification
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, functionblock: UInt8, requestingafunctionblocknamenotification: UInt8, requestingafunctionblockinfonotification: UInt8) {
        precondition(functionblock <= 255)
        precondition(requestingafunctionblocknamenotification <= 1)
        precondition(requestingafunctionblockinfonotification <= 1)
        self.form = formEnum.rawValue
        self.functionblock = functionblock
        self.requestingafunctionblocknamenotification = requestingafunctionblocknamenotification
        self.requestingafunctionblockinfonotification = requestingafunctionblockinfonotification
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 15, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(form), offset: 4, width: 2)
        (lo, hi) = setBits128(lo, hi, 16, offset: 6, width: 10)
        (lo, hi) = setBits128(lo, hi, UInt64(functionblock), offset: 16, width: 8)
        (lo, hi) = setBits128(lo, hi, UInt64(requestingafunctionblocknamenotification), offset: 30, width: 1)
        (lo, hi) = setBits128(lo, hi, UInt64(requestingafunctionblockinfonotification), offset: 31, width: 1)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointGetFunctionBlockInfo? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 16 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let functionblock = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        let requestingafunctionblocknamenotification = UInt8(getBits128(ump.lo, ump.hi, offset: 30, width: 1))
        let requestingafunctionblockinfonotification = UInt8(getBits128(ump.lo, ump.hi, offset: 31, width: 1))
        return MIDIEndpointGetFunctionBlockInfo(form: form, functionblock: functionblock, requestingafunctionblocknamenotification: requestingafunctionblocknamenotification, requestingafunctionblockinfonotification: requestingafunctionblockinfonotification)
    }
}
