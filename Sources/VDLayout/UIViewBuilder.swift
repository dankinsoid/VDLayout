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
	public static func buildArray(_ components: [SubviewList]) -> SubviewList {
		SubviewList(components)
	}
	
	@inlinable
	public static func buildEither<C1: SubviewListProtocol>(first component: C1) -> SubviewList {
		SubviewList(component)
	}
	
	@inlinable
	public static func buildEither<C1: SubviewListProtocol>(second component: C1) -> SubviewList {
		SubviewList(component)
	}
	
	@inlinable
	public static func buildOptional<C1: SubviewListProtocol>(_ component: C1?) -> SubviewList {
		SubviewList(component.map({ [$0] }) ?? [])
	}
	
	@inlinable
	public static func buildLimitedAvailability<C1: SubviewListProtocol>(_ component: C1) -> SubviewList {
		SubviewList(component)
	}
	
	@inline(__always)
	public static func buildBlock() -> SubviewList {
		SubviewList()
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol>(_ c1: C1) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol>(_ c1: C1, _ c2: C2) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol, C15: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol, c15 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol, C15: SubviewListProtocol, C16: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol, c15 as SubviewListProtocol, c16 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol, C15: SubviewListProtocol, C16: SubviewListProtocol, C17: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol, c15 as SubviewListProtocol, c16 as SubviewListProtocol, c17 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol, C15: SubviewListProtocol, C16: SubviewListProtocol, C17: SubviewListProtocol, C18: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol, c15 as SubviewListProtocol, c16 as SubviewListProtocol, c17 as SubviewListProtocol, c18 as SubviewListProtocol)
	}
	
	@inline(__always)
	public static func buildBlock<C1: SubviewListProtocol, C2: SubviewListProtocol, C3: SubviewListProtocol, C4: SubviewListProtocol, C5: SubviewListProtocol, C6: SubviewListProtocol, C7: SubviewListProtocol, C8: SubviewListProtocol, C9: SubviewListProtocol, C10: SubviewListProtocol, C11: SubviewListProtocol, C12: SubviewListProtocol, C13: SubviewListProtocol, C14: SubviewListProtocol, C15: SubviewListProtocol, C16: SubviewListProtocol, C17: SubviewListProtocol, C18: SubviewListProtocol, C19: SubviewListProtocol>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18, _ c19: C19) -> SubviewList {
		SubviewList(c1 as SubviewListProtocol, c2 as SubviewListProtocol, c3 as SubviewListProtocol, c4 as SubviewListProtocol, c5 as SubviewListProtocol, c6 as SubviewListProtocol, c7 as SubviewListProtocol, c8 as SubviewListProtocol, c9 as SubviewListProtocol, c10 as SubviewListProtocol, c11 as SubviewListProtocol, c12 as SubviewListProtocol, c13 as SubviewListProtocol, c14 as SubviewListProtocol, c15 as SubviewListProtocol, c16 as SubviewListProtocol, c17 as SubviewListProtocol, c18 as SubviewListProtocol, c19 as SubviewListProtocol)
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
