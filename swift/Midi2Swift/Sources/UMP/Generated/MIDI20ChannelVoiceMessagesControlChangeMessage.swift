import Foundation
import Core

/// MIDI20ChannelVoiceMessages.ControlChangeMessage (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesControlChangeMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var index: UInt8
    public var value: UInt32
    public init(group: UInt8, channel: UInt8, index: UInt8, value: UInt32) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(index <= 127)
        precondition(value <= 4294967295)
        self.group = group
        self.channel = channel
        self.index = index
        self.value = value
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(11), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(index)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(value)), offset: 32, width: 32)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesControlChangeMessage? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 11 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let index = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let value = UInt32(getBits(ump.raw, offset: 32, width: 32))
        return MIDI20ChannelVoiceMessagesControlChangeMessage(group: group, channel: channel, index: index, value: value)
    }
}
