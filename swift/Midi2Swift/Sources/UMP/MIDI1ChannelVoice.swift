import Foundation
import Core

// MARK: - MIDI 1.0 Channel Voice (UMP32)

public struct M1NoteOn: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var noteNumber: UInt8
    public var velocity: UInt8
    public init(group: UInt8, channel: UInt8, noteNumber: UInt8, velocity: UInt8) {
        precondition(group < 16 && channel < 16)
        precondition(noteNumber < 128 && velocity < 128)
        self.group = group; self.channel = channel; self.noteNumber = noteNumber; self.velocity = velocity
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1001, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(noteNumber), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(velocity), offset: 25, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1NoteOn? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1001 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let noteNumber = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let velocity = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return M1NoteOn(group: group, channel: channel, noteNumber: noteNumber, velocity: velocity)
    }
}

public struct M1NoteOff: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var noteNumber: UInt8
    public var velocity: UInt8
    public init(group: UInt8, channel: UInt8, noteNumber: UInt8, velocity: UInt8) {
        precondition(group < 16 && channel < 16)
        precondition(noteNumber < 128 && velocity < 128)
        self.group = group; self.channel = channel; self.noteNumber = noteNumber; self.velocity = velocity
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1000, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(noteNumber), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(velocity), offset: 25, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1NoteOff? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1000 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let noteNumber = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let velocity = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return M1NoteOff(group: group, channel: channel, noteNumber: noteNumber, velocity: velocity)
    }
}

public struct M1ControlChange: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var index: UInt8
    public var value: UInt8
    public init(group: UInt8, channel: UInt8, index: UInt8, value: UInt8) {
        precondition(group < 16 && channel < 16)
        precondition(index < 128 && value < 128)
        self.group = group; self.channel = channel; self.index = index; self.value = value
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1011, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(index), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(value), offset: 25, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1ControlChange? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1011 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let index = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let value = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return M1ControlChange(group: group, channel: channel, index: index, value: value)
    }
}

public struct M1ProgramChange: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var program: UInt8
    public init(group: UInt8, channel: UInt8, program: UInt8) {
        precondition(group < 16 && channel < 16)
        precondition(program < 128)
        self.group = group; self.channel = channel; self.program = program
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1100, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(program), offset: 17, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1ProgramChange? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1100 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let program = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return M1ProgramChange(group: group, channel: channel, program: program)
    }
}

public struct M1ChannelPressure: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var pressure: UInt8
    public init(group: UInt8, channel: UInt8, pressure: UInt8) {
        precondition(group < 16 && channel < 16 && pressure < 128)
        self.group = group; self.channel = channel; self.pressure = pressure
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1101, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(pressure), offset: 17, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1ChannelPressure? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1101 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let pressure = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return M1ChannelPressure(group: group, channel: channel, pressure: pressure)
    }
}

public struct M1PitchBend: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var value14: UInt16 // 0..16383
    public init(group: UInt8, channel: UInt8, value14: UInt16) {
        precondition(group < 16 && channel < 16 && value14 < 16384)
        self.group = group; self.channel = channel; self.value14 = value14
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1110, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        let lsb = UInt32(value14 & 0x7F)
        let msb = UInt32((value14 >> 7) & 0x7F)
        raw = setBits32(raw, value: lsb, offset: 17, width: 7)
        raw = setBits32(raw, value: msb, offset: 25, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1PitchBend? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1110 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let lsb = UInt16(getBits32(ump.raw, offset: 17, width: 7))
        let msb = UInt16(getBits32(ump.raw, offset: 25, width: 7))
        let val = (msb << 7) | lsb
        return M1PitchBend(group: group, channel: channel, value14: val)
    }
}

