//
//  SubviewProtocol.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

public protocol SubviewProtocol: SubviewsArrayConvertable, UILayoutable {
	func createViewToAdd() -> UIView
	func didAdded(view: UIView, to superview: UIView)
}

public protocol SubviewsArrayConvertable {
	func asSubviews() -> [SubviewProtocol]
}

extension Array: SubviewsArrayConvertable where Element: SubviewProtocol {
	public func asSubviews() -> [SubviewProtocol] {
		self
	}
}

extension Optional: SubviewsArrayConvertable where Wrapped: SubviewsArrayConvertable {
	public func asSubviews() -> [SubviewProtocol] {
		self?.asSubviews() ?? []
	}
}

extension UIView: SubviewProtocol {
	public func createViewToAdd() -> UIView { self }
	public func didAdded(view: UIView, to superview: UIView) {}
}

extension UIViewController: SubviewProtocol {
	
	public var itemForConstraint: Any {
		view.itemForConstraint
	}
	
	public func createViewToAdd() -> UIView {
		loadViewIfNeeded()
		return view
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		superview.vc?.addChild(self)
	}
	
}

extension SubviewsArrayConvertable where Self: SubviewProtocol {
	public func asSubviews() -> [SubviewProtocol] {
		[self]
	}
}
