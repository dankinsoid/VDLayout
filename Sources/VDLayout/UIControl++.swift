//
//  File.swift
//  
//
//  Created by Данил Войдилов on 29.12.2021.
//

import UIKit
import VDChain

extension Chaining where Value: UIControl {
	public func on(event: UIControl.Event, action: @escaping (Value) -> Void, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> Self {
	self.do { value in
			if let target = value.targets[codeID]?[event] {
				target.set(value, action: action)
			} else {
				let target = Target()
				target.set(value, action: action)
				value.targets[codeID, default: [:]][event] = target
				value.addTarget(target, action: #selector(Target.handler), for: event)
			}
		}
	}
}

private extension UIControl {
	var targets: [CodeID: [UIControl.Event: Target]] {
		get { associated.targets ?? [:] }
		set { associated.targets = newValue }
	}
}

extension UIControl.Event: Hashable {}

private final class Target {
	var action: ((UIResponder) -> Void)?
	weak var base: UIResponder?
	
	func set<T: UIResponder>(_ value: T, action: @escaping (T) -> Void) {
		base = value
		self.action = {
			if let base = $0 as? T {
				action(base)
			}
		}
	}
	
	@objc func handler() {
		if let responder = base {
			action?(responder)
		}
	}
}
