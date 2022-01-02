//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

public struct UILayout: MutableCollection, ExpressibleByArrayLiteral, UI {
	var nodes: [UIElementNode]
	public var count: Int { nodes.count }
	public var startIndex: Int { nodes.startIndex }
	public var endIndex: Int { nodes.endIndex }
	public var layout: UILayout {
		Logs.print("don`t call layout directly for UILayout, call layout()")
		return self
	}
	
	init(nodes: [UIElementNode]) {
		self.nodes = nodes
	}
	
	public init(flat: [UILayout]) {
		self.nodes = flat.flatMap { $0.nodes }
	}
	
	public init(arrayLiteral elements: UILayout...) {
		self.init(flat: elements)
	}
	
	public init(@UIBuilder layout: () -> UILayout) {
		self = layout()
	}
	
	public init() {
		nodes = []
	}
	
	public init(element: AnyUIElementType, id: UIIdentity) {
		nodes = [UIElementNode(element, id: id)]
	}
	
	public subscript(position: Int) -> UILayout {
		get {
			UILayout(nodes: [nodes[position]])
		}
		set {
			nodes.insert(contentsOf: newValue.nodes, at: position)
		}
	}
	
	public func `in`(element: UI.Type, codeID: CodeID) -> UILayout {
		UILayout(nodes: nodes.map {
			$0.in(element: element, codeID: codeID)
		})
	}
	
	public func id<T: Hashable>(_ id: T) -> UILayout {
		UILayout(nodes: nodes.map {
			$0.id(id)
		})
	}
	
	public func index(after i: Int) -> Int {
		nodes.index(after: i)
	}
	
	public var elements: [AnyUIElementType] {
		nodes.map { $0.element }
	}
}
