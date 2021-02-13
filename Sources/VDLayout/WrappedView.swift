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

@dynamicMemberLookup
public struct WrappedView<W: SubviewProtocol, P: SubviewProtocol>: SubviewProtocol, ValueChainingProtocol {
	
	public var itemForConstraint: Any { parent.itemForConstraint }
	let parent: P
	public var wrappedValue: W
	
	private(set) public var action: (W) -> W = { $0 }
	
	public init(_ child: W, parent: P) {
		self.wrappedValue = child
		self.parent = parent
	}
	
	public func viewToAdd() -> UIView {
		parent.viewToAdd()
	}
	
	public func didAdded(to superview: UIView) {
		parent.didAdded(to: superview)
		parent.viewToAdd().add(subview: wrappedValue)
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<W, A>) -> ChainingProperty<WrappedView, A, KeyPath<W, A>> {
		ChainingProperty<WrappedView, A, KeyPath<W, A>>(self, getter: keyPath)
	}
	
	public subscript<A>(dynamicMember keyPath: WritableKeyPath<W, A>) -> ChainingProperty<WrappedView, A, WritableKeyPath<W, A>> {
		ChainingProperty<WrappedView, A, WritableKeyPath<W, A>>(self, getter: keyPath)
	}
	
	public subscript<A>(dynamicMember keyPath: ReferenceWritableKeyPath<W, A>) -> ChainingProperty<WrappedView, A, ReferenceWritableKeyPath<W, A>> {
		ChainingProperty<WrappedView, A, ReferenceWritableKeyPath<W, A>>(self, getter: keyPath)
	}
	
	public func copy(with action: @escaping (W) -> W) -> WrappedView {
		var result = WrappedView(wrappedValue, parent: parent)
		result.action = action
		return result
	}
}

extension WrappedView: Attributable where P: Attributable {
	public typealias Att = P.Att
	
	public var target: P.Target {
		parent.target
	}
}
