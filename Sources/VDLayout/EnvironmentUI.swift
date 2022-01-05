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
//	public var environments: EnvironmentsUI {
//		EnvironmentsUI(content: self)
//	}
	
	public func environment<T>(_ keyPath: WritableKeyPath<UIEnvironmentValues, T>, _ value: T) -> some UI {
		EnvironmentValueUI(content: self) {
			$0[keyPath: keyPath] = value
		}
	}
	
	public func transformEnvironment<Value>(_ keyPath: WritableKeyPath<UIEnvironmentValues, Value>, transform: @escaping (inout Value) -> Void) -> some UI {
		EnvironmentValueUI(content: self) { transform(&$0[keyPath: keyPath]) }
	}
}

//public struct EnvironmentsUI<Content: UI>: UI {
//	public let content: Content
//
//	public func value<A>(_ keyPath: KeyPath<Content, UIEnvironmentValue<Content, A>>, default defaultValue: A) -> UIEnvironmentValue<Content, A> {
//		UIEnvironmentValue(content: content, keyPath: keyPath, defaultValue: defaultValue)
//	}
//}

//public struct UIEnvironmentValue<Content: UI, Value> {
//	public let content: Content
//	let keyPath: KeyPath<Content, UIEnvironmentValue<Content, Value>>
//	let defaultValue: Value
//	
//	public func callAsFunction(_ value: Value) -> some UI {
//		EnvironmentValueUI(content: content) {
//			$0[keyPath] = value
//		}
//	}
//}

private struct EnvironmentValueUI<Content: UI>: UI {
	let content: Content
//	let codeID: CodeID
	let apply: (inout UIEnvironmentValues) -> Void
	
	var layout: UILayout {
		content
			.updateUIViewConvertable { view in
				apply(&view.context.environments)
			}
	}
}
