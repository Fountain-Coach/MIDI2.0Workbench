import Foundation
import Core

/// MIDI20ChannelVoiceMessages.PerNotePitchBend (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesPerNotePitchBend: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var notenumber: UInt8
    public var pitch: UInt32
    public init(group: UInt8, channel: UInt8, notenumber: UInt8, pitch: UInt32) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(notenumber <= 127)
        precondition(pitch <= 4294967295)
        self.group = group
        self.channel = channel
        self.notenumber = notenumber
        self.pitch = pitch
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(6), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(notenumber)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(pitch)), offset: 32, width: 32)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesPerNotePitchBend? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 6 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let notenumber = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let pitch = UInt32(getBits(ump.raw, offset: 32, width: 32))
        return MIDI20ChannelVoiceMessagesPerNotePitchBend(group: group, channel: channel, notenumber: notenumber, pitch: pitch)
    }
}
