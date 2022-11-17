import SwiftUI
import UIKit

public extension NSLayoutConstraint.Attribute {

    struct Set: OptionSet, Hashable {

        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        // swiftlint:disable cyclomatic_complexity
        public init(_ attributes: NSLayoutConstraint.Attribute...) {
            var result: Set = []
            if attributes.contains(.top) {
                result.insert(.top)
            }
            if attributes.contains(.left) {
                result.insert(.left)
            }
            if attributes.contains(.right) {
                result.insert(.right)
            }
            if attributes.contains(.bottom) {
                result.insert(.bottom)
            }
            if attributes.contains(.leading) {
                result.insert(.leading)
            }
            if attributes.contains(.trailing) {
                result.insert(.trailing)
            }
            if attributes.contains(.width) {
                result.insert(.width)
            }
            if attributes.contains(.height) {
                result.insert(.height)
            }
            if attributes.contains(.centerX) {
                result.insert(.centerX)
            }
            if attributes.contains(.centerY) {
                result.insert(.centerY)
            }
            if attributes.contains(.lastBaseline) {
                result.insert(.lastBaseline)
            }
            if attributes.contains(.firstBaseline) {
                result.insert(.firstBaseline)
            }
            if attributes.contains(.leftMargin) {
                result.insert(.leftMargin)
            }
            if attributes.contains(.rightMargin) {
                result.insert(.rightMargin)
            }
            if attributes.contains(.topMargin) {
                result.insert(.topMargin)
            }
            if attributes.contains(.bottomMargin) {
                result.insert(.bottomMargin)
            }
            if attributes.contains(.leadingMargin) {
                result.insert(.leadingMargin)
            }
            if attributes.contains(.trailingMargin) {
                result.insert(.trailingMargin)
            }
            if attributes.contains(.centerXWithinMargins) {
                result.insert(.centerXWithinMargins)
            }
            if attributes.contains(.centerYWithinMargins) {
                result.insert(.centerYWithinMargins)
            }
            self = result
        }

        public var attributes: [NSLayoutConstraint.Attribute] {
            var result: [NSLayoutConstraint.Attribute] = []
            if contains(.top) {
                result.append(.top)
            }
            if contains(.left) {
                result.append(.left)
            }
            if contains(.right) {
                result.append(.right)
            }
            if contains(.bottom) {
                result.append(.bottom)
            }
            if contains(.leading) {
                result.append(.leading)
            }
            if contains(.trailing) {
                result.append(.trailing)
            }
            if contains(.width) {
                result.append(.width)
            }
            if contains(.height) {
                result.append(.height)
            }
            if contains(.centerX) {
                result.append(.centerX)
            }
            if contains(.centerY) {
                result.append(.centerY)
            }
            if contains(.lastBaseline) {
                result.append(.lastBaseline)
            }
            if contains(.firstBaseline) {
                result.append(.firstBaseline)
            }
            if contains(.leftMargin) {
                result.append(.leftMargin)
            }
            if contains(.rightMargin) {
                result.append(.rightMargin)
            }
            if contains(.topMargin) {
                result.append(.topMargin)
            }
            if contains(.bottomMargin) {
                result.append(.bottomMargin)
            }
            if contains(.leadingMargin) {
                result.append(.leadingMargin)
            }
            if contains(.trailingMargin) {
                result.append(.trailingMargin)
            }
            if contains(.centerXWithinMargins) {
                result.append(.centerXWithinMargins)
            }
            if contains(.centerYWithinMargins) {
                result.append(.centerYWithinMargins)
            }
            return result
        }
        // swiftlint:enable cyclomatic_complexity
    }
}

extension NSLayoutConstraint.Attribute.Set: CustomStringConvertible {

    public var description: String {
        attributes.description
    }
}

public extension NSLayoutConstraint.Attribute.Set {

    static let top = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 0)
    static let left = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 1)
    static let right = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 2)
    static let bottom = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 3)
    static let leading = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 4)
    static let trailing = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 5)
    static let width = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 6)
    static let height = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 7)
    static let centerX = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 8)
    static let centerY = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 9)
    static let lastBaseline = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 10)
    static let firstBaseline = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 11)
    static let leftMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 12)
    static let rightMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 13)
    static let topMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 14)
    static let bottomMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 15)
    static let leadingMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 16)
    static let trailingMargin = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 17)
    static let centerXWithinMargins = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 18)
    static let centerYWithinMargins = NSLayoutConstraint.Attribute.Set(rawValue: 1 << 19)

    static var all: NSLayoutConstraint.Attribute.Set {
        [
            .top,
            .left,
            .right,
            .bottom,
            .leading,
            .trailing,
            .width,
            .height,
            .centerX,
            .centerY,
            .lastBaseline,
            .firstBaseline,
            .leftMargin,
            .rightMargin,
            .topMargin,
            .bottomMargin,
            .leadingMargin,
            .trailingMargin,
            .centerXWithinMargins,
            .centerYWithinMargins
        ]
    }

    static var center: NSLayoutConstraint.Attribute.Set {
        [.centerX, .centerY]
    }

    static func edges(_ edges: Edge.Set, _ optional: Edge.Set...) -> NSLayoutConstraint.Attribute.Set {
        let edges = optional.reduce(edges) { $0.union($1) }
        var result: NSLayoutConstraint.Attribute.Set = []
        if edges.contains(.top) {
            result.insert(.top)
        }
        if edges.contains(.leading) {
            result.insert(.leading)
        }
        if edges.contains(.trailing) {
            result.insert(.trailing)
        }
        if edges.contains(.bottom) {
            result.insert(.bottom)
        }
        return result
    }

    static var edges: NSLayoutConstraint.Attribute.Set {
        .edges(.all)
    }

    static var size: NSLayoutConstraint.Attribute.Set {
        [.width, .height]
    }

    static func size(_ axis: NSLayoutConstraint.Axis) -> NSLayoutConstraint.Attribute.Set {
        switch axis {
        case .horizontal: return .width
        case .vertical: return .height
        @unknown default: return []
        }
    }
}
