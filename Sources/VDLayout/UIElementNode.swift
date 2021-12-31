//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

struct UIElementNode: Identifiable {
	var id: UIIdentity
	var element: AnyUIElementType
	
	init(_ element: AnyUIElementType, id: UIIdentity) {
		self.element = element
		self.id = id
	}
	
	func create() -> UIViewConvertable {
		element._createUIView()
	}
	
	func update(_ view: UIViewConvertable) {
		UIElementContext.current = view.context
		let pin = UIElementContext.current.environments.pin
		view.subscribeLayout {[weak view] in
			view?.layout(pin: pin)
		}
		view.asUIView.updateUIElements()
		element._updateUIView(view)
	}
	
	func `in`(element: UI.Type, codeID: CodeID) -> UIElementNode {
		UIElementNode(self.element, id: id.in(element: element, codeID: codeID))
	}
}
