//
//  Operators.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import RxSwift
import ConstraintsOperators

extension SubviewProtocol {
	
	public func onAdded(_ action: @escaping (Self, _ superview: UIView) -> Void) -> DidAddedSubview<Self> {
		DidAddedSubview(self) { superview in
			action(self, superview)
		}
	}
	
	public func onMovedToWindow(_ action: @escaping (Self) -> Void) -> DidAddedSubview<Self> {
		DidAddedSubview(self) { superview in
			let view = self.viewToAdd()
			view.rx.movedToWindow.subscribe(onSuccess: {
				action(self)
			}).disposed(by: view.rx.asDisposeBag)
		}
	}
	
}

extension SubviewProtocol where Self: Attributable, Target: SubviewProtocol {
	
	public func background<S: SubviewProtocol>(_ back: S) -> WrappedView<Constraints<Target>, S> {
		WrappedView<Constraints<Target>, S>(leading[0].trailing[0].top[0].bottom[0], parent: back)
	}
	
}

private func with(priority: UILayoutPriority, to constraint: NSLayoutConstraint) {
	constraint.priority = priority
	constraint.isActive = true
}
