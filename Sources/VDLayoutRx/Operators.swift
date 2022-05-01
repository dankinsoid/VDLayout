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

extension SubviewProtocol where Self: Attributable, Target: SubviewProtocol {
	
	public func background<S: SubviewProtocol>(_ back: S) -> WrappedView<Constraints<Target>, S> {
		WrappedView<Constraints<Target>, S>(edges()[0], parent: back)
	}
	
}

private func with(priority: UILayoutPriority, to constraint: NSLayoutConstraint) {
	constraint.priority = priority
	constraint.isActive = true
}
