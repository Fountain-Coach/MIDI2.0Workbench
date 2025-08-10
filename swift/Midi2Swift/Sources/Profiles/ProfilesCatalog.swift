import Foundation

public struct ProfileID: Equatable, Hashable {
    public let bank: UInt8
    public let index: UInt8
    public let name: String
}

public enum ProfilesCatalog {
    public static let all: [ProfileID] = [
        ProfileID(bank: 0x21, index: 0x0, name: "Default Control Change Mapping"),
        ProfileID(bank: 0x0, index: 0x0, name: "General MIDI 2"),
        ProfileID(bank: 0x21, index: 0x2, name: "General MIDI 2 Single Channel"),
        ProfileID(bank: 0x20, index: 0x1, name: "Drawbar Organ"),
        ProfileID(bank: 0x61, index: 0x0, name: "Rotary Speaker Effect"),
        ProfileID(bank: 0x21, index: 0x1, name: "Note On Orchestral Articulation"),
        ProfileID(bank: 0x31, index: 0x0, name: "MPE")
    ]
    public static func lookup(bank: UInt8, index: UInt8) -> ProfileID? {
        return all.first { $0.bank == bank && $0.index == index }
    }
}
