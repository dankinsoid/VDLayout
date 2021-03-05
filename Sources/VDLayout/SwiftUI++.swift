//
//  SwiftUI++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 11.02.2021.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct UIKitView<V: UIView>: UIViewRepresentable {
	
	let make: () -> V
	
	public init(_ make: @escaping () -> V) {
		self.make = make
	}
	
	public init(_ make: @escaping @autoclosure () -> V) {
		self.make = make
	}
	
	public func makeUIView(context: UIViewRepresentableContext<UIKitView<V>>) -> V {
		make()
	}
	
	public func updateUIView(_ uiView: V, context: UIViewRepresentableContext<UIKitView<V>>) {}
	
}

@available(iOS 13.0, *)
public struct UIKitViewController<V: UIViewController>: UIViewControllerRepresentable {
	
	public let make: () -> V
	
	public init(_ make: @escaping () -> V) {
		self.make = make
	}
	
	public init(_ make: @escaping @autoclosure () -> V) {
		self.make = make
	}
	
	public func makeUIViewController(context: UIViewControllerRepresentableContext<UIKitViewController<V>>) -> V {
		make()
	}
	
	public func updateUIViewController(_ uiViewController: V, context: UIViewControllerRepresentableContext<UIKitViewController<V>>) {}
	
}

@available(iOS 13.0, *)
extension View {
	public var uiKit: UIHostingController<Self> {
		UIHostingController(rootView: self)
	}
}

@available(iOS 13.0, *)
extension NSObjectProtocol where Self: UIView {
	public var swiftUI: UIKitView<Self> {
		UIKitView(self)
	}
}

@available(iOS 13.0, *)
extension NSObjectProtocol where Self: UIViewController {
	public var swiftUI: UIKitViewController<Self> {
		UIKitViewController(self)
	}
}
