//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

//public struct UI: MutableCollection, ExpressibleByArrayLiteral {
//	var nodes: [UIElementNode]
//	public var count: Int { nodes.count }
//	public var startIndex: Int { nodes.startIndex }
//	public var endIndex: Int { nodes.endIndex }
//	
//	init(nodes: [UIElementNode]) {
//		self.nodes = nodes
//	}
//	
//	public init(flat: [UI]) {
//		self.nodes = flat.flatMap { $0.nodes }
//	}
//	
//	public init(arrayLiteral elements: UI...) {
//		self.init(flat: elements)
//	}
//	
//	public init(@UIBuilder layout: () -> UI) {
//		self = layout()
//	}
//	
//	public init() {
//		nodes = []
//	}
//	
//	public init(element: AnyUIElementType, id: UIIdentity) {
//		nodes = [UIElementNode(element, id: id)]
//	}
//	
//	public subscript(position: Int) -> UI {
//		get {
//			UI(nodes: [nodes[position]])
//		}
//		set {
//			nodes.insert(contentsOf: newValue.nodes, at: position)
//		}
//	}
//	
//	public func `in`(element: UI.Type, codeID: CodeID) -> UI {
//		UI(nodes: nodes.map {
//			$0.in(element: element, codeID: codeID)
//		})
//	}
//	
//	public func id<T: Hashable>(_ id: T) -> UI {
//		UI(nodes: nodes.map {
//			$0.id(id)
//		})
//	}
//	
//	public func index(after i: Int) -> Int {
//		nodes.index(after: i)
//	}
//	
//	public var elements: [AnyUIElementType] {
//		nodes.map { $0.element }
//	}
//}
