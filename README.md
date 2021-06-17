# VDLayout

[![CI Status](https://img.shields.io/travis/dankinsoid/VDLayout.svg?style=flat)](https://travis-ci.org/dankinsoid/VDLayout)
[![Version](https://img.shields.io/cocoapods/v/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![License](https://img.shields.io/cocoapods/l/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![Platform](https://img.shields.io/cocoapods/p/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)


## Description
This repository provides a declarative way to layout in SwiftUI-style

## Example

```swift
view.add {
	UIStackView.V {
		UILabel("1")
			.chain
			.textAlignment(.center)
			.textColor(.red)
			.contentPriority.horizontal.compression(.required)
		UILabel().chain.text("2")
		UIButton().chain.title("Button")
	}
	.chain
	.alignment(.center)
	.distribution(.equalSpacing)
	.spacing(3)
	.edges().equal(to: 0)
	.width(8)
	.width.equal(to: { $0.height / 2 })
}
```
## Usage

### Base
 - `SubviewProtocol` - protocol describes any type that can be used as a subview
 - `SubviewsBuilder` - function builder to create `[SubviewProtocol]`, it allows use SwiftUI `View`s as well (also you can use any `SubviewProtocol` in SwiftUI `ViewBuilder`)
 - `LtView`, `LtViewController` - helper classes with `createLayout()` function to override, optional for use
 - `UIKiView`, `UIKitViewController` - SwiftUI wrappers on `UIView` and `UIViewController`: useful for `PreviewProvider`
 - `.chain` - property to create `KeyPath` chaining for views, after `.chain` you can write any property of view, then subscript with value (`[value]`) or `Publisher` to subscribe (`[cb: somePublisher]`)
 - `do {...}` - function to any custom actions on view
 - `add {...}` - analog of `addSubview` but with `SubviewsBuilder`
 - `with {...}` - same as `add` but returns the view itself, for using in layout
 
 ### Constraints
 For constraints this repo use `ConstraintsOperators` dependency, examples:
 ```swift
 UIView()
 	.edges().equal(to: 0)
 	.top.equal(to: view2.bottom + 4)
 	.bottom.greater(than: view3.bottom + 10)
 	.width.equal(to: { $0.superview?.height * 2 + 10 })
 ```
 You can use subscripts instead of `equal(to:...)` to shorten: `button.size[44]`
 
 ### Tables and collection
 For tables and collections this repo use `Carbon` dependency
 `UIList` and `UICollection` - helper `UITableView` and `UICollectionView` subclasses
 
 ```swift
 UIList($elements) {
	SomeCell($0) 
}
 ```
 
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
    .package(url: "https://github.com/dankinsoid/VDLayout.git", from: "2.11.0")
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

