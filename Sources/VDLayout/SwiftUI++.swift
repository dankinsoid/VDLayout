//
//  SwiftUI++.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 11.02.2021.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct UIKitView<V: UIView>: UIViewRepresentable {
	
	let make: () -> V
	
	init(_ make: @escaping () -> V) {
		self.make = make
	}
	
	init(_ make: @escaping @autoclosure () -> V) {
		self.make = make
	}
	
	func makeUIView(context: UIViewRepresentableContext<UIKitView<V>>) -> V {
		make()
	}
	
	func updateUIView(_ uiView: V, context: UIViewRepresentableContext<UIKitView<V>>) {}
	
}

@available(iOS 13.0, *)
struct UIKitViewController<V: UIViewController>: UIViewControllerRepresentable {
	
	let make: () -> V
	
	init(_ make: @escaping () -> V) {
		self.make = make
	}
	
	init(_ make: @escaping @autoclosure () -> V) {
		self.make = make
	}
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<UIKitViewController<V>>) -> V {
		make()
	}
	
	func updateUIViewController(_ uiViewController: V, context: UIViewControllerRepresentableContext<UIKitViewController<V>>) {}
	
}
