// swift-tools-version:5.2
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
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.23.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.11.0"),
			.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: ["ConstraintsOperators", "VDKit", "RxSwift", .product(name: "RxCocoa", package: "RxSwift")]
				),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout", "VDKit"]),
    ]
)
