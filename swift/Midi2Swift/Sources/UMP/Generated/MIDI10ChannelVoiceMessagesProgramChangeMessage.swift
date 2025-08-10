import Foundation
import Core

/// MIDI10ChannelVoiceMessages.ProgramChangeMessage (UMP32)
/// Source: libs/messageTypes.js:68
public struct MIDI10ChannelVoiceMessagesProgramChangeMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var program: UInt8
    public init(group: UInt8, channel: UInt8, program: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(program <= 127)
        self.group = group
        self.channel = channel
        self.program = program
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(2), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(12), offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(channel)), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(program)), offset: 17, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> MIDI10ChannelVoiceMessagesProgramChangeMessage? {
        if getBits32(ump.raw, offset: 0, width: 4) != 2 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 12 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let program = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return MIDI10ChannelVoiceMessagesProgramChangeMessage(group: group, channel: channel, program: program)
    }
}
