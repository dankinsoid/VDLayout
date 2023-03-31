import Foundation
import VDChain

extension ValueBuilder {
	
	@inlinable
	public static func buildExpression<C: ValueChaining>(_ expression: Chain<C>) -> Value where C.Root == Value {
		expression.apply()
	}
}
