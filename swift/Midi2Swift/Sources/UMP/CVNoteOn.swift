import Foundation
import Core

public struct CVNoteOn: Equatable {
    public var group: UInt8      // 0..15
    public var channel: UInt8    // 0..15
    public var noteNumber: UInt8 // 0..127
    public var attributeType: UInt8 // 7 bits used
    public var velocity: UInt16
    public var attribute: UInt16

    public init(group: UInt8, channel: UInt8, noteNumber: UInt8, attributeType: UInt8, velocity: UInt16, attribute: UInt16) {
        precondition(group < 16)
        precondition(channel < 16)
        precondition(noteNumber < 128)
        precondition(attributeType < 128)
        self.group = group
        self.channel = channel
        self.noteNumber = noteNumber
        self.attributeType = attributeType
        self.velocity = velocity
        self.attribute = attribute
    }

    // Encode according to extracted contract fields
    // messageType [0..3] = 0x4, group [4..7], statusNibble [8..11] = 0x9
    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: 0x4, offset: 0, width: 4)
        raw = setBits(raw, value: UInt64(group), offset: 4, width: 4)
        raw = setBits(raw, value: 0x9, offset: 8, width: 4)
        raw = setBits(raw, value: UInt64(channel), offset: 12, width: 4)
        raw = setBits(raw, value: UInt64(noteNumber), offset: 17, width: 7)
        raw = setBits(raw, value: UInt64(attributeType), offset: 25, width: 7)
        raw = setBits(raw, value: UInt64(velocity), offset: 32, width: 16)
        raw = setBits(raw, value: UInt64(attribute), offset: 48, width: 16)
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> CVNoteOn? {
        let mt = getBits(ump.raw, offset: 0, width: 4)
        let st = getBits(ump.raw, offset: 8, width: 4)
        guard mt == 0x4 && st == 0x9 else { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let noteNumber = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let attributeType = UInt8(getBits(ump.raw, offset: 25, width: 7))
        let velocity = UInt16(getBits(ump.raw, offset: 32, width: 16))
        let attribute = UInt16(getBits(ump.raw, offset: 48, width: 16))
        return CVNoteOn(group: group, channel: channel, noteNumber: noteNumber, attributeType: attributeType, velocity: velocity, attribute: attribute)
    }
}

