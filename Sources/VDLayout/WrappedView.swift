import Foundation
import UIKit
import VDChain
import ConstraintsOperators

public struct WrappedView<Root: SubviewProtocol, P: SubviewProtocol>: SubviewProtocol, ValueChaining {
	let parent: P
	public var root: Root
	
	public init(_ child: Root, parent: P) {
		self.root = child
		self.parent = parent
	}

    public func apply(on root: inout Root) {
    }
    
	public func createViewToAdd() -> UIView {
		let result = parent.createViewToAdd()
		result.add(subview: root)
		return result
	}
}

extension WrappedView: UILayoutableArray where P: UILayoutableArray {
	public func asLayoutableArray() -> [UILayoutable] {
		parent.asLayoutableArray()
	}
}

extension WrappedView: UILayoutable where P: UILayoutable {
	public var itemForConstraint: ConstraintItem { parent.itemForConstraint }
}

extension WrappedView: Attributable where P: Attributable {
	public typealias Att = P.Att
	
	public var target: P.Target {
		parent.target
	}
}
