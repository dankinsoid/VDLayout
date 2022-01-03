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
		if observeLayout == nil {
			_ = try? asUIView.onMethodInvoked(#selector(UIView.layoutSubviews)) {[weak self] _ in
				self?.layoutPins()
			}
		}
		observeLayout = LayoutObservation(action: action)
//		layoutPins()
	}
	
	func layoutPins() {
		observeLayout?.action()
	}
}

private extension UIViewConvertable {
	
	var observeLayout: LayoutObservation? {
		get { associated.observeLayout ?? nil }
		set { associated.observeLayout = newValue }
	}
}

private struct LayoutObservation {
	var action: () -> Void
}