public struct M1PolyPressure: Equatable {
    public var group: UInt8
    public var channel: UInt8
    public var noteNumber: UInt8
    public var pressure: UInt8
    public init(group: UInt8, channel: UInt8, noteNumber: UInt8, pressure: UInt8) {
        precondition(group < 16 && channel < 16)
        precondition(noteNumber < 128 && pressure < 128)
        self.group = group; self.channel = channel; self.noteNumber = noteNumber; self.pressure = pressure
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x2, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0b1010, offset: 8, width: 4)
        raw = setBits32(raw, value: UInt32(channel), offset: 12, width: 4)
        raw = setBits32(raw, value: UInt32(noteNumber), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(pressure), offset: 25, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> M1PolyPressure? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let st = getBits32(ump.raw, offset: 8, width: 4)
        guard mt == 0x2 && st == 0b1010 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let channel = UInt8(getBits32(ump.raw, offset: 12, width: 4))
        let noteNumber = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let pressure = UInt8(getBits32(ump.raw, offset: 25, width: 7))
        return M1PolyPressure(group: group, channel: channel, noteNumber: noteNumber, pressure: pressure)
    }
}

// MARK: - System Common/Real-Time (subset)

public struct SysMTCQuarterFrame: Equatable {
    public var group: UInt8
    public var nnndddd: UInt8 // 7-bit combined payload
    public init(group: UInt8, nnndddd: UInt8) {
        precondition(group < 16 && nnndddd < 128)
        self.group = group; self.nnndddd = nnndddd
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x1, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0xF1, offset: 8, width: 8)
        raw = setBits32(raw, value: UInt32(nnndddd), offset: 17, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> SysMTCQuarterFrame? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let status = getBits32(ump.raw, offset: 8, width: 8)
        guard mt == 0x1 && status == 0xF1 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let nnndddd = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return SysMTCQuarterFrame(group: group, nnndddd: nnndddd)
    }
}

public struct SysSongPositionPointer: Equatable {
    public var group: UInt8
    public var value14: UInt16
    public init(group: UInt8, value14: UInt16) {
        precondition(group < 16 && value14 < 16384)
        self.group = group; self.value14 = value14
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x1, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0xF2, offset: 8, width: 8)
        let l = UInt32(value14 & 0x7F)
        let m = UInt32((value14 >> 7) & 0x7F)
        raw = setBits32(raw, value: l, offset: 17, width: 7)
        raw = setBits32(raw, value: m, offset: 24, width: 8) // per libs ranges [24,31]
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> SysSongPositionPointer? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let status = getBits32(ump.raw, offset: 8, width: 8)
        guard mt == 0x1 && status == 0xF2 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let l = UInt16(getBits32(ump.raw, offset: 17, width: 7))
        let m = UInt16(getBits32(ump.raw, offset: 24, width: 8) & 0x7F)
        return SysSongPositionPointer(group: group, value14: (m << 7) | l)
    }
}

public struct SysSongSelect: Equatable {
    public var group: UInt8
    public var song: UInt8 // 0..127
    public init(group: UInt8, song: UInt8) {
        precondition(group < 16 && song < 128)
        self.group = group; self.song = song
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x1, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: 0xF3, offset: 8, width: 8)
        raw = setBits32(raw, value: UInt32(song), offset: 17, width: 7)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> SysSongSelect? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        let status = getBits32(ump.raw, offset: 8, width: 8)
        guard mt == 0x1 && status == 0xF3 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let song = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return SysSongSelect(group: group, song: song)
    }
}

public struct SysNoDataStatus: Equatable {
    public var group: UInt8
    public var status: UInt8 // e.g., 0xF8, 0xFA, 0xFB, 0xFC, 0xFE, 0xFF
    public init(group: UInt8, status: UInt8) {
        precondition(group < 16)
        self.group = group; self.status = status
    }
    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: 0x1, offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(group), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(status), offset: 8, width: 8)
        return UMP32(raw: raw)
    }
    public static func decode(_ ump: UMP32) -> SysNoDataStatus? {
        let mt = getBits32(ump.raw, offset: 0, width: 4)
        guard mt == 0x1 else { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let status = UInt8(getBits32(ump.raw, offset: 8, width: 8))
        // Caller validates specific allowed statuses
        return SysNoDataStatus(group: group, status: status)
    }
}
