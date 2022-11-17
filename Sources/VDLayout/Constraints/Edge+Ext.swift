import SwiftUI

extension Edge.Set: Hashable {

    public var asAttributes: [NSLayoutConstraint.Attribute] {
        var result: [NSLayoutConstraint.Attribute] = []
        if contains(.top) { result.append(.top) }
        if contains(.bottom) { result.append(.bottom) }
        if contains(.trailing) { result.append(.trailing) }
        if contains(.leading) { result.append(.leading) }
        return result
    }

    public var inverted: Edge.Set {
        var result: Edge.Set = []
        if contains(.leading) { result.insert(.trailing) }
        if contains(.trailing) { result.insert(.leading) }
        if contains(.top) { result.insert(.bottom) }
        if contains(.bottom) { result.insert(.top) }
        return result
    }

    public init(_ edge: Edge) {
        switch edge {
        case .leading: self = .leading
        case .trailing: self = .trailing
        case .top: self = .top
        case .bottom: self = .bottom
        }
    }
}

extension UIRectEdge: Hashable {

    public static var vertical: UIRectEdge { [.top, .bottom] }
    public static var horizontal: UIRectEdge { [.left, .right] }

    public var inverted: UIRectEdge {
        var result: UIRectEdge = []
        if contains(.left) { result.insert(.right) }
        if contains(.right) { result.insert(.left) }
        if contains(.top) { result.insert(.bottom) }
        if contains(.bottom) { result.insert(.top) }
        return result
    }

    public init(_ edge: Edge) {
        switch edge {
        case .leading: self = .left
        case .trailing: self = .right
        case .top: self = .top
        case .bottom: self = .bottom
        }
    }

    public static var trailing: UIRectEdge {
        UIApplication.shared.isLTRLanguage ? .right : .left
    }

    public static var leading: UIRectEdge {
        UIApplication.shared.isLTRLanguage ? .left : .right
    }
}

extension UIRectEdge: CustomStringConvertible {

    public var description: String {
        switch self {
        case .left: return ".left"
        case .right: return ".right"
        case .top: return ".top"
        case .bottom: return ".bottom"
        case .all: return ".all"
        case .vertical: return ".vertical"
        case .horizontal: return ".horizontal"
        default:
            var result: [String] = []
            if contains(.left) { result.append(".left") }
            if contains(.right) { result.append(".right") }
            if contains(.top) { result.append(".top") }
            if contains(.bottom) { result.append(".bottom") }
            return "[\(result.joined(separator: ", "))]"
        }
    }
}

public extension Edge {

    var opposite: Edge {
        switch self {
        case .leading: return .trailing
        case .trailing: return .leading
        case .top: return .bottom
        case .bottom: return .top
        }
    }

    var axe: Axis {
        switch self {
        case .bottom, .top: return .vertical
        case .leading, .trailing: return .horizontal
        }
    }

    var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .trailing: return .trailing
        case .top: return .top
        case .bottom: return .bottom
        }
    }

    static var left: Edge {
        UIApplication.shared.isLTRLanguage ? .leading : .trailing
    }

    static var right: Edge {
        UIApplication.shared.isLTRLanguage ? .trailing : .leading
    }
}

public extension Edge.Set {

    static var left: Edge.Set {
        UIApplication.shared.isLTRLanguage ? .leading : .trailing
    }

    static var right: Edge.Set {
        UIApplication.shared.isLTRLanguage ? .trailing : .leading
    }
}

public extension UIEdgeInsets {

    init(edges: [Edge.Set: CGFloat]) {
        self = UIEdgeInsets(
            top: edges.first { $0.key.contains(.top) }?.value ?? 0,
            left: edges.first { $0.key.contains(.left) }?.value ?? 0,
            bottom: edges.first { $0.key.contains(.bottom) }?.value ?? 0,
            right: edges.first { $0.key.contains(.right) }?.value ?? 0
        )
    }

    subscript(_ edge: Edge) -> CGFloat {
        get {
            switch edge {
            case .left: return left
            case .right: return right
            case .top: return top
            case .bottom: return bottom
            default: return 0
            }
        }
        set {
            switch edge {
            case .left: left = newValue
            case .right: right = newValue
            case .top: top = newValue
            case .bottom: bottom = newValue
            default: break
            }
        }
    }
}

public func * (lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(top: lhs.top * rhs, left: lhs.left * rhs, bottom: lhs.bottom * rhs, right: lhs.right * rhs)
}

public func * (lhs: CGFloat, rhs: UIEdgeInsets) -> UIEdgeInsets {
    rhs * lhs
}

public prefix func - (_ rhs: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(top: -rhs.top, left: -rhs.left, bottom: -rhs.bottom, right: -rhs.right)
}

public extension EdgeInsets {

    var uiEdgeInsets: UIEdgeInsets {
        UIEdgeInsets(
            top: top,
            left: UIApplication.shared.isLTRLanguage ? leading : trailing,
            bottom: bottom,
            right: UIApplication.shared.isLTRLanguage ? trailing : leading
        )
    }
}

public extension CACornerMask {

    static func edge(_ edge: Edge) -> CACornerMask {
        switch edge {
        case .leading: return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .bottom: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .top: return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .trailing: return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}

public extension CGFloat {

    static var anchorLeading: CGFloat {
        UIApplication.shared.isLTRLanguage ? 0 : 1
    }

    static var anchorTrailing: CGFloat {
        UIApplication.shared.isLTRLanguage ? 1 : 0
    }
}
