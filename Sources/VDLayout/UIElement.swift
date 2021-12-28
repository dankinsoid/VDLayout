//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

#if canImport(UIKit)
import UIKit
import VDChain

postfix operator §

@dynamicMemberLookup
public struct UIElement<UIViewType: UIElementsUpdatable>: Chaining, UIElementType {
	public var apply: (inout UIViewType) -> Void = { _ in }
	public var create: () -> UIViewType
	private var update: (UIViewType) -> Void
	
	public init(_ create: @escaping () -> UIViewType, update: @escaping (UIViewType) -> Void) {
		self.create = create
		self.update = update
	}
	
	public func createUIView() -> UIViewType {
		create()
	}
	
	public func updateUIView(_ view: UIViewType) {
		update(view)
	}
	
	public subscript<T>(dynamicMember keyPath: KeyPath<UIViewType, T>) -> ChainProperty<Self, T> {
		ChainProperty(self, getter: keyPath)
	}
}

extension UIElement {
	
	public init(_ create: @escaping @autoclosure () -> UIViewType) {
		self = .init(create)
	}
	
	public init(_ create: @escaping () -> UIViewType) {
		self = .init(create) { _ in }
	}
	
	public init(_ make: @escaping @autoclosure () -> UIViewType, update: @escaping (UIViewType) -> Void ) {
		self = .init(make, update: update)
	}
	
	public init(_ make: @escaping () -> Chain<UIViewType>, update: @escaping (UIViewType) -> Void) {
		self = .init({ make().apply() }, update: update)
	}
	
	public init(_ make: @escaping @autoclosure () -> Chain<UIViewType>, update: @escaping (UIViewType) -> Void) {
		self = .init(make, update: update)
	}
}

public postfix func §<T: UIElementsUpdatable>(_ lhs: @escaping @autoclosure () -> T) -> UIElement<T> { UIElement(lhs) }
#endif
