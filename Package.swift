// swift-tools-version:5.3
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
    ],
    targets: [
			.target(
				name: "VDLayout",
				dependencies: ["VDChain"]
			),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDChain"]
			),
    ]
)
