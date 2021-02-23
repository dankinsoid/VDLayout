//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

import UIKit
import Carbon
import ConstraintsOperators

@_functionBuilder
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

private final class CellView: UIView {
	
	override func addSubview(_ view: UIView) {
		super.addSubview(view)
		view.ignoreAutoresizingMask()
		view.edges() =| 0
	}
	
}
