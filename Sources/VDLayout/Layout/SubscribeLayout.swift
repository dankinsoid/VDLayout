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
		if asUIView.associated.observeLayout == nil {
			_ = try? asUIView.onMethodInvoked(#selector(UIView.layoutSubviews)) {[weak self] _ in
				self?.layoutPins()
			}
		}
		asUIView.associated.observeLayout = LayoutObservation(action: action)
	}
	
	func layoutPins() {
		asUIView.associated.observeLayout?.action()
	}
}

private struct LayoutObservation {
	var action: () -> Void
}

private extension AssociatedValues {
	var observeLayout: LayoutObservation? {
		get { self[\.observeLayout] ?? nil }
		set { self[\.observeLayout] = newValue }
	}
}
