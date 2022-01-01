//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

extension UIView: UIViewConvertable {
	
	public var asUIView: UIView { self }
	
	public func add(to parent: UIView) {
		parent.add(subview: self)
	}
	
	public func remove(from parent: UIView) {
		removeFromSuperview()
	}
	
	var vc: UIViewController? {
		(next as? UIViewController) ?? (next as? UIView)?.vc
	}
	
	public func add(subview: UIView) {
		if let custom = self as? CustomSubviewAddable {
			custom.customAddSubview(subview)
		} else {
			addSubview(subview)
		}
	}
}
