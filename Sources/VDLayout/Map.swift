//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation

struct MapUI: UI {
	let base: UILayout
	var layout: UILayout {
		UILayout(nodes: base.nodes.map({
			UIElementNode(
				MapComponent(base: $0.element, map: , update: <#T##(UIViewConvertable) -> Void#>),
				id: $0.id
			)
		}))
	}
}

struct MapComponent: AnyUIElementType {
	let base: AnyUIElementType
	let map: (UIViewConvertable) -> UIViewConvertable
	let update: (UIViewConvertable) -> Void
	
	func _createUIView() -> UIViewConvertable {
		base._createUIView()
	}
	
	func _updateUIView(_ view: UIViewConvertable) {
		base._updateUIView(<#T##view: UIViewConvertable##UIViewConvertable#>)
		update(view)
	}
}
