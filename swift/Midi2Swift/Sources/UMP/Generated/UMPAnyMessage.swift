import Foundation
import Core

public enum UMPAnyMessage: Equatable {
    case FlexDataMessagesFlexDataMessages0x0(FlexDataMessagesFlexDataMessages0x0)
    case FlexDataMessagesFlexDataMessages0x1(FlexDataMessagesFlexDataMessages0x1)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB)
    case FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC)
    case FlexDataMessagesFlexDataMessages0x2(FlexDataMessagesFlexDataMessages0x2)
    case FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0)
    case FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1)
    case FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2)
    case FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3)
    case FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4)
    case FlexDataMessagesFlexDataMessages0x3(FlexDataMessagesFlexDataMessages0x3)
    case FlexDataMessagesFlexDataMessages0x4(FlexDataMessagesFlexDataMessages0x4)
    case FlexDataMessagesFlexDataMessages0x5(FlexDataMessagesFlexDataMessages0x5)
    case FlexDataMessagesFlexDataMessages0x6(FlexDataMessagesFlexDataMessages0x6)
    case FlexDataMessagesFlexDataMessages0x7(FlexDataMessagesFlexDataMessages0x7)
    case FlexDataMessagesFlexDataMessages0x8(FlexDataMessagesFlexDataMessages0x8)
    case FlexDataMessagesFlexDataMessages0x9(FlexDataMessagesFlexDataMessages0x9)
    case FlexDataMessagesFlexDataMessages0xA(FlexDataMessagesFlexDataMessages0xA)
    case FlexDataMessagesFlexDataMessages0xB(FlexDataMessagesFlexDataMessages0xB)
    case FlexDataMessagesFlexDataMessages0xC(FlexDataMessagesFlexDataMessages0xC)
    case FlexDataMessagesSubdivisionClicks1(FlexDataMessagesSubdivisionClicks1)
    case FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0)
    case FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1)
    case FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5)
    case FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6)
    case FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(FlexDataMessagesSubdivisionClicks1SubdivisionClicks1)
    case MIDI10ChannelVoiceMessagesChannelPressureMessage(MIDI10ChannelVoiceMessagesChannelPressureMessage)
    case MIDI10ChannelVoiceMessagesControlChangeMessage(MIDI10ChannelVoiceMessagesControlChangeMessage)
    case MIDI10ChannelVoiceMessagesNoteOff(MIDI10ChannelVoiceMessagesNoteOff)
    case MIDI10ChannelVoiceMessagesNoteOn(MIDI10ChannelVoiceMessagesNoteOn)
    case MIDI10ChannelVoiceMessagesPitchBend(MIDI10ChannelVoiceMessagesPitchBend)
    case MIDI10ChannelVoiceMessagesPolyPressure(MIDI10ChannelVoiceMessagesPolyPressure)
    case MIDI10ChannelVoiceMessagesProgramChangeMessage(MIDI10ChannelVoiceMessagesProgramChangeMessage)
    case MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages(MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages)
    case MIDI20ChannelVoiceMessagesAssignablePerNoteController(MIDI20ChannelVoiceMessagesAssignablePerNoteController)
    case MIDI20ChannelVoiceMessagesChannelPressureMessage(MIDI20ChannelVoiceMessagesChannelPressureMessage)
    case MIDI20ChannelVoiceMessagesControlChangeMessage(MIDI20ChannelVoiceMessagesControlChangeMessage)
    case MIDI20ChannelVoiceMessagesNoteOff(MIDI20ChannelVoiceMessagesNoteOff)
    case MIDI20ChannelVoiceMessagesNoteOn(MIDI20ChannelVoiceMessagesNoteOn)
    case MIDI20ChannelVoiceMessagesPerNoteManagementMessage(MIDI20ChannelVoiceMessagesPerNoteManagementMessage)
    case MIDI20ChannelVoiceMessagesPerNotePitchBend(MIDI20ChannelVoiceMessagesPerNotePitchBend)
    case MIDI20ChannelVoiceMessagesPitchBend(MIDI20ChannelVoiceMessagesPitchBend)
    case MIDI20ChannelVoiceMessagesPolyPressure(MIDI20ChannelVoiceMessagesPolyPressure)
    case MIDI20ChannelVoiceMessagesProgramChangeMessage(MIDI20ChannelVoiceMessagesProgramChangeMessage)
    case MIDI20ChannelVoiceMessagesRegisteredControllerRPN(MIDI20ChannelVoiceMessagesRegisteredControllerRPN)
    case MIDI20ChannelVoiceMessagesRegisteredPerNoteController(MIDI20ChannelVoiceMessagesRegisteredPerNoteController)
    case MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN(MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN)
    case MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN)
    case MIDIEndpointEndofFileMessage(MIDIEndpointEndofFileMessage)
    case MIDIEndpointFunctionBlockInfoNotification(MIDIEndpointFunctionBlockInfoNotification)
    case MIDIEndpointFunctionBlockNameNotification(MIDIEndpointFunctionBlockNameNotification)
    case MIDIEndpointGetFunctionBlockInfo(MIDIEndpointGetFunctionBlockInfo)
    case MIDIEndpointGetMIDIEndpointInfo(MIDIEndpointGetMIDIEndpointInfo)
    case MIDIEndpointMIDIEndpointDeviceInfoNotify(MIDIEndpointMIDIEndpointDeviceInfoNotify)
    case MIDIEndpointMIDIEndpointInfoNotify(MIDIEndpointMIDIEndpointInfoNotify)
    case MIDIEndpointMIDIEndpointNameNotify(MIDIEndpointMIDIEndpointNameNotify)
    case MIDIEndpointMIDIEndpointProductInstanceIdNotify(MIDIEndpointMIDIEndpointProductInstanceIdNotify)
    case MIDIEndpointStartofSequenceMessage(MIDIEndpointStartofSequenceMessage)
    case MIDIEndpointStreamConfigurationNotify(MIDIEndpointStreamConfigurationNotify)
    case MIDIEndpointStreamConfigurationRequest(MIDIEndpointStreamConfigurationRequest)
    case SysExCompleteSystemExclusiveMessageinOnePacket(SysExCompleteSystemExclusiveMessageinOnePacket)
    case SysExSystemExclusiveContinuePacket(SysExSystemExclusiveContinuePacket)
    case SysExSystemExclusiveEndPacket(SysExSystemExclusiveEndPacket)
    case SysExSystemExclusiveStartPacket(SysExSystemExclusiveStartPacket)
    case SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket(SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket)
    case SysEx8andMDSMixedDataSetHeader(SysEx8andMDSMixedDataSetHeader)
    case SysEx8andMDSMixedDataSetPayload(SysEx8andMDSMixedDataSetPayload)
    case SysEx8andMDSSystemExclusive8ContinuePacket(SysEx8andMDSSystemExclusive8ContinuePacket)
    case SysEx8andMDSSystemExclusive8StartPacket(SysEx8andMDSSystemExclusive8StartPacket)
    case SysEx8andMDSSystemExclusiveEndPacket(SysEx8andMDSSystemExclusiveEndPacket)
    case SystemRealTimeandSystemCommonMessagesActiveSensing(SystemRealTimeandSystemCommonMessagesActiveSensing)
    case SystemRealTimeandSystemCommonMessagesContinue(SystemRealTimeandSystemCommonMessagesContinue)
    case SystemRealTimeandSystemCommonMessagesMIDITimeCode(SystemRealTimeandSystemCommonMessagesMIDITimeCode)
    case SystemRealTimeandSystemCommonMessagesReset(SystemRealTimeandSystemCommonMessagesReset)
    case SystemRealTimeandSystemCommonMessagesSongPositionPointer(SystemRealTimeandSystemCommonMessagesSongPositionPointer)
    case SystemRealTimeandSystemCommonMessagesSongSelect(SystemRealTimeandSystemCommonMessagesSongSelect)
    case SystemRealTimeandSystemCommonMessagesStart(SystemRealTimeandSystemCommonMessagesStart)
    case SystemRealTimeandSystemCommonMessagesStop(SystemRealTimeandSystemCommonMessagesStop)
    case SystemRealTimeandSystemCommonMessagesTimingClock(SystemRealTimeandSystemCommonMessagesTimingClock)
    case SystemRealTimeandSystemCommonMessagesTuneRequest(SystemRealTimeandSystemCommonMessagesTuneRequest)
    case UtilityMessagesDeltaClockstamp(UtilityMessagesDeltaClockstamp)
    case UtilityMessagesDeltaClockstampTicksPerQuarterNote(UtilityMessagesDeltaClockstampTicksPerQuarterNote)
    case UtilityMessagesJRClock(UtilityMessagesJRClock)
    case UtilityMessagesJRTimestamp(UtilityMessagesJRTimestamp)
    case UtilityMessagesNOOP(UtilityMessagesNOOP)
}

