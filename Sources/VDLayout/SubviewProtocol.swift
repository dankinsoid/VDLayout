//
//  SubviewProtocol.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

public protocol SubviewProtocol {
	func createViewToAdd() -> UIView
	func didAdded(view: UIView, to superview: UIView)
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
