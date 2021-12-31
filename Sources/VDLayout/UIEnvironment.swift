//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

@propertyWrapper
public struct UIEnvironment<Value> {
	
	public static subscript<EnclosingType: UIViewConvertable>(
		_enclosingInstance observed: EnclosingType,
		wrapped wrappedKeyPath: KeyPath<EnclosingType, Value>,
		storage storageKeyPath: KeyPath<EnclosingType, Self>
	) -> Value {
		get {
			let keyPath = observed[keyPath: storageKeyPath].keyPath
			return observed.context.environments[keyPath: keyPath]
		}
		set {
			let keyPath = observed[keyPath: storageKeyPath].keyPath
			observed.context.environments[keyPath: keyPath] = newValue
			observed.asUIView.updateUIElements()
		}
	}
	
	public var wrappedValue: Value {
		get { UIElementContext.current.environments[keyPath: keyPath] }
		nonmutating set { UIElementContext.current.environments[keyPath: keyPath] = newValue }
	}
	
	private let keyPath: WritableKeyPath<UIEnvironmentValues, Value>
	
	public init(_ keyPath: WritableKeyPath<UIEnvironmentValues, Value>) {
		self.keyPath = keyPath
	}
}