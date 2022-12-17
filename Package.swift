// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayout",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "VDLayout", targets: ["VDLayout"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dankinsoid/VDChain.git", from: "2.5.2"),
        .package(url: "https://github.com/dankinsoid/VDPin.git", from: "1.6.0")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: ["VDChain", "VDPin"]
        ),
    ]
)
