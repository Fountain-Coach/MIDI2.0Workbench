import XCTest
@testable import UMP

final class AllMessagesAutoVectorTests: XCTestCase {
    func testAllMessagesEncodeDecodeFromAutoVectors() throws {
        let base = try locateVectors()
        var arr: [[String: Any]] = []
        for name in ["auto_vectors.json", "ump_endpoint.json", "ump_flex.json"] {
            let url = base.appendingPathComponent(name)
            if FileManager.default.fileExists(atPath: url.path) {
                let data = try Data(contentsOf: url)
                let part = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                arr.append(contentsOf: part)
            }
        }
        let groups = Dictionary(grouping: arr, by: { $0["name"] as! String })
        for (name, vectors) in groups {
            for v in vectors.prefix(2) {
                guard let rawHex = v["raw"] as? String else { continue }
                let d = v["decoded"] as! [String: Any]
                switch name {
            case "UtilityMessages.NOOP":
                let group = UInt8(d["group"] as! Int)
                let msg = make_UtilityMessagesNOOP(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(UtilityMessagesNOOP.decode(raw))
                return
            case "UtilityMessages.JRClock":
                let group = UInt8(d["group"] as! Int)
                let msg = make_UtilityMessagesJRClock(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(UtilityMessagesJRClock.decode(raw))
                return
            case "UtilityMessages.JRTimestamp":
                let group = UInt8(d["group"] as! Int)
                let msg = make_UtilityMessagesJRTimestamp(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(UtilityMessagesJRTimestamp.decode(raw))
                return
            case "UtilityMessages.DeltaClockstampTicksPerQuarterNote":
                let group = UInt8(d["group"] as! Int)
                let msg = make_UtilityMessagesDeltaClockstampTicksPerQuarterNote(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(UtilityMessagesDeltaClockstampTicksPerQuarterNote.decode(raw))
                return
            case "UtilityMessages.DeltaClockstamp":
                let group = UInt8(d["group"] as! Int)
                let msg = make_UtilityMessagesDeltaClockstamp(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(UtilityMessagesDeltaClockstamp.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.MIDITimeCode":
                let group = UInt8(d["group"] as! Int)
                let nnndddd = UInt8(d["nnndddd"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesMIDITimeCode(group, nnndddd)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesMIDITimeCode.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.SongPositionPointer":
                let group = UInt8(d["group"] as! Int)
                let lllllll = UInt8(d["lllllll"] as! Int)
                let mmmmmmm = UInt8(d["mmmmmmm"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesSongPositionPointer(group, lllllll, mmmmmmm)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesSongPositionPointer.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.SongSelect":
                let group = UInt8(d["group"] as! Int)
                let sssssss = UInt8(d["sssssss"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesSongSelect(group, sssssss)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesSongSelect.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.TuneRequest":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesTuneRequest(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesTuneRequest.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.TimingClock":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesTimingClock(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesTimingClock.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.Start":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesStart(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesStart.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.Continue":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesContinue(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesContinue.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.Stop":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesStop(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesStop.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.ActiveSensing":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesActiveSensing(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesActiveSensing.decode(raw))
                return
            case "SystemRealTimeandSystemCommonMessages.Reset":
                let group = UInt8(d["group"] as! Int)
                let msg = make_SystemRealTimeandSystemCommonMessagesReset(group)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SystemRealTimeandSystemCommonMessagesReset.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.NoteOff":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let velocity = UInt8(d["velocity"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesNoteOff(group, channel, notenumber, velocity)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesNoteOff.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.NoteOn":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let velocity = UInt8(d["velocity"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesNoteOn(group, channel, notenumber, velocity)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesNoteOn.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.PolyPressure":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let pressure = UInt8(d["Pressure"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesPolyPressure(group, channel, notenumber, pressure)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesPolyPressure.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.ControlChangeMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt8(d["value"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesControlChangeMessage(group, channel, index, value)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesControlChangeMessage.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.ProgramChangeMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let program = UInt8(d["program"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesProgramChangeMessage(group, channel, program)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesProgramChangeMessage.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.ChannelPressureMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let pressure = UInt8(d["Pressure"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesChannelPressureMessage(group, channel, pressure)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesChannelPressureMessage.decode(raw))
                return
            case "MIDI10ChannelVoiceMessages.PitchBend":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let lsbdata = UInt8(d["LSBdata"] as! Int)
                let msbdata = UInt8(d["MSBdata"] as! Int)
                let msg = make_MIDI10ChannelVoiceMessagesPitchBend(group, channel, lsbdata, msbdata)
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI10ChannelVoiceMessagesPitchBend.decode(raw))
                return
            case "SysEx.CompleteSystemExclusiveMessageinOnePacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let msg = make_SysExCompleteSystemExclusiveMessageinOnePacket(group, bytecount, byte1, byte2, byte3, byte4, byte5, byte6)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SysExCompleteSystemExclusiveMessageinOnePacket.decode(raw))
                return
            case "SysEx.SystemExclusiveStartPacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let msg = make_SysExSystemExclusiveStartPacket(group, bytecount, byte1, byte2, byte3, byte4, byte5, byte6)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SysExSystemExclusiveStartPacket.decode(raw))
                return
            case "SysEx.SystemExclusiveContinuePacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let msg = make_SysExSystemExclusiveContinuePacket(group, bytecount, byte1, byte2, byte3, byte4, byte5, byte6)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SysExSystemExclusiveContinuePacket.decode(raw))
                return
            case "SysEx.SystemExclusiveEndPacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let msg = make_SysExSystemExclusiveEndPacket(group, bytecount, byte1, byte2, byte3, byte4, byte5, byte6)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(SysExSystemExclusiveEndPacket.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.NoteOff":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let attributetype = UInt8(d["attributeType"] as! Int)
                let velocity = UInt16(d["velocity"] as! Int)
                let attribute = UInt16(d["attribute"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesNoteOff(group, channel, notenumber, attributetype, velocity, attribute)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesNoteOff.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.NoteOn":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let attributetype = UInt8(d["attributeType"] as! Int)
                let velocity = UInt16(d["velocity"] as! Int)
                let attribute = UInt16(d["attribute"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesNoteOn(group, channel, notenumber, attributetype, velocity, attribute)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesNoteOn.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.PolyPressure":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let pressure = UInt32(d["Pressure"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesPolyPressure(group, channel, notenumber, pressure)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesPolyPressure.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.ControlChangeMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesControlChangeMessage(group, channel, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesControlChangeMessage.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.RegisteredControllerRPN":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let bank = UInt8(d["Bank"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesRegisteredControllerRPN(group, channel, bank, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesRegisteredControllerRPN.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.AssignableControllerNRPNMessages":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let bank = UInt8(d["Bank"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages(group, channel, bank, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.RelativeRegisteredControllerRPN":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let bank = UInt8(d["Bank"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(group, channel, bank, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.RelativeAssignableControllerNRPN":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let bank = UInt8(d["Bank"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN(group, channel, bank, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.ProgramChangeMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let bankvalid = UInt8(d["bankValid"] as! Int)
                let program = UInt8(d["program"] as! Int)
                let bankmsb = UInt8(d["BankMSB"] as! Int)
                let banklsb = UInt8(d["BankLSB"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesProgramChangeMessage(group, channel, bankvalid, program, bankmsb, banklsb)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesProgramChangeMessage.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.ChannelPressureMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let pressure = UInt32(d["Pressure"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesChannelPressureMessage(group, channel, pressure)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesChannelPressureMessage.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.PitchBend":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let pitch = UInt32(d["pitch"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesPitchBend(group, channel, pitch)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesPitchBend.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.PerNotePitchBend":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let pitch = UInt32(d["pitch"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesPerNotePitchBend(group, channel, notenumber, pitch)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesPerNotePitchBend.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.AssignablePerNoteController":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesAssignablePerNoteController(group, channel, notenumber, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesAssignablePerNoteController.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.RegisteredPerNoteController":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let index = UInt8(d["index"] as! Int)
                let value = UInt32(d["value"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesRegisteredPerNoteController(group, channel, notenumber, index, value)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesRegisteredPerNoteController.decode(raw))
                return
            case "MIDI20ChannelVoiceMessages.PerNoteManagementMessage":
                let group = UInt8(d["group"] as! Int)
                let channel = UInt8(d["channel"] as! Int)
                let notenumber = UInt8(d["noteNumber"] as! Int)
                let detachpernotecontrollersfrompreviouslyreceivednotes = UInt8(d["DetachPerNotecontrollersfrompreviouslyreceivedNotes"] as! Int)
                let resetsetpernotecontrollerstodefaultvalues = UInt8(d["ResetSetPerNotecontrollerstodefaultvalues"] as! Int)
                let msg = make_MIDI20ChannelVoiceMessagesPerNoteManagementMessage(group, channel, notenumber, detachpernotecontrollersfrompreviouslyreceivednotes, resetsetpernotecontrollerstodefaultvalues)
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(MIDI20ChannelVoiceMessagesPerNoteManagementMessage.decode(raw))
                return
            case "SysEx8andMDS.CompleteSystemExclusive8MessageinOnePacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let streamid = UInt8(d["streamid"] as! Int)
                let msg = make_SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket(group, bytecount, streamid)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket.decode(raw))
                return
            case "SysEx8andMDS.SystemExclusive8StartPacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let streamid = UInt8(d["streamid"] as! Int)
                let msg = make_SysEx8andMDSSystemExclusive8StartPacket(group, bytecount, streamid)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSSystemExclusive8StartPacket.decode(raw))
                return
            case "SysEx8andMDS.SystemExclusive8ContinuePacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let streamid = UInt8(d["streamid"] as! Int)
                let msg = make_SysEx8andMDSSystemExclusive8ContinuePacket(group, bytecount, streamid)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSSystemExclusive8ContinuePacket.decode(raw))
                return
            case "SysEx8andMDS.SystemExclusiveEndPacket":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let streamid = UInt8(d["streamid"] as! Int)
                let msg = make_SysEx8andMDSSystemExclusiveEndPacket(group, bytecount, streamid)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSSystemExclusiveEndPacket.decode(raw))
                return
            case "SysEx8andMDS.MixedDataSetHeader":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let mdsid = UInt8(d["mdsId"] as! Int)
                let numberofvalidbytesinthismessagechunk = UInt8(d["numberofvalidbytesinthismessagechunk"] as! Int)
                let numberofchunksinmixeddataset = UInt16(d["numberofchunksinmixeddataset"] as! Int)
                let numberofthischunk = UInt16(d["numberofthischunk"] as! Int)
                let manufacturerid = UInt16(d["manufacturerid"] as! Int)
                let deviceid = UInt16(d["deviceid"] as! Int)
                let subid1 = UInt16(d["subid1"] as! Int)
                let subid2 = UInt16(d["subid2"] as! Int)
                let msg = make_SysEx8andMDSMixedDataSetHeader(group, bytecount, mdsid, numberofvalidbytesinthismessagechunk, numberofchunksinmixeddataset, numberofthischunk, manufacturerid, deviceid, subid1, subid2)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSMixedDataSetHeader.decode(raw))
                return
            case "SysEx8andMDS.MixedDataSetPayload":
                let group = UInt8(d["group"] as! Int)
                let bytecount = UInt8(d["byteCount"] as! Int)
                let mdsid = UInt8(d["mdsId"] as! Int)
                let msg = make_SysEx8andMDSMixedDataSetPayload(group, bytecount, mdsid)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(SysEx8andMDSMixedDataSetPayload.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1SubdivisionClicks1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let subdivisionclicks1 = UInt8(d["SubdivisionClicks1"] as! Int)
                let subdivisionclicks2 = UInt8(d["SubdivisionClicks2"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(channel, group, form, subdivisionclicks1, subdivisionclicks2)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1SubdivisionClicks1.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1FlexDataMessages0x5":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1FlexDataMessages0x6":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.SubdivisionClicks1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let subdivisionclicks1 = UInt8(d["SubdivisionClicks1"] as! Int)
                let subdivisionclicks2 = UInt8(d["SubdivisionClicks2"] as! Int)
                let msg = make_FlexDataMessagesSubdivisionClicks1(channel, group, form, subdivisionclicks1, subdivisionclicks2)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesSubdivisionClicks1.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x5":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x5(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x5.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x6":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x6(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x6.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x2":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x3":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x4":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x5":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x6":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x7":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x8":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0x9":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0xA":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0xB":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1FlexDataMessages0xC":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x3":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x3(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x3.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x4":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x4(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x4.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x5":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x5(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x5.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x6":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x6(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x6.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x7":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x7(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x7.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x8":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x8(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x8.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x9":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x9(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x9.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0xA":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0xA(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0xA.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0xB":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0xB(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0xB.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0xC":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0xC(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0xC.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2FlexDataMessages0x2":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2FlexDataMessages0x3":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2FlexDataMessages0x4":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x0":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x0(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x0.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x1":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x1(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x1.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x2":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x2(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x2.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x3":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x3(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x3.decode(raw))
                return
            case "FlexDataMessages.FlexDataMessages0x4":
                let channel = UInt8(d["channel"] as! Int)
                let group = UInt8(d["group"] as! Int)
                let form = UInt8(d["form"] as! Int)
                let msg = make_FlexDataMessagesFlexDataMessages0x4(channel, group, form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(FlexDataMessagesFlexDataMessages0x4.decode(raw))
                return
            case "MIDIEndpoint.GetMIDIEndpointInfo":
                let form = UInt8(d["form"] as! Int)
                let umpversionmajor = UInt8(d["UMPVersionMajor"] as! Int)
                let umpversionminor = UInt8(d["UMPVersionMinor"] as! Int)
                let msg = make_MIDIEndpointGetMIDIEndpointInfo(form, umpversionmajor, umpversionminor)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointGetMIDIEndpointInfo.decode(raw))
                return
            case "MIDIEndpoint.MIDIEndpointInfoNotify":
                let form = UInt8(d["form"] as! Int)
                let umpversionmajor = UInt8(d["UMPVersionMajor"] as! Int)
                let umpversionminor = UInt8(d["UMPVersionMinor"] as! Int)
                let staticfunctionblocks = UInt8(d["StaticFunctionBlocks"] as! Int)
                let numberoffunctionblocks = UInt8(d["NumberofFunctionBlocks"] as! Int)
                let msg = make_MIDIEndpointMIDIEndpointInfoNotify(form, umpversionmajor, umpversionminor, staticfunctionblocks, numberoffunctionblocks)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointMIDIEndpointInfoNotify.decode(raw))
                return
            case "MIDIEndpoint.MIDIEndpointDeviceInfoNotify":
                let form = UInt8(d["form"] as! Int)
                let manufactureridbyte1 = UInt8(d["ManufacturerIdByte1"] as! Int)
                let manufactureridbyte2 = UInt8(d["ManufacturerIdByte2"] as! Int)
                let manufactureridbyte3 = UInt8(d["ManufacturerIdByte3"] as! Int)
                let familyidlsb = UInt8(d["FamilyIdLSB"] as! Int)
                let familyidmsb = UInt8(d["FamilyIdMSB"] as! Int)
                let modelidlsb = UInt8(d["ModelIdLSB"] as! Int)
                let modelidmsb = UInt8(d["ModelIdMSB"] as! Int)
                let softwarerevisionlevel1 = UInt8(d["SoftwareRevisionLevel1"] as! Int)
                let softwarerevisionlevel2 = UInt8(d["SoftwareRevisionLevel2"] as! Int)
                let softwarerevisionlevel3 = UInt8(d["SoftwareRevisionLevel3"] as! Int)
                let softwarerevisionlevel4 = UInt8(d["SoftwareRevisionLevel4"] as! Int)
                let msg = make_MIDIEndpointMIDIEndpointDeviceInfoNotify(form, manufactureridbyte1, manufactureridbyte2, manufactureridbyte3, familyidlsb, familyidmsb, modelidlsb, modelidmsb, softwarerevisionlevel1, softwarerevisionlevel2, softwarerevisionlevel3, softwarerevisionlevel4)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointMIDIEndpointDeviceInfoNotify.decode(raw))
                return
            case "MIDIEndpoint.MIDIEndpointNameNotify":
                let form = UInt8(d["form"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let byte7 = UInt8(d["Byte7"] as! Int)
                let byte8 = UInt8(d["Byte8"] as! Int)
                let byte9 = UInt8(d["Byte9"] as! Int)
                let byte10 = UInt8(d["Byte10"] as! Int)
                let byte11 = UInt8(d["Byte11"] as! Int)
                let byte12 = UInt8(d["Byte12"] as! Int)
                let byte13 = UInt8(d["Byte13"] as! Int)
                let byte14 = UInt8(d["Byte14"] as! Int)
                let msg = make_MIDIEndpointMIDIEndpointNameNotify(form, byte1, byte2, byte3, byte4, byte5, byte6, byte7, byte8, byte9, byte10, byte11, byte12, byte13, byte14)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointMIDIEndpointNameNotify.decode(raw))
                return
            case "MIDIEndpoint.MIDIEndpointProductInstanceIdNotify":
                let form = UInt8(d["form"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let byte7 = UInt8(d["Byte7"] as! Int)
                let byte8 = UInt8(d["Byte8"] as! Int)
                let byte9 = UInt8(d["Byte9"] as! Int)
                let byte10 = UInt8(d["Byte10"] as! Int)
                let byte11 = UInt8(d["Byte11"] as! Int)
                let byte12 = UInt8(d["Byte12"] as! Int)
                let byte13 = UInt8(d["Byte13"] as! Int)
                let byte14 = UInt8(d["Byte14"] as! Int)
                let msg = make_MIDIEndpointMIDIEndpointProductInstanceIdNotify(form, byte1, byte2, byte3, byte4, byte5, byte6, byte7, byte8, byte9, byte10, byte11, byte12, byte13, byte14)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointMIDIEndpointProductInstanceIdNotify.decode(raw))
                return
            case "MIDIEndpoint.StreamConfigurationRequest":
                let form = UInt8(d["form"] as! Int)
                let _protocol = UInt8(d["Protocol"] as! Int)
                let msg = make_MIDIEndpointStreamConfigurationRequest(form, _protocol)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointStreamConfigurationRequest.decode(raw))
                return
            case "MIDIEndpoint.StreamConfigurationNotify":
                let form = UInt8(d["form"] as! Int)
                let _protocol = UInt8(d["Protocol"] as! Int)
                let msg = make_MIDIEndpointStreamConfigurationNotify(form, _protocol)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointStreamConfigurationNotify.decode(raw))
                return
            case "MIDIEndpoint.GetFunctionBlockInfo":
                let form = UInt8(d["form"] as! Int)
                let functionblock = UInt8(d["FunctionBlock"] as! Int)
                let requestingafunctionblocknamenotification = UInt8(d["RequestingaFunctionBlockNameNotification"] as! Int)
                let requestingafunctionblockinfonotification = UInt8(d["RequestingaFunctionBlockInfoNotification"] as! Int)
                let msg = make_MIDIEndpointGetFunctionBlockInfo(form, functionblock, requestingafunctionblocknamenotification, requestingafunctionblockinfonotification)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointGetFunctionBlockInfo.decode(raw))
                return
            case "MIDIEndpoint.FunctionBlockInfoNotification":
                let form = UInt8(d["form"] as! Int)
                let active = UInt8(d["Active"] as! Int)
                let functionblock = UInt8(d["FunctionBlock"] as! Int)
                let uihint = UInt8(d["UIHint"] as! Int)
                let ismidi10 = UInt8(d["IsMIDI10"] as! Int)
                let direction = UInt8(d["Direction"] as! Int)
                let firstgroup = UInt8(d["FirstGroup"] as! Int)
                let grouplength = UInt8(d["GroupLength"] as! Int)
                let midicisupport = UInt8(d["MIDICISupport"] as! Int)
                let maxsysexstreams = UInt8(d["MaxSysExStreams"] as! Int)
                let msg = make_MIDIEndpointFunctionBlockInfoNotification(form, active, functionblock, uihint, ismidi10, direction, firstgroup, grouplength, midicisupport, maxsysexstreams)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointFunctionBlockInfoNotification.decode(raw))
                return
            case "MIDIEndpoint.FunctionBlockNameNotification":
                let form = UInt8(d["form"] as! Int)
                let functionblock = UInt8(d["FunctionBlock"] as! Int)
                let byte1 = UInt8(d["Byte1"] as! Int)
                let byte2 = UInt8(d["Byte2"] as! Int)
                let byte3 = UInt8(d["Byte3"] as! Int)
                let byte4 = UInt8(d["Byte4"] as! Int)
                let byte5 = UInt8(d["Byte5"] as! Int)
                let byte6 = UInt8(d["Byte6"] as! Int)
                let byte7 = UInt8(d["Byte7"] as! Int)
                let byte8 = UInt8(d["Byte8"] as! Int)
                let byte9 = UInt8(d["Byte9"] as! Int)
                let byte10 = UInt8(d["Byte10"] as! Int)
                let byte11 = UInt8(d["Byte11"] as! Int)
                let byte12 = UInt8(d["Byte12"] as! Int)
                let byte13 = UInt8(d["Byte13"] as! Int)
                let msg = make_MIDIEndpointFunctionBlockNameNotification(form, functionblock, byte1, byte2, byte3, byte4, byte5, byte6, byte7, byte8, byte9, byte10, byte11, byte12, byte13)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointFunctionBlockNameNotification.decode(raw))
                return
            case "MIDIEndpoint.StartofSequenceMessage":
                let form = UInt8(d["form"] as! Int)
                let msg = make_MIDIEndpointStartofSequenceMessage(form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointStartofSequenceMessage.decode(raw))
                return
            case "MIDIEndpoint.EndofFileMessage":
                let form = UInt8(d["form"] as! Int)
                let msg = make_MIDIEndpointEndofFileMessage(form)
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(MIDIEndpointEndofFileMessage.decode(raw))
                return
                default: continue
                }
            }
        }
    }

private func make_UtilityMessagesNOOP(group: UInt8) -> UtilityMessagesNOOP { UtilityMessagesNOOP(group: group) }
private func make_UtilityMessagesJRClock(group: UInt8) -> UtilityMessagesJRClock { UtilityMessagesJRClock(group: group) }
private func make_UtilityMessagesJRTimestamp(group: UInt8) -> UtilityMessagesJRTimestamp { UtilityMessagesJRTimestamp(group: group) }
private func make_UtilityMessagesDeltaClockstampTicksPerQuarterNote(group: UInt8) -> UtilityMessagesDeltaClockstampTicksPerQuarterNote { UtilityMessagesDeltaClockstampTicksPerQuarterNote(group: group) }
private func make_UtilityMessagesDeltaClockstamp(group: UInt8) -> UtilityMessagesDeltaClockstamp { UtilityMessagesDeltaClockstamp(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesMIDITimeCode(group: UInt8, nnndddd: UInt8) -> SystemRealTimeandSystemCommonMessagesMIDITimeCode { SystemRealTimeandSystemCommonMessagesMIDITimeCode(group: group, nnndddd: nnndddd) }
private func make_SystemRealTimeandSystemCommonMessagesSongPositionPointer(group: UInt8, lllllll: UInt8, mmmmmmm: UInt8) -> SystemRealTimeandSystemCommonMessagesSongPositionPointer { SystemRealTimeandSystemCommonMessagesSongPositionPointer(group: group, lllllll: lllllll, mmmmmmm: mmmmmmm) }
private func make_SystemRealTimeandSystemCommonMessagesSongSelect(group: UInt8, sssssss: UInt8) -> SystemRealTimeandSystemCommonMessagesSongSelect { SystemRealTimeandSystemCommonMessagesSongSelect(group: group, sssssss: sssssss) }
private func make_SystemRealTimeandSystemCommonMessagesTuneRequest(group: UInt8) -> SystemRealTimeandSystemCommonMessagesTuneRequest { SystemRealTimeandSystemCommonMessagesTuneRequest(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesTimingClock(group: UInt8) -> SystemRealTimeandSystemCommonMessagesTimingClock { SystemRealTimeandSystemCommonMessagesTimingClock(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesStart(group: UInt8) -> SystemRealTimeandSystemCommonMessagesStart { SystemRealTimeandSystemCommonMessagesStart(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesContinue(group: UInt8) -> SystemRealTimeandSystemCommonMessagesContinue { SystemRealTimeandSystemCommonMessagesContinue(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesStop(group: UInt8) -> SystemRealTimeandSystemCommonMessagesStop { SystemRealTimeandSystemCommonMessagesStop(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesActiveSensing(group: UInt8) -> SystemRealTimeandSystemCommonMessagesActiveSensing { SystemRealTimeandSystemCommonMessagesActiveSensing(group: group) }
private func make_SystemRealTimeandSystemCommonMessagesReset(group: UInt8) -> SystemRealTimeandSystemCommonMessagesReset { SystemRealTimeandSystemCommonMessagesReset(group: group) }
private func make_MIDI10ChannelVoiceMessagesNoteOff(group: UInt8, channel: UInt8, notenumber: UInt8, velocity: UInt8) -> MIDI10ChannelVoiceMessagesNoteOff { MIDI10ChannelVoiceMessagesNoteOff(group: group, channel: channel, notenumber: notenumber, velocity: velocity) }
private func make_MIDI10ChannelVoiceMessagesNoteOn(group: UInt8, channel: UInt8, notenumber: UInt8, velocity: UInt8) -> MIDI10ChannelVoiceMessagesNoteOn { MIDI10ChannelVoiceMessagesNoteOn(group: group, channel: channel, notenumber: notenumber, velocity: velocity) }
private func make_MIDI10ChannelVoiceMessagesPolyPressure(group: UInt8, channel: UInt8, notenumber: UInt8, pressure: UInt8) -> MIDI10ChannelVoiceMessagesPolyPressure { MIDI10ChannelVoiceMessagesPolyPressure(group: group, channel: channel, notenumber: notenumber, pressure: pressure) }
private func make_MIDI10ChannelVoiceMessagesControlChangeMessage(group: UInt8, channel: UInt8, index: UInt8, value: UInt8) -> MIDI10ChannelVoiceMessagesControlChangeMessage { MIDI10ChannelVoiceMessagesControlChangeMessage(group: group, channel: channel, index: index, value: value) }
private func make_MIDI10ChannelVoiceMessagesProgramChangeMessage(group: UInt8, channel: UInt8, program: UInt8) -> MIDI10ChannelVoiceMessagesProgramChangeMessage { MIDI10ChannelVoiceMessagesProgramChangeMessage(group: group, channel: channel, program: program) }
private func make_MIDI10ChannelVoiceMessagesChannelPressureMessage(group: UInt8, channel: UInt8, pressure: UInt8) -> MIDI10ChannelVoiceMessagesChannelPressureMessage { MIDI10ChannelVoiceMessagesChannelPressureMessage(group: group, channel: channel, pressure: pressure) }
private func make_MIDI10ChannelVoiceMessagesPitchBend(group: UInt8, channel: UInt8, lsbdata: UInt8, msbdata: UInt8) -> MIDI10ChannelVoiceMessagesPitchBend { MIDI10ChannelVoiceMessagesPitchBend(group: group, channel: channel, lsbdata: lsbdata, msbdata: msbdata) }
private func make_SysExCompleteSystemExclusiveMessageinOnePacket(group: UInt8, bytecount: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8) -> SysExCompleteSystemExclusiveMessageinOnePacket { SysExCompleteSystemExclusiveMessageinOnePacket(group: group, bytecount: bytecount, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6) }
private func make_SysExSystemExclusiveStartPacket(group: UInt8, bytecount: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8) -> SysExSystemExclusiveStartPacket { SysExSystemExclusiveStartPacket(group: group, bytecount: bytecount, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6) }
private func make_SysExSystemExclusiveContinuePacket(group: UInt8, bytecount: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8) -> SysExSystemExclusiveContinuePacket { SysExSystemExclusiveContinuePacket(group: group, bytecount: bytecount, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6) }
private func make_SysExSystemExclusiveEndPacket(group: UInt8, bytecount: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8) -> SysExSystemExclusiveEndPacket { SysExSystemExclusiveEndPacket(group: group, bytecount: bytecount, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6) }
private func make_MIDI20ChannelVoiceMessagesNoteOff(group: UInt8, channel: UInt8, notenumber: UInt8, attributetype: UInt8, velocity: UInt16, attribute: UInt16) -> MIDI20ChannelVoiceMessagesNoteOff { MIDI20ChannelVoiceMessagesNoteOff(group: group, channel: channel, notenumber: notenumber, attributetype: attributetype, velocity: velocity, attribute: attribute) }
private func make_MIDI20ChannelVoiceMessagesNoteOn(group: UInt8, channel: UInt8, notenumber: UInt8, attributetype: UInt8, velocity: UInt16, attribute: UInt16) -> MIDI20ChannelVoiceMessagesNoteOn { MIDI20ChannelVoiceMessagesNoteOn(group: group, channel: channel, notenumber: notenumber, attributetype: attributetype, velocity: velocity, attribute: attribute) }
private func make_MIDI20ChannelVoiceMessagesPolyPressure(group: UInt8, channel: UInt8, notenumber: UInt8, pressure: UInt32) -> MIDI20ChannelVoiceMessagesPolyPressure { MIDI20ChannelVoiceMessagesPolyPressure(group: group, channel: channel, notenumber: notenumber, pressure: pressure) }
private func make_MIDI20ChannelVoiceMessagesControlChangeMessage(group: UInt8, channel: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesControlChangeMessage { MIDI20ChannelVoiceMessagesControlChangeMessage(group: group, channel: channel, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesRegisteredControllerRPN(group: UInt8, channel: UInt8, bank: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesRegisteredControllerRPN { MIDI20ChannelVoiceMessagesRegisteredControllerRPN(group: group, channel: channel, bank: bank, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages(group: UInt8, channel: UInt8, bank: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages { MIDI20ChannelVoiceMessagesAssignableControllerNRPNMessages(group: group, channel: channel, bank: bank, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(group: UInt8, channel: UInt8, bank: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN { MIDI20ChannelVoiceMessagesRelativeRegisteredControllerRPN(group: group, channel: channel, bank: bank, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN(group: UInt8, channel: UInt8, bank: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN { MIDI20ChannelVoiceMessagesRelativeAssignableControllerNRPN(group: group, channel: channel, bank: bank, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesProgramChangeMessage(group: UInt8, channel: UInt8, bankvalid: UInt8, program: UInt8, bankmsb: UInt8, banklsb: UInt8) -> MIDI20ChannelVoiceMessagesProgramChangeMessage { MIDI20ChannelVoiceMessagesProgramChangeMessage(group: group, channel: channel, bankvalid: bankvalid, program: program, bankmsb: bankmsb, banklsb: banklsb) }
private func make_MIDI20ChannelVoiceMessagesChannelPressureMessage(group: UInt8, channel: UInt8, pressure: UInt32) -> MIDI20ChannelVoiceMessagesChannelPressureMessage { MIDI20ChannelVoiceMessagesChannelPressureMessage(group: group, channel: channel, pressure: pressure) }
private func make_MIDI20ChannelVoiceMessagesPitchBend(group: UInt8, channel: UInt8, pitch: UInt32) -> MIDI20ChannelVoiceMessagesPitchBend { MIDI20ChannelVoiceMessagesPitchBend(group: group, channel: channel, pitch: pitch) }
private func make_MIDI20ChannelVoiceMessagesPerNotePitchBend(group: UInt8, channel: UInt8, notenumber: UInt8, pitch: UInt32) -> MIDI20ChannelVoiceMessagesPerNotePitchBend { MIDI20ChannelVoiceMessagesPerNotePitchBend(group: group, channel: channel, notenumber: notenumber, pitch: pitch) }
private func make_MIDI20ChannelVoiceMessagesAssignablePerNoteController(group: UInt8, channel: UInt8, notenumber: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesAssignablePerNoteController { MIDI20ChannelVoiceMessagesAssignablePerNoteController(group: group, channel: channel, notenumber: notenumber, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesRegisteredPerNoteController(group: UInt8, channel: UInt8, notenumber: UInt8, index: UInt8, value: UInt32) -> MIDI20ChannelVoiceMessagesRegisteredPerNoteController { MIDI20ChannelVoiceMessagesRegisteredPerNoteController(group: group, channel: channel, notenumber: notenumber, index: index, value: value) }
private func make_MIDI20ChannelVoiceMessagesPerNoteManagementMessage(group: UInt8, channel: UInt8, notenumber: UInt8, detachpernotecontrollersfrompreviouslyreceivednotes: UInt8, resetsetpernotecontrollerstodefaultvalues: UInt8) -> MIDI20ChannelVoiceMessagesPerNoteManagementMessage { MIDI20ChannelVoiceMessagesPerNoteManagementMessage(group: group, channel: channel, notenumber: notenumber, detachpernotecontrollersfrompreviouslyreceivednotes: detachpernotecontrollersfrompreviouslyreceivednotes, resetsetpernotecontrollerstodefaultvalues: resetsetpernotecontrollerstodefaultvalues) }
private func make_SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket(group: UInt8, bytecount: UInt8, streamid: UInt8) -> SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket { SysEx8andMDSCompleteSystemExclusive8MessageinOnePacket(group: group, bytecount: bytecount, streamid: streamid) }
private func make_SysEx8andMDSSystemExclusive8StartPacket(group: UInt8, bytecount: UInt8, streamid: UInt8) -> SysEx8andMDSSystemExclusive8StartPacket { SysEx8andMDSSystemExclusive8StartPacket(group: group, bytecount: bytecount, streamid: streamid) }
private func make_SysEx8andMDSSystemExclusive8ContinuePacket(group: UInt8, bytecount: UInt8, streamid: UInt8) -> SysEx8andMDSSystemExclusive8ContinuePacket { SysEx8andMDSSystemExclusive8ContinuePacket(group: group, bytecount: bytecount, streamid: streamid) }
private func make_SysEx8andMDSSystemExclusiveEndPacket(group: UInt8, bytecount: UInt8, streamid: UInt8) -> SysEx8andMDSSystemExclusiveEndPacket { SysEx8andMDSSystemExclusiveEndPacket(group: group, bytecount: bytecount, streamid: streamid) }
private func make_SysEx8andMDSMixedDataSetHeader(group: UInt8, bytecount: UInt8, mdsid: UInt8, numberofvalidbytesinthismessagechunk: UInt8, numberofchunksinmixeddataset: UInt16, numberofthischunk: UInt16, manufacturerid: UInt16, deviceid: UInt16, subid1: UInt16, subid2: UInt16) -> SysEx8andMDSMixedDataSetHeader { SysEx8andMDSMixedDataSetHeader(group: group, bytecount: bytecount, mdsid: mdsid, numberofvalidbytesinthismessagechunk: numberofvalidbytesinthismessagechunk, numberofchunksinmixeddataset: numberofchunksinmixeddataset, numberofthischunk: numberofthischunk, manufacturerid: manufacturerid, deviceid: deviceid, subid1: subid1, subid2: subid2) }
private func make_SysEx8andMDSMixedDataSetPayload(group: UInt8, bytecount: UInt8, mdsid: UInt8) -> SysEx8andMDSMixedDataSetPayload { SysEx8andMDSMixedDataSetPayload(group: group, bytecount: bytecount, mdsid: mdsid) }
private func make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0 { FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1 { FlexDataMessagesSubdivisionClicks1FlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(channel: UInt8, group: UInt8, form: UInt8, subdivisionclicks1: UInt8, subdivisionclicks2: UInt8) -> FlexDataMessagesSubdivisionClicks1SubdivisionClicks1 { FlexDataMessagesSubdivisionClicks1SubdivisionClicks1(channel: channel, group: group, form: form, subdivisionclicks1: subdivisionclicks1, subdivisionclicks2: subdivisionclicks2) }
private func make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5 { FlexDataMessagesSubdivisionClicks1FlexDataMessages0x5(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6 { FlexDataMessagesSubdivisionClicks1FlexDataMessages0x6(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x0 { FlexDataMessagesFlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1 { FlexDataMessagesFlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesSubdivisionClicks1(channel: UInt8, group: UInt8, form: UInt8, subdivisionclicks1: UInt8, subdivisionclicks2: UInt8) -> FlexDataMessagesSubdivisionClicks1 { FlexDataMessagesSubdivisionClicks1(channel: channel, group: group, form: form, subdivisionclicks1: subdivisionclicks1, subdivisionclicks2: subdivisionclicks2) }
private func make_FlexDataMessagesFlexDataMessages0x5(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x5 { FlexDataMessagesFlexDataMessages0x5(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x6(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x6 { FlexDataMessagesFlexDataMessages0x6(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x2(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x3(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x4(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x5(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x6(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x7(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x8(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9 { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0x9(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xA(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xB(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC { FlexDataMessagesFlexDataMessages0x1FlexDataMessages0xC(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x0 { FlexDataMessagesFlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1 { FlexDataMessagesFlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2 { FlexDataMessagesFlexDataMessages0x2(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x3(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x3 { FlexDataMessagesFlexDataMessages0x3(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x4(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x4 { FlexDataMessagesFlexDataMessages0x4(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x5(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x5 { FlexDataMessagesFlexDataMessages0x5(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x6(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x6 { FlexDataMessagesFlexDataMessages0x6(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x7(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x7 { FlexDataMessagesFlexDataMessages0x7(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x8(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x8 { FlexDataMessagesFlexDataMessages0x8(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x9(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x9 { FlexDataMessagesFlexDataMessages0x9(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0xA(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0xA { FlexDataMessagesFlexDataMessages0xA(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0xB(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0xB { FlexDataMessagesFlexDataMessages0xB(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0xC(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0xC { FlexDataMessagesFlexDataMessages0xC(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0 { FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1 { FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2 { FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x2(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3 { FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x3(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4 { FlexDataMessagesFlexDataMessages0x2FlexDataMessages0x4(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x0(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x0 { FlexDataMessagesFlexDataMessages0x0(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x1(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x1 { FlexDataMessagesFlexDataMessages0x1(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x2(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x2 { FlexDataMessagesFlexDataMessages0x2(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x3(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x3 { FlexDataMessagesFlexDataMessages0x3(channel: channel, group: group, form: form) }
private func make_FlexDataMessagesFlexDataMessages0x4(channel: UInt8, group: UInt8, form: UInt8) -> FlexDataMessagesFlexDataMessages0x4 { FlexDataMessagesFlexDataMessages0x4(channel: channel, group: group, form: form) }
private func make_MIDIEndpointGetMIDIEndpointInfo(form: UInt8, umpversionmajor: UInt8, umpversionminor: UInt8) -> MIDIEndpointGetMIDIEndpointInfo { MIDIEndpointGetMIDIEndpointInfo(form: form, umpversionmajor: umpversionmajor, umpversionminor: umpversionminor) }
private func make_MIDIEndpointMIDIEndpointInfoNotify(form: UInt8, umpversionmajor: UInt8, umpversionminor: UInt8, staticfunctionblocks: UInt8, numberoffunctionblocks: UInt8) -> MIDIEndpointMIDIEndpointInfoNotify { MIDIEndpointMIDIEndpointInfoNotify(form: form, umpversionmajor: umpversionmajor, umpversionminor: umpversionminor, staticfunctionblocks: staticfunctionblocks, numberoffunctionblocks: numberoffunctionblocks) }
private func make_MIDIEndpointMIDIEndpointDeviceInfoNotify(form: UInt8, manufactureridbyte1: UInt8, manufactureridbyte2: UInt8, manufactureridbyte3: UInt8, familyidlsb: UInt8, familyidmsb: UInt8, modelidlsb: UInt8, modelidmsb: UInt8, softwarerevisionlevel1: UInt8, softwarerevisionlevel2: UInt8, softwarerevisionlevel3: UInt8, softwarerevisionlevel4: UInt8) -> MIDIEndpointMIDIEndpointDeviceInfoNotify { MIDIEndpointMIDIEndpointDeviceInfoNotify(form: form, manufactureridbyte1: manufactureridbyte1, manufactureridbyte2: manufactureridbyte2, manufactureridbyte3: manufactureridbyte3, familyidlsb: familyidlsb, familyidmsb: familyidmsb, modelidlsb: modelidlsb, modelidmsb: modelidmsb, softwarerevisionlevel1: softwarerevisionlevel1, softwarerevisionlevel2: softwarerevisionlevel2, softwarerevisionlevel3: softwarerevisionlevel3, softwarerevisionlevel4: softwarerevisionlevel4) }
private func make_MIDIEndpointMIDIEndpointNameNotify(form: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8, byte7: UInt8, byte8: UInt8, byte9: UInt8, byte10: UInt8, byte11: UInt8, byte12: UInt8, byte13: UInt8, byte14: UInt8) -> MIDIEndpointMIDIEndpointNameNotify { MIDIEndpointMIDIEndpointNameNotify(form: form, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6, byte7: byte7, byte8: byte8, byte9: byte9, byte10: byte10, byte11: byte11, byte12: byte12, byte13: byte13, byte14: byte14) }
private func make_MIDIEndpointMIDIEndpointProductInstanceIdNotify(form: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8, byte7: UInt8, byte8: UInt8, byte9: UInt8, byte10: UInt8, byte11: UInt8, byte12: UInt8, byte13: UInt8, byte14: UInt8) -> MIDIEndpointMIDIEndpointProductInstanceIdNotify { MIDIEndpointMIDIEndpointProductInstanceIdNotify(form: form, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6, byte7: byte7, byte8: byte8, byte9: byte9, byte10: byte10, byte11: byte11, byte12: byte12, byte13: byte13, byte14: byte14) }
private func make_MIDIEndpointStreamConfigurationRequest(form: UInt8, _protocol: UInt8) -> MIDIEndpointStreamConfigurationRequest { MIDIEndpointStreamConfigurationRequest(form: form, _protocol: _protocol) }
private func make_MIDIEndpointStreamConfigurationNotify(form: UInt8, _protocol: UInt8) -> MIDIEndpointStreamConfigurationNotify { MIDIEndpointStreamConfigurationNotify(form: form, _protocol: _protocol) }
private func make_MIDIEndpointGetFunctionBlockInfo(form: UInt8, functionblock: UInt8, requestingafunctionblocknamenotification: UInt8, requestingafunctionblockinfonotification: UInt8) -> MIDIEndpointGetFunctionBlockInfo { MIDIEndpointGetFunctionBlockInfo(form: form, functionblock: functionblock, requestingafunctionblocknamenotification: requestingafunctionblocknamenotification, requestingafunctionblockinfonotification: requestingafunctionblockinfonotification) }
private func make_MIDIEndpointFunctionBlockInfoNotification(form: UInt8, active: UInt8, functionblock: UInt8, uihint: UInt8, ismidi10: UInt8, direction: UInt8, firstgroup: UInt8, grouplength: UInt8, midicisupport: UInt8, maxsysexstreams: UInt8) -> MIDIEndpointFunctionBlockInfoNotification { MIDIEndpointFunctionBlockInfoNotification(form: form, active: active, functionblock: functionblock, uihint: uihint, ismidi10: ismidi10, direction: direction, firstgroup: firstgroup, grouplength: grouplength, midicisupport: midicisupport, maxsysexstreams: maxsysexstreams) }
private func make_MIDIEndpointFunctionBlockNameNotification(form: UInt8, functionblock: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8, byte4: UInt8, byte5: UInt8, byte6: UInt8, byte7: UInt8, byte8: UInt8, byte9: UInt8, byte10: UInt8, byte11: UInt8, byte12: UInt8, byte13: UInt8) -> MIDIEndpointFunctionBlockNameNotification { MIDIEndpointFunctionBlockNameNotification(form: form, functionblock: functionblock, byte1: byte1, byte2: byte2, byte3: byte3, byte4: byte4, byte5: byte5, byte6: byte6, byte7: byte7, byte8: byte8, byte9: byte9, byte10: byte10, byte11: byte11, byte12: byte12, byte13: byte13) }
private func make_MIDIEndpointStartofSequenceMessage(form: UInt8) -> MIDIEndpointStartofSequenceMessage { MIDIEndpointStartofSequenceMessage(form: form) }
private func make_MIDIEndpointEndofFileMessage(form: UInt8) -> MIDIEndpointEndofFileMessage { MIDIEndpointEndofFileMessage(form: form) }

    private func locateVectors() throws -> URL {
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() }
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        let vectors = repoRoot.appendingPathComponent("vectors/golden")
        return vectors
    }
    private func parseHex32(_ s: String) -> UInt32 { let clean = s.replacingOccurrences(of: "0x", with: ""); return UInt32(strtoul(clean, nil, 16)) }
    private func parseHex64(_ s: String) -> UInt64 { let clean = s.replacingOccurrences(of: "0x", with: ""); return strtoull(clean, nil, 16) }
    private func parseHex128(_ s: String) -> (UInt64, UInt64) { let clean = s.replacingOccurrences(of: "0x", with: "").uppercased(); let padded = String(repeating: "0", count: max(0, 32 - clean.count)) + clean; let hiStr = String(padded.prefix(padded.count - 16)); let loStr = String(padded.suffix(16)); let lo = strtoull(loStr, nil, 16); let hi = strtoull(hiStr, nil, 16); return (lo, hi) }
}
