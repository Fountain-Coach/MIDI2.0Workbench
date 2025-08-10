import Foundation
import Core

/// MIDI20ChannelVoiceMessages.RelativeRegisteredControllerRPN (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var bank: UInt8
    public var index: UInt8
    public var value: UInt32
    public init(group: UInt8, channel: UInt8, bank: UInt8, index: UInt8, value: UInt32) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(bank <= 127)
        precondition(index <= 127)
        precondition(value <= 4294967295)
        self.group = group
        self.channel = channel
        self.bank = bank
        self.index = index
        self.value = value
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(4), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(bank)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(index)), offset: 25, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(value)), offset: 32, width: 32)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 4 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let bank = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let index = UInt8(getBits(ump.raw, offset: 25, width: 7))
        let value = UInt32(getBits(ump.raw, offset: 32, width: 32))
        return MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(group: group, channel: channel, bank: bank, index: index, value: value)
    }
}
