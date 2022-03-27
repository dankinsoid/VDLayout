//
//  File.swift
//  
//
//  Created by Данил Войдилов on 27.12.2021.
//

import UIKit
import SwiftUI

@resultBuilder
public struct UIStructureBuilder<Parent: UIRender> where Parent.Parent == Parent {

	@inlinable
	public static func buildBlock(_ components: AnyUIStructure<Parent>...) -> AnyUIStructure<Parent> {
		UI(flat: components)
	}
	
	@inlinable
	public static func buildArray(_ components: [AnyUIStructure<Parent>]) -> AnyUIStructure<Parent> {
		UI(flat: components.enumerated().map { $0.element.id($0.offset) })
	}
	
	@inlinable
	public static func buildEither(first component: AnyUIStructure<Parent>) -> AnyUIStructure<Parent> {
		component
	}
	
	@inlinable
	public static func buildEither(second component: AnyUIStructure<Parent>) -> AnyUIStructure<Parent> {
		component
	}
	
	@inlinable
	public static func buildOptional(_ component: AnyUIStructure<Parent>?) -> AnyUIStructure<Parent> {
		component ?? EmptyUIStructure().asAnyUIStructure()
	}
	
	@inlinable
	public static func buildLimitedAvailability(_ component: AnyUIStructure<Parent>) -> AnyUIStructure<Parent> {
		component
	}
	
	@inlinable
	public static func buildExpression<T: UIStructure>(_ expression: T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> AnyUIStructure<Parent> {
		expression.layout(codeID: CodeID(file: file, line: line, column: column))
	}
	
	@inlinable
	public static func buildExpression<T: UIRender>(_ expression: @escaping @autoclosure () -> T, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> AnyUIStructure<Parent> where T.Parent == Parent {
		UIElement(expression).asAnyUIStructure()
	}
}
