import Foundation
import Core

/// SystemRealTimeandSystemCommonMessages.SongPositionPointer (UMP32)
/// Source: libs/messageTypes.js:68
public struct SystemRealTimeandSystemCommonMessagesSongPositionPointer: Equatable {
    public var group: UInt8
    public var lllllll: UInt8
    public var mmmmmmm: UInt8
    public init(group: UInt8, lllllll: UInt8, mmmmmmm: UInt8) {
        precondition(group <= 15)
        precondition(lllllll <= 127)
        precondition(mmmmmmm <= 255)
        self.group = group
        self.lllllll = lllllll
        self.mmmmmmm = mmmmmmm
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(1), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(242), offset: 8, width: 8)
        raw = setBits32(raw, value: UInt32(UInt64(lllllll)), offset: 17, width: 7)
        raw = setBits32(raw, value: UInt32(UInt64(mmmmmmm)), offset: 24, width: 8)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> SystemRealTimeandSystemCommonMessagesSongPositionPointer? {
        if getBits32(ump.raw, offset: 0, width: 4) != 1 { return nil }
        if getBits32(ump.raw, offset: 8, width: 8) != 242 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let lllllll = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        let mmmmmmm = UInt8(getBits32(ump.raw, offset: 24, width: 8))
        return SystemRealTimeandSystemCommonMessagesSongPositionPointer(group: group, lllllll: lllllll, mmmmmmm: mmmmmmm)
    }
}
