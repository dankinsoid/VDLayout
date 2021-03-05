//
//  SubviewProtocol.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import ConstraintsOperators
import RxSwift
import RxCocoa

public protocol SubviewProtocol {
	func createViewToAdd() -> UIView
}

extension UIView: SubviewProtocol {
	public func createViewToAdd() -> UIView { self }
}

extension UIViewController: SubviewProtocol {
	
	public var itemForConstraint: Any {
		view.itemForConstraint
	}
	
	public func createViewToAdd() -> UIView {
		loadViewIfNeeded()
		view.rx.movedToWindow.asObservable().take(1).subscribe(onNext: {[weak self] in
			self?.view.superview?.vc?.addChild(self!)
		}).disposed(by: rx.asDisposeBag)
		return view
	}
	
}
