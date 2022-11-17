import UIKit

public protocol ConstraintsRangeConvertable {

    func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat)
}

extension CGFloat: ConstraintsRangeConvertable {

    public func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat) {
        (.equal, self)
    }
}

extension Double: ConstraintsRangeConvertable {

    public func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat) {
        (.equal, self)
    }
}

extension Int: ConstraintsRangeConvertable {

    public func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat) {
        (.equal, CGFloat(self))
    }
}

extension PartialRangeThrough: ConstraintsRangeConvertable where Bound: ConstraintsRangeConvertable {

    public func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat) {
        (.lessThanOrEqual, upperBound.toConstraintsRange().1)
    }
}

extension PartialRangeFrom: ConstraintsRangeConvertable where Bound: ConstraintsRangeConvertable {

    public func toConstraintsRange() -> (NSLayoutConstraint.Relation, CGFloat) {
        (.greaterThanOrEqual, lowerBound.toConstraintsRange().1)
    }
}
