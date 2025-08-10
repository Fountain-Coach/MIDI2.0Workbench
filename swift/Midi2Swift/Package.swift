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
        .library(name: "CI", targets: ["CI"]),
        .library(name: "Profiles", targets: ["Profiles"]),
        .library(name: "PropertyExchange", targets: ["PropertyExchange"]),
    ],
    targets: [
        .target(name: "Core", path: "Sources/Core"),
        .target(name: "UMP", dependencies: ["Core"], path: "Sources/UMP"),
        .target(name: "CI", dependencies: ["Core"], path: "Sources/CI"),
        .target(name: "Profiles", path: "Sources/Profiles"),
        .target(name: "PropertyExchange", dependencies: ["CI"], path: "Sources/PropertyExchange"),
        .testTarget(name: "UMPTests", dependencies: ["UMP"], path: "Tests/UMPTests"),
        .testTarget(name: "CITests", dependencies: ["CI"], path: "Tests/CITests"),
        .testTarget(name: "ProfilesTests", dependencies: ["Profiles"], path: "Tests/ProfilesTests"),
        .testTarget(name: "PropertyExchangeTests", dependencies: ["PropertyExchange"], path: "Tests/PropertyExchangeTests"),
    ]
)
