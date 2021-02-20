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
	
	public func createViewToAdd() -> UIView {
		item?.createViewToAdd() ?? UIView()
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		item?.didAdded(view: view, to: superview)
		view.ignoreAutoresizingMask()
		view.rx.movedToWindow.subscribe(onSuccess: {
			self.isActive = true
		}).disposed(by: superview.rx.asDisposeBag)
	}
	
}
