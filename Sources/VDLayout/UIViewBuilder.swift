//
//  UIViewBuilder.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit

@_functionBuilder
public struct UIViewBuilder {
	
//	/// :nodoc:
	@inlinable
	public static func buildBlock() -> SubviewsArrayConvertable {
		AnySubviews([])
	}
	
	/// :nodoc:
	@inlinable
	public static func buildBlock(_ components: SubviewsArrayConvertable...) -> SubviewsArrayConvertable {
		AnySubviews(components.map { $0.asSubviews() }.joinedArray())
	}
	
	@inlinable
	public static func buildIf(_ component: SubviewsArrayConvertable?) -> SubviewsArrayConvertable {
		component ?? Array<AnySubview>()
	}

	/// :nodoc:
	@inlinable
	public static func buildEither(first: SubviewsArrayConvertable) -> SubviewsArrayConvertable {
		first
	}

	/// :nodoc:
	@inlinable
	public static func buildEither(second: SubviewsArrayConvertable) -> SubviewsArrayConvertable {
		second
	}
	
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
	
	public func createViewToAdd() -> UIView {
		item.createViewToAdd()
	}
	
	public func didAdded(view: UIView, to superview: UIView) {
		item.didAdded(view: view, to: superview)
	}
	
	public var itemForConstraint: Any { item.itemForConstraint }
	
}
