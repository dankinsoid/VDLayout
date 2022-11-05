// swift-tools-version:5.7
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
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.33.0"),
            .package(url: "https://github.com/dankinsoid/VDChain.git", from: "2.4.0"),
			.package(url: "https://github.com/dankinsoid/CombineOperators.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: [
                "ConstraintsOperators",
                "VDChain",
                "CombineOperators",
                .product(name: "CombineCocoa", package: "CombineOperators"),
            ]
        ),
        .testTarget(
            name: "VDLayoutTests",
            dependencies: ["VDLayout"]
        )
    ]
)
