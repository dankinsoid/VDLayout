//
//  ConstraintedSubview.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

@dynamicMemberLookup
public struct DidAddedSubview<W: SubviewProtocol>: SubviewProtocol, ValueChainingProtocol {
	public var wrappedValue: W
	private let didAddedTo: (UIView, UIView) -> Void
	private(set) public var action: (W) -> W = { $0 }
	
	init(_ content: W, didAdded: @escaping (UIView, UIView) -> Void) {
		wrappedValue = content
		didAddedTo = didAdded
	}
	
	public func createViewToAdd() -> UIView {
		wrappedValue.createViewToAdd()
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		wrappedValue.didAdded(view: view, to: superview)
		didAddedTo(view, superview)
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<W, A>) -> ChainingProperty<DidAddedSubview, A> {
		ChainingProperty<DidAddedSubview, A>(self, getter: keyPath)
	}
	
	public func copy(with action: @escaping (W) -> W) -> DidAddedSubview {
		var result = DidAddedSubview(wrappedValue, didAdded: didAddedTo)
		result.action = action
		return result
	}
	
}

extension DidAddedSubview: UILayoutableArray where W: UILayoutableArray {
	public func asLayoutableArray() -> [UILayoutable] {
		wrappedValue.asLayoutableArray()
	}
}

extension DidAddedSubview: UILayoutable where W: UILayoutable {
	public var itemForConstraint: Any { wrappedValue.itemForConstraint }
}

extension DidAddedSubview: Attributable where W: Attributable {
	public typealias Att = W.Att
	public var target: W.Target { wrappedValue.target }
}
