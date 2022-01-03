//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation
import SwiftUI

public struct SwiftUIElement<Content: View>: UIElementType {
	public let content: Content
	
	public init(_ content: Content) {
		self.content = content
	}
	
	public func createUIView() -> UIHostingController<Content> {
		UIHostingController(rootView: content)
	}
	
	public func updateUIView(_ view: UIHostingController<Content>) {
		view.rootView = content
	}
}

extension UIBuilder {
	
	@inlinable
	public static func buildExpression<T: View>(_ expression: T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayout {
		SwiftUIElement(expression).layout(codeID: codeID)
	}
}

extension ViewBuilder {
	
	@inlinable
	public static func buildExpression<T: View>(_ expression: T) -> T {
		expression
	}
	
	public static func buildExpression<T: UI>(_ expression: @escaping @autoclosure () -> T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayoutView {
		UILayoutView { expression().layout(codeID: codeID) }
	}
	
	public static func buildExpression<T: UIViewConvertable>(_ expression: @escaping @autoclosure () -> T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayoutView {
		UILayoutView { UIElement(expression).layout(codeID: codeID) }
	}
}

public struct UILayoutView: View {
	public let layout: () -> UILayout
	@StateObject private var storage = ViewModel()
	
	public init(_ layout: @escaping () -> UILayout) {
		self.layout = layout
	}
	
	public var body: some View {
		storage.updating {
			ForEach(layout().nodes) { $0 }
		}
	}
}

private final class ViewModel: UIResponder, UIUpdatableStorage, ObservableObject {
	var updaters: [CodeID: Any] = [:]
	@Published var update = false
	
	func updateUILayout() {
		update.toggle()
	}
}

extension UIElementNode: UIViewRepresentable {
	
	public func makeUIView(context: Context) -> UIView {
		let convertable = element._createUIView()
		if let view = convertable as? UIView {
			return view
		} else {
			return _UIViewType(element._createUIView())
		}
	}

	public func updateUIView(_ uiView: UIView, context: Context) {
		if let viewType = uiView as? _UIViewType {
			update(superview: nil, current: viewType.convertable)
		} else {
			update(superview: nil, current: uiView)
		}
	}
	
	private final class _UIViewType: UIView {
		let convertable: UIViewConvertable
		
		override var intrinsicContentSize: CGSize { convertable.asUIView.intrinsicContentSize }
		
		init(_ convertable: UIViewConvertable) {
			self.convertable = convertable
			super.init(frame: .zero)
		}
		
		override func didMoveToWindow() {
			super.didMoveToWindow()
			convertable.add(to: self)
		}
		
		override func layoutSubviews() {
			super.layoutSubviews()
			convertable.asUIView.pin.all().layout()
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}
