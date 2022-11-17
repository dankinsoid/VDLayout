import UIKit

/// Type that can be used in a `NSLayoutConstraint`
public protocol NSLayoutConstraintable {

    var constraintItem: AnyObject { get }

    func withConstraints(_ constraints: [NSLayoutConstraint]) -> Constraints
}

public extension NSLayoutConstraintable {
    
    func withConstraints(_ constraints: [NSLayoutConstraint]) -> Constraints {
        Constraints(item: self, constraints: constraints)
    }
}

extension UIView: NSLayoutConstraintable {

    public var constraintItem: AnyObject { self }
}

extension UILayoutGuide: NSLayoutConstraintable {

    public var constraintItem: AnyObject { self }
}

extension UIViewController: NSLayoutConstraintable {

    public var constraintItem: AnyObject { view }
}

public extension NSLayoutConstraintable {

    var superviewConstraintItem: NSLayoutConstraintable? {
        asUIView?.superview
    }

    var asUIView: UIView? {
        (constraintItem as? UIView) ?? (constraintItem as? UILayoutGuide)?.owningView
    }
}
