import Foundation
import Core

/// SystemRealTimeandSystemCommonMessages.MIDITimeCode (UMP32)
/// Source: libs/messageTypes.js:68
public struct SystemRealTimeandSystemCommonMessagesMIDITimeCode: Equatable {
    public var group: UInt8
    public var nnndddd: UInt8
    public init(group: UInt8, nnndddd: UInt8) {
        precondition(group <= 15)
        precondition(nnndddd <= 127)
        self.group = group
        self.nnndddd = nnndddd
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(1), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(241), offset: 8, width: 8)
        raw = setBits32(raw, value: UInt32(UInt64(nnndddd)), offset: 17, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> SystemRealTimeandSystemCommonMessagesMIDITimeCode? {
        if getBits32(ump.raw, offset: 0, width: 4) != 1 { return nil }
        if getBits32(ump.raw, offset: 8, width: 8) != 241 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let nnndddd = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return SystemRealTimeandSystemCommonMessagesMIDITimeCode(group: group, nnndddd: nnndddd)
    }
}
