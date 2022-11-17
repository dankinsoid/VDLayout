import SwiftUI

public extension NSLayoutConstraintable {

    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: set of attributes to be set
    ///   - toItem: second item for constraints
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin(
        _ attributes: NSLayoutConstraint.Attribute.Set,
        to toItem: NSLayoutConstraintable? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        let options = NSLayoutConstraint.Options(options)
        var result: [NSLayoutConstraint] = []
        attributes.attributes.forEach { attribute in
            let constraint = NSLayoutConstraint.create(
                attribute: attribute,
                item: self,
                attribute: attribute,
                toItem: toItem,
                options: options,
                file: file,
                line: line
            )
            result.append(constraint)
        }
        return withConstraints(result)
    }

    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: set of attributes to be set
    ///   - value: constant
    ///   - toItem: second item for constraints
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin<Value: ConstraintsRangeConvertable>(
        _ attributes: NSLayoutConstraint.Attribute.Set,
        _ value: Value,
        to toItem: NSLayoutConstraintable? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        pin(
            attributes,
            to: toItem,
            options: NSLayoutConstraint.Options(options + [.offset(value)]),
            file: file,
            line: line
        )
    }

    /// Pin edges of the view to a specified item or its superview.
    ///
    /// - Parameters:
    ///   - edges: dictionary of paddings
    ///   - toItem: second item for constraints, if this parameter is `nil` then a superview will be used
    ///   - options: constraint options
    /// - Returns: Array of created constraints.
    @discardableResult
    func pin(
        edges: [Edge.Set: CGFloat],
        to toItem: NSLayoutConstraintable? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        let options = NSLayoutConstraint.Options(options)
        let array = edges.flatMap {
            pin(
                .edges($0.key),
                $0.value,
                to: toItem,
                options: options,
                file: file,
                line: line
            ).constraints
        }
        return withConstraints(array)
    }

    /// Pin a given view before/after another view
    ///
    /// - Parameters:
    ///   - edge: edge to be pinned
    ///   - item: second item for constraints
    ///   - options: constraints options
    @discardableResult
    func pin(
        to edge: Edge,
        of item: NSLayoutConstraintable,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        pin(
            NSLayoutConstraint.Attribute.Set(edge.opposite.attribute),
            to: NSLayoutConstraint.Attribute.Set(edge.attribute),
            of: item,
            options: NSLayoutConstraint.Options(options),
            file: file,
            line: line
        )
    }

    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: dictionary of attributes to be set
    ///   - toItem: second item for constraints
    ///   - options: constraint options
    /// - Returns: Constraints
    @discardableResult
    func pin(
        _ attributes: [NSLayoutConstraint.Attribute.Set: CGFloat],
        to toItem: NSLayoutConstraintable? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        let options = NSLayoutConstraint.Options(options)
        let array = attributes.flatMap {
            pin(
                $0.key,
                to: toItem,
                options: options,
                .offset($0.value),
                file: file,
                line: line
            ).constraints
        }
        return withConstraints(array)
    }

    /// Pin a given view to another view
    @discardableResult
    func pin(
        _ firstAttributes: NSLayoutConstraint.Attribute.Set,
        to secondAttributes: NSLayoutConstraint.Attribute.Set,
        of item: NSLayoutConstraintable,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        let secondAttributesArray = secondAttributes.attributes
        let options = NSLayoutConstraint.Options(options)
        let array = firstAttributes.attributes.flatMap { firstAttribute in
            secondAttributesArray.filter { $0.isCompatible(with: firstAttribute) }.map { secondAttribute in
                NSLayoutConstraint.create(
                    attribute: firstAttribute,
                    item: self,
                    attribute: secondAttribute,
                    toItem: item,
                    options: options,
                    file: file,
                    line: line
                )
            }
        }
        return withConstraints(array)
    }

    /// Set size of the view.
    /// - Parameters:
    ///   - aspectRatio: relation height to width
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin(
        aspectRatio: CGFloat,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Constraints {
        let options = NSLayoutConstraint.Options(options + [.multiplier(aspectRatio)])
        let constraint = NSLayoutConstraint.create(
            attribute: .height,
            item: self,
            attribute: .width,
            toItem: self,
            options: options,
            file: file,
            line: line
        )
        return withConstraints([constraint])
    }
}
