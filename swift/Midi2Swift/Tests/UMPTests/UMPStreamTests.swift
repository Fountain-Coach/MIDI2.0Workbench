import XCTest
@testable import UMP
@testable import Core

final class UMPStreamTests: XCTestCase {
    func testDecodeWordsMixed() {
        // 32-bit: MIDI 1.0 Note On
        let m1 = M1NoteOn(group: 0, channel: 2, noteNumber: 64, velocity: 100).encode()
        // 64-bit: MIDI 2.0 CV Note On
        let m2 = CVNoteOn(group: 1, channel: 3, noteNumber: 60, attributeType: 0, velocity: 0x1111, attribute: 0).encode()
        // 128-bit: SysEx8 Start
        let m3 = SysEx8andMDSSystemExclusive8StartPacket(group: 0, bytecount: 4, streamid: 0x55).encode()

        func words(_ u32: UMP32) -> [UInt32] { [u32.raw] }
        func words(_ u64: UMP64) -> [UInt32] {
            let w0 = UInt32(truncatingIfNeeded: u64.raw & 0xFFFF_FFFF)
            let w1 = UInt32(truncatingIfNeeded: (u64.raw >> 32) & 0xFFFF_FFFF)
            return [w0, w1]
        }
        func words(_ u128: UMP128) -> [UInt32] {
            let w0 = UInt32(truncatingIfNeeded: u128.lo & 0xFFFF_FFFF)
            let w1 = UInt32(truncatingIfNeeded: (u128.lo >> 32) & 0xFFFF_FFFF)
            let w2 = UInt32(truncatingIfNeeded: u128.hi & 0xFFFF_FFFF)
            let w3 = UInt32(truncatingIfNeeded: (u128.hi >> 32) & 0xFFFF_FFFF)
            return [w0, w1, w2, w3]
        }

        let stream = words(m1) + words(m2) + words(m3)
        let (messages, errors) = UMPStream.decodeWords(stream)
        XCTAssertTrue(errors.isEmpty)
        XCTAssertEqual(messages.count, 3)

        // spot-check variants
        if case .MIDI10ChannelVoiceMessagesNoteOn(let v0) = messages[0] {
            XCTAssertEqual(v0.channel, 2)
        } else { XCTFail("index 0 not MIDI1 NoteOn") }
        if case .MIDI20ChannelVoiceMessagesNoteOn(let v1) = messages[1] {
            XCTAssertEqual(v1.channel, 3)
        } else { XCTFail("index 1 not MIDI2 NoteOn") }
        if case .SysEx8andMDSSystemExclusive8StartPacket(let v2) = messages[2] {
            XCTAssertEqual(v2.streamid, 0x55)
        } else { XCTFail("index 2 not SysEx8 Start") }
    }

    func testDecodeWordsTruncated() {
        // create a 128-bit header first word only -> should report truncated
        var lo: UInt64 = 0, hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 5, offset: 0, width: 4) // SysEx8
        let w0 = UInt32(truncatingIfNeeded: lo & 0xFFFF_FFFF)
        let (messages, errors) = UMPStream.decodeWords([w0])
        XCTAssertTrue(messages.isEmpty)
        XCTAssertEqual(errors.count, 1)
    }
}

