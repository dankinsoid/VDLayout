//
//  cb++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import Combine
import CombineOperators
import CombineCocoa

@available(iOS 13.0, macOS 10.15, *)
extension Reactive where Base: UIView {
	
	public var movedToWindow: AnyPublisher<Void, Error> {
		methodInvoked(#selector(UIView.didMoveToWindow))
			.map {[weak base] _ in base?.window != nil }
			.prepend(base.window != nil)
			.filter { $0 }
			.map { _ in }
			.prefix(1)
			.eraseToAnyPublisher()
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension Reactive {
	
	public func binded<O: Publisher, A: Subscriber>(_ kp: KeyPath<Reactive, O>, to observer: A) -> Base where A.Input == O.Output, A.Failure == O.Failure {
		self[keyPath: kp].subscribe(observer)
		return base
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainProperty where Base: ValueChainingProtocol, Base.Value: AnyObject {
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output == Value {
		subscribe(value)
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output == Value? {
		subscribe(value.compactMap { $0 })
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output? == Value {
		subscribe(value.map { $0 as Value })
		return chaining
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value? {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output? == Value {
		self[cb: value]
	}
	
	private func subscribe<P: Publisher>(_ value: P) where P.Output == Value {
		let result = chaining.value
		let setter = (getter as? ReferenceWritableKeyPath<Base.Value, Value>)?.set
		value => {[weak result] in
			guard let it = result else { return }
			_ = setter?(it, $0)
		}
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainProperty where Base: ValueChainingProtocol, Base.Value: AnyObject, Value: Equatable {
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output == Value {
		if skipEqual {
			subscribe(value.removeDuplicates())
		} else {
			subscribe(value)
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output == Value? {
		if skipEqual {
			subscribe(value.removeDuplicates().compactMap { $0 })
		} else {
			subscribe(value.compactMap { $0 })
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output? == Value {
		if skipEqual {
			subscribe(value.removeDuplicates().map { $0 as Value })
		} else {
			subscribe(value.map { $0 as Value })
		}
		return chaining
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value? {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output? == Value {
		self[cb: value]
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainProperty where Base: ValueChainingProtocol, Value: Subscriber {
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output == Value.Input, O.Failure == Value.Failure {
		subscribe(value)
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output == Value.Input?, O.Failure == Value.Failure {
		subscribe(value.compactMap { $0 })
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> Base where O.Output? == Value.Input, O.Failure == Value.Failure {
		subscribe(value.map { $0 as Value.Input })
		return chaining
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value.Input, O.Failure == Value.Failure {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output == Value.Input?, O.Failure == Value.Failure {
		self[cb: value]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O) -> Base where O.Output? == Value.Input, O.Failure == Value.Failure {
		self[cb: value]
	}
	
	private func subscribe<P: Publisher>(_ value: P) where P.Output == Value.Input, P.Failure == Value.Failure {
		value => getter.get(chaining.value)
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainProperty where Base: ValueChainingProtocol, Value: Subscriber, Value.Input: Equatable {
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output == Value.Input, O.Failure == Value.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates())
		} else {
			subscribe(value)
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output == Value.Input?, O.Failure == Value.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates().compactMap { $0 })
		} else {
			subscribe(value.compactMap { $0 })
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> Base where O.Output? == Value.Input, O.Failure == Value.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates().map { $0 as Value.Input })
		} else {
			subscribe(value.map { $0 as Value.Input })
		}
		return chaining
	}
	
	public func callAsFunction<O: Publisher>(_ value: O, skipEqual: Bool = true) -> Base where O.Output == Value.Input, O.Failure == Value.Failure {
		self[cb: value, skipEqual]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O, skipEqual: Bool = true) -> Base where O.Output == Value.Input?, O.Failure == Value.Failure {
		self[cb: value, skipEqual]
	}
	
	public func callAsFunction<O: Publisher>(_ value: O, skipEqual: Bool = true) -> Base where O.Output? == Value.Input, O.Failure == Value.Failure {
		self[cb: value, skipEqual]
	}
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainProperty where Base: ValueChainingProtocol, Value: Publisher {
	
	public subscript<O: Subscriber>(_ observer: O) -> Base where O.Input == Value.Output, O.Failure == Value.Failure {
		subscribe(observer)
	}
	
	public subscript<O: Subscriber>(_ observer: O) -> Base where O.Input == Value.Output?, O.Failure == Value.Failure {
		subscribe(observer.mapSubscriber { $0 })
	}
	
	public subscript<O: Subscriber>(_ observer: O) -> Base where O.Input? == Value.Output, O.Failure == Value.Failure {
		subscribe(observer.ignoreNil())
	}
	
	public func callAsFunction<O: Subscriber>(_ value: O) -> Base where O.Input == Value.Output, O.Failure == Value.Failure {
		self[value]
	}
	
	public func callAsFunction<O: Subscriber>(_ value: O) -> Base where O.Input == Value.Output?, O.Failure == Value.Failure {
		self[value]
	}
	
	public func callAsFunction<O: Subscriber>(_ value: O) -> Base where O.Input? == Value.Output, O.Failure == Value.Failure {
		self[value]
	}
	
	private func subscribe<O: Subscriber>(_ value: O) -> Base where O.Input == Value.Output, O.Failure == Value.Failure {
		let result = chaining.value
		getter.get(result).subscribe(value)
		return chaining
	}

	public func on(_ action: @escaping (Value.Output) -> Void) -> Base {
		subscribe(
			AnySubscriber(
				receiveSubscription: {
					$0.request(.unlimited)
				},
				receiveValue: {
					action($0)
					return .unlimited
				},
				receiveCompletion: nil
			)
		)
	}
}
