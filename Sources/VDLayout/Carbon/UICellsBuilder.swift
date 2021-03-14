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
import VDKit

public typealias UICellsBuilder = CellsBuilder

public struct LazyComponent<ID: Hashable, S: SubviewProtocol>: IdentifiableComponent {
	public let id: ID
	var create: () -> S
	var size: ((CGRect) -> CGSize)?
	
	public init(id: ID, create: @escaping () -> S, size: ((CGRect) -> CGSize)? = nil) {
		self.id = id
		self.create = create
		self.size = size
	}
	
	public init(id: ID, create: @escaping @autoclosure () -> S, size: ((CGRect) -> CGSize)? = nil) {
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
