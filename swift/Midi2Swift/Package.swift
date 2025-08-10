// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Midi2Swift",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "Core", targets: ["Core"]),
        .library(name: "UMP", targets: ["UMP"]),
    ],
    targets: [
        .target(name: "Core", path: "Sources/Core"),
        .target(
            name: "UMP",
            dependencies: ["Core"],
            path: "Sources/UMP",
            exclude: ["Generated", "CVNoteOn.swift", "MIDI1ChannelVoice.swift", "SysEx7.swift"],
            sources: ["ChannelVoiceNoteOn.swift"]
        ),
        .testTarget(
            name: "UMPTests",
            dependencies: ["UMP", "Core"],
            path: "Tests/UMPTests",
            exclude: [
                "AllMessagesAutoVectorTests.swift",
                "AutoVectorDecodeSmokeTests.swift",
                "CVNoteOnTests.swift",
                "GeneratedCoverageSmokeTests.swift",
                "MIDI1AndSystemTests.swift",
                "StreamAndData128Tests.swift",
                "SysEx7Tests.swift"
            ],
            sources: ["ChannelVoiceNoteOnTests.swift"]
        ),
    ]
)
