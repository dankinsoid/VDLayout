//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

extension UIView: UIViewConvertable {
	
	public func updateUIElements() {
		updateNodes(nodes: nodes, for: self)
	}
	
	public func update(_ layouts: UILayout...) {
		updateUILayout(UILayout(flat: layouts))
	}
	
	public func update(@UIViewNodesBuilder _ layout: () -> UILayout) {
		updateUILayout(layout())
	}
	
	public func updateUILayout(_ layout: UILayout) {
		updateNodes(nodes: layout.nodes, for: self)
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

extension UIViewConvertable {
	
	private(set) var nodes: [UIElementNode] {
		get { associated.nodes }
		set { associated.nodes = newValue }
	}
	
	private var uiElements: [UIViewConvertable] {
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
	var nodeID: UIIdentity? {
		get { self[\.nodeID] ?? nil }
		set { self[\.nodeID] = newValue }
	}
	var nodes: [UIElementNode] {
		get { self[\.nodes] ?? [] }
		set { self[\.nodes] = newValue }
	}
	var uiElements: [UIViewConvertable] {
		get { self[\.uiElements] ?? [] }
		set { self[\.uiElements] = newValue }
	}
}
