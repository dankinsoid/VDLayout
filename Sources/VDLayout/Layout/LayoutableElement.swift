//
//  File.swift
//  
//
//  Created by Данил Войдилов on 30.12.2021.
//

import UIKit
import PinLayout

extension UIEnvironmentValues {
	var pin: ((PinLayout<UIView>) -> PinLayout<UIView>)? {
		get { self[\.pin] ?? nil }
		set { self[\.pin] = newValue }
	}
}

extension UIViewConvertable {
	func layout(pin: (PinLayout<UIView>) -> PinLayout<UIView>) {
		pin(asUIView.pin).layout()
	}
}

extension UI {
	public func top() -> some UI {
		pin {
			$0.top()
		}
	}
	
	public func pin(_ action: @escaping (PinLayout<UIView>) -> PinLayout<UIView>) -> some UI {
		transformEnvironment(\.pin) { pin in
			let p = pin
			pin = {
				action(p?($0) ?? $0)
			}
		}
	}
}
