// swift-tools-version:5.6
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
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.30.0"),
			.package(url: "https://github.com/dankinsoid/VDKit.git", from: "1.189.0"),
			.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
			.package(url: "https://github.com/dankinsoid/CarbonTable.git", from: "2.1.0")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: [
							"ConstraintsOperators",
							"VDKit",
							"RxSwift",
							.product(name: "RxCocoa", package: "RxSwift"),
							"CarbonTable"
						]
				),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout", "VDKit"]),
    ]
)
