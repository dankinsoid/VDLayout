//
//  Layoutt.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 10.02.2021.
//

import UIKit
import VDKit
import RxSwift
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		let view = item?.createViewToAdd() ?? UIView()
		view.ignoreAutoresizingMask()
		view.rx.movedToWindow.asObservable().take(1).subscribe(onNext: {
			self.isActive = true
		}).disposed(by: view.rx.asDisposeBag)
		return view
	}
	
}

extension Observable: LayoutAttributeType where Element: LayoutAttributeType {
	public typealias Attribute = Element.Attribute
	
	public func constraints<B, L: UILayoutableArray, Q: AttributeConvertable>(with first: LayoutAttribute<B, L, Q>?, relation: NSLayoutConstraint.Relation) -> Constraints<L> {
		let result = Constraints<L>.empty
		let constraints = result.onlyConstraints
		let disposable = subscribe(onNext: { value in
			constraints.update(value.constraints(with: first, relation: relation).onlyConstraints)
		})
		if let item = first?.item.asLayoutableArray().first?.itemForConstraint.item {
			disposable.disposed(by: Reactive(item).asDisposeBag)
		}
		return result
	}
}

public struct LayoutAttributeObservable<A, C: UILayoutableArray>: ObservableType, LayoutAttributeType {
	public typealias Attribute = LayoutAttribute<A, C, NSLayoutConstraint.Attribute>.Attribute
	public typealias Element = LayoutAttribute<A, C, NSLayoutConstraint.Attribute>
	let subject: Observable<LayoutAttribute<A, C, NSLayoutConstraint.Attribute>>
	
	public func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, LayoutAttribute<A, C, NSLayoutConstraint.Attribute> == Observer.Element {
		subject.subscribe(observer)
	}
	
	public func constraints<B, L, Q>(with first: LayoutAttribute<B, L, Q>?, relation: NSLayoutConstraint.Relation) -> Constraints<L> where L : UILayoutableArray, Q : AttributeConvertable {
		let result = Constraints<L>.empty
		let constraints = result.onlyConstraints
		let disposable = subject.subscribe(onNext: { value in
			constraints.update(value.constraints(with: first, relation: relation).onlyConstraints)
		})
		if let item = first?.item.asLayoutableArray().first?.itemForConstraint.item {
			disposable.disposed(by: Reactive(item).asDisposeBag)
		}
		return result
	}
}

///MATH
public func *<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { $0 * rhs })
}

public func *<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: O) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { rhs * $0 })
}

public func /<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: O) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { rhs / $0 })
}

public func +<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { $0 + rhs })
}

public func +<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: O) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { rhs + $0 })
}

public func -<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { $0 - rhs })
}

public func -<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: O) -> LayoutAttributeObservable<A, C> where O.Element == CGFloat {
	LayoutAttributeObservable(subject: lhs.asObservable().map { rhs - $0 })
}

public func *<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { $0 * rhs }) }
}

public func *<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: O) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { rhs * $0 }) }
}

public func /<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: O) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { rhs / $0 }) }
}

public func +<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { $0 + rhs }) }
}

public func +<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: O) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { rhs + $0 }) }
}

public func -<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ lhs: O, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { $0 - rhs }) }
}

public func -<A, C: UILayoutableArray, O: ObservableConvertibleType>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: O) -> LayoutAttributeObservable<A, C>? where O.Element == CGFloat {
	rhs.map { rhs in LayoutAttributeObservable(subject: lhs.asObservable().map { rhs - $0 }) }
}
