import UIKit

public struct Constraints {

    public weak var item: AnyObject?
    public var constraints: [NSLayoutConstraint] = []
    public var isEmpty: Bool { constraints.isEmpty }

    init(item: any NSLayoutConstraintable, constraints: [NSLayoutConstraint] = []) {
        self.item = item.constraintItem
        self.constraints = constraints
    }

    public init() {}

    public func set(active: Bool) {
        constraints.forEach { $0.isActive = active }
    }

    public func set(priority: UILayoutPriority) {
        constraints.forEach {
            let isActive = $0.isActive
            $0.isActive = false
            $0.priority = priority
            $0.isActive = isActive
        }
    }

    public func update(constant: CGFloat) {
        constraints.forEach {
            $0.constant = constant * $0.firstAttribute.offsetMultiplier
        }
    }
}

extension Constraints: CustomStringConvertible {

    public var description: String {
        "[\n\(constraints.map { $0.identifier ?? "\($0)" }.joined(separator: "\n    "))\n]"
    }
}

extension Constraints: NSLayoutConstraintable {

    public var constraintItem: AnyObject {
        item ?? UIView()
    }

    public func makeConstraints(_ constraints: [NSLayoutConstraint]) -> Constraints {
        Constraints(item: self, constraints: self.constraints + constraints)
    }
}
