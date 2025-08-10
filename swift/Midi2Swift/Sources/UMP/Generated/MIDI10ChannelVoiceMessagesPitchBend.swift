import Foundation
import Core

/// MIDI10ChannelVoiceMessages.PitchBend (UMP32)
/// Source: libs/messageTypes.js:68
public struct MIDI10ChannelVoiceMessagesPitchBend: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var lsbdata: UInt8
    public var msbdata: UInt8
    public init(group: UInt8, channel: UInt8, lsbdata: UInt8, msbdata: UInt8) {
        precondition(group <= 15)
        precondition(channel <= 15)
        precondition(lsbdata <= 127)
        precondition(msbdata <= 127)
        self.group = group
        self.channel = channel
        self.lsbdata = lsbdata
        self.msbdata = msbdata
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(2), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(14), offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(channel)), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(lsbdata)), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(UInt64(msbdata)), offset: 25, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> MIDI10ChannelVoiceMessagesPitchBend? {
        if getBits32(ump.raw, offset: 0, width: 4) != 2 { return nil }
        if getBits32(ump.raw, offset: 8, width: 4) != 14 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let lsbdata = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let msbdata = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return MIDI10ChannelVoiceMessagesPitchBend(group: group, channel: channel, lsbdata: lsbdata, msbdata: msbdata)
    }
}
