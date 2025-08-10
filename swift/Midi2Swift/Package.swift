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
            path: "Sources/UMP"
        ),
        .testTarget(
            name: "UMPTests",
            dependencies: ["UMP", "Core"],
            path: "Tests/UMPTests"
        ),
    ]
)
