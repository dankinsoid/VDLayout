//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import VDChain

postfix operator §

@dynamicMemberLookup
public struct UIElement<UIViewType: UIRender>: Chaining, UIStructure {
	public var apply: (inout UIViewType) -> Void = { _ in }
	public var create: () -> UIViewType
	private var update: (UIViewType) -> Void
	
	public var children: [AnyUIStructure<UIViewType.Parent>] { [] }
	
	public init(_ create: @escaping () -> UIViewType, update: @escaping (UIViewType) -> Void) {
		self.create = create
		self.update = update
	}
	
	public func createRender() -> UIViewType {
		create()
	}
	
	public func updateRender(_ render: UIViewType) {
		var view = render
		apply(&view)
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

public postfix func §<T: UIRender>(_ lhs: @escaping @autoclosure () -> T) -> UIElement<T> { UIElement(lhs) }
