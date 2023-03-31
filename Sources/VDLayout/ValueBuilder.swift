import Foundation

@resultBuilder
public enum ValueBuilder<Value> {
	
	@inlinable
	public static func buildBlock(_ component: Value) -> Value {
		component
	}
	
	@inlinable
	public static func buildExpression(_ expression: Value) -> Value {
		expression
	}
}
