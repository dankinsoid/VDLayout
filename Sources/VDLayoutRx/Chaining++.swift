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
	public var itemForConstraint: ConstraintItem {
		wrappedValue.itemForConstraint
	}
}

extension ValueChaining: SubviewProtocol where W: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		apply().createViewToAdd()
	}
	
}

extension ValueChaining: Attributable where W: Attributable {
	public typealias Target = W.Target
	public typealias Att = W.Att
	
	public var target: W.Target {
		wrappedValue.target
	}
	
}
