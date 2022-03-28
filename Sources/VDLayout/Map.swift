//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation

//extension UI {
//	public func mapUIViewConvertable(get: @escaping (UIViewConvertable) -> UIViewConvertable, set: @escaping (UIViewConvertable) -> UIViewConvertable, update: @escaping (UIViewConvertable) -> Void) -> some UI {
//		MapUI(base: layout(), get: get, set: set, update: update)
//	}
//}
//
//private struct MapUI: UI {
//	let base: UI
//	let get: (UIViewConvertable) -> UIViewConvertable
//	let set: (UIViewConvertable) -> UIViewConvertable
//	let update: (UIViewConvertable) -> Void
//	
//	var layout: UI {
//		UI(nodes: base.nodes.map({
//			UIElementNode(
//				MapComponent(base: $0.element, map: (get, set), update: update),
//				id: $0.id
//			)
//		}))
//	}
//}
//
//private struct MapComponent: AnyUIElementType {
//	let base: AnyUIElementType
//	let map: (get: (UIViewConvertable) -> UIViewConvertable, set: (UIViewConvertable) -> UIViewConvertable)
//	let update: (UIViewConvertable) -> Void
//	
//	func _createUIView() -> UIViewConvertable {
//		map.get(base._createUIView())
//	}
//	
//	func _updateUIView(_ view: UIViewConvertable) {
//		update(view)
//		base._updateUIView(map.set(view))
//	}
//}
//	
