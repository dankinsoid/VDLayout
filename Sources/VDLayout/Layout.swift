//
//  Layoutt.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 10.02.2021.
//

import UIKit
import VDKit
import CombineOperators
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		let view = item?.createViewToAdd() ?? UIView()
		view.ignoreAutoresizingMask()
		if #available(iOS 13.0, *) {
			view.cb.movedToWindow => { self.isActive = true }
		} else {
			self.isActive = true
		}
		return view
	}
	
}
