// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayout",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "VDLayout", targets: ["VDLayout"]),
    ],
    dependencies: [
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.27.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.64.0"),
			.package(url: "https://github.com/dankinsoid/CombineOperators.git", from: "1.65.0"),
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
