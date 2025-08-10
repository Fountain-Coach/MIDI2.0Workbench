import Foundation
import Core

/// SystemRealTimeandSystemCommonMessages.SongSelect (UMP32)
/// Source: libs/messageTypes.js:68
public struct SystemRealTimeandSystemCommonMessagesSongSelect: Equatable {
    public var group: UInt8
    public var sssssss: UInt8
    public init(group: UInt8, sssssss: UInt8) {
        precondition(group <= 15)
        precondition(sssssss <= 127)
        self.group = group
        self.sssssss = sssssss
    }

    public func encode() -> UMP32 {
        var raw: UInt32 = 0
        raw = setBits32(raw, value: UInt32(1), offset: 0, width: 4)
        raw = setBits32(raw, value: UInt32(UInt64(group)), offset: 4, width: 4)
        raw = setBits32(raw, value: UInt32(243), offset: 8, width: 8)
        raw = setBits32(raw, value: UInt32(UInt64(sssssss)), offset: 17, width: 7)
        return UMP32(raw: raw)
    }

    public static func decode(_ ump: UMP32) -> SystemRealTimeandSystemCommonMessagesSongSelect? {
        if getBits32(ump.raw, offset: 0, width: 4) != 1 { return nil }
        if getBits32(ump.raw, offset: 8, width: 8) != 243 { return nil }
        let group = UInt8(getBits32(ump.raw, offset: 4, width: 4))
        let sssssss = UInt8(getBits32(ump.raw, offset: 17, width: 7))
        return SystemRealTimeandSystemCommonMessagesSongSelect(group: group, sssssss: sssssss)
    }
}
