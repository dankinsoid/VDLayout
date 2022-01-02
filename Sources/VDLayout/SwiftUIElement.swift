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
	
	@inlinable
	public static func buildExpression<T: UI>(_ expression: T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayoutView {
		UILayoutView(expression.layout(codeID: codeID))
	}
	
	@inlinable
	public static func buildExpression<T: UIViewConvertable>(_ expression: @escaping @autoclosure () -> T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayoutView {
		UILayoutView(UIElement(expression).layout(codeID: codeID))
	}
}

public struct UILayoutView: View {
	public let layout: UILayout
	
	public init(_ layout: UILayout) {
		self.layout = layout
	}
	
	public var body: some View {
		ForEach(layout.nodes) { $0 }
	}
}

extension UIElementNode: UIViewRepresentable {
	func makeUIView(context: Context) -> UIView {
		let convertable = element._createUIView()
		if let view = convertable as? UIView {
			return view
		} else {
			return _UIViewType(element._createUIView())
		}
	}

	func updateUIView(_ uiView: UIView, context: Context) {
		if let viewType = uiView as? _UIViewType {
			element._updateUIView(viewType.convertable)
		} else {
			element._updateUIView(uiView)
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
