import Foundation
import Core

/// SysEx8andMDS.MixedDataSetHeader (UMP128)
/// Source: libs/messageTypes.js:68
public struct SysEx8andMDSMixedDataSetHeader: Equatable {
    public var group: UInt8
    public var bytecount: UInt8
    public var mdsid: UInt8
    public var numberofvalidbytesinthismessagechunk: UInt8
    public var numberofchunksinmixeddataset: UInt16
    public var numberofthischunk: UInt16
    public var manufacturerid: UInt16
    public var deviceid: UInt16
    public var subid1: UInt16
    public var subid2: UInt16
    public init(group: UInt8, bytecount: UInt8, mdsid: UInt8, numberofvalidbytesinthismessagechunk: UInt8, numberofchunksinmixeddataset: UInt16, numberofthischunk: UInt16, manufacturerid: UInt16, deviceid: UInt16, subid1: UInt16, subid2: UInt16) {
        precondition(group <= 15)
        precondition(bytecount <= 15)
        precondition(mdsid <= 255)
        precondition(numberofvalidbytesinthismessagechunk <= 255)
        precondition(numberofchunksinmixeddataset <= 65535)
        precondition(numberofthischunk <= 65535)
        precondition(manufacturerid <= 65535)
        precondition(deviceid <= 65535)
        precondition(subid1 <= 65535)
        precondition(subid2 <= 65535)
        self.group = group
        self.bytecount = bytecount
        self.mdsid = mdsid
        self.numberofvalidbytesinthismessagechunk = numberofvalidbytesinthismessagechunk
        self.numberofchunksinmixeddataset = numberofchunksinmixeddataset
        self.numberofthischunk = numberofthischunk
        self.manufacturerid = manufacturerid
        self.deviceid = deviceid
        self.subid1 = subid1
        self.subid2 = subid2
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        { let tmp = setBits128(lo, hi, 5, offset: 0, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(group), offset: 4, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, 8, offset: 8, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(bytecount), offset: 12, width: 4); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(mdsid), offset: 16, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(numberofvalidbytesinthismessagechunk), offset: 24, width: 8); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(numberofchunksinmixeddataset), offset: 32, width: 16); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(numberofthischunk), offset: 48, width: 16); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(manufacturerid), offset: 64, width: 16); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(deviceid), offset: 80, width: 16); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(subid1), offset: 96, width: 16); lo = tmp.0; hi = tmp.1 }
        { let tmp = setBits128(lo, hi, UInt64(subid2), offset: 112, width: 16); lo = tmp.0; hi = tmp.1 }
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> SysEx8andMDSMixedDataSetHeader? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 5 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 8, width: 4) != 8 { return nil }
        let group = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 4))
        let bytecount = UInt8(getBits128(ump.lo, ump.hi, offset: 12, width: 4))
        let mdsid = UInt8(getBits128(ump.lo, ump.hi, offset: 16, width: 8))
        let numberofvalidbytesinthismessagechunk = UInt8(getBits128(ump.lo, ump.hi, offset: 24, width: 8))
        let numberofchunksinmixeddataset = UInt16(getBits128(ump.lo, ump.hi, offset: 32, width: 16))
        let numberofthischunk = UInt16(getBits128(ump.lo, ump.hi, offset: 48, width: 16))
        let manufacturerid = UInt16(getBits128(ump.lo, ump.hi, offset: 64, width: 16))
        let deviceid = UInt16(getBits128(ump.lo, ump.hi, offset: 80, width: 16))
        let subid1 = UInt16(getBits128(ump.lo, ump.hi, offset: 96, width: 16))
        let subid2 = UInt16(getBits128(ump.lo, ump.hi, offset: 112, width: 16))
        return SysEx8andMDSMixedDataSetHeader(group: group, bytecount: bytecount, mdsid: mdsid, numberofvalidbytesinthismessagechunk: numberofvalidbytesinthismessagechunk, numberofchunksinmixeddataset: numberofchunksinmixeddataset, numberofthischunk: numberofthischunk, manufacturerid: manufacturerid, deviceid: deviceid, subid1: subid1, subid2: subid2)
    }
}
