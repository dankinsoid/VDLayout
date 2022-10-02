import UIKit
import VDChain
import ConstraintsOperators

extension Chain: UILayoutableArray where Base.Root: UILayoutableArray, Base: ValueChaining {
	
	public func asLayoutableArray() -> [UILayoutable] {
		apply().asLayoutableArray()
	}
}

extension Chain: UILayoutable where Base.Root: UILayoutable, Base: ValueChaining {
	public var itemForConstraint: ConstraintItem {
		apply().itemForConstraint
	}
}

extension Chain: Attributable where Base.Root: Attributable, Base: ValueChaining {
    
	public typealias Target = Base.Root.Target
	public typealias Att = Base.Root.Att
	
	public var target: Base.Root.Target {
		apply().target
	}
}
