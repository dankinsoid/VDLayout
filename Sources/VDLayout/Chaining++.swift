//
//  File.swift
//  
//
//  Created by Данил Войдилов on 13.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

extension ValueChaining: UILayoutableArray where W: UILayoutableArray {
	
	public func asLayoutableArray() -> [UILayoutable] {
		wrappedValue.asLayoutableArray()
	}
	
}

extension ValueChaining: UILayoutable where W: UILayoutable {
	public var itemForConstraint: Any {
		wrappedValue.itemForConstraint
	}
}

extension ValueChaining: SubviewProtocol where W: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		wrappedValue.createViewToAdd()
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		apply().didAdded(view: view, to: superview)
	}
	
}

extension ValueChaining: Attributable where W: Attributable {
	public typealias Target = W.Target
	public typealias Att = W.Att
	
	public var target: W.Target {
		wrappedValue.target
	}
	
}
