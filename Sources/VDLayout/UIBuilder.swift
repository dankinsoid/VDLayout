//
//  File.swift
//  
//
//  Created by Данил Войдилов on 27.12.2021.
//

import UIKit
import SwiftUI

@resultBuilder
public struct UIBuilder {

	@inlinable
	public static func buildBlock(_ components: UILayout...) -> UILayout {
		UILayout(flat: components)
	}
	
	@inlinable
	public static func buildArray(_ components: [UILayout]) -> UILayout {
		UILayout(flat: components.enumerated().map { $0.element.id($0.offset) })
	}
	
	@inlinable
	public static func buildEither(first component: UILayout) -> UILayout {
		component
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
	public static func buildExpression<T: UI>(_ expression: T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> UILayout {
		expression.layout(codeID: CodeID(file: file, line: line, column: column))
	}
	
	@inlinable
	public static func buildExpression<T: UIViewConvertable>(_ expression: @escaping @autoclosure () -> T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> UILayout {
		UIElement(expression).layout(codeID: CodeID(file: file, line: line, column: column))
	}
}
