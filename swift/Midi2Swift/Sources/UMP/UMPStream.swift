import Foundation
import Core

public enum UMPDecodeError: Error, Equatable {
    case truncated(expectedWords: Int, atIndex: Int)
    case unknownMessageType(UInt8, atIndex: Int)
    case undecodable(atIndex: Int)
}

public struct UMPStream {
    // Determine container width (in 32-bit words) by messageType nibble of first word
    @inlinable
    static func widthWords(firstWord: UInt32) -> Int {
        let mt = UInt8(getBits32(firstWord, offset: 0, width: 4))
        switch mt {
        case 0x0, 0x1, 0x2: return 1 // Utility, System, MIDI1-CV
        case 0x3, 0x4: return 2 // SysEx7, MIDI2-CV
        case 0x5, 0xD, 0xF: return 4 // SysEx8/MDS, Flex, Endpoint/Stream
        default: return 0
        }
    }

    // Decode a stream of 32-bit UMP words into typed messages
    public static func decodeWords(_ words: [UInt32]) -> (messages: [UMPAnyMessage], errors: [UMPDecodeError]) {
        var out: [UMPAnyMessage] = []
        var errs: [UMPDecodeError] = []
        var i = 0
        while i < words.count {
            let w0 = words[i]
            let width = widthWords(firstWord: w0)
            if width == 0 {
                let mt = UInt8(getBits32(w0, offset: 0, width: 4))
                errs.append(.unknownMessageType(mt, atIndex: i))
                i += 1
                continue
            }
            if i + width > words.count {
                errs.append(.truncated(expectedWords: width, atIndex: i))
                break
            }
            switch width {
            case 1:
                let u32 = UMP32(raw: w0)
                if let any = UMPDecoder.decode(u32) { out.append(any) } else { errs.append(.undecodable(atIndex: i)) }
            case 2:
                let raw64 = (UInt64(words[i+1]) << 32) | UInt64(words[i])
                let u64 = UMP64(raw: raw64)
                if let any = UMPDecoder.decode(u64) { out.append(any) } else { errs.append(.undecodable(atIndex: i)) }
            case 4:
                let lo = (UInt64(words[i+1]) << 32) | UInt64(words[i])
                let hi = (UInt64(words[i+3]) << 32) | UInt64(words[i+2])
                let u128 = UMP128(lo: lo, hi: hi)
                if let any = UMPDecoder.decode(u128) { out.append(any) } else { errs.append(.undecodable(atIndex: i)) }
            default:
                break
            }
            i += width
        }
        return (out, errs)
    }

    // Convenience to flatten typed messages back to words
    public static func encodeWords(_ messages: [UMPAnyMessage]) -> [UInt32] {
        var words: [UInt32] = []
        for m in messages {
            switch m {
            case .UtilityMessagesDeltaClockstamp(let v):
                words.append(v.encode().raw)
            default:
                // Fallback: use container inspection via Mirror on associated value
                let mirror = Mirror(reflecting: m)
                if let child = mirror.children.first?.value {
                    if let v = child as? (any AnyUMPEncodable) {
                        words.append(contentsOf: v.toWords())
                    }
                }
            }
        }
        return words
    }
}

// Internal protocol-only convenience to lower associated value to words without writing per-case code.
// Not public API; used by encodeWords fallback.
fileprivate protocol AnyUMPEncodable {}
extension UMP32: AnyUMPEncodable { }
extension UMP64: AnyUMPEncodable { }
extension UMP128: AnyUMPEncodable { }

fileprivate extension AnyUMPEncodable {
    func toWords() -> [UInt32] {
        if let m = self as? UMP32 { return [m.raw] }
        if let m = self as? UMP64 {
            let lo = UInt32(truncatingIfNeeded: m.raw & 0xFFFF_FFFF)
            let hi = UInt32(truncatingIfNeeded: (m.raw >> 32) & 0xFFFF_FFFF)
            return [lo, hi]
        }
        if let m = self as? UMP128 {
            let w0 = UInt32(truncatingIfNeeded: m.lo & 0xFFFF_FFFF)
            let w1 = UInt32(truncatingIfNeeded: (m.lo >> 32) & 0xFFFF_FFFF)
            let w2 = UInt32(truncatingIfNeeded: m.hi & 0xFFFF_FFFF)
            let w3 = UInt32(truncatingIfNeeded: (m.hi >> 32) & 0xFFFF_FFFF)
            return [w0, w1, w2, w3]
        }
        return []
    }
}

