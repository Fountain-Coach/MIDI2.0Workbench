// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Midi2Swift",
    products: [
        .library(name: "Midi2Swift", targets: ["Midi2Swift"]),
    ],
    targets: [
        .target(name: "Midi2Swift", path: "Sources"),
        .testTarget(name: "Midi2SwiftTests", dependencies: ["Midi2Swift"], path: "Tests"),
    ]
)
