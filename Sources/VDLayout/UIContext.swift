//
//  SwiftUIView.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

public struct UIContext {
	public static var current = UIContext()
	
	public var environments = UIEnvironmentValues()
	public weak var updating: UIUpdatableStorage?
	
	public init() {}
}

public protocol UIUpdatableStorage: UIResponder {
	func updateUILayout()
	var updaters: [CodeID: Any] { get set }
}

extension UIUpdatableStorage {
	public var context: UIContext {
		get {
			var result = associated.context ?? UIContext()
			if let parent = next as? UIUpdatableStorage {
				result.environments.link = {[weak parent] in parent?.context.environments }
			}
			return result
		}
		set {
			associated.context = newValue
		}
	}
}
