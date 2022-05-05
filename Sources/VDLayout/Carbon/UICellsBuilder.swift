//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

#if canImport(CarbonTable)
import UIKit
import CarbonTable
import ConstraintsOperators
#if canImport(SwiftUI)
import SwiftUI
#endif
import VDKit

public typealias UICellsBuilder = ComposeBuilder<CellsCreator>

public enum CellsCreator: ArrayInitable {
	public static func create(from: [CellsBuildable]) -> CellsBuildable {
		from.count == 1 ? from[0] : CellNodeArray(from.map { $0.buildCells() }.joined())
	}
}

public struct CellNodeArray: CellsBuildable {
	
	private var cells: [CellNode]
	
	public init<C: Collection>(_ items: C) where C.Element == CellNode {
		cells = Array(items)
	}
	
	public func buildCells() -> [CellNode] {
		cells
	}
	
}

extension ComposeBuilder where C == CellsCreator {

	@inlinable
	public static func buildExpression<C: CellsBuildable>(_ expression: C) -> CellsBuildable {
		expression
	}
	
	@inlinable
	public static func buildExpression<C: SubviewProtocol>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
		CellNodeArray([CellNode(LazyComponent(id: UUID(), create: expression))])
	}
	
	@inlinable
	public static func buildExpression(_ expression: @escaping @autoclosure () -> ComponentCellSize) -> CellsBuildable {
		CellNodeArray([CellNode(LazyComponent(id: UUID(), create: { expression().subview }, size: { expression().size($0) }))])
	}
	
	@available(iOS 13.0, *)
	@inlinable
	public static func buildExpression<C: View>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
		CellNodeArray([CellNode(ViewComponent(expression, id: UUID()))])
	}

}

public struct LazyComponent<ID: Hashable>: IdentifiableComponent {
	public let id: ID
	var create: () -> SubviewProtocol
	var size: ((CGRect) -> CGSize)?
	
	public init(id: ID, create: @escaping () -> SubviewProtocol, size: ((CGRect) -> CGSize)? = nil) {
		self.id = id
		self.create = create
		self.size = size
	}
	
	public func renderContent() -> UIView {
		CellView {
			create()
		}
	}
	
	public func render(in content: UIView) {}
	
	public func referenceSize(in bounds: CGRect) -> CGSize? {
		size?(bounds)
	}
}

public struct CellSubview<View: SubviewProtocol>: Component {
	
	let render: () -> View
	
	public init(_ create: @escaping () -> View) {
		render = create
	}
	
	public func renderContent() -> UIView {
		render().createViewToAdd()
	}
	
	public func render(in content: UIView) {}
}

extension Component {
//	public func 
}

extension SubviewProtocol {
	public func cellSize(_ size: @escaping (CGRect) -> CGSize) -> ComponentCellSize {
		ComponentCellSize(subview: self, size: size)
	}
	public func cellSize(_ size: CGSize) -> ComponentCellSize {
		cellSize { _ in size }
	}
	public func cellSize(_ size: CGFloat) -> ComponentCellSize {
		cellSize(CGSize(width: size, height: size))
	}
	public func cellSize(width: CGFloat, height: CGFloat) -> ComponentCellSize {
		cellSize(CGSize(width: width, height: height))
	}
}

@available(iOS 13.0, *)
extension View {
	public func cellSize(_ size: @escaping (CGRect) -> CGSize) -> ViewComponent<UUID, Self> {
		ViewComponent({ self }, id: UUID(), size: size)
	}
	public func cellSize(_ size: CGSize) -> ViewComponent<UUID, Self> {
		cellSize { _ in size }
	}
	public func cellSize(_ size: CGFloat) -> ViewComponent<UUID, Self> {
		cellSize(CGSize(width: size, height: size))
	}
	public func cellSize(width: CGFloat, height: CGFloat) -> ViewComponent<UUID, Self> {
		cellSize(CGSize(width: width, height: height))
	}
}

public struct ComponentCellSize {
	public let subview: SubviewProtocol
	public let size: (CGRect) -> CGSize
}

@available(iOS 13.0, *)
public struct ViewComponent<ID: Hashable, Body: View>: IdentifiableComponent {
	public var id: ID
	public let body: () -> Body
	public var size: ((CGRect) -> CGSize)?
	
	public init(_ body: @escaping () -> Body, id: ID, size: ((CGRect) -> CGSize)? = nil) {
		self.body = body
		self.id = id
		self.size = size
	}
	
	public func renderContent() -> _UIHostingView<Body> {
		_UIHostingView(rootView: body())
	}
	
	public func render(in content: _UIHostingView<Body>) {}
	
	public func referenceSize(in bounds: CGRect) -> CGSize? {
		size?(bounds)
	}
}

private final class CellView: UIView {
	
	override func addSubview(_ view: UIView) {
		super.addSubview(view)
		view.ignoreAutoresizingMask()
		view.edges() =| 0
	}
	
}
#endif
