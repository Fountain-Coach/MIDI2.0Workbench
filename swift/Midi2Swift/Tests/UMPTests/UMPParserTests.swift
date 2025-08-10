import XCTest
@testable import UMP
@testable import Core

final class UMPParserTests: XCTestCase {
    func testParseMIDI2CVNoteOn() {
        let msg = CVNoteOn(group: 2, channel: 3, noteNumber: 60, attributeType: 0, velocity: 0x1234, attribute: 0)
        let packet = msg.encode() // UMP64
        let parsed = UMPParser.parse(packet)
        switch parsed {
        case .midi2ChannelVoice(let group, let status, let channel):
            XCTAssertEqual(group, 2)
            XCTAssertEqual(status, 0x9)
            XCTAssertEqual(channel, 3)
        default:
            XCTFail("Expected midi2ChannelVoice, got \(parsed)")
        }
    }

    func testParseSysEx7Complete() {
        let msg = SysEx7Complete(group: 1, byteCount: 3, bytes: (0x7E, 0x7F, 0x09, 0, 0, 0))
        let packet = msg.encode() // UMP64
        let parsed = UMPParser.parse(packet)
        switch parsed {
        case .sysEx7(let group, let form, let bc):
            XCTAssertEqual(group, 1)
            XCTAssertEqual(form, 0) // Complete
            XCTAssertEqual(bc, 3)
        default:
            XCTFail("Expected sysEx7, got \(parsed)")
        }
    }

    func testParseMIDI1NoteOn() {
        let m1 = M1NoteOn(group: 0, channel: 5, noteNumber: 64, velocity: 100)
        let p = m1.encode()
        let parsed = UMPParser.parse(p)
        switch parsed {
        case .midi1ChannelVoice(let group, let status, let channel):
            XCTAssertEqual(group, 0)
            XCTAssertEqual(status, 0x9) // Note On
            XCTAssertEqual(channel, 5)
        default:
            XCTFail("Expected midi1ChannelVoice, got \(parsed)")
        }
    }

    func testParseSysEx8Start() {
        let e = SysEx8andMDSSystemExclusive8StartPacket(group: 0, bytecount: 4, streamid: 0x11)
        let p = e.encode()
        let parsed = UMPParser.parse(p)
        switch parsed {
        case .sysEx8MDS(let form, let bc, let streamID):
            XCTAssertEqual(form, 1) // Start
            XCTAssertEqual(bc, 4)
            XCTAssertEqual(streamID, 0x11)
        default:
            XCTFail("Expected sysEx8MDS, got \(parsed)")
        }
    }

    func testParseEndpointGetInfoHeader() {
        let e = MIDIEndpointGetMIDIEndpointInfo(formEnum: .complete, umpversionmajor: 1, umpversionminor: 0)
        let p = e.encode()
        let parsed = UMPParser.parse(p)
        switch parsed {
        case .endpoint(let form, let status10):
            XCTAssertEqual(form, 0)
            XCTAssertEqual(status10, 0)
        default:
            XCTFail("Expected endpoint, got \(parsed)")
        }
    }

    func testParseFlexHeader() {
        let f = FlexDataMessagesSubdivisionClicks1FlexDataMessages0x0(channel: 7, group: 2, form: 0)
        let p = f.encode()
        let parsed = UMPParser.parse(p)
        switch parsed {
        case .flexData(let group, let channel, let form):
            XCTAssertEqual(group, 2)
            XCTAssertEqual(channel, 7)
            XCTAssertEqual(form, 0)
        default:
            XCTFail("Expected flexData, got \(parsed)")
        }
    }
}

