import XCTest
@testable import UMP
import Core

final class ChannelVoiceNoteOnTests: XCTestCase {
    struct Vector: Decodable {
        struct Decoded: Decodable {
            let messageType: UInt8
            let group: UInt8
            let statusNibble: UInt8
            let channel: UInt8
            let noteNumber: UInt8
            let attributeType: UInt8
            let velocity: UInt16
            let attribute: UInt16
        }
        let caseName: String
        let raw: String
        let decoded: Decoded
        enum CodingKeys: String, CodingKey {
            case caseName = "case"
            case raw
            case decoded
        }
    }

    func testGoldenVectors() throws {
        let testFileURL = URL(fileURLWithPath: #filePath)
        let repoRoot = testFileURL
            .deletingLastPathComponent() // ChannelVoiceNoteOnTests.swift
            .deletingLastPathComponent() // UMPTests
            .deletingLastPathComponent() // Tests
            .deletingLastPathComponent() // Midi2Swift
            .deletingLastPathComponent() // swift
        let vectorsURL = repoRoot.appendingPathComponent("vectors/golden/ump_channel_voice.json")
        let data = try Data(contentsOf: vectorsURL)
        let vectors = try JSONDecoder().decode([Vector].self, from: data)
        for vector in vectors {
            let rawValue = UInt64(vector.raw.dropFirst(2), radix: 16)!
            guard let decoded = ChannelVoiceNoteOn.decode(UMP64(raw: rawValue)) else {
                XCTFail("decode failed for \(vector.caseName)")
                continue
            }
            XCTAssertEqual(decoded.group, vector.decoded.group)
            XCTAssertEqual(decoded.channel, vector.decoded.channel)
            XCTAssertEqual(decoded.noteNumber, vector.decoded.noteNumber)
            XCTAssertEqual(decoded.attributeType, vector.decoded.attributeType)
            XCTAssertEqual(decoded.velocity, vector.decoded.velocity)
            XCTAssertEqual(decoded.attribute, vector.decoded.attribute)
            XCTAssertEqual(decoded.encode().raw, rawValue)
            XCTAssertEqual(vector.decoded.messageType, ChannelVoiceNoteOn.messageType)
            XCTAssertEqual(vector.decoded.statusNibble, ChannelVoiceNoteOn.statusNibble)
        }
    }
}
