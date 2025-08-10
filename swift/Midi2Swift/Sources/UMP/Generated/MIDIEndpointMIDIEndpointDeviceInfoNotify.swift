import Foundation
import Core

/// MIDIEndpoint.MIDIEndpointDeviceInfoNotify (UMP128)
/// Source: libs/messageTypes.js:68
public struct MIDIEndpointMIDIEndpointDeviceInfoNotify: Equatable {
    public var form: UInt8
    public var manufactureridbyte1: UInt8
    public var manufactureridbyte2: UInt8
    public var manufactureridbyte3: UInt8
    public var familyidlsb: UInt8
    public var familyidmsb: UInt8
    public var modelidlsb: UInt8
    public var modelidmsb: UInt8
    public var softwarerevisionlevel1: UInt8
    public var softwarerevisionlevel2: UInt8
    public var softwarerevisionlevel3: UInt8
    public var softwarerevisionlevel4: UInt8
    public init(form: UInt8, manufactureridbyte1: UInt8, manufactureridbyte2: UInt8, manufactureridbyte3: UInt8, familyidlsb: UInt8, familyidmsb: UInt8, modelidlsb: UInt8, modelidmsb: UInt8, softwarerevisionlevel1: UInt8, softwarerevisionlevel2: UInt8, softwarerevisionlevel3: UInt8, softwarerevisionlevel4: UInt8) {
        precondition(form <= 3)
        precondition(manufactureridbyte1 <= 127)
        precondition(manufactureridbyte2 <= 127)
        precondition(manufactureridbyte3 <= 127)
        precondition(familyidlsb <= 127)
        precondition(familyidmsb <= 127)
        precondition(modelidlsb <= 127)
        precondition(modelidmsb <= 127)
        precondition(softwarerevisionlevel1 <= 127)
        precondition(softwarerevisionlevel2 <= 127)
        precondition(softwarerevisionlevel3 <= 127)
        precondition(softwarerevisionlevel4 <= 127)
        self.form = form
        self.manufactureridbyte1 = manufactureridbyte1
        self.manufactureridbyte2 = manufactureridbyte2
        self.manufactureridbyte3 = manufactureridbyte3
        self.familyidlsb = familyidlsb
        self.familyidmsb = familyidmsb
        self.modelidlsb = modelidlsb
        self.modelidmsb = modelidmsb
        self.softwarerevisionlevel1 = softwarerevisionlevel1
        self.softwarerevisionlevel2 = softwarerevisionlevel2
        self.softwarerevisionlevel3 = softwarerevisionlevel3
        self.softwarerevisionlevel4 = softwarerevisionlevel4
    }

    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }

    public init(formEnum: Form, manufactureridbyte1: UInt8, manufactureridbyte2: UInt8, manufactureridbyte3: UInt8, familyidlsb: UInt8, familyidmsb: UInt8, modelidlsb: UInt8, modelidmsb: UInt8, softwarerevisionlevel1: UInt8, softwarerevisionlevel2: UInt8, softwarerevisionlevel3: UInt8, softwarerevisionlevel4: UInt8) {
        precondition(manufactureridbyte1 <= 127)
        precondition(manufactureridbyte2 <= 127)
        precondition(manufactureridbyte3 <= 127)
        precondition(familyidlsb <= 127)
        precondition(familyidmsb <= 127)
        precondition(modelidlsb <= 127)
        precondition(modelidmsb <= 127)
        precondition(softwarerevisionlevel1 <= 127)
        precondition(softwarerevisionlevel2 <= 127)
        precondition(softwarerevisionlevel3 <= 127)
        precondition(softwarerevisionlevel4 <= 127)
        self.form = formEnum.rawValue
        self.manufactureridbyte1 = manufactureridbyte1
        self.manufactureridbyte2 = manufactureridbyte2
        self.manufactureridbyte3 = manufactureridbyte3
        self.familyidlsb = familyidlsb
        self.familyidmsb = familyidmsb
        self.modelidlsb = modelidlsb
        self.modelidmsb = modelidmsb
        self.softwarerevisionlevel1 = softwarerevisionlevel1
        self.softwarerevisionlevel2 = softwarerevisionlevel2
        self.softwarerevisionlevel3 = softwarerevisionlevel3
        self.softwarerevisionlevel4 = softwarerevisionlevel4
    }

    public func encode() -> UMP128 {
        var lo: UInt64 = 0
        var hi: UInt64 = 0
        (lo, hi) = setBits128(lo, hi, 15, offset: 0, width: 4)
        (lo, hi) = setBits128(lo, hi, UInt64(form), offset: 4, width: 2)
        (lo, hi) = setBits128(lo, hi, 2, offset: 6, width: 10)
        (lo, hi) = setBits128(lo, hi, UInt64(manufactureridbyte1), offset: 41, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(manufactureridbyte2), offset: 49, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(manufactureridbyte3), offset: 57, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(familyidlsb), offset: 65, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(familyidmsb), offset: 73, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(modelidlsb), offset: 81, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(modelidmsb), offset: 89, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(softwarerevisionlevel1), offset: 97, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(softwarerevisionlevel2), offset: 105, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(softwarerevisionlevel3), offset: 113, width: 7)
        (lo, hi) = setBits128(lo, hi, UInt64(softwarerevisionlevel4), offset: 121, width: 7)
        return UMP128(lo: lo, hi: hi)
    }

    public static func decode(_ ump: UMP128) -> MIDIEndpointMIDIEndpointDeviceInfoNotify? {
        if getBits128(ump.lo, ump.hi, offset: 0, width: 4) != 15 { return nil }
        if getBits128(ump.lo, ump.hi, offset: 6, width: 10) != 2 { return nil }
        let form = UInt8(getBits128(ump.lo, ump.hi, offset: 4, width: 2))
        let manufactureridbyte1 = UInt8(getBits128(ump.lo, ump.hi, offset: 41, width: 7))
        let manufactureridbyte2 = UInt8(getBits128(ump.lo, ump.hi, offset: 49, width: 7))
        let manufactureridbyte3 = UInt8(getBits128(ump.lo, ump.hi, offset: 57, width: 7))
        let familyidlsb = UInt8(getBits128(ump.lo, ump.hi, offset: 65, width: 7))
        let familyidmsb = UInt8(getBits128(ump.lo, ump.hi, offset: 73, width: 7))
        let modelidlsb = UInt8(getBits128(ump.lo, ump.hi, offset: 81, width: 7))
        let modelidmsb = UInt8(getBits128(ump.lo, ump.hi, offset: 89, width: 7))
        let softwarerevisionlevel1 = UInt8(getBits128(ump.lo, ump.hi, offset: 97, width: 7))
        let softwarerevisionlevel2 = UInt8(getBits128(ump.lo, ump.hi, offset: 105, width: 7))
        let softwarerevisionlevel3 = UInt8(getBits128(ump.lo, ump.hi, offset: 113, width: 7))
        let softwarerevisionlevel4 = UInt8(getBits128(ump.lo, ump.hi, offset: 121, width: 7))
        return MIDIEndpointMIDIEndpointDeviceInfoNotify(form: form, manufactureridbyte1: manufactureridbyte1, manufactureridbyte2: manufactureridbyte2, manufactureridbyte3: manufactureridbyte3, familyidlsb: familyidlsb, familyidmsb: familyidmsb, modelidlsb: modelidlsb, modelidmsb: modelidmsb, softwarerevisionlevel1: softwarerevisionlevel1, softwarerevisionlevel2: softwarerevisionlevel2, softwarerevisionlevel3: softwarerevisionlevel3, softwarerevisionlevel4: softwarerevisionlevel4)
    }
}
