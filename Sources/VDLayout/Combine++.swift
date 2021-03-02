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
extension ChainingProperty where C: ValueChainingProtocol, C.W: AnyObject {
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output == B {
		subscribe(value)
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output == B? {
		subscribe(value.compactMap { $0 })
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output? == B {
		subscribe(value.map { $0 as B })
		return chaining
	}
	
	private func subscribe<P: Publisher>(_ value: P) where P.Output == B {
		let result = chaining.wrappedValue
		let setter = (getter as? ReferenceWritableKeyPath<C.W, B>)?.set
		value => {[weak result] in
			guard let it = result else { return }
			_ = setter?(it, $0)
		}
	}
	
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainingProperty where C: ValueChainingProtocol, C.W: AnyObject, B: Equatable {
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B {
		if skipEqual {
			subscribe(value.removeDuplicates())
		} else {
			subscribe(value)
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B? {
		if skipEqual {
			subscribe(value.removeDuplicates().compactMap { $0 })
		} else {
			subscribe(value.compactMap { $0 })
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output? == B {
		if skipEqual {
			subscribe(value.removeDuplicates().map { $0 as B })
		} else {
			subscribe(value.map { $0 as B })
		}
		return chaining
	}
	
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainingProperty where C: ValueChainingProtocol, B: Subscriber {
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output == B.Input, O.Failure == B.Failure {
		subscribe(value)
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output == B.Input?, O.Failure == B.Failure {
		subscribe(value.compactMap { $0 })
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O) -> C where O.Output? == B.Input, O.Failure == B.Failure {
		subscribe(value.map { $0 as B.Input })
		return chaining
	}
	
	private func subscribe<P: Publisher>(_ value: P) where P.Output == B.Input, P.Failure == B.Failure {
		value => getter.get(chaining.wrappedValue)
	}
	
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainingProperty where C: ValueChainingProtocol, B: Subscriber, B.Input: Equatable {
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B.Input, O.Failure == B.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates())
		} else {
			subscribe(value)
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B.Input?, O.Failure == B.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates().compactMap { $0 })
		} else {
			subscribe(value.compactMap { $0 })
		}
		return chaining
	}
	
	public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output? == B.Input, O.Failure == B.Failure {
		if skipEqual {
			subscribe(value.removeDuplicates().map { $0 as B.Input })
		} else {
			subscribe(value.map { $0 as B.Input })
		}
		return chaining
	}
	
}

@available(iOS 13.0, macOS 10.15, *)
extension ChainingProperty where C: ValueChainingProtocol, B: Publisher {
	
	public subscript<O: Subscriber>(_ observer: O) -> C where O.Input == B.Output, O.Failure == B.Failure {
		subscribe(observer)
		return chaining
	}
	
	public subscript<O: Subscriber>(_ observer: O) -> C where O.Input == B.Output?, O.Failure == B.Failure {
		subscribe(observer.mapSubscriber { $0 })
		return chaining
	}
	
	public subscript<O: Subscriber>(_ observer: O) -> C where O.Input? == B.Output, O.Failure == B.Failure {
		subscribe(observer.ignoreNil())
		return chaining
	}
	
	private func subscribe<O: Subscriber>(_ value: O) where O.Input == B.Output, O.Failure == B.Failure {
		let result = chaining.wrappedValue
		getter.get(result).subscribe(value)
	}
	
}
