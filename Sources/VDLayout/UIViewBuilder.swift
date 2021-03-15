//
//  SubviewsBuilder.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
#if canImport(SwiftUI)
import SwiftUI
#endif

@_functionBuilder
public struct SubviewsBuilder {
	
	@inlinable
	public static func buildArray(_ components: [SubviewListProtocol]) -> SubviewListProtocol {
		SubviewList(components)
	}
	
	@inlinable
	public static func buildEither(first component: SubviewListProtocol) -> SubviewListProtocol {
		component
	}
	
	@inlinable
	public static func buildEither(second component: SubviewListProtocol) -> SubviewListProtocol {
		component
	}
	
	@inlinable
	public static func buildOptional(_ component: SubviewListProtocol?) -> SubviewListProtocol {
		component ?? SubviewList()
	}
	
	@inlinable
	public static func buildLimitedAvailability(_ component: SubviewListProtocol) -> SubviewListProtocol {
		SubviewList(component)
	}
	
	@inline(__always)
	public static func buildBlock(_ components: SubviewListProtocol...) -> SubviewListProtocol {
		SubviewList(components)
	}
}

extension ArrayBuilder where T == SubviewProtocol {
	
	@inline(__always)
	public static func buildExpression<S: SubviewProtocol>(_ expression: S) -> [T] {
		[expression]
	}
	
	@available(iOS 13.0, *)
	@inline(__always)
	public static func buildExpression<S: View>(_ expression: S) -> [T] {
		[expression.uiKit]
	}
	
}

@available(iOS 13.0, *)
extension ViewBuilder {
	
	@inline(__always)
	public static func buildExpression<V: View>(_ expression: V) -> V {
		expression
	}
	
	@inline(__always)
	public static func buildExpression<V: SubviewProtocol>(_ expression: @escaping @autoclosure () -> V) -> SubviewRepresentableView<V> {
		SubviewRepresentableView(expression)
	}
}

public struct SubviewList: SubviewListProtocol {
	public let subviews: [SubviewProtocol]
	
	public init<C: Collection>(subviews: C) where C.Element == SubviewProtocol {
		self.subviews = Array(subviews)
	}
	
	public init(_ subviews: [SubviewListProtocol]) {
		self = SubviewList(subviews: subviews.map { $0.asSubviews() }.joined())
	}
	
	public init(_ subviews: SubviewListProtocol...) {
		self = SubviewList(subviews)
	}
	
	public func asSubviews() -> [SubviewProtocol] {
		subviews
	}
}
