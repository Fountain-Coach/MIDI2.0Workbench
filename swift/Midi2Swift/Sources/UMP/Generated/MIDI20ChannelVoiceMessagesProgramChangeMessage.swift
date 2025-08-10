import Foundation
import Core

/// MIDI20ChannelVoiceMessages.ProgramChangeMessage (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesProgramChangeMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var bankvalid: UInt8
    public var program: UInt8
    public var bankmsb: UInt8
    public var banklsb: UInt8
    public init(group: UInt8, channel: UInt8, bankvalid: UInt8, program: UInt8, bankmsb: UInt8, banklsb: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(bankvalid <= 1)
        precondition(program <= 127)
        precondition(bankmsb <= 127)
        precondition(banklsb <= 127)
        self.group = group
        self.channel = channel
        self.bankvalid = bankvalid
        self.program = program
        self.bankmsb = bankmsb
        self.banklsb = banklsb
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(12), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(bankvalid)), offset: 31, width: 1)
        raw = setBits(raw, value: UInt64(UInt64(program)), offset: 33, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(bankmsb)), offset: 49, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(banklsb)), offset: 57, width: 7)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesProgramChangeMessage? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 12 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let bankvalid = UInt8(getBits(ump.raw, offset: 31, width: 1))
        let program = UInt8(getBits(ump.raw, offset: 33, width: 7))
        let bankmsb = UInt8(getBits(ump.raw, offset: 49, width: 7))
        let banklsb = UInt8(getBits(ump.raw, offset: 57, width: 7))
        return MIDI20ChannelVoiceMessagesProgramChangeMessage(group: group, channel: channel, bankvalid: bankvalid, program: program, bankmsb: bankmsb, banklsb: banklsb)
    }
}
