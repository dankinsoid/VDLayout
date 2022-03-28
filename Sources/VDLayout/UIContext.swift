//
//  SwiftUIView.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

public struct UIContext {
	public static var current = UIContext(updating: DummyUpdatable())
	
	public var environments: UIEnvironmentValues {
		get { updating.environments }
		nonmutating set { updating.environments = newValue }
	}
	public var updating: UIUpdatable
	public var isUpadting = false
}

private final class DummyUpdatable: UIUpdatable {
	var uiStorage = UIStorage()
	var updatableParent: UIUpdatable? { nil }
}
