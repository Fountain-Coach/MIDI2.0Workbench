import Foundation
import Core

/// MIDI10ChannelVoiceMessages.ControlChangeMessage (UMP32)
/// Source: libs/messageTypes.js:68
public struct MIDI10ChannelVoiceMessagesControlChangeMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var index: UInt8
    public var value: UInt8
    public init(group: UInt8, channel: UInt8, index: UInt8, value: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(index <= 127)
        precondition(value <= 127)
        self.group = group
        self.channel = channel
        self.index = index
        self.value = value
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(2), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(11), offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(channel)), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(index)), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(UInt64(value)), offset: 25, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> MIDI10ChannelVoiceMessagesControlChangeMessage? {
        if getBits32(ump.raw, offset: 0, width: 4) != 2 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 11 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let index = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let value = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return MIDI10ChannelVoiceMessagesControlChangeMessage(group: group, channel: channel, index: index, value: value)
    }
}
