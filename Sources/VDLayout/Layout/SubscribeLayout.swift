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
		if associated.observeLayout == nil {
			_ = try? asUIView.onMethodInvoked(#selector(UIView.layoutSubviews)) {[weak self] _ in
				self?.layoutPins()
			}
		}
		associated.observeLayout = LayoutObservation(action: action)
//		layoutPins()
	}
	
	func layoutPins() {
		associated.observeLayout?.action()
	}
}

private extension AssociatedValues {
	
	var observeLayout: LayoutObservation? {
		get { self[\.observeLayout] ?? nil }
		set { self[\.observeLayout] = newValue }
	}
}

private struct LayoutObservation {
	var action: () -> Void
}
