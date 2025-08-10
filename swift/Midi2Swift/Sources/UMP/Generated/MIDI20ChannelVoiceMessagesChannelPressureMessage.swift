import Foundation
import Core

/// MIDI20ChannelVoiceMessages.ChannelPressureMessage (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesChannelPressureMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var pressure: UInt32
    public init(group: UInt8, channel: UInt8, pressure: UInt32) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(pressure <= 4294967295)
        self.group = group
        self.channel = channel
        self.pressure = pressure
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(13), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(pressure)), offset: 32, width: 32)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesChannelPressureMessage? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 13 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let pressure = UInt32(getBits(ump.raw, offset: 32, width: 32))
        return MIDI20ChannelVoiceMessagesChannelPressureMessage(group: group, channel: channel, pressure: pressure)
    }
}
