import UIKit

public extension NSLayoutConstraint {

    static func create(
        attribute firstAttribute: NSLayoutConstraint.Attribute,
        item firstItem: some NSLayoutConstraintable,
        attribute secondAttribute: NSLayoutConstraint.Attribute,
        toItem secondItem: (any NSLayoutConstraintable)?,
        options: Options,
        file: String = #filePath,
        line: UInt = #line
    ) -> NSLayoutConstraint {
        if options.turnOffAutoresizing {
            firstItem.asUIView?.translatesAutoresizingMaskIntoConstraints = false
        }

        let toItem: (any NSLayoutConstraintable)?
        if let second = secondItem {
            toItem = second
        } else if firstAttribute.requireSecondItem {
            toItem = firstItem.superviewConstraintItem
        } else {
            toItem = nil
        }
        if
            let constraint = updateConstraint(
                attribute: firstAttribute,
                item: firstItem,
                attribute: secondAttribute,
                toItem: toItem,
                options: options
            ) {
            constraint.setIdentifierFor(filePath: file, line: line)
            return constraint
        }

        let constraint = NSLayoutConstraint(
            item: firstItem.constraintItem,
            attribute: firstAttribute,
            relatedBy: firstAttribute.relation(for: options.relation),
            toItem: options.useSafeArea ? toItem?.asUIView?.safeAreaLayoutGuide : toItem?.constraintItem,
            attribute: secondAttribute,
            multiplier: options.multiplier,
            constant: options.offset * firstAttribute.offsetMultiplier
        )
        constraint.setIdentifierFor(filePath: file, line: line)
        constraint.priority = options.priority ?? .required
        constraint.isActive = options.activated ?? true
        return constraint
    }

    func setIdentifierFor(filePath: String, line: UInt) {
        let path = filePath.components(separatedBy: ["/"]).suffix(1).joined(separator: "/")
        var id = "\(path) \(line) - \(firstAttribute)"
        if firstAttribute != secondAttribute, secondAttribute != .notAnAttribute {
            id += "/\(secondAttribute)"
        }
        identifier = id
    }

    func removeConflicts(with constraints: [NSLayoutConstraint]) {
        Set(constraints).filter(willConflict).forEach {
            $0.isActive = false
        }
    }

    func willConflict(with rhs: NSLayoutConstraint) -> Bool {
        guard self !== rhs else { return false }
        return willConflictWith(
            item: rhs.first,
            toItem: rhs.second,
            options: rhs.options
        )
    }
}

private extension NSLayoutConstraint {

    struct Item: Equatable {

        let attribute: NSLayoutConstraint.Attribute
        let view: AnyObject?

        static func == (lhs: NSLayoutConstraint.Item, rhs: NSLayoutConstraint.Item) -> Bool {
            if let left = lhs.view, let right = rhs.view {
                return left === right && lhs.attribute == rhs.attribute
            }
            if lhs.view == nil, rhs.view == nil {
                return lhs.attribute == rhs.attribute
            }
            return false
        }
    }

    var first: Item {
        Item(attribute: firstAttribute, view: firstItem)
    }

    var second: Item {
        Item(attribute: secondAttribute, view: secondItem)
    }

    func willConflictWith(
        item firstItemTo: Item,
        toItem secondItemTo: Item,
        options: NSLayoutConstraint.Options
    ) -> Bool {
        guard priority == options.priority ?? .required else { return false }
        if firstItem == nil && secondItem == nil || firstItemTo.view == nil && secondItemTo.view == nil {
            return false
        }
        let isSame = (first == firstItemTo && second == secondItemTo) && relation == options.relation
        let relationTo = firstItemTo.attribute.relation(for: options.relation)
        let isReverted = (first == secondItemTo && second == firstItemTo) && relation.isOpposite(to: relationTo)
        return isSame || isReverted
    }

    static func updateConstraint(
        attribute firstAttribute: NSLayoutConstraint.Attribute,
        item firstItem: (any NSLayoutConstraintable)?,
        attribute secondAttribute: NSLayoutConstraint.Attribute,
        toItem secondItem: (any NSLayoutConstraintable)?,
        options: NSLayoutConstraint.Options
    ) -> NSLayoutConstraint? {
        guard options.update else { return nil }
        let constraintOwner: UIView?
        if let second = secondItem?.asUIView, second !== firstItem?.asUIView {
            constraintOwner = firstItem?.asUIView?.commonAncestor(with: second)
        } else {
            constraintOwner = firstItem?.asUIView
        }
        guard
            let constraint = constraintOwner?.constraintWith(
                attribute: firstAttribute,
                item: firstItem?.constraintItem,
                attribute: secondAttribute,
                toItem: options.useSafeArea ? secondItem?.asUIView?.safeAreaLayoutGuide : secondItem?.constraintItem,
                options: options
            )
        else {
            return nil
        }
        guard constraint.multiplier == options.multiplier else {
            constraint.isActive = false
            return nil
        }
        constraint.constant = options.offset * constraint.firstAttribute.offsetMultiplier
        constraint.isActive = options.activated ?? true
        return constraint
    }
}

private extension NSLayoutConstraint.Relation {

    func isOpposite(to rhs: NSLayoutConstraint.Relation) -> Bool {
        switch (self, rhs) {
        case (.equal, .equal): return true
        case (.greaterThanOrEqual, .lessThanOrEqual): return true
        case (.lessThanOrEqual, .greaterThanOrEqual): return true
        default: return false
        }
    }
}

private extension UIView {

    func constraintWith(
        attribute firstAttribute: NSLayoutConstraint.Attribute,
        item firstItem: AnyObject?,
        attribute secondAttribute: NSLayoutConstraint.Attribute,
        toItem secondItem: AnyObject?,
        options: NSLayoutConstraint.Options
    ) -> NSLayoutConstraint? {
        constraints.first {
            $0.willConflictWith(
                item: NSLayoutConstraint.Item(attribute: firstAttribute, view: firstItem),
                toItem: NSLayoutConstraint.Item(attribute: secondAttribute, view: secondItem),
                options: options
            )
        }
    }
}
