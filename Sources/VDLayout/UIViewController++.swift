//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

extension UIViewController: UIElementsUpdatable {
	
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
		updateNodes(nodes: nodes, for: view)
	}
}
