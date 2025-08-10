import Foundation
import Core

/// MIDI10ChannelVoiceMessages.NoteOff (UMP32)
/// Source: libs/messageTypes.js:68
public struct MIDI10ChannelVoiceMessagesNoteOff: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var notenumber: UInt8
    public var velocity: UInt8
    public init(group: UInt8, channel: UInt8, notenumber: UInt8, velocity: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(notenumber <= 127)
        precondition(velocity <= 127)
        self.group = group
        self.channel = channel
        self.notenumber = notenumber
        self.velocity = velocity
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(2), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(8), offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(channel)), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(notenumber)), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(UInt64(velocity)), offset: 25, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> MIDI10ChannelVoiceMessagesNoteOff? {
        if getBits32(ump.raw, offset: 0, width: 4) != 2 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 8 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let notenumber = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let velocity = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return MIDI10ChannelVoiceMessagesNoteOff(group: group, channel: channel, notenumber: notenumber, velocity: velocity)
    }
}
