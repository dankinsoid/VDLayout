//
//  Rx++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
	
	public var movedToWindow: Single<Void> {
		methodInvoked(#selector(UIView.didMoveToWindow))
			.map {[weak base] _ in base?.window != nil }
			.startWith(base.window != nil)
			.filter { $0 }
			.map { _ in }
			.take(1)
			.asSingle()
	}
	
}

extension Reactive where Base: AnyObject {
	
	public func binded<O: ObservableConvertibleType, A: ObserverType>(_ kp: KeyPath<Reactive, O>, to observer: A) -> Base where A.Element == O.Element {
		let current = objc_getAssociatedObject(base, &bagKey) as? DisposeBag
		let bag = current ?? DisposeBag()
		if current == nil {
			objc_setAssociatedObject(base, &bagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
		self[keyPath: kp].asObservable().subscribe(observer).disposed(by: bag)
		return base
	}
	
}

extension ChainingProperty where C: ValueChainingProtocol, C.W: AnyObject {
	
	public subscript<O: ObservableConvertibleType>(_ value: O) -> C where O.Element == B {
		subscribe(value)
		return chaining
	}
	
	public subscript<O: ObservableConvertibleType>(_ value: O) -> C.W where O.Element == B {
		subscribe(value)
		return chaining.apply()
	}
	
	private func subscribe<O: ObservableConvertibleType>(_ value: O) where O.Element == B {
		let result = chaining.wrappedValue
		let setter = (getter as? ReferenceWritableKeyPath<C.W, B>)?.set
		value.asObservable().subscribe(onNext: {[weak result] in
			guard let it = result else { return }
			_ = setter?(it, $0)
		}).disposed(by: Reactive(result).asDisposeBag)
	}
	
}

extension Reactive where Base: AnyObject {
	
	var asDisposeBag: DisposeBag {
		get {
			let current = objc_getAssociatedObject(base, &bagKey) as? DisposeBag
			let bag = current ?? DisposeBag()
			if current == nil {
				objc_setAssociatedObject(base, &bagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			}
			return bag
		}
		set {
			objc_setAssociatedObject(base, &bagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
}

private var bagKey = "disposeBagKey0000"
