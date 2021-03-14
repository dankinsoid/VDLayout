//
//  SubviewProtocol.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators
import CombineOperators
import CombineCocoa

public protocol SubviewListProtocol {
	func asSubviews() -> [SubviewProtocol]
}

public protocol SubviewProtocol: SubviewListProtocol {
	func createViewToAdd() -> UIView
}

extension SubviewListProtocol where Self: SubviewProtocol {
	public func asSubviews() -> [SubviewProtocol] {
		[self]
	}
}

extension UIView: SubviewProtocol {
	public func createViewToAdd() -> UIView { self }
}

extension UIViewController: SubviewProtocol {
	
	public var itemForConstraint: ConstraintItem {
		view.itemForConstraint
	}
	
	public func createViewToAdd() -> UIView {
		loadViewIfNeeded()
		view.cb.movedToWindow.prefix(1) => {[weak self] in
			self?.view.superview?.vc?.addChild(self!)
		}
		return view
	}
	
}
