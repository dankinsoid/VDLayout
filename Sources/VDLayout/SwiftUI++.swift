import UIKit
import RxSwift
import RxCocoa
import SwiftUI
import ConstraintsOperators

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
