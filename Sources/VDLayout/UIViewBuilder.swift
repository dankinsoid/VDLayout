//
//  UIViewBuilder.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit

@_functionBuilder
public struct UIViewBuilder {
	
//	/// :nodoc:
	@inlinable
	public static func buildBlock() -> AnySubviews {
		AnySubviews([])
	}
	
//	/// :nodoc:
//	@inlinable
//	public static func buildBlock(_ components: SubviewsArrayConvertable...) -> SubviewsArrayConvertable {
//		components.map { $0.asSubviews() }.joined().map { AnySubview($0) }
//	}
//	/// :nodoc:
//	@inlinable
//	public static func buildBlock(_ components: SubviewsArrayConvertable...) -> SubviewsArrayConvertable {
//		components.map { $0.asSubviews() }.joined().map { AnySubview($0) }
//	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0>(_ c0: C0) -> AnySubviews where C0: SubviewsArrayConvertable {
		AnySubviews([c0])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable {
		AnySubviews([c0, c1])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable, C16: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable, C16: SubviewsArrayConvertable, C17: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable, C16: SubviewsArrayConvertable, C17: SubviewsArrayConvertable, C18: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18, _ c19: C19) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable, C16: SubviewsArrayConvertable, C17: SubviewsArrayConvertable, C18: SubviewsArrayConvertable, C19: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18, _ c19: C19, _ c20: C20) -> AnySubviews where C0: SubviewsArrayConvertable, C1: SubviewsArrayConvertable, C2: SubviewsArrayConvertable, C3: SubviewsArrayConvertable, C4: SubviewsArrayConvertable, C5: SubviewsArrayConvertable, C6: SubviewsArrayConvertable, C7: SubviewsArrayConvertable, C8: SubviewsArrayConvertable, C9: SubviewsArrayConvertable, C10: SubviewsArrayConvertable, C11: SubviewsArrayConvertable, C12: SubviewsArrayConvertable, C13: SubviewsArrayConvertable, C14: SubviewsArrayConvertable, C15: SubviewsArrayConvertable, C16: SubviewsArrayConvertable, C17: SubviewsArrayConvertable, C18: SubviewsArrayConvertable, C19: SubviewsArrayConvertable, C20: SubviewsArrayConvertable {
		AnySubviews([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20])
	}
	
//	@inlinable
//	public static func buildIf(_ component: SubviewsArrayConvertable?) -> SubviewsArrayConvertable {
//		component ?? Array<AnySubview>()
//	}
//
//	/// :nodoc:
//	@inlinable
//	public static func buildEither(first: SubviewsArrayConvertable) -> SubviewsArrayConvertable {
//		first
//	}
//
//	/// :nodoc:
//	@inlinable
//	public static func buildEither(second: SubviewsArrayConvertable) -> SubviewsArrayConvertable {
//		second
//	}
	
}

public struct AnySubviews: SubviewsArrayConvertable {
	public let items: [SubviewProtocol]
	
	public init(_ items: [SubviewsArrayConvertable]) {
		self.items = Array(items.map { $0.asSubviews() }.joined())
	}
	
	public func asSubviews() -> [SubviewProtocol] {
		items
	}
}

public struct AnySubview: SubviewProtocol {
	public let item: SubviewProtocol
	
	public init(_ item: SubviewProtocol) {
		self.item = item
	}
	
	public func viewToAdd() -> UIView {
		item.viewToAdd()
	}
	
	public func didAdded(to superview: UIView) {
		item.didAdded(to: superview)
	}
	
	public var itemForConstraint: Any { item.itemForConstraint }
	
}
