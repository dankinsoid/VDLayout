//
//  File.swift
//  
//
//  Created by Данил Войдилов on 27.12.2021.
//

import UIKit

@resultBuilder
public struct UIBuilder {

	@inlinable
	public static func buildBlock(_ components: UILayout...) -> UILayout {
		UILayout(flat: components)
	}
	
	@inlinable
	public static func buildArray(_ components: [UILayout]) -> UILayout {
		UILayout(flat: components)
	}
	
	@inlinable
	public static func buildEither(first component: UILayout) -> UILayout {
		UILayout(flat: [component])
	}
	
	@inlinable
	public static func buildEither(second component: UILayout) -> UILayout {
		component
	}
	
	@inlinable
	public static func buildOptional(_ component: UILayout?) -> UILayout {
		component ?? UILayout()
	}
	
	@inlinable
	public static func buildLimitedAvailability(_ component: UILayout) -> UILayout {
		component
	}
	
	@inlinable
	public static func buildExpression(_ expression: UILayout) -> UILayout {
		expression
	}
	
	@inlinable
	public static func buildExpression<T: UI>(_ expression: T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayout {
		expression.layout(codeID: codeID)
	}
	
	@inlinable
	public static func buildExpression<T: UIViewConvertable>(_ expression: @escaping @autoclosure () -> T, codeID: CodeID = CodeID(file: #filePath, line: #line, column: #column)) -> UILayout {
		UIElement(expression).layout(codeID: codeID)
	}
}
