//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public struct UIElementNode: Identifiable {
	public var id: CodeID
	public var viewCreator: AnyUIElementType
	
	public init(_ viewCreator: AnyUIElementType, file: String, line: UInt, column: UInt) {
		self.viewCreator = viewCreator
		id = CodeID(file: file, line: line, column: column)
	}
	
	public init<UIViewType: UIElementsUpdatable>(file: String = #filePath, line: UInt = #line, column: UInt = #column, _ create: @escaping @autoclosure () -> UIViewType) {
		self.init(UIElement(create), file: file, line: line, column: column)
	}
	
	public init<UIViewType: UIElementsUpdatable>(file: String = #filePath, line: UInt = #line, column: UInt = #column, _ create: @escaping () -> UIViewType) {
		self.init(UIElement(create), file: file, line: line, column: column)
	}
	
	public func create() -> UIElementsUpdatable {
		viewCreator._createUIView()
	}
	
	public func update(_ view: UIElementsUpdatable) {
		view.updateUIElements()
		viewCreator._updateUIView(view)
	}
}
