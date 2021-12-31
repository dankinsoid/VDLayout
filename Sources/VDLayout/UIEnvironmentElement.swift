//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation
import VDChain

extension UIElementType {
	public var environment: UIEnvironmentElement<Self> {
		UIEnvironmentElement(content: self)
	}
	
	public func transformEnvironment<Value>(_ keyPath: WritableKeyPath<UIEnvironmentValues, Value>) {
		
	}
}

@dynamicMemberLookup
public struct UIEnvironmentElement<Content: UIElementType>: Chaining, UIElementType {
	public var apply: (inout UIEnvironmentValues) -> Void = { _ in }
	public let content: Content
	
	public func createUIView() -> Content.UIViewType {
		content.createUIView()
	}
	
	public func updateUIView(_ view: Content.UIViewType) {
		apply(&view.asUIView.context.environments)
		content.updateUIView(view)
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<Value, A>) -> ChainProperty<Self, A> {
		ChainProperty(self, getter: keyPath)
	}
}
