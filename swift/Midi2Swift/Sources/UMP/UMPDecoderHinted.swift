import Foundation
import Core

public extension UMPDecoder {
    @inlinable
    static func decode(parsed: UMPParsed, _ ump: UMP32) -> UMPAnyMessage? {
        // For 32-bit families, hint only confirms width; reuse existing decode
        return decode(ump)
    }

    @inlinable
    static func decode(parsed: UMPParsed, _ ump: UMP64) -> UMPAnyMessage? {
        return decode(ump)
    }

    @inlinable
    static func decode(parsed: UMPParsed, _ ump: UMP128) -> UMPAnyMessage? {
        return decode(ump)
    }
}

