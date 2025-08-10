import Foundation
import Core

/// SysEx8andMDS.MixedDataSetPayload (UMP128)
/// Source: libs/messageTypes.js:68
public struct SysEx8andMDSMixedDataSetPayload: Equatable {
    public var group: UInt8
    public var bytecount: UInt8
    public var mdsid: UInt8
    public init(group: UInt8, bytecount: UInt8, mdsid: UInt8) {
        precondition(group <= 15)
        precondition(bytecount <= 15)
        precondition(mdsid <= 255)
        self.group = group
        self.bytecount = bytecount
        self.mdsid = mdsid
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 5, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(group), offset: 4, width: 4)
        (lo, hi) = setBits128(lo, hi, 9, offset: 8, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(bytecount), offset: 12, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(mdsid), offset: 16, width: 8)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> SysEx8andMDSMixedDataSetPayload? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 5 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 8, width: 4) != 9 { return nil }
        let group = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
        let bytecount = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 4))
        let mdsid = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        return SysEx8andMDSMixedDataSetPayload(group: group, bytecount: bytecount, mdsid: mdsid)
    }
}
