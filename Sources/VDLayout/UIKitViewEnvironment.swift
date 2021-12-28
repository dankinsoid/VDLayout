//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation

//extension UIElementType {
//	public func uiKitViewEnvironment<T: UIView>(for type: T.Type) -> UIKitViewEnvironment<T, Self> {
//		UIKitViewEnvironment(content: self)
//	}
//
//	public func uiKitViewEnvironment<T: UIViewController>(for type: T.Type) -> UIKitViewEnvironment<T, Self> {
//		UIKitViewEnvironment(content: self)
//	}
//}
//
//extension EnvironmentValues {
//	fileprivate var uikit: (Any) -> Void {
//		get { self[UIKitKey.self] }
//		set { self[UIKitKey.self] = newValue }
//	}
//
//	private enum UIKitKey: EnvironmentKey {
//		static var defaultValue: (Any) -> Void { { _ in } }
//	}
//}
//
//@dynamicMemberLookup
//public struct UIKitViewEnvironment<T, Content: UIElementType>: Chaining, UIElementType {
//	public var apply: (inout T) -> Void = { _ in }
//	public let content: Content
//	//	private var ketPathes: [PartialKeyPath<T>: Any] = [:]
//
//	public var body: some View {
//		content
//			.transformEnvironment(\.uikit) { closure in
//				let cl = closure
//				closure = {
//					cl($0)
//					if var t = $0 as? T {
//						apply(&t)
//					}
//				}
//			}
//	}
//	//
//	//	public mutating func onGetProperty<P>(_ keyPath: WritableKeyPath<T, P>, _ value: P) {
//	//		ketPathes[keyPath] = value
//	//	}
//
//	public subscript<A>(dynamicMember keyPath: KeyPath<T, A>) -> ChainProperty<Self, A> {
//		ChainProperty(self, getter: keyPath)
//	}
//}
