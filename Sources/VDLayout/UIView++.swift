//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

extension UIView: UIElementsUpdatable {
	
	public func updateUIElements() {
		updateNodes(nodes)
	}
	
	public func update(_ nodes: UIElementNode...) {
		updateNodes(nodes)
	}
	
	public func update(@UIViewNodesBuilder _ nodes: () -> [UIElementNode]) {
		updateNodes(nodes())
	}
	
	public func updateNodes(_ nodes: [UIElementNode]) {
		updateNodes(nodes: nodes, for: self)
	}
	
	public func add(subview: UIView) {
		if let custom = self as? CustomSubviewAddable {
			custom.customAddSubview(subview)
		} else {
			addSubview(subview)
		}
	}
	
	var vc: UIViewController? {
		(next as? UIViewController) ?? (next as? UIView)?.vc
	}
}

extension UIElementsUpdatable where Self: NSObject {
	
	private(set) public var nodes: [UIElementNode] {
		get { associated.nodes }
		set { associated.nodes = newValue }
	}
	
	private var uiElements: [UIElementsUpdatable] {
		get { associated.uiElements }
		set { associated.uiElements = newValue }
	}
	
	func updateNodes(nodes: [UIElementNode], for uiView: UIView) {
		self.nodes = nodes
		var subviewNodes = Dictionary(
			uiElements.compactMap { view in view.nodeID.map { ($0, view) } }
		) { _, new in
			new
		}
		for node in nodes {
			if let view = subviewNodes[node.id] {
				node.update(view)
			} else {
				let view = node.create()
				view.add(to: uiView)
				node.update(view)
			}
			subviewNodes[node.id] = nil
		}
		for (_, view) in subviewNodes {
			view.remove(from: uiView)
		}
	}
}

extension AssociatedValues {
	var nodeID: UIViewNodeID? {
		get { self[\.nodeID] ?? nil }
		set { self[\.nodeID] = newValue }
	}
	var nodes: [UIElementNode] {
		get { self[\.nodes] ?? [] }
		set { self[\.nodes] = newValue }
	}
	var uiElements: [UIElementsUpdatable] {
		get { self[\.uiElements] ?? [] }
		set { self[\.uiElements] = newValue }
	}
}
