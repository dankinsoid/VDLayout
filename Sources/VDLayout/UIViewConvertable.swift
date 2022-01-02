//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public protocol UIViewConvertable: UIUpdatableStorage {
	var asUIView: UIView { get }
	func add(to parent: UIView)
	func remove(from parent: UIView)
}

extension UIViewConvertable {
	var nodeID: UIIdentity? {
		get { associated.nodeID }
		set { associated.nodeID = newValue }
	}
}
