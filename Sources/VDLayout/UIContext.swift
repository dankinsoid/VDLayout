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
	public weak var updating: UIViewConvertable?
	
	public init() {}
}

extension AssociatedValues {
	fileprivate var context: UIContext {
		get { self[\.context] ?? UIContext() }
		set { self[\.context] = newValue }
	}
}

extension UIViewConvertable {
	public var context: UIContext {
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
