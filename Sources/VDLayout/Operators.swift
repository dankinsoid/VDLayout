//
//  Operators.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import Combine
import CombineOperators
import ConstraintsOperators

extension SubviewProtocol {
	
	public func onAdded(_ action: @escaping (UIView, _ superview: UIView) -> Void) -> DidAddedSubview<Self> {
		DidAddedSubview(self) { view, superview in
			action(view, superview)
		}
	}
	
	@available(iOS 13.0, *)
	public func onMovedToWindow(_ action: @escaping (UIView) -> Void) -> DidAddedSubview<Self> {
		DidAddedSubview(self) { view, superview in
			view?.cb.movedToWindow => {[weak view] in
				guard let view = view else { return }
				action(view)
			}
		}
	}
	
//	public func with(_ subviews: [SubviewProtocol]) -> Self {
////		DidAddedSubview(self) { _, superview in
//		let view = createViewToAdd()
//		subviews.forEach(view.add)
//		return self
////		}
//	}
//	
//	public func with(@SubviewsBuilder _ subviews: () -> SubviewsArrayConvertable) -> Self {
//		with(subviews().asSubviews())
//	}
	
}

extension SubviewProtocol where Self: Attributable, Target: SubviewProtocol {
	
	public func background<S: SubviewProtocol>(_ back: S) -> WrappedView<Constraints<Target>, S> {
		WrappedView<Constraints<Target>, S>(edges()[0], parent: back)
	}
	
}

private func with(priority: UILayoutPriority, to constraint: NSLayoutConstraint) {
	constraint.priority = priority
	constraint.isActive = true
}
