//
//  UIKit++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import Foundation
import UIKit
import VDKit
import RxSwift
import RxCocoa

extension UIView {
	
	public convenience init(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) {
		self.init()
		subviews().forEach(add)
	}
	
	public func add(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) {
		subviews().forEach(add)
	}
	
	public func with(_ subviews: [SubviewProtocol]) -> Self {
		subviews.forEach(add)
		return self
	}
	
	public func with(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) -> Self {
		with(subviews())
	}
	
	public func add(subview: SubviewProtocol) {
		let view = subview.createViewToAdd()
		view.translatesAutoresizingMaskIntoConstraints = false
		if let stack = self as? UIStackView {
			stack.addArrangedSubview(view)
		} else {
			addSubview(view)
		}
	}
}
