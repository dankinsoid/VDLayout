//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation
import Combine

@propertyWrapper
@dynamicMemberLookup
public struct BindingPublisher<Output> {
	public var wrappedValue: Output {
		get { get() }
		nonmutating set { set(newValue) }
	}
	
	private let get: () -> Output
	private let set: (Output) -> Void
	private let publisher: AnyPublisher<Output, Never>
	
	public var projectedValue: BindingPublisher {
		get { self }
		set { self = newValue }
	}
	
	private init(_ publisher: AnyPublisher<Output, Never>, get: @escaping () -> Output, set: @escaping (Output) -> Void) {
		self.get = get
		self.set = set
		self.publisher = publisher
	}
	
	public init<P: Publisher>(publisher: P, get: @escaping () -> Output, set: @escaping (Output) -> Void) where P.Output == Output, P.Failure == Never {
		self.init(AnyPublisher(publisher), get: get, set: set)
	}
	
	public init(get: @escaping () -> Output, set: @escaping (Output) -> Void) {
		let subject = PassthroughSubject<Output, Never>()
		self.init(publisher: subject) {
			get()
		} set: {
			set($0)
			subject.send($0)
		}
	}
	
	public init(wrappedValue: Output) {
		self.init(valueSubject: CurrentValueSubject<Output, Never>(wrappedValue))
	}
	
	public init(valueSubject: CurrentValueSubject<Output, Never>) {
		self.init(publisher: valueSubject, get: { valueSubject.value }, set: valueSubject.send)
	}
	
	public subscript<T>(dynamicMember keyPath: WritableKeyPath<Output, T>) -> BindingPublisher<T> {
		BindingPublisher<T>(publisher: publisher.map(keyPath)) {
			wrappedValue[keyPath: keyPath]
		} set: {
			wrappedValue[keyPath: keyPath] = $0
		}
	}
}

extension BindingPublisher: Publisher {
	public typealias Failure = Never
	
	public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Output == S.Input {
		publisher.receive(subscriber: subscriber)
	}
}
