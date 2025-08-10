import Foundation
import Core

public enum UMPParsed: Equatable {
    case utility(group: UInt8, statusCode: UInt8)
    case system(group: UInt8, status: UInt8)
    case midi1ChannelVoice(group: UInt8, statusNibble: UInt8, channel: UInt8)
    case sysEx7(group: UInt8, form: UInt8, byteCount: UInt8)
    case midi2ChannelVoice(group: UInt8, statusNibble: UInt8, channel: UInt8)
    case sysEx8MDS(form: UInt8, byteCount: UInt8, streamID: UInt8)
    case flexData(group: UInt8, channel: UInt8, form: UInt8)
    case endpoint(form: UInt8, status10: UInt16)
    case unknown(messageType: UInt8)
}

public struct UMPParser {
    public static func parse(_ ump: UMP32) -> UMPParsed {
        let mt = UInt8(getBits32(ump.raw, offset: 0, width: 4))
        switch mt {
        case 0x0: // Utility
            let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
            let statusCode = UInt8(getBits32(ump.raw, offset: 8, width: 4))
            return .utility(group: group, statusCode: statusCode)
        case 0x1: // System Common/Real-time
            let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
            let status = UInt8(getBits32(ump.raw, offset: 8, width: 8))
            return .system(group: group, status: status)
        case 0x2: // MIDI 1.0 Channel Voice
            let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
            let statusNibble = UInt8(getBits32(ump.raw, offset: 8, width: 4))
            let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
            return .midi1ChannelVoice(group: group, statusNibble: statusNibble, channel: channel)
        default:
            return .unknown(messageType: mt)
        }
    }

    public static func parse(_ ump: UMP64) -> UMPParsed {
        let mt = UInt8(getBits(ump.raw, offset: 0, width: 4))
        switch mt {
        case 0x3: // SysEx7
            let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
            let form = UInt8(getBits(ump.raw, offset: 8, width: 4))
            let byteCount = UInt8(getBits(ump.raw, offset: 12, width: 4))
            return .sysEx7(group: group, form: form, byteCount: byteCount)
        case 0x4: // MIDI 2.0 Channel Voice
            let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
            let statusNibble = UInt8(getBits(ump.raw, offset: 8, width: 4))
            let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
            return .midi2ChannelVoice(group: group, statusNibble: statusNibble, channel: channel)
        default:
            return .unknown(messageType: mt)
        }
    }

    public static func parse(_ ump: UMP128) -> UMPParsed {
        let mt = UInt8(getBits128(ump.lo, ump.hi, offset: 0, width: 4))
        switch mt {
        case 0x5: // SysEx8/MDS
            let form = UInt8(getBits128(ump.lo, ump.hi, offset: 8, width: 4))
            let byteCount = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 4))
            let streamID = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
            return .sysEx8MDS(form: form, byteCount: byteCount, streamID: streamID)
        case 0xD: // Flex Data
            // Flex uses channel at [4..7], group at [8..11], form[12..13]
            let channel = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
            let group = UInt8(getBits128(ump.lo, ump.hi, offset: 8, width: 4))
            let form = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 2))
            return .flexData(group: group, channel: channel, form: form)
        case 0xF: // MIDI Endpoint / Stream
            // Endpoint uses 2-bit form at [4..5] and 10-bit status at [6..15]
            let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
            let status10 = UInt16(getBits128(ump.lo, ump.hi, offset: 6, width: 10))
            return .endpoint(form: form, status10: status10)
        default:
            return .unknown(messageType: mt)
        }
    }
}

