//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit
import PinLayout
import NSMethodsObservation

extension UIViewConvertable {
	
	func subscribeLayout(_ action: @escaping () -> Void) {
		if asUIView.observeLayout == nil {
			_ = try? asUIView.onMethodInvoked(#selector(UIView.layoutSubviews)) {[weak self] _ in
				self?.layoutPins()
			}
		}
		asUIView.observeLayout = LayoutObservation(action: action)
	}
	
	func layoutPins() {
		asUIView.observeLayout?.action()
	}
}

private extension UIView {
	
	var observeLayout: LayoutObservation? {
		get { associated.observeLayout ?? nil }
		set { associated.observeLayout = newValue }
	}
}

private struct LayoutObservation {
	var action: () -> Void
}
