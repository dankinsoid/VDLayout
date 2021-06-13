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

public struct WrappedView<Value: SubviewProtocol, P: SubviewProtocol>: SubviewProtocol, ValueChainingProtocol {
	
	let parent: P
	public var value: Value
	
	public init(_ child: Value, parent: P) {
		self.value = child
		self.parent = parent
	}
	
	public func createViewToAdd() -> UIView {
		let result = parent.createViewToAdd()
		result.add(subview: value)
		return result
	}
	
	public func apply(_ value: Value) -> Value { value }
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
