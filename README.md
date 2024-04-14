# VDLayout

[![Version](https://img.shields.io/cocoapods/v/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![License](https://img.shields.io/cocoapods/l/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)
[![Platform](https://img.shields.io/cocoapods/p/VDLayout.svg?style=flat)](https://cocoapods.org/pods/VDLayout)

## Table of Contents
- [Overview](#overview)
- [Concepts](#concepts)
- [Usage and Examples](#usage-and-examples)
- [List of Methods and Extensions](#list-of-methods-and-extensions)
- [Installation](#installation)
- [Related Libraries](#related-libraries)
- [Contributors](#contributors)

## Overview
VDLayout is a lightweight and intuitive Swift library designed to simplify the layout building process in UIKit. By providing convenient extensions on native UIKit components, it allows developers to easily and quickly define user interfaces in a manner that is clean, efficient, and easy to understand. This library aims to offer a smooth integration into any UIKit project, and also SwiftUI, by avoiding complex abstractions or magic. It's essentially a friendly UIKit companion, making your layout code more readable and maintainable.

## Concepts
VDLayout introduces several key concepts:

- **Subview and SubviewBuilder**: These types allow for the creation and configuration of subviews within a parent view.
- **UISubview and UISubviewController**: These are helper subclasses for UIView and UIViewController respectively. You can inherit these to override the `content` property.
- [**Chain**](https://github.com/dankinsoid/VDChain): This is a view wrapper that enables method chaining on a view via keypaths.
- [**pin(_:) methods**](https://github.com/dankinsoid/VDPin): These methods allow for the creation of auto-layout constraints.
- [**UIKitView**](https://github.com/dankinsoid/UIKitViews): This is a SwiftUI wrapper around UIView and UIViewController that supports chaining and provides seamless integration of UIKit components with SwiftUI.
- **CellsSection and ViewCell**: These structures are used for building and managing cells in table and collection views.
- [**ViewCellsReloadable**](Docs/ReloadableViews.md): This is a protocol that marks a view as having reloadable cells.

With these elements, the library provides a simple, yet powerful toolkit for handling common layout tasks in UIKit.

## Usage and Examples
The VDLayout library can be used to handle a variety of tasks.

For instance, you can easily chain together properties and methods on views:

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

You can also use it to manage collections and tables:

```swift
let dataSource = UITableViewSource()
let tableView = UITableView(dataSource)

dataSource.reload(data: items) { _ in
    SomeTableViewCell()
} reload: { cell, item in
  cell.text = item.name
}
```

## List of Methods and Extensions
VDLayout extends various UIKit components with numerous useful methods. For a full list, see [here](Docs/MethodsAndExtensions.md).

## Installation
VDLayout is available via Swift Package Manager (SPM). 

To install it, simply add the following line to the dependencies value of your Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/dankinsoid/VDLayout.git", from: "4.12.0")
]
```

Then, in your target dependencies, add `"VDLayout"`:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["VDLayout"]),
]
```

## Related Libraries
VDLayout makes use of several related libraries:

- [VDPin](https://github.com/dankinsoid/VDPin): A Swift library for easy creation of AutoLayout constraints.
- [VDChain](https://github.com/dankinsoid/VDChain): A Swift library that enables method chaining on views via keypaths.
- [UIKitViews](https://github.com/dankinsoid/UIKitViews): A Swift library providing seamless integration of UIKit components with the SwiftUI framework

## Contributors
- Voidilov Daniil: Main Developer
- OpenAI's ChatGPT: Contributor to README

For any queries or suggestions, feel free to open an issue on GitHub.

--- 

This document was co-authored by an OpenAI language model. The descriptions and examples have been reviewed for accuracy and clarity. If you have any corrections or improvements, please open an issue or make a pull request on GitHub.
