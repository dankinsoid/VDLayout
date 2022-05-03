//
//  File.swift
//  
//
//  Created by Данил Войдилов on 13.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

extension Chain: UILayoutableArray where Value: UILayoutableArray {
	
	public func asLayoutableArray() -> [UILayoutable] {
		apply().asLayoutableArray()
	}
}

extension Chain: UILayoutable where Value: UILayoutable {
	public var itemForConstraint: ConstraintItem {
		apply().itemForConstraint
	}
}

extension Chain: Attributable where Value: Attributable {
	public typealias Target = Value.Target
	public typealias Att = Value.Att
	
	public var target: Value.Target {
		apply().target
	}
}
