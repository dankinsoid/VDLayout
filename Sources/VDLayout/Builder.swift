//
//  File.swift
//  
//
//  Created by Данил Войдилов on 27.12.2021.
//

import UIKit

@resultBuilder
public struct UIViewNodesBuilder {

	@inlinable
	public static func buildBlock(_ components: [UIElementNode]...) -> [UIElementNode] {
		components.reduce(into: [], +=)
	}
	
	@inlinable
	public static func buildArray(_ components: [UIElementNode]) -> [UIElementNode] {
		components
	}
	
	@inlinable
	public static func buildEither(first component: [UIElementNode]) -> [UIElementNode] {
		component
	}
	
	@inlinable
	public static func buildEither(second component: [UIElementNode]) -> [UIElementNode] {
		component
	}
	
	@inlinable
	public static func buildOptional(_ component: [UIElementNode]?) -> [UIElementNode] {
		component ?? []
	}
	
	@inlinable
	public static func buildExpression(_ expression: UIElementNode) -> [UIElementNode] {
		[expression]
	}
	
	@inlinable
	public static func buildExpression<T: UIElementType>(_ expression: T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> [UIElementNode] {
		[UIElementNode(expression, file: file, line: line, column: column)]
	}
	
	@inlinable
	public static func buildExpression<T: UIView>(_ expression: @escaping @autoclosure () -> T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> [UIElementNode] {
		[UIElementNode(UIElement(expression), file: file, line: line, column: column)]
	}
}
