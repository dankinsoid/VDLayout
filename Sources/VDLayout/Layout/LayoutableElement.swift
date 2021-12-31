//
//  File.swift
//  
//
//  Created by Данил Войдилов on 30.12.2021.
//

import UIKit
import PinLayout

extension UIEnvironmentValues {
	var pin: (PinLayout<UIView>) -> PinLayout<UIView> {
		get { self[\.pin] ?? { $0 } }
		set { self[\.pin] = newValue }
	}
}

extension UIViewConvertable {
	func layout(pin: (PinLayout<UIView>) -> PinLayout<UIView>) {
		pin(asUIView.pin).layout()
	}
}

extension UIElementType where UIViewType: Layoutable {
	public func top() -> UIEnvironmentElement<Self> {
		pin {
			$0.top()
		}
	}
	
	public func pin(_ action: @escaping (PinLayout<UIView>) -> PinLayout<UIView>) -> UIEnvironmentElement<Self> {
		environment.pin(action)
	}
}
