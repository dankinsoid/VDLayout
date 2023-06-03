# VDLayout

[![Version](https://img.shields.io/cocoapods/v/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![License](https://img.shields.io/cocoapods/l/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![Platform](https://img.shields.io/cocoapods/p/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)

This repository provides a declarative way to layout in SwiftUI-style. The DSL is based on [KeyPath chaining](https://github.com/dankinsoid/VDChain) so you can use any view property, don't need to create a DSL wrapper on your custom views, but you can create [custom convinience modifiers](Sources/VDLayout/Modifiers).

## Example

```swift
public final class SomeView: UISubview {

  private let label = UILabel()

  override public var content: any Subview {
    UIStackView.V(spacing: 3, alignment: .center) {
      label
        .chain
        .textAlignment(.center)
        .textColor(.red)
        .contentPriority(.required, axis: .horizontal, type: .compression)
	    
      UILabel().chain
        .text("Subtitle")

      UIButton().chain
        .title("Tap me")
    }
    .pin(.edges)
  }

  public func update(title: String) {
    label.text = title
  }
}
```
## Usage

### Base
 - `Subview` - protocol describes any type that can be used as a subview
 - `SubviewBuilder` - function builder to create `any Subview`, it allows use SwiftUI `View`s as well.
 - `.chain` - property to create `KeyPath` [chaining](https://github.com/dankinsoid/VDChain.git) for views.
 - `do {...}` - function to any custom actions on view
 - `add {...}` - analog of `addSubview` but with `SubviewBuilder`
 - `with {...}` - same as `add` but returns the view itself, for using in layout
 
 ### Constraints
 For constraints this repo use [`pin`](https://github.com/dankinsoid/VDPin.git) methods, examples:
 ```swift
 UIView()
  .pin(.edges)
  .pin(to: .bottom, of: view2, options: .offset(4))
  .pin(.bottom, 10..., to: view3)  
  .pin(.width, to: .height, of: superview, options: .multiplier(2), .offset(10), .toSafeArea)
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
    .package(url: "https://github.com/dankinsoid/VDLayout.git", from: "4.8.1")
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

