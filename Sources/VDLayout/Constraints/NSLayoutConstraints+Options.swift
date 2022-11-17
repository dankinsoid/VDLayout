import UIKit

public extension NSLayoutConstraint {

    struct Options: Hashable, ExpressibleByArrayLiteral {

        public var offset: CGFloat
        public var multiplier: CGFloat
        public var relation: NSLayoutConstraint.Relation
        public var priority: UILayoutPriority?
        public var activated: Bool?
        public var update: Bool
        public var turnOffAutoresizing: Bool
        public var useSafeArea: Bool

        public init(_ elements: [Options]) {
            self.init(
                offset: elements.map(\.offset).reduce(0, +),
                multiplier: elements.map(\.multiplier).reduce(1, *),
                relation: Options.relation(for: Set(elements.map(\.relation))),
                priority: elements.compactMap { $0.priority?.rawValue }.max().map { UILayoutPriority(rawValue: $0) },
                activated: elements.compactMap(\.activated).nilIfEmpty?.contains { $0 },
                update: elements.contains { $0.update },
                turnOffAutoresizing: !(elements.contains { !$0.turnOffAutoresizing }),
                useSafeArea: elements.contains { $0.useSafeArea }
            )
        }

        public init(
            offset: CGFloat = 0,
            multiplier: CGFloat = 1,
            relation: NSLayoutConstraint.Relation = .equal,
            priority: UILayoutPriority? = nil,
            activated: Bool? = nil,
            update: Bool = false,
            turnOffAutoresizing: Bool = true,
            useSafeArea: Bool = false
        ) {
            self.offset = offset
            self.multiplier = multiplier
            self.relation = relation
            self.priority = priority
            self.activated = activated
            self.update = update
            self.turnOffAutoresizing = turnOffAutoresizing
            self.useSafeArea = useSafeArea
        }

        public init(arrayLiteral elements: Options...) {
            self.init(elements)
        }
    }

    var options: Options {
        Options(
            offset: constant * firstAttribute.offsetMultiplier,
            multiplier: multiplier,
            relation: firstAttribute.relation(for: relation),
            priority: priority,
            activated: isActive
        )
    }
}

public extension NSLayoutConstraint.Options {

    static var `default`: NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(priority: .required, activated: true)
    }

    static func offset<Value: ConstraintsRangeConvertable>(_ offset: Value) -> NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(
            offset: offset.toConstraintsRange().1,
            relation: offset.toConstraintsRange().0
        )
    }

    static func multiplier(_ multiplier: CGFloat) -> NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(multiplier: multiplier)
    }

    static func relation(_ relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(relation: relation)
    }

    static func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(priority: priority)
    }

    static var inactive: NSLayoutConstraint.Options {
        .activated(false)
    }

    static func activated(_ activated: Bool) -> NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(activated: activated)
    }

    static var lessThanOrEqual: NSLayoutConstraint.Options {
        .relation(.lessThanOrEqual)
    }

    static var greaterThanOrEqual: NSLayoutConstraint.Options {
        .relation(.greaterThanOrEqual)
    }

    static var update: NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(update: true)
    }

    static var translatesAutoresizingMask: NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(turnOffAutoresizing: false)
    }

    static var safeArea: NSLayoutConstraint.Options {
        NSLayoutConstraint.Options(useSafeArea: true)
    }
}

private extension NSLayoutConstraint.Options {

    static func relation(for relations: Set<NSLayoutConstraint.Relation>) -> NSLayoutConstraint.Relation {
        if relations.contains(.lessThanOrEqual), relations.contains(.greaterThanOrEqual) {
            return .equal
        } else if relations.contains(.lessThanOrEqual) {
            return .lessThanOrEqual
        } else if relations.contains(.greaterThanOrEqual) {
            return .greaterThanOrEqual
        } else {
            return .equal
        }
    }
}
