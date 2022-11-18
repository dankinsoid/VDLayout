import UIKit

/// Type that can be used in a `NSLayoutConstraint`
public protocol NSLayoutConstraintable {
    
    var constraintItem: AnyObject { get }
}


struct AnyNSLayoutConstraintable: NSLayoutConstraintable {
    
    var constraintItem: AnyObject
    
    init(_ constraintItem: AnyObject) {
        self.constraintItem = constraintItem
    }
}
