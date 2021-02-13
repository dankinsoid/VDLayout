//
//  File.swift
//  
//
//  Created by Данил Войдилов on 13.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

extension ChainingProperty: UILayoutableArray where C.W: UILayoutableArray, C: ValueChainingProtocol {
	
	public func asLayoutableArray() -> [UILayoutable] {
		chaining.wrappedValue.asLayoutableArray()
	}
	
}

extension ChainingProperty: UILayoutable where C.W: SubviewProtocol, C: ValueChainingProtocol {
	public var itemForConstraint: Any {
		chaining.wrappedValue.itemForConstraint
	}
}

extension ChainingProperty: SubviewsArrayConvertable where C.W: SubviewProtocol, C: ValueChainingProtocol {
	public func asSubviews() -> [SubviewProtocol] {
		chaining.wrappedValue.asSubviews()
	}
}

extension ChainingProperty: SubviewProtocol where C.W: SubviewProtocol, C: ValueChainingProtocol {
	
	public func viewToAdd() -> UIView {
		chaining.wrappedValue.viewToAdd()
	}
	
	public func didAdded(to superview: UIView) {
		chaining.wrappedValue.didAdded(to: superview)
	}
	
}
