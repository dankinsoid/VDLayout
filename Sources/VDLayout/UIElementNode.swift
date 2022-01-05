//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public struct UIElementNode: Identifiable {
	public var id: UIIdentity
	public var element: AnyUIElementType
	
	public init(_ element: AnyUIElementType, id: UIIdentity) {
		self.element = element
		self.id = id
	}
	
	public func create() -> UIViewConvertable {
		let result = element._createUIView()
		result.associated.nodeID = id
		return result
	}
	
	@discardableResult
	public func update(superview: UIView?, current: UIViewConvertable?) -> UIViewConvertable {
		if let view = current {
			update(view)
			return view
		} else {
			let new = create()
			if let view = superview {
				new.add(to: view)
			}
			update(new)
			return new
		}
	}
	
	private func update(_ view: UIViewConvertable) {
		view.applyEnvironments()
		view.updateUILayout {
			element._updateUIView(view)
		}
	}
	
	public func `in`(element: UI.Type, codeID: CodeID) -> UIElementNode {
		UIElementNode(self.element, id: id.in(element: element, codeID: codeID))
	}
	
	public func id<T: Hashable>(_ id: T) -> UIElementNode {
		UIElementNode(self.element, id: self.id.id(id))
	}
}
