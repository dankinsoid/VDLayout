// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "VDLayout", targets: ["VDLayout"]),
    ],
    dependencies: [
			.package(url: "https://github.com/dankinsoid/VDChain", from: "1.0.0"),
			.package(url: "https://github.com/dankinsoid/NSMethodsObservation", from: "1.1.0"),
			.package(url: "https://github.com/layoutBox/PinLayout", from: "1.10.0")
    ],
    targets: [
			.target(
				name: "VDLayout",
				dependencies: ["VDChain", "NSMethodsObservation", "PinLayout"]
			),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout", "VDChain"]
			),
    ]
)
