//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation

struct MapComponent: AnyUIElementType {
	let base: AnyUIElementType
	let map: (UIViewConvertable) -> UIViewConvertable
	let update: (UIViewConvertable) -> Void
	
	func _createUIView() -> UIViewConvertable {
		base._createUIView()
	}
	
	func _updateUIView(_ view: UIViewConvertable) {
		
	}
}
