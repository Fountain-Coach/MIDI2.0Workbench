import Core

public struct ChannelVoiceNoteOn {
    public static let messageType: UInt8 = 4
    public static let statusNibble: UInt8 = 9

    public var group: UInt8
    public var channel: UInt8
    public var noteNumber: UInt8
    public var attributeType: UInt8
    public var velocity: UInt16
    public var attribute: UInt16

    public init(group: UInt8, channel: UInt8, noteNumber: UInt8, attributeType: UInt8, velocity: UInt16, attribute: UInt16) {
        precondition(group < 16)
        precondition(channel < 16)
        precondition(noteNumber < 128)
        precondition(attributeType < 128)
        precondition(velocity <= UInt16.max)
        precondition(attribute <= UInt16.max)
        self.group = group
        self.channel = channel
        self.noteNumber = noteNumber
        self.attributeType = attributeType
        self.velocity = velocity
        self.attribute = attribute
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw |= UInt64(Self.messageType) << 0
        raw |= UInt64(group) << 4
        raw |= UInt64(Self.statusNibble) << 8
        raw |= UInt64(channel) << 12
        raw |= UInt64(noteNumber) << 17
        raw |= UInt64(attributeType) << 25
        raw |= UInt64(velocity) << 32
        raw |= UInt64(attribute) << 48
        return UMP64(raw: raw)
    }

    public static func decode(_ container: UMP64) -> ChannelVoiceNoteOn? {
        let raw = container.raw
        let mt = UInt8((raw >> 0) & 0xF)
        guard mt == Self.messageType else { return nil }
        let group = UInt8((raw >> 4) & 0xF)
        let status = UInt8((raw >> 8) & 0xF)
        guard status == Self.statusNibble else { return nil }
        let channel = UInt8((raw >> 12) & 0xF)
        let noteNumber = UInt8((raw >> 17) & 0x7F)
        let attributeType = UInt8((raw >> 25) & 0x7F)
        let velocity = UInt16((raw >> 32) & 0xFFFF)
        let attribute = UInt16((raw >> 48) & 0xFFFF)
        return ChannelVoiceNoteOn(group: group, channel: channel, noteNumber: noteNumber, attributeType: attributeType, velocity: velocity, attribute: attribute)
    }
}
