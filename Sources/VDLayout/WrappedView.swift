//
//  WrappedView.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import Foundation
import UIKit
import VDKit
import ConstraintsOperators

public struct WrappedView<W: SubviewProtocol, P: SubviewProtocol>: SubviewProtocol, ValueChainingProtocol {
	
	let parent: P
	public var wrappedValue: W
	
	private(set) public var action: (W) -> W = { $0 }
	
	public init(_ child: W, parent: P) {
		self.wrappedValue = child
		self.parent = parent
	}
	
	public func createViewToAdd() -> UIView {
		parent.createViewToAdd()
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		parent.didAdded(view: view, to: superview)
		view.add(subview: wrappedValue)
	}
	
	public func copy(with action: @escaping (W) -> W) -> WrappedView {
		var result = WrappedView(wrappedValue, parent: parent)
		result.action = action
		return result
	}
}

extension WrappedView: UILayoutableArray where P: UILayoutableArray {
	public func asLayoutableArray() -> [UILayoutable] {
		parent.asLayoutableArray()
	}
}

extension WrappedView: UILayoutable where P: UILayoutable {
	public var itemForConstraint: Any { parent.itemForConstraint }
}

extension WrappedView: Attributable where P: Attributable {
	public typealias Att = P.Att
	
	public var target: P.Target {
		parent.target
	}
}
