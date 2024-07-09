// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "VDLayout",
	platforms: [
		.iOS(.v13),
	],
	products: [
		.library(name: "VDLayout", targets: ["VDLayout"]),
	],
	dependencies: [
		.package(url: "https://github.com/dankinsoid/VDChain.git", from: "3.0.0"),
		.package(url: "https://github.com/dankinsoid/UIKitViews.git", from: "1.4.0"),
		.package(url: "https://github.com/dankinsoid/VDPin.git", from: "1.7.0"),
        .package(url: "https://github.com/dankinsoid/CellsReloadable.git", from: "2.0.0"),
	],
	targets: [
		.target(
			name: "VDLayout",
			dependencies: ["VDChain", "VDPin", "UIKitViews", "CellsReloadable"]
		),
	]
)
