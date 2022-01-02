//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation
import VDChain

extension UI {
	public func environment<T: UIViewConvertable>(for type: T.Type) -> UIElementEnvironment<T, Self> {
		UIElementEnvironment(content: self)
	}
	
	public func transformEnvironment<T: UIViewConvertable, Value>(for type: T.Type, _ keyPath: ReferenceWritableKeyPath<T, Value>, transform: @escaping (inout Value?) -> Void) -> some UI {
		transformEnvironment(\.uiElement[keyPath], transform: transform)
	}
}

extension UIEnvironmentValues {
	var uiElement: UIElementEnvironmentValues {
		get { self[\.uiElement] ?? UIElementEnvironmentValues() }
		set { self[\.uiElement] = newValue }
	}
}

struct UIElementEnvironmentValues {
	private var values: [AnyKeyPath: (Any?, (UIViewConvertable) -> Void)] = [:]
	
	subscript<T: UIViewConvertable, Value>(keyPath: ReferenceWritableKeyPath<T, Value>) -> Value? {
		get {
			values[keyPath]?.0 as? Value
		}
		set {
			set(keyPath: keyPath, value: newValue)
		}
	}
	
	subscript<T: UIViewConvertable, Value>(keyPath: ReferenceWritableKeyPath<T, Value?>) -> Value? {
		get {
			self[keyPath, nil]
		}
		set {
			self[keyPath, nil] = newValue
		}
	}
	
	subscript<T: UIViewConvertable, Value>(keyPath: ReferenceWritableKeyPath<T, Value>, or: Value) -> Value {
		get { (values[keyPath]?.0 as? Value) ?? or }
		set { set(keyPath: keyPath, value: newValue) }
	}
	
	private mutating func set<T: UIViewConvertable, Value>(keyPath: ReferenceWritableKeyPath<T, Value>, value: Value?) {
		guard let value = value else {
			values[keyPath] = nil
			return
		}
		values[keyPath] = (value, { ($0 as? T)?[keyPath: keyPath] = value })
	}
	
	func apply(for view: UIViewConvertable) {
		values.values.forEach {
			$0.1(view)
		}
	}
}

@dynamicMemberLookup
public struct UIElementEnvironment<Value: UIViewConvertable, Content: UI>: UI {
	var transform: (inout UIElementEnvironmentValues) -> Void = { _ in }
	let content: Content
	
	public var layout: UILayout {
		content
			.transformEnvironment(\.uiElement, transform: transform)
	}
	
	public subscript<A>(dynamicMember keyPath: ReferenceWritableKeyPath<Value, A>) -> Property<A> {
		Property(keyPath: keyPath, base: self)
	}
	
	@dynamicMemberLookup
	public struct Property<S> {
		var keyPath: KeyPath<Value, S>
		var base: UIElementEnvironment
		
		public subscript<A>(dynamicMember keyPath: KeyPath<S, A>) -> Property<A> {
			Property<A>(keyPath: self.keyPath.appending(path: keyPath), base: base)
		}
		
		public func callAsFunction(_ value: S) -> UIElementEnvironment {
			guard let kp = keyPath as? ReferenceWritableKeyPath<Value, S> else { return base }
			var result = base
			let trans = result.transform
			result.transform = {
				trans(&$0)
				$0[kp] = value
			}
			return result
		}
	}
}
