import Foundation
import Core

/// MIDI20ChannelVoiceMessages.NoteOn (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesNoteOn: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var notenumber: UInt8
    public var attributetype: UInt8
    public var velocity: UInt16
    public var attribute: UInt16
    public init(group: UInt8, channel: UInt8, notenumber: UInt8, attributetype: UInt8, velocity: UInt16, attribute: UInt16) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(notenumber <= 127)
        precondition(attributetype <= 127)
        precondition(velocity <= 65535)
        precondition(attribute <= 65535)
        self.group = group
        self.channel = channel
        self.notenumber = notenumber
        self.attributetype = attributetype
        self.velocity = velocity
        self.attribute = attribute
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(9), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(notenumber)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(attributetype)), offset: 25, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(velocity)), offset: 32, width: 16)
        raw = setBits(raw, value: UInt64(UInt64(attribute)), offset: 48, width: 16)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesNoteOn? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 9 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let notenumber = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let attributetype = UInt8(getBits(ump.raw, offset: 25, width: 7))
        let velocity = UInt16(getBits(ump.raw, offset: 32, width: 16))
        let attribute = UInt16(getBits(ump.raw, offset: 48, width: 16))
        return MIDI20ChannelVoiceMessagesNoteOn(group: group, channel: channel, notenumber: notenumber, attributetype: attributetype, velocity: velocity, attribute: attribute)
    }
}
