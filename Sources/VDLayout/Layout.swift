//
//  Layoutt.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 10.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewsArrayConvertable where Item: SubviewProtocol {
	public func asSubviews() -> [SubviewProtocol] { [self] }
}

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func viewToAdd() -> UIView {
		item.viewToAdd()
	}
	
	public func didAdded(to superview: UIView) {
		item.didAdded(to: superview)
		let view = item.viewToAdd()
		view.ignoreAutoresizingMask()
		view.rx.movedToWindow.subscribe(onSuccess: {
			self.isActive = true
		}).disposed(by: superview.rx.asDisposeBag)
	}
	
}