public enum UMPDecoder {
    public static func decode(_ ump: UMP32) -> UMPAnyMessage? {
let mt = getBits32(ump.raw, offset: 0, width: 4)
        switch mt {
        case 0:
        if (getBits32(ump.raw, offset: 0, width: 4) == 0 && getBits32(ump.raw, offset: 8, width: 4) == 4) { if let v = UtilityMessagesDeltaClockstamp.decode(ump) { return .UtilityMessagesDeltaClockstamp(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 0 && getBits32(ump.raw, offset: 8, width: 4) == 3) { if let v = UtilityMessagesDeltaClockstampTicksPerQuarterNote.decode(ump) { return .UtilityMessagesDeltaClockstampTicksPerQuarterNote(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 0 && getBits32(ump.raw, offset: 8, width: 4) == 1) { if let v = UtilityMessagesJRClock.decode(ump) { return .UtilityMessagesJRClock(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 0 && getBits32(ump.raw, offset: 8, width: 4) == 2) { if let v = UtilityMessagesJRTimestamp.decode(ump) { return .UtilityMessagesJRTimestamp(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 0 && getBits32(ump.raw, offset: 8, width: 4) == 0) { if let v = UtilityMessagesNOOP.decode(ump) { return .UtilityMessagesNOOP(v) } }
        return nil
        case 1:
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 254) { if let v = SystemRealTimeandSystemCommonMessagesActiveSensing.decode(ump) { return .SystemRealTimeandSystemCommonMessagesActiveSensing(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 251) { if let v = SystemRealTimeandSystemCommonMessagesContinue.decode(ump) { return .SystemRealTimeandSystemCommonMessagesContinue(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 241) { if let v = SystemRealTimeandSystemCommonMessagesMIDITimeCode.decode(ump) { return .SystemRealTimeandSystemCommonMessagesMIDITimeCode(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 255) { if let v = SystemRealTimeandSystemCommonMessagesReset.decode(ump) { return .SystemRealTimeandSystemCommonMessagesReset(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 242) { if let v = SystemRealTimeandSystemCommonMessagesSongPositionPointer.decode(ump) { return .SystemRealTimeandSystemCommonMessagesSongPositionPointer(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 243) { if let v = SystemRealTimeandSystemCommonMessagesSongSelect.decode(ump) { return .SystemRealTimeandSystemCommonMessagesSongSelect(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 250) { if let v = SystemRealTimeandSystemCommonMessagesStart.decode(ump) { return .SystemRealTimeandSystemCommonMessagesStart(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 252) { if let v = SystemRealTimeandSystemCommonMessagesStop.decode(ump) { return .SystemRealTimeandSystemCommonMessagesStop(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 248) { if let v = SystemRealTimeandSystemCommonMessagesTimingClock.decode(ump) { return .SystemRealTimeandSystemCommonMessagesTimingClock(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 1 && getBits32(ump.raw, offset: 8, width: 8) == 246) { if let v = SystemRealTimeandSystemCommonMessagesTuneRequest.decode(ump) { return .SystemRealTimeandSystemCommonMessagesTuneRequest(v) } }
        return nil
        case 2:
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 13) { if let v = MIDI10ChannelVoiceMessagesChannelPressureMessage.decode(ump) { return .MIDI10ChannelVoiceMessagesChannelPressureMessage(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 11) { if let v = MIDI10ChannelVoiceMessagesControlChangeMessage.decode(ump) { return .MIDI10ChannelVoiceMessagesControlChangeMessage(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 8) { if let v = MIDI10ChannelVoiceMessagesNoteOff.decode(ump) { return .MIDI10ChannelVoiceMessagesNoteOff(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 9) { if let v = MIDI10ChannelVoiceMessagesNoteOn.decode(ump) { return .MIDI10ChannelVoiceMessagesNoteOn(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 14) { if let v = MIDI10ChannelVoiceMessagesPitchBend.decode(ump) { return .MIDI10ChannelVoiceMessagesPitchBend(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 10) { if let v = MIDI10ChannelVoiceMessagesPolyPressure.decode(ump) { return .MIDI10ChannelVoiceMessagesPolyPressure(v) } }
        if (getBits32(ump.raw, offset: 0, width: 4) == 2 && getBits32(ump.raw, offset: 8, width: 4) == 12) { if let v = MIDI10ChannelVoiceMessagesProgramChangeMessage.decode(ump) { return .MIDI10ChannelVoiceMessagesProgramChangeMessage(v) } }
        return nil
        }
    }
    public static func decode(_ ump: UMP64) -> UMPAnyMessage? {
let mt = getBits(ump.raw, offset: 0, width: 4)
        switch mt {
        case 3:
            let form = getBits(ump.raw, offset: 8, width: 4)
            switch form {

            default: break
            }
        if (getBits(ump.raw, offset: 0, width: 4) == 3 && getBits(ump.raw, offset: 8, width: 4) == 0) { if let v = SysExCompleteSystemExclusiveMessageinOnePacket.decode(ump) { return .SysExCompleteSystemExclusiveMessageinOnePacket(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 3 && getBits(ump.raw, offset: 8, width: 4) == 2) { if let v = SysExSystemExclusiveContinuePacket.decode(ump) { return .SysExSystemExclusiveContinuePacket(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 3 && getBits(ump.raw, offset: 8, width: 4) == 3) { if let v = SysExSystemExclusiveEndPacket.decode(ump) { return .SysExSystemExclusiveEndPacket(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 3 && getBits(ump.raw, offset: 8, width: 4) == 1) { if let v = SysExSystemExclusiveStartPacket.decode(ump) { return .SysExSystemExclusiveStartPacket(v) } }
        return nil
        case 4:
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 3) { if let v = MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages.decode(ump) { return .MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 1) { if let v = MIDI20ChannelVoiceMessagesAssignablePerNoteController.decode(ump) { return .MIDI20ChannelVoiceMessagesAssignablePerNoteController(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 13) { if let v = MIDI20ChannelVoiceMessagesChannelPressureMessage.decode(ump) { return .MIDI20ChannelVoiceMessagesChannelPressureMessage(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 11) { if let v = MIDI20ChannelVoiceMessagesControlChangeMessage.decode(ump) { return .MIDI20ChannelVoiceMessagesControlChangeMessage(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 8) { if let v = MIDI20ChannelVoiceMessagesNoteOff.decode(ump) { return .MIDI20ChannelVoiceMessagesNoteOff(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 9) { if let v = MIDI20ChannelVoiceMessagesNoteOn.decode(ump) { return .MIDI20ChannelVoiceMessagesNoteOn(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 15) { if let v = MIDI20ChannelVoiceMessagesPerNoteManagementMessage.decode(ump) { return .MIDI20ChannelVoiceMessagesPerNoteManagementMessage(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 6) { if let v = MIDI20ChannelVoiceMessagesPerNotePitchBend.decode(ump) { return .MIDI20ChannelVoiceMessagesPerNotePitchBend(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 14) { if let v = MIDI20ChannelVoiceMessagesPitchBend.decode(ump) { return .MIDI20ChannelVoiceMessagesPitchBend(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 10) { if let v = MIDI20ChannelVoiceMessagesPolyPressure.decode(ump) { return .MIDI20ChannelVoiceMessagesPolyPressure(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 12) { if let v = MIDI20ChannelVoiceMessagesProgramChangeMessage.decode(ump) { return .MIDI20ChannelVoiceMessagesProgramChangeMessage(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 2) { if let v = MIDI20ChannelVoiceMessagesRegisteredControllerRPN.decode(ump) { return .MIDI20ChannelVoiceMessagesRegisteredControllerRPN(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 0) { if let v = MIDI20ChannelVoiceMessagesRegisteredPerNoteController.decode(ump) { return .MIDI20ChannelVoiceMessagesRegisteredPerNoteController(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 5) { if let v = MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN.decode(ump) { return .MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN(v) } }
        if (getBits(ump.raw, offset: 0, width: 4) == 4 && getBits(ump.raw, offset: 8, width: 4) == 4) { if let v = MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN.decode(ump) { return .MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(v) } }
        return nil
        }
    }
    public static func decode(_ ump: UMP128) -> UMPAnyMessage? {
let mt = getBits128(ump.lo, ump.hi, offset: 0, width: 4)
        switch mt {
        case 5:
            let form = getBits128(ump.lo, ump.hi, offset: 8, width: 4)
            switch form {

            default: break
            }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 0) { if let v = SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket.decode(ump) { return .SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 8) { if let v = SysEx8andMDSMixedDataSetHeader.decode(ump) { return .SysEx8andMDSMixedDataSetHeader(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 9) { if let v = SysEx8andMDSMixedDataSetPayload.decode(ump) { return .SysEx8andMDSMixedDataSetPayload(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 2) { if let v = SysEx8andMDSSystemExclusive8ContinuePacket.decode(ump) { return .SysEx8andMDSSystemExclusive8ContinuePacket(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 1) { if let v = SysEx8andMDSSystemExclusive8StartPacket.decode(ump) { return .SysEx8andMDSSystemExclusive8StartPacket(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 5 && getBits128(ump.lo, ump.hi, offset: 8, width: 4) == 3) { if let v = SysEx8andMDSSystemExclusiveEndPacket.decode(ump) { return .SysEx8andMDSSystemExclusiveEndPacket(v) } }
        return nil
        case 13:
            let form2 = getBits128(ump.lo, ump.hi, offset: 12, width: 2)
            switch form2 {

            default: break
            }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 0) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 1) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 2) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 3) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 4) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 5) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 6) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 7) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 8) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 9) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 10) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 11) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 12) { if let v = FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 0) { if let v = FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 1) { if let v = FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 2) { if let v = FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 3) { if let v = FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 4) { if let v = FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 0) { if let v = FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0.decode(ump) { return .FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 1) { if let v = FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1.decode(ump) { return .FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 5) { if let v = FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5.decode(ump) { return .FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 6) { if let v = FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6.decode(ump) { return .FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0 && getBits128(ump.lo, ump.hi, offset: 24, width: 8) == 2) { if let v = FlexDataMessagesSubdivisionClicks1SubdivisionClicks1.decode(ump) { return .FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0) { if let v = FlexDataMessagesFlexDataMessages0x0.decode(ump) { return .FlexDataMessagesFlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0) { if let v = FlexDataMessagesFlexDataMessages0x0.decode(ump) { return .FlexDataMessagesFlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 0) { if let v = FlexDataMessagesFlexDataMessages0x0.decode(ump) { return .FlexDataMessagesFlexDataMessages0x0(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1) { if let v = FlexDataMessagesFlexDataMessages0x1.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1) { if let v = FlexDataMessagesFlexDataMessages0x1.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 1) { if let v = FlexDataMessagesFlexDataMessages0x1.decode(ump) { return .FlexDataMessagesFlexDataMessages0x1(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2) { if let v = FlexDataMessagesFlexDataMessages0x2.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2) { if let v = FlexDataMessagesFlexDataMessages0x2.decode(ump) { return .FlexDataMessagesFlexDataMessages0x2(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 3) { if let v = FlexDataMessagesFlexDataMessages0x3.decode(ump) { return .FlexDataMessagesFlexDataMessages0x3(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 3) { if let v = FlexDataMessagesFlexDataMessages0x3.decode(ump) { return .FlexDataMessagesFlexDataMessages0x3(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 4) { if let v = FlexDataMessagesFlexDataMessages0x4.decode(ump) { return .FlexDataMessagesFlexDataMessages0x4(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 4) { if let v = FlexDataMessagesFlexDataMessages0x4.decode(ump) { return .FlexDataMessagesFlexDataMessages0x4(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 5) { if let v = FlexDataMessagesFlexDataMessages0x5.decode(ump) { return .FlexDataMessagesFlexDataMessages0x5(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 5) { if let v = FlexDataMessagesFlexDataMessages0x5.decode(ump) { return .FlexDataMessagesFlexDataMessages0x5(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 6) { if let v = FlexDataMessagesFlexDataMessages0x6.decode(ump) { return .FlexDataMessagesFlexDataMessages0x6(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 6) { if let v = FlexDataMessagesFlexDataMessages0x6.decode(ump) { return .FlexDataMessagesFlexDataMessages0x6(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 7) { if let v = FlexDataMessagesFlexDataMessages0x7.decode(ump) { return .FlexDataMessagesFlexDataMessages0x7(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 8) { if let v = FlexDataMessagesFlexDataMessages0x8.decode(ump) { return .FlexDataMessagesFlexDataMessages0x8(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 9) { if let v = FlexDataMessagesFlexDataMessages0x9.decode(ump) { return .FlexDataMessagesFlexDataMessages0x9(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 10) { if let v = FlexDataMessagesFlexDataMessages0xA.decode(ump) { return .FlexDataMessagesFlexDataMessages0xA(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 11) { if let v = FlexDataMessagesFlexDataMessages0xB.decode(ump) { return .FlexDataMessagesFlexDataMessages0xB(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 12) { if let v = FlexDataMessagesFlexDataMessages0xC.decode(ump) { return .FlexDataMessagesFlexDataMessages0xC(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 13 && getBits128(ump.lo, ump.hi, offset: 16, width: 8) == 2) { if let v = FlexDataMessagesSubdivisionClicks1.decode(ump) { return .FlexDataMessagesSubdivisionClicks1(v) } }
        return nil
        case 15:
            let form2 = getBits128(ump.lo, ump.hi, offset: 4, width: 2)
            switch form2 {

            default: break
            }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 33) { if let v = MIDIEndpointEndofFileMessage.decode(ump) { return .MIDIEndpointEndofFileMessage(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 17) { if let v = MIDIEndpointFunctionBlockInfoNotification.decode(ump) { return .MIDIEndpointFunctionBlockInfoNotification(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 18) { if let v = MIDIEndpointFunctionBlockNameNotification.decode(ump) { return .MIDIEndpointFunctionBlockNameNotification(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 16) { if let v = MIDIEndpointGetFunctionBlockInfo.decode(ump) { return .MIDIEndpointGetFunctionBlockInfo(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 0) { if let v = MIDIEndpointGetMIDIEndpointInfo.decode(ump) { return .MIDIEndpointGetMIDIEndpointInfo(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 2) { if let v = MIDIEndpointMIDIEndpointDeviceInfoNotify.decode(ump) { return .MIDIEndpointMIDIEndpointDeviceInfoNotify(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 1) { if let v = MIDIEndpointMIDIEndpointInfoNotify.decode(ump) { return .MIDIEndpointMIDIEndpointInfoNotify(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 3) { if let v = MIDIEndpointMIDIEndpointNameNotify.decode(ump) { return .MIDIEndpointMIDIEndpointNameNotify(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 4) { if let v = MIDIEndpointMIDIEndpointProductInstanceIdNotify.decode(ump) { return .MIDIEndpointMIDIEndpointProductInstanceIdNotify(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 32) { if let v = MIDIEndpointStartofSequenceMessage.decode(ump) { return .MIDIEndpointStartofSequenceMessage(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 6) { if let v = MIDIEndpointStreamConfigurationNotify.decode(ump) { return .MIDIEndpointStreamConfigurationNotify(v) } }
        if (getBits128(ump.lo, ump.hi, offset: 0, width: 4) == 15 && getBits128(ump.lo, ump.hi, offset: 6, width: 10) == 5) { if let v = MIDIEndpointStreamConfigurationRequest.decode(ump) { return .MIDIEndpointStreamConfigurationRequest(v) } }
        return nil
        }
    }
}
