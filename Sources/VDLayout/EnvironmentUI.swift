//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation
import VDChain
import SwiftUI

extension UI {
	public var environment: EnvironmentUI<Self> {
		EnvironmentUI(content: self)
	}
	
	public func transformEnvironment<Value>(_ keyPath: WritableKeyPath<UIEnvironmentValues, Value>, transform: @escaping (inout Value) -> Void) -> some UI {
		EnvironmentUI(apply: { transform(&$0[keyPath: keyPath]) }, content: self)
	}
}

@dynamicMemberLookup
public struct EnvironmentUI<Content: UI>: Chaining, UI {
	public var apply: (inout UIEnvironmentValues) -> Void = { _ in }
	public let content: Content
	
	public var layout: UILayout {
		content
			.updateUIViewConvertable { view in
				apply(&view.asUIView.context.environments)
			}
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<Value, A>) -> ChainProperty<Self, A> {
		ChainProperty(self, getter: keyPath)
	}
}
