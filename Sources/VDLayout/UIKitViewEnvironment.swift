//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation
import VDChain

extension UIElementType {
	public func environment<T: UIViewConvertable>(for type: T.Type) -> UIKitViewEnvironment<T, Self> {
		UIKitViewEnvironment(content: self)
	}
}

//extension EnvironmentValues {
//	fileprivate var uikit: (Any) -> Void {
//		get { self[UIKitKey.self] }
//		set { self[UIKitKey.self] = newValue }
//	}
//
//	private enum UIKitKey: EnvironmentKey {
//		static var defaultValue: (Any) -> Void { { _ in } }
//	}
//}

@dynamicMemberLookup
public struct UIKitViewEnvironment<Value: UIViewConvertable, Content: UIElementType>: Chaining, UIElementType {
	public var apply: (inout Value) -> Void = { _ in }
	public let content: Content

	public func createUIView() -> Content.UIViewType {
		content.createUIView()
	}
	
	public func updateUIView(_ view: Content.UIViewType) {
		content.updateUIView(view)
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<Value, A>) -> ChainProperty<Self, A> {
		ChainProperty(self, getter: keyPath)
	}
}
