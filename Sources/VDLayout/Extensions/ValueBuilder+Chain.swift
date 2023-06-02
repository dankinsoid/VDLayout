import Foundation
import VDChain

public extension ValueBuilder {

	@inlinable
	static func buildExpression<C: ValueChaining>(_ expression: Chain<C>) -> Value where C.Root == Value {
		expression.apply()
	}
}
