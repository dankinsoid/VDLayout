// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayout",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(name: "VDLayout", targets: ["VDLayout"]),
    ],
    dependencies: [
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.12.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.7.0"),
			.package(url: "https://github.com/ReactiveX/RxSwift", from: "6.0.0"),
			.package(url: "https://github.com/dankinsoid/Carbon", from: "1.0.1")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: ["ConstraintsOperators", "VDKit", "RxSwift", "RxCocoa", "Carbon"]
				),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout", "VDKit"]),
    ]
)
