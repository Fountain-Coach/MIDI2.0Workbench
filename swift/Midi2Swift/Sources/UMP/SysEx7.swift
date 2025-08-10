import Foundation
import Core

// SysEx7 64-bit Complete (form 0)
public struct SysEx7Complete: Equatable {
    public var group: UInt8
    public var byteCount: UInt8 // 0..6
    public var bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    public init(group: UInt8, byteCount: UInt8, bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)) {
        precondition(group < 16)
        precondition(byteCount <= 6)
        self.group = group
        self.byteCount = byteCount
        self.bytes = bytes
    }

    public func encode() -> UMP64 {
        var raw: UInt64 = 0
        raw = setBits(raw, value: 0x3, offset: 0, width: 4) // SysEx family
        raw = setBits(raw, value: UInt64(group), offset: 4, width: 4)
        raw = setBits(raw, value: 0x0, offset: 8, width: 4) // Complete form
        raw = setBits(raw, value: UInt64(byteCount), offset: 12, width: 4)
        let arr: [UInt8] = [bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5]
        let offsets = [17,25,33,41,49,57]
        for i in 0..<6 {
            raw = setBits(raw, value: UInt64(arr[i] & 0x7F), offset: offsets[i], width: 7)
        }
        return UMP64(raw: raw)
    }

    public static func decode(_ ump: UMP64) -> SysEx7Complete? {
        let mt = getBits(ump.raw, offset: 0, width: 4)
        let form = getBits(ump.raw, offset: 8, width: 4)
        guard mt == 0x3 && form == 0x0 else { return nil }
        let group = UInt8(getBits(ump.raw, offset: 4, width: 4))
        let bc = UInt8(getBits(ump.raw, offset: 12, width: 4))
        let b0 = UInt8(getBits(ump.raw, offset: 17, width: 7))
        let b1 = UInt8(getBits(ump.raw, offset: 25, width: 7))
        let b2 = UInt8(getBits(ump.raw, offset: 33, width: 7))
        let b3 = UInt8(getBits(ump.raw, offset: 41, width: 7))
        let b4 = UInt8(getBits(ump.raw, offset: 49, width: 7))
        let b5 = UInt8(getBits(ump.raw, offset: 57, width: 7))
        return SysEx7Complete(group: group, byteCount: bc, bytes: (b0,b1,b2,b3,b4,b5))
    }
}

