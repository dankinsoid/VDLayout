//
//  Layoutt.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 10.02.2021.
//

import UIKit
import VDKit
import RxSwift
import RxCocoa
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		let view = item?.createViewToAdd() ?? UIView()
		view.ignoreAutoresizingMask()
		view.rx.movedToWindow.asObservable().take(1).subscribe(onNext: {
			self.isActive = true
		}).disposed(by: view.rx.asDisposeBag)
		return view
	}
	
}
