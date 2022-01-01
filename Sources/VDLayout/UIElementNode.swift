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
		let result = element._createUIView()
		result.nodeID = id
		return result
	}
	
	func update(for view: UIView, current: UIViewConvertable?) {
		if let view = current {
			update(view)
		} else {
			let new = create()
			new.add(to: view)
			update(new)
		}
	}
	
	private func update(_ view: UIViewConvertable) {
		view.updateUILayout {
			element._updateUIView(view)
		}
	}
	
	func `in`(element: UI.Type, codeID: CodeID) -> UIElementNode {
		UIElementNode(self.element, id: id.in(element: element, codeID: codeID))
	}
	
	func id<T: Hashable>(_ id: T) -> UIElementNode {
		UIElementNode(self.element, id: self.id.id(id))
	}
}

//import SwiftUI
//
//extension UIElementNode: UIViewRepresentable {
//	func makeUIView(context: Context) -> UIView {
//		element._createUIView().asUIView
//	}
//
//	func updateUIView(_ uiView: UIView, context: Context) {
//		element._updateUIView(<#T##view: UIViewConvertable##UIViewConvertable#>)
//	}
//}
