import UIKit
import VDChain
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

extension PropertyChain where Base: ValueChaining, Base.Root: AnyObject {
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element == Value {
		subscribe(value.asObservable())
        return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element == Value? {
		subscribe(value.asObservable().compactMap { $0 })
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element? == Value {
		subscribe(value.asObservable().map { $0 })
		return chaining.wrap()
	}
	
	private func subscribe(_ value: Observable<Value>) {
		let result = chaining.root
        guard let setter = getter as? ReferenceWritableKeyPath<Base.Root, Value> else { return }
		value.asObservable().subscribe(onNext: {[weak result] in
			guard let it = result else { return }
            it[keyPath: setter] = $0
		}).disposed(by: Reactive(result).asDisposeBag)
	}
	
}

extension PropertyChain where Base: ValueChaining, Base.Root: AnyObject, Value: Equatable {
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element == Value {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged() : value.asObservable())
        return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element == Value? {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged().compactMap { $0 } : value.asObservable().compactMap { $0 })
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element? == Value {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged().map { $0 } : value.asObservable().map { $0 })
		return chaining.wrap()
	}
	
}

extension PropertyChain where Base: ValueChaining, Base.Root: AnyObject, Value: ObserverType {
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element == Value.Element {
		subscribe(value.asObservable())
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element == Value.Element? {
		subscribe(value.asObservable().compactMap { $0 })
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O) -> Chain<Base> where O.Element? == Value.Element {
		subscribe(value.asObservable().map { $0 })
		return chaining.wrap()
	}
	
	private func subscribe(_ value: Observable<Value.Element>) {
		let result = chaining.root
		value.asObservable().subscribe(onNext: {[weak result, getter] in
			guard let it = result else { return }
			it[keyPath: getter].on(.next($0))
		}).disposed(by: Reactive(result).asDisposeBag)
	}
	
}

extension PropertyChain where Base: ValueChaining, Base.Root: AnyObject, Value: ObserverType, Value.Element: Equatable {
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element == Value.Element {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged() : value.asObservable())
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element == Value.Element? {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged().compactMap { $0 } : value.asObservable().compactMap { $0 })
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObservableConvertibleType>(_ value: O, skipEqual: Bool = true) -> Chain<Base> where O.Element? == Value.Element {
		subscribe(skipEqual ? value.asObservable().distinctUntilChanged().map { $0 } : value.asObservable().map { $0 })
		return chaining.wrap()
	}
}

extension PropertyChain where Base: ValueChaining, Base.Root: AnyObject, Value: ObservableConvertibleType {
	
	public func callAsFunction<O: ObserverType>(_ observer: O) -> Chain<Base> where O.Element == Value.Element {
		subscribe(observer.asObserver())
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObserverType>(_ observer: O) -> Chain<Base> where O.Element == Value.Element? {
		subscribe(observer.mapObserver { $0 })
		return chaining.wrap()
	}
	
	public func callAsFunction<O: ObserverType>(_ observer: O) -> Chain<Base> where O.Element? == Value.Element {
		let observer = observer.asObserver()
		subscribe(AnyObserver {
			guard case .next(let optional) = $0, let value = optional else { return }
			observer.onNext(value)
		})
		return chaining.wrap()
	}
	
	private func subscribe(_ value: AnyObserver<Value.Element>) {
		let result = chaining.root
		result[keyPath: getter].asObservable().subscribe(value).disposed(by: Reactive(result).asDisposeBag)
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
