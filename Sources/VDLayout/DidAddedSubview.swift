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
	public var itemForConstraint: Any { wrappedValue.itemForConstraint }
	private let didAddedTo: (UIView) -> Void
	private(set) public var action: (W) -> W = { $0 }
	
	init(_ content: W, didAdded: @escaping (UIView) -> Void) {
		wrappedValue = content
		didAddedTo = didAdded
	}
	
	public func viewToAdd() -> UIView {
		wrappedValue.viewToAdd()
	}
	
	public func didAdded(to superview: UIView) {
		wrappedValue.didAdded(to: superview)
		didAddedTo(superview)
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<W, A>) -> ChainingProperty<DidAddedSubview, A, KeyPath<W, A>> {
		ChainingProperty<DidAddedSubview, A, KeyPath<W, A>>(self, getter: keyPath)
	}
	
	public subscript<A>(dynamicMember keyPath: WritableKeyPath<W, A>) -> ChainingProperty<DidAddedSubview, A, WritableKeyPath<W, A>> {
		ChainingProperty<DidAddedSubview, A, WritableKeyPath<W, A>>(self, getter: keyPath)
	}
	
	public subscript<A>(dynamicMember keyPath: ReferenceWritableKeyPath<W, A>) -> ChainingProperty<DidAddedSubview, A, ReferenceWritableKeyPath<W, A>> {
		ChainingProperty<DidAddedSubview, A, ReferenceWritableKeyPath<W, A>>(self, getter: keyPath)
	}
	
	public func copy(with action: @escaping (W) -> W) -> DidAddedSubview {
		var result = DidAddedSubview(wrappedValue, didAdded: didAddedTo)
		result.action = action
		return result
	}
	
}

extension DidAddedSubview: Attributable where W: Attributable {
	public typealias Att = W.Att
	public var target: W.Target { wrappedValue.target }
}
