// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VDLayoutRx",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "VDLayoutRx", targets: ["VDLayoutRx"]),
    ],
    dependencies: [
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.29.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.144.0"),
			.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
			.package(url: "https://github.com/dankinsoid/Carbon.git", from: "1.0.1")
    ],
    targets: [
        .target(
            name: "VDLayoutRx",
            dependencies: ["ConstraintsOperators", "VDKit", "RxSwift", .product(name: "RxCocoa", package: "RxSwift"), "Carbon"]
				),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayoutRx", "VDKit"]),
    ]
)
