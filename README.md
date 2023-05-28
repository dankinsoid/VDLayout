# VDLayout

[![CI Status](https://img.shields.io/travis/dankinsoid/VDLayout.svg?style=flat)](https://travis-ci.org/dankinsoid/VDLayout)
[![Version](https://img.shields.io/cocoapods/v/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![License](https://img.shields.io/cocoapods/l/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![Platform](https://img.shields.io/cocoapods/p/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)


## Description
This repository provides a declarative way to layout in SwiftUI-style. The DSL is based on [KeyPath chaining](https://github.com/dankinsoid/VDChain) so you can use any view property, don't need to create a DSL wrapper on your custom views, but you can create [custom convinience modifiers](Sources/VDLayout/Modifiers).

## Example

```swift
view.add {
  UIStackView.V {
    UILabel("1")
      .chain
	    .textAlignment(.center)
	    .textColor(.red)
	    .contentPriority(.required, axis: .horizontal, type: .compression)
	    
	  UILabel().chain.text("2")
    UIButton().chain.title("Button")
  }
  .alignment(.center)
  .distribution(.equalSpacing)
  .spacing(3)
  .pin(.edges)
  .pin(.width, 8)
  .pin(aspectRatio: 1 / 2)
}
```
## Usage

### Base
 - `SubviewProtocol` - protocol describes any type that can be used as a subview
 - `SubviewsBuilder` - function builder to create `[SubviewProtocol]`, it allows use SwiftUI `View`s as well (also you can use any `SubviewProtocol` in SwiftUI `ViewBuilder`)
 - `ViewComponent` - protocol describes 
 - `LtView`, `LtViewController` - helper classes with `createLayout()` function to override, optional for use
 - `.chain` - property to create `KeyPath` chaining for views, after `.chain` you can write any property of view, then subscript with value (`[value]`) or `Publisher` to subscribe (`[cb: somePublisher]`)
 - `do {...}` - function to any custom actions on view
 - `add {...}` - analog of `addSubview` but with `SubviewsBuilder`
 - `with {...}` - same as `add` but returns the view itself, for using in layout
 
 ### Constraints
 For constraints this repo use [`pin`](https://github.com/dankinsoid/VDPin.git) methods, examples:
 ```swift
 UIView()
 	.pin(.edges)
 	.pin(to: .bottom, of: view2, options: .offset(4))
  .pin(.bottom, 10..., to: view3)  
 	.pin(.width, to: .height, of: superview, options: .multiplier(2), .offset(10))
 ```
 
## Installation
1. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/VDLayout.git", from: "4.6.2")
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

