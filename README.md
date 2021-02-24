# VDLayout

[![CI Status](https://img.shields.io/travis/dankinsoid/VDLayout.svg?style=flat)](https://travis-ci.org/dankinsoid/VDLayout)
[![Version](https://img.shields.io/cocoapods/v/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![License](https://img.shields.io/cocoapods/l/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![Platform](https://img.shields.io/cocoapods/p/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)


## Description
This repository provides a declarative way to laoyut

## Example

```swift
view.add {
	UIStackView.V {
		UILabel().chain.text["1"]
		UILabel().chain.text["2"]
		UIButton().chain.titleLabel.text[""]
	}
	.chain
	.alignment[.center]
	.distribution[.equalSpacing]
	.spacing[3]
	.edges().equal(to: 0)
	.width[8]
	.widthToHeight(equal: 1 / 2)
}
```
## Usage
TODO

## Installation
1.  [CocoaPods](https://cocoapods.org)

Add the following line to your Podfile:
```ruby
pod 'VDLayout'
```
and run `pod update` from the podfile directory first.

2. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/VDLayout.git", from: "1.31.0")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["VDLayout"])
  ]
)
```
```ruby
$ swift build
```

## Author

dankinsoid, voidilov@gmail.com

## License

VDLayout is available under the MIT license. See the LICENSE file for more info.

