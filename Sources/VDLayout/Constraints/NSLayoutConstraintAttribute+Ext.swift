import UIKit

extension NSLayoutConstraint.Attribute {

    var needMirroring: Bool {
        switch self {
        case .trailing, .right, .bottom, .bottomMargin, .trailingMargin, .rightMargin:
            return true
        default:
            return false
        }
    }

    var offsetMultiplier: CGFloat {
        needMirroring ? -1 : 1
    }

    func relation(for relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        guard needMirroring else { return relation }
        switch relation {
        case .lessThanOrEqual:
            return .greaterThanOrEqual
        case .greaterThanOrEqual:
            return .lessThanOrEqual
        default:
            return relation
        }
    }

    var requireSecondItem: Bool {
        switch self {
        case .width, .height, .notAnAttribute:
            return false
        default:
            return true
        }
    }
}

extension NSLayoutConstraint.Attribute: CustomStringConvertible {

    public var description: String {
        switch self {
        case .top: return ".top"
        case .left: return ".left"
        case .right: return ".right"
        case .bottom: return ".bottom"
        case .leading: return ".leading"
        case .trailing: return ".trailing"
        case .width: return ".width"
        case .height: return ".height"
        case .centerX: return ".centerX"
        case .centerY: return ".centerY"
        case .lastBaseline: return ".lastBaseline"
        case .firstBaseline: return ".firstBaseline"
        case .leftMargin: return ".leftMargin"
        case .rightMargin: return ".rightMargin"
        case .topMargin: return ".topMargin"
        case .bottomMargin: return ".bottomMargin"
        case .leadingMargin: return ".leadingMargin"
        case .trailingMargin: return ".trailingMargin"
        case .centerXWithinMargins: return ".centerXWithinMargins"
        case .centerYWithinMargins: return ".centerYWithinMargins"
        case .notAnAttribute: return ".notAnAttribute"
        @unknown default: return "unknown"
        }
    }
}

public extension NSLayoutConstraint.Attribute {

    func isCompatible(with other: NSLayoutConstraint.Attribute) -> Bool {
        self == other || NSLayoutConstraint.Attribute.compatibilityGroups.contains { $0.contains(self) && $0.contains(other) }
    }
}

private extension NSLayoutConstraint.Attribute {

    static var compatibilityGroups: [Swift.Set<NSLayoutConstraint.Attribute>] {
        [
            [.width, .height],
            [.top, .bottom, .lastBaseline, .firstBaseline, .topMargin, .bottomMargin, .centerY, .centerYWithinMargins],
            [.leading, .leadingMargin, .trailing, .trailingMargin, .centerX, .centerXWithinMargins],
            [.left, .leftMargin, .right, .rightMargin, .centerX, .centerXWithinMargins],
            [.notAnAttribute]
        ]
    }
}
