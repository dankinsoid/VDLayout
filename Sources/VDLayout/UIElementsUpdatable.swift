//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public protocol UIElementsUpdatable {
	var nodeID: UIViewNodeID? { get nonmutating set }
	func updateUIElements()
	func add(to parent: UIView)
	func remove(from parent: UIView)
}

extension UIElementsUpdatable where Self: NSObject {
	public var nodeID: UIViewNodeID? {
		get { associated.nodeID }
		set { associated.nodeID = newValue }
	}
}

extension UIElementsUpdatable where Self: Collection, Element: UIElementsUpdatable {
	
	public func add(to parent: UIView) {
		forEach {
			$0.add(to: parent)
		}
	}
	
	public func remove(from parent: UIView) {
		forEach {
			$0.remove(from: parent)
		}
	}
}

extension UIElementsUpdatable where Self: UIView {
	
	public func add(to parent: UIView) {
		parent.add(subview: self)
	}
	
	public func remove(from parent: UIView) {
		removeFromSuperview()
	}
}

extension UIElementsUpdatable where Self: UIViewController {
	
	public func add(to parent: UIView) {
		loadViewIfNeeded()
		parent.add(subview: view)
		parent.vc?.addChild(self)
	}
	
	public func remove(from parent: UIView) {
		view.removeFromSuperview()
		removeFromParent()
	}
}
