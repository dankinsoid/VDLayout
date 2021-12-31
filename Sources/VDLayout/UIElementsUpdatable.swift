//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public protocol UIViewConvertable: UIResponder {
	var asUIView: UIView { get }
	func add(to parent: UIView)
	func remove(from parent: UIView)
}

extension UIViewConvertable {
	var nodeID: UIIdentity? {
		get { associated.nodeID }
		set { associated.nodeID = newValue }
	}
}

extension UIViewConvertable where Self: UIView {
	public var asUIView: UIView { self }
	
	public func add(to parent: UIView) {
		parent.add(subview: self)
	}
	
	public func remove(from parent: UIView) {
		removeFromSuperview()
	}
}

extension UIViewConvertable where Self: UIViewController {
	public var asUIView: UIView { view }
	
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
