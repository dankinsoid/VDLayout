//
//  SwiftUIView.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

public struct UIElementContext {
	public static var current = UIElementContext()
	
	public var environments = UIEnvironmentValues()
	
	public init() {}
}

extension AssociatedValues {
	fileprivate var context: UIElementContext {
		get { self[\.context] ?? UIElementContext() }
		set { self[\.context] = newValue }
	}
}

extension UIViewConvertable {
	public var context: UIElementContext {
		get {
			var result = associated.context
			if let parent = next as? UIViewConvertable {
				result.environments.link = {[weak parent] in parent?.context.environments }
			}
			return result
		}
		set {
			associated.context = newValue
		}
	}
}
