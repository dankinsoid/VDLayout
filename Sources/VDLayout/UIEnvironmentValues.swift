//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public struct UIEnvironmentValues {
	
	private var values: [AnyKeyPath: Any] = [:]
	var link: (() -> UIEnvironmentValues?)?
	
	public init() {}
	
	public subscript<T>(_ keyPath: WritableKeyPath<UIEnvironmentValues, T>) -> T? {
		get {
			self[keyPath: keyPath]
		}
		set {
			self[keyPath: keyPath] = newValue
		}
	}
	
	public subscript<T>(_ keyPath: KeyPath<UI, UIEnvironmentValue<T>>) -> T {
		get {
			self[keyPath: keyPath] ?? EmptyUI()[keyPath: keyPath].defaultValue
		}
		set {
			self[keyPath: keyPath] = newValue
		}
	}
	
	private subscript<T>(keyPath keyPath: AnyKeyPath) -> T? {
		get {
			if let any = values[keyPath] ?? link?()?[keyPath: keyPath], type(of: any) == T.self {
				return any as? T
			}
			return nil
		}
		set {
			guard let newValue = newValue else { return }
			values[keyPath] = newValue
		}
	}
	
	public mutating func merge(with parent: UIEnvironmentValues) {
		values.merge(parent.values) { it, _ in
			it
		}
	}
}
