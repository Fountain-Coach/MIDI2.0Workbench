import Foundation
import Core

/// MIDI20ChannelVoiceMessages.PerNoteManagementMessage (UMP64)
/// Source: libs/messageTypes.js:68
public struct MIDI20ChannelVoiceMessagesPerNoteManagementMessage: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var notenumber: UInt8
    public var detachpernotecontrollersfrompreviouslyreceivednotes: UInt8
    public var resetsetpernotecontrollerstodefaultvalues: UInt8
    public init(group: UInt8, channel: UInt8, notenumber: UInt8, detachpernotecontrollersfrompreviouslyreceivednotes: UInt8, resetsetpernotecontrollerstodefaultvalues: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(notenumber <= 127)
        precondition(detachpernotecontrollersfrompreviouslyreceivednotes <= 1)
        precondition(resetsetpernotecontrollerstodefaultvalues <= 1)
        self.group = group
        self.channel = channel
        self.notenumber = notenumber
        self.detachpernotecontrollersfrompreviouslyreceivednotes = detachpernotecontrollersfrompreviouslyreceivednotes
        self.resetsetpernotecontrollerstodefaultvalues = resetsetpernotecontrollerstodefaultvalues
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: UInt64(4), offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(group)), offset: 4, width: 4)
        raw = setBits(raw, value: UInt64(15), offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(channel)), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(UInt64(notenumber)), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(UInt64(detachpernotecontrollersfrompreviouslyreceivednotes)), offset: 30, width: 1)
        raw = setBits(raw, value: UInt64(UInt64(resetsetpernotecontrollerstodefaultvalues)), offset: 31, width: 1)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> MIDI20ChannelVoiceMessagesPerNoteManagementMessage? {
        if getBits(ump.raw, offset: 0, width: 4) != 4 { return nil }
        if getBits(ump.raw, offset: 8, width: 4) != 15 { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let notenumber = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let detachpernotecontrollersfrompreviouslyreceivednotes = UInt8(getBits(ump.raw, offset: 30, width: 1))
        let resetsetpernotecontrollerstodefaultvalues = UInt8(getBits(ump.raw, offset: 31, width: 1))
        return MIDI20ChannelVoiceMessagesPerNoteManagementMessage(group: group, channel: channel, notenumber: notenumber, detachpernotecontrollersfrompreviouslyreceivednotes: detachpernotecontrollersfrompreviouslyreceivednotes, resetsetpernotecontrollerstodefaultvalues: resetsetpernotecontrollerstodefaultvalues)
    }
}
