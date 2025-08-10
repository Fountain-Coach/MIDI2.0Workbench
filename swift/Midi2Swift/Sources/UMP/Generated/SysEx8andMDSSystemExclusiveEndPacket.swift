import Foundation
import Core

/// SysEx8andMDS.SystemExclusiveEndPacket (UMP128)
/// Source: libs/messageTypes.js:68
public struct SysEx8andMDSSystemExclusiveEndPacket: Equatable {
    public var group: UInt8
    public var bytecount: UInt8
    public var streamid: UInt8
    public init(group: UInt8, bytecount: UInt8, streamid: UInt8) {
        precondition(group <= 15)
        precondition(bytecount <= 15)
        precondition(streamid <= 255)
        self.group = group
        self.bytecount = bytecount
        self.streamid = streamid
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 5, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(group), offset: 4, width: 4)
        (lo, hi) = setBits128(lo, hi, 3, offset: 8, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(bytecount), offset: 12, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(streamid), offset: 16, width: 8)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> SysEx8andMDSSystemExclusiveEndPacket? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 5 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 8, width: 4) != 3 { return nil }
        let group = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
        let bytecount = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 4))
        let streamid = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        return SysEx8andMDSSystemExclusiveEndPacket(group: group, bytecount: bytecount, streamid: streamid)
    }
}
