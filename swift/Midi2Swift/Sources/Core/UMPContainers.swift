import Foundation

public struct UMP64: Equatable, Hashable {
    public var raw: UInt64
    public init(raw: UInt64) { self.raw = raw }
}

public struct UMP32: Equatable, Hashable {
    public var raw: UInt32
    public init(raw: UInt32) { self.raw = raw }
}

public struct UMP128: Equatable, Hashable {
    public var lo: UInt64 // bits 0..63
    public var hi: UInt64 // bits 64..127
    public init(lo: UInt64 = 0, hi: UInt64 = 0) { self.lo = lo; self.hi = hi }
}

@inline(__always)
public func mask(width: Int) -> UInt64 {
    if width <= 0 { return 0 }
    if width >= 64 { return ~0 }
    return (1 << UInt64(width)) - 1
}

@inline(__always)
public func setBits(_ raw: UInt64, value: UInt64, offset: Int, width: Int) -> UInt64 {
    let m = mask(width: width) << UInt64(offset)
    let v = (value & mask(width: width)) << UInt64(offset)
    return (raw & ~m) | v
}

@inline(__always)
public func getBits(_ raw: UInt64, offset: Int, width: Int) -> UInt64 {
    let v = (raw >> UInt64(offset)) & mask(width: width)
    return v
}

@inline(__always)
public func setBits128(_ rawLo: UInt64, _ rawHi: UInt64, value: UInt64, offset: Int, width: Int) -> (UInt64, UInt64) {
    // Supports up to 64-bit field width (sufficient for UMP definitions)
    if offset + width <= 64 {
        return (setBits(rawLo, value: value, offset: offset, width: width), rawHi)
    } else if offset >= 64 {
        return (rawLo, setBits(rawHi, value: value, offset: offset - 64, width: width))
    } else {
        // Split across boundary
        let lowWidth = 64 - offset
        let highWidth = width - lowWidth
        let lowVal = value & mask(width: lowWidth)
        let highVal = (value >> UInt64(lowWidth)) & mask(width: highWidth)
        let lo = setBits(rawLo, value: lowVal, offset: offset, width: lowWidth)
        let hi = setBits(rawHi, value: highVal, offset: 0, width: highWidth)
        return (lo, hi)
    }
}

@inline(__always)
public func setBits128(_ rawLo: UInt64, _ rawHi: UInt64, _ value: UInt64, offset: Int, width: Int) -> (UInt64, UInt64) {
    return setBits128(rawLo, rawHi, value: value, offset: offset, width: width)
}

@inline(__always)
public func getBits128(_ rawLo: UInt64, _ rawHi: UInt64, offset: Int, width: Int) -> UInt64 {
    if offset + width <= 64 {
        return getBits(rawLo, offset: offset, width: width)
    } else if offset >= 64 {
        return getBits(rawHi, offset: offset - 64, width: width)
    } else {
        let lowWidth = 64 - offset
        let highWidth = width - lowWidth
        let low = getBits(rawLo, offset: offset, width: lowWidth)
        let high = getBits(rawHi, offset: 0, width: highWidth)
        return low | (high << UInt64(lowWidth))
    }
}

@inline(__always)
public func mask32(width: Int) -> UInt32 {
    if width <= 0 { return 0 }
    if width >= 32 { return ~0 }
    return (1 << UInt32(width)) - 1
}

@inline(__always)
public func setBits32(_ raw: UInt32, value: UInt32, offset: Int, width: Int) -> UInt32 {
    let m = mask32(width: width) << UInt32(offset)
    let v = (value & mask32(width: width)) << UInt32(offset)
    return (raw & ~m) | v
}

@inline(__always)
public func getBits32(_ raw: UInt32, offset: Int, width: Int) -> UInt32 {
    let v = (raw >> UInt32(offset)) & mask32(width: width)
    return v
}
