import Foundation

// Common spec enums helpful for callers. Generated code does not depend on these,
// but they provide type-safe values for constructing messages.

public enum MessageType: UInt8 {
    case utility = 0x0
    case systemCommonOrRealTime = 0x1
    case midi1ChannelVoice = 0x2
    case sysEx7 = 0x3
    case midi2ChannelVoice = 0x4
    case sysEx8OrMDS = 0x5
    case flexData = 0xD
    case stream = 0xF // MIDI Endpoint / Stream
}

public enum UMPForm2Bit: UInt8 { // 2-bit form fields used across families
    case complete = 0
    case start = 1
    case `continue` = 2
    case end = 3
}

