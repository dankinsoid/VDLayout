import UIKit

/// Type that can be used in a `NSLayoutConstraint`
public protocol NSLayoutConstraintable {
    
    var constraintItem: AnyObject { get }
}
