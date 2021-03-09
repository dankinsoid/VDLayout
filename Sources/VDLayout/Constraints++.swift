//
//  Layoutt.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 10.02.2021.
//

import UIKit
import VDKit
import Combine
import CombineOperators
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		let view = item?.createViewToAdd() ?? UIView()
		view.ignoreAutoresizingMask()
		if #available(iOS 13.0, *) {
			view.cb.movedToWindow => { self.isActive = true }
		} else {
			self.isActive = true
		}
		return view
	}
	
}

extension CurrentValueSubject: LayoutAttributeType where Output: LayoutAttributeType {
	public typealias Attribute = Output.Attribute
	
	public func constraints<B, L: UILayoutableArray, Q: AttributeConvertable>(with first: LayoutAttribute<B, L, Q>?, relation: NSLayoutConstraint.Relation) -> Constraints<L> {
		let result = value.constraints(with: first, relation: relation)
		let constraints = result.onlyConstraints
		dropFirst().subscribe { value in
			constraints.update(value.constraints(with: first, relation: relation).onlyConstraints)
		}
		return result
	}
}

public struct LayoutAttributePublisher<A, C: UILayoutableArray>: Publisher, LayoutAttributeType {
	public typealias Attribute = LayoutAttribute<A, C, NSLayoutConstraint.Attribute>.Attribute
	public typealias Output = LayoutAttribute<A, C, NSLayoutConstraint.Attribute>
	public typealias Failure = Never
	let subject: Publishers.Map<CurrentValueSubject<CGFloat, Never>, LayoutAttribute<A, C, NSLayoutConstraint.Attribute>>
	public var value: LayoutAttribute<A, C, NSLayoutConstraint.Attribute> {
		subject.transform(subject.upstream.value)
	}
	 
	public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, LayoutAttribute<A, C, NSLayoutConstraint.Attribute> == S.Input {
		subject.subscribe(subscriber)
	}
	
	public func constraints<B, L, Q>(with first: LayoutAttribute<B, L, Q>?, relation: NSLayoutConstraint.Relation) -> Constraints<L> where L : UILayoutableArray, Q : AttributeConvertable {
		let result = value.constraints(with: first, relation: relation)
		let constraints = result.onlyConstraints
		dropFirst().subscribe { value in
			constraints.update(value.constraints(with: first, relation: relation).onlyConstraints)
		}
		return result
	}
}

///MATH
public func *<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { $0 * rhs })
}

public func *<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { rhs * $0 })
}

public func /<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { rhs / $0 })
}

public func +<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { $0 + rhs })
}

public func +<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { rhs + $0 })
}

public func -<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { $0 - rhs })
}

public func -<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C> {
	LayoutAttributePublisher(subject: lhs.map { rhs - $0 })
}

public func *<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { $0 * rhs }) }
}

public func *<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { rhs * $0 }) }
}

public func /<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { rhs / $0 }) }
}

public func +<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { $0 + rhs }) }
}

public func +<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { rhs + $0 }) }
}

public func -<A, C: UILayoutableArray>(_ lhs: CurrentValueSubject<CGFloat, Never>, _ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { $0 - rhs }) }
}

public func -<A, C: UILayoutableArray>(_ rhs: LayoutAttribute<A, C, NSLayoutConstraint.Attribute>?, _ lhs: CurrentValueSubject<CGFloat, Never>) -> LayoutAttributePublisher<A, C>? {
	rhs.map { rhs in LayoutAttributePublisher(subject: lhs.map { rhs - $0 }) }
}
