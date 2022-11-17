import UIKit

extension UILayoutPriority: ExpressibleByFloatLiteral {

    public init(floatLiteral value: Float) {
        self.init(rawValue: value)
    }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: UInt) {
        self.init(rawValue: Float(value))
    }
}
