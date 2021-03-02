// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayout",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "VDLayout", targets: ["VDLayout"]),
    ],
    dependencies: [
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.13.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.13.0"),
			.package(url: "https://github.com/dankinsoid/CombineOperators.git", from: "1.35.0"),
			.package(url: "https://github.com/dankinsoid/Carbon.git", from: "1.0.1")
    ],
    targets: [
			.target(
				name: "VDLayout",
				dependencies: ["ConstraintsOperators", "VDKit", "CombineOperators", .product(name: "CombineCocoa", package: "CombineOperators"), "Carbon"]
			),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout", "ConstraintsOperators", "VDKit", "CombineOperators", .product(name: "CombineCocoa", package: "CombineOperators"), "Carbon"]
			),
    ]
)
