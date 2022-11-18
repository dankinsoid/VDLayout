import UIKit

/// Type that can be used in a `NSLayoutConstraint`
public protocol Pinnable {
    
    associatedtype ConstraintsCollection = Constraints
    
    func makeConstraints(_ constraints: @escaping (any NSLayoutConstraintable) -> [NSLayoutConstraint]) -> ConstraintsCollection
}

public extension Pinnable where ConstraintsCollection == Constraints, Self: NSLayoutConstraintable {
    
    func makeConstraints(_ constraints: @escaping (any NSLayoutConstraintable) -> [NSLayoutConstraint]) -> Constraints {
        Constraints(item: self, constraints: constraints(self))
    }
}

extension UIView: NSLayoutConstraintable, Pinnable {
    
    public var constraintItem: AnyObject { self }
}

extension UILayoutGuide: NSLayoutConstraintable, Pinnable {
    
    public var constraintItem: AnyObject { self }
}

extension UIViewController: NSLayoutConstraintable, Pinnable {
    
    public var constraintItem: AnyObject { view }
}

public extension NSLayoutConstraintable {
    
    var superviewConstraintItem: (any NSLayoutConstraintable)? {
        asUIView?.superview
    }
    
    var asUIView: UIView? {
        (constraintItem as? UIView) ?? (constraintItem as? UILayoutGuide)?.owningView
    }
}
