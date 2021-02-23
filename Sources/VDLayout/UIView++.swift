//
//  UIKit++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import Foundation
import UIKit
import VDKit

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
		subview.didAdded(view: view, to: self)
	}
	
}

extension UIButton {
	
	public var title: String? {
		get { title(for: .normal) }
		set { setTitle(newValue, for: .normal) }
	}
	
	public var titleColor: UIColor? {
		get { titleColor(for: .normal) }
		set { setTitleColor(newValue, for: .normal) }
	}
	
	public var titles: UIControl.States<String> {
		UIControl.States(get: title, set: setTitle)
	}
	
	public var titleColors: UIControl.States<UIColor> {
		UIControl.States(get: titleColor, set: setTitleColor)
	}
	
}

extension UIControl {
	
	public struct States<Value> {
		private let get: (State) -> Value?
		private let set: (Value?, State) -> Void
		
		public subscript(_ key: State) -> Value? {
			get { get(key) }
			nonmutating set { set(newValue, key) }
		}
		
		public init(get: @escaping (State) -> Value?, set: @escaping (Value?, State) -> Void) {
			self.get = get
			self.set = set
		}
		
	}
	
}

extension UIControl.State: Hashable {}

extension UILabel {
	
	public convenience init(_ text: String) {
		self.init()
		self.text = text
	}
	
}
