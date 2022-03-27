//
//  File.swift
//  
//
//  Created by Данил Войдилов on 10.02.2022.
//

import Foundation

public struct UIStorage {
	
	private var values: [PartialKeyPath<UIStorage>: Any] = [:]
	public var environments = UIEnvironmentValues()
	
	public init() {}
	
	public subscript<T>(_ keyPath: WritableKeyPath<UIStorage, T>) -> T? {
		get { values[keyPath] as? T }
		set { values[keyPath] = newValue }
	}
}

extension UIUpdatable {
	
	public var environments: UIEnvironmentValues {
		get {
			var result = uiStorage.environments
			if let parent = updatableParent {
				result.link = {[weak parent] in parent?.environments }
			}
			return result
		}
		set {
			var result = newValue
			result.link = nil
			uiStorage.environments = result
		}
	}
}
