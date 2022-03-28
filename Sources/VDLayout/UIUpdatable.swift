//
//  File.swift
//  
//
//  Created by Данил Войдилов on 10.02.2022.
//

import Foundation

public protocol UIUpdatable: AnyObject {
	var uiStorage: UIStorage { get set }
	var updatableParent: UIUpdatable? { get }
}

extension UIUpdatable {
	
	public func update() {
		update {}
	}
	
	public func update<T>(action: () -> T) -> T {
		update(action: { _ in action() })
	}
	
	public func update<T>(action: (UIContext) -> T) -> T {
		let current = UIContext.current
		UIContext.current = UIContext(updating: self, isUpadting: true)
		let result = action(UIContext.current)
		
		UIContext.current = current
		return result
	}
}

extension UIUpdatable where Self: NSObject {
	
	public var uiStorage: UIStorage {
		get {
			associated.uiStorage
		}
		set {
			associated.uiStorage = newValue
		}
	}
}

private extension AssociatedValues {
	var uiStorage: UIStorage {
		get {
			self[\.uiStorage] ?? UIStorage()
		}
		set {
			self[\.uiStorage] = newValue
		}
	}
}
