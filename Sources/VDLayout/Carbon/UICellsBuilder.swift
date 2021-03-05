//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

#if canImport(Carbon)
import UIKit
import Carbon
import ConstraintsOperators
#if canImport(SwiftUI)
import SwiftUI
#endif

@resultBuilder
public struct UICellsBuilder: CellsBuildable {

	private var cells: [CellNode]

	public init<C: Collection>(_ items: C) where C.Element == CellNode {
		cells = Array(items)
	}
	
	public func buildCells() -> [CellNode] {
		cells
	}

	@inlinable
	public static func buildBlock(_ components: CellsBuildable...) -> CellsBuildable {
		UICellsBuilder(components.map { $0.buildCells() }.joined())
	}

	@inlinable
	public static func buildArray(_ components: [CellsBuildable]) -> CellsBuildable {
		UICellsBuilder(components.map { $0.buildCells() }.joined())
	}

	@inlinable
	public static func buildEither(first component: CellsBuildable) -> CellsBuildable {
		component
	}

	@inlinable
	public static func buildEither(second component: CellsBuildable) -> CellsBuildable {
		component
	}

	@inlinable
	public static func buildOptional(_ component: CellsBuildable?) -> CellsBuildable {
		component ?? UICellsBuilder([])
	}

	@inlinable
	public static func buildLimitedAvailability(_ component: CellsBuildable) -> CellsBuildable {
		component
	}

	@inlinable
	public static func buildExpression<C: CellsBuildable>(_ expression: C) -> CellsBuildable {
		expression
	}
	
	@inlinable
	public static func buildExpression<C: SubviewProtocol>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
		UICellsBuilder([CellNode(LazyComponent(id: UUID(), create: expression))])
	}
	
	@inlinable
	public static func buildExpression<C: View>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
		UICellsBuilder([CellNode(ViewComponent(expression, id: UUID()))])
	}

}

public struct LazyComponent<ID: Hashable>: IdentifiableComponent {
	public let id: ID
	var create: () -> SubviewProtocol
	
	public init(id: ID, create: @escaping () -> SubviewProtocol) {
		self.id = id
		self.create = create
	}
	
	public func renderContent() -> UIView {
		CellView {
			create()
		}
	}
	
	public func render(in content: UIView) {}
	
}

@available(iOS 13.0, *)
public struct ViewComponent<ID: Hashable, Body: View>: IdentifiableComponent {
	public var id: ID
	public let body: () -> Body
	
	public init(_ body: @escaping () -> Body, id: ID) {
		self.body = body
		self.id = id
	}
	
	public func renderContent() -> _UIHostingView<Body> {
		_UIHostingView(rootView: body())
	}
	
	public func render(in content: _UIHostingView<Body>) {}
	
}

private final class CellView: UIView {
	
	override func addSubview(_ view: UIView) {
		super.addSubview(view)
		view.ignoreAutoresizingMask()
		view.edges() =| 0
	}
	
}
#endif
