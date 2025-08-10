import Foundation
import Core

/// MIDI10ChannelVoiceMessages.PolyPressure (UMP32)
/// Source: libs/messageTypes.js:68
public struct MIDI10ChannelVoiceMessagesPolyPressure: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var notenumber: UInt8
    public var pressure: UInt8
    public init(group: UInt8, channel: UInt8, notenumber: UInt8, pressure: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(notenumber <= 127)
        precondition(pressure <= 127)
        self.group = group
        self.channel = channel
        self.notenumber = notenumber
        self.pressure = pressure
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(2), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(10), offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(channel)), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(notenumber)), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(UInt64(pressure)), offset: 25, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> MIDI10ChannelVoiceMessagesPolyPressure? {
        if getBits32(ump.raw, offset: 0, width: 4) != 2 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 10 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let notenumber = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let pressure = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return MIDI10ChannelVoiceMessagesPolyPressure(group: group, channel: channel, notenumber: notenumber, pressure: pressure)
    }
}
