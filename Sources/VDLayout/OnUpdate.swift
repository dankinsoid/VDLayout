//
//  File.swift
//  
//
//  Created by Данил Войдилов on 02.01.2022.
//

import Foundation

extension UI {
	public func updateUIViewConvertable(update: @escaping (UIViewConvertable) -> Void) -> some UI {
		OnUpdateUI(base: layout(), update: update)
	}
}

private struct OnUpdateUI: UI {
	let base: UILayout
	let update: (UIViewConvertable) -> Void
	
	var layout: UILayout {
		UILayout(nodes: base.nodes.map({
			UIElementNode(
				OnUpdateComponent(base: $0.element, update: update),
				id: $0.id
			)
		}))
	}
}

private struct OnUpdateComponent: AnyUIElementType {
	let base: AnyUIElementType
	let update: (UIViewConvertable) -> Void
	
	func _createUIView() -> UIViewConvertable {
		base._createUIView()
	}
	
	func _updateUIView(_ view: UIViewConvertable) {
		update(view)
		base._updateUIView(view)
	}
}
