//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation
import Combine

@propertyWrapper
public struct UIState<Value>: Identifiable {
	public var id: CodeID
	private var defaultValue: Value
	private let view: View
	public var wrappedValue: Value {
		get { subject.value }
		nonmutating set {
			subject.value = newValue
			view.view?.updateUILayout()
		}
	}
	
	public var projectedValue: BindingPublisher<Value> {
		let publisher = subject
		return BindingPublisher(publisher: subject, get: { publisher.value }, set: { wrappedValue = $0 })
	}
	
	public init(initial: Value, codeID: CodeID) {
		defaultValue = initial
		id = codeID
		view = View(UIContext.current.updating)
	}
	
	public init(wrappedValue: Value, codeID: CodeID = CodeID(file: #file, line: #line, column: #column)) {
		self.init(initial: wrappedValue, codeID: codeID)
	}
	
	public static subscript<EnclosingType: UIUpdatableStorage>(
		_enclosingInstance observed: EnclosingType,
		wrapped wrappedKeyPath: KeyPath<EnclosingType, Value>,
		storage storageKeyPath: KeyPath<EnclosingType, Self>
	) -> Value {
		get {
			subject(view: observed, state: observed[keyPath: storageKeyPath]).value
		}
		set {
			subject(view: observed, state: observed[keyPath: storageKeyPath]).value = newValue
			observed.updateUILayout()
		}
	}
	
	private var subject: CurrentValueSubject<Value, Never> {
		guard let view = view.view ?? UIContext.current.updating else {
			return CurrentValueSubject(defaultValue)
		}
		self.view.view = view
		return UIState.subject(view: view, state: self)
	}
	
	private static func subject(view: UIUpdatableStorage, state: UIState) -> CurrentValueSubject<Value, Never> {
		guard let subject = view.updaters[state.id] as? CurrentValueSubject<Value, Never> else {
			let subject = CurrentValueSubject<Value, Never>(state.defaultValue)
			view.updaters[state.id] = subject
			return subject
		}
		return subject
	}
}

private final class View {
	weak var view: UIUpdatableStorage?
	
	init(_ view: UIUpdatableStorage?) {
		self.view = view
	}
}
