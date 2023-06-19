import SwiftUI
import VDChain

@resultBuilder
public enum SubviewBuilder {

	@inlinable
	public static func buildBlock(_ components: any Subview...) -> any Subview {
		buildArray(components)
	}

	@inlinable
	public static func buildArray(_ components: [any Subview]) -> any Subview {
		components
	}

	@inlinable
	public static func buildEither(first component: any Subview) -> any Subview {
		component
	}

	@inlinable
	public static func buildEither(second component: any Subview) -> any Subview {
		component
	}

	@inlinable
	public static func buildOptional(_ component: (any Subview)?) -> any Subview {
		component ?? EmptySubview()
	}

	@inlinable
	public static func buildLimitedAvailability(_ component: any Subview) -> any Subview {
		component
	}

	@inlinable
	public static func buildExpression(_ expression: some Subview) -> any Subview {
		expression
	}

	@inlinable
	public static func buildExpression(_ expression: any Subview) -> any Subview {
		expression
	}

	@inlinable
	public static func buildExpression(_ expression: some View) -> any Subview {
		SelfSizingHostingController(rootView: expression)
	}

	@inlinable
	public static func buildExpression<T: Subview>(_ expression: some Sequence<T>) -> any Subview {
		buildArray(Array(expression))
	}

	@inlinable
	public static func buildExpression(_ expression: some Sequence<any Subview>) -> any Subview {
		buildArray(Array(expression))
	}

	#if DEBUG
	@inlinable
	public static func buildExpression<T: ValueChaining>(
		_ expression: Chain<T>,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function
	) -> any Subview where T.Root: UIView {
		expression.restorationIDIfNeeded(file: file, line: line, function: function)
	}

	@inlinable
	public static func buildExpression<T: UIView>(
		_ expression: T,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function
	) -> any Subview {
		buildExpression(expression.chain, file: file, line: line, function: function)
	}
	#endif
}
