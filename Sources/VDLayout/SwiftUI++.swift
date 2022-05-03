//
//  SwiftUI++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 11.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI
import ConstraintsOperators
import UIKitComposable

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
	public var uiKit: _UIHostingView<Self> {
		_UIHostingView(rootView: self)
	}
}

extension SubviewProtocol {
	@available(iOS 13.0, *)
	public var swiftUI: SubviewRepresentableView<Self> {
		SubviewRepresentableView(self)
	}
}

@available(iOS 13.0, *)
public struct SubviewRepresentableView<V: SubviewProtocol>: UIViewRepresentable {
	
	let make: () -> V
	
	public init(_ make: @escaping () -> V) {
		self.make = make
	}
	
	public init(_ make: @escaping @autoclosure () -> V) {
		self.make = make
	}
	
	public func makeUIView(context: UIViewRepresentableContext<SubviewRepresentableView<V>>) -> UIView {
		let content = make().createViewToAdd()
		content.ignoreAutoresizingMask()
		content.contentPriority.both.both = .required
		return content
	}
	
	public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SubviewRepresentableView<V>>) {}
	
}
