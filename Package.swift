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
			.package(url: "https://github.com/dankinsoid/ConstraintsOperators.git", from: "2.33.0"),
            .package(url: "https://github.com/dankinsoid/VDChain.git", from: "2.3.0"),
			.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "VDLayout",
            dependencies: [
                "ConstraintsOperators",
                "VDChain",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                ]
            ),
			.testTarget(
				name: "VDLayoutTests",
				dependencies: ["VDLayout"]
            ),
    ]
)
