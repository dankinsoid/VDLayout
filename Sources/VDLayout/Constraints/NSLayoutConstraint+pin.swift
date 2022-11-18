import SwiftUI

public extension Pinnable {

    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: set of attributes to be set
    ///   - toItem: second item for constraints
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin(
        _ attributes: NSLayoutConstraint.Attribute.Set,
        to toItem: (any NSLayoutConstraintable)? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
        makeConstraints { item in
            let options = NSLayoutConstraint.Options(options)
            return attributes.attributes.map { attribute in
                NSLayoutConstraint.create(
                    attribute: attribute,
                    item: item,
                    attribute: attribute,
                    toItem: toItem,
                    options: options,
                    file: file,
                    line: line
                )
            }
        }
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
        to toItem: (any NSLayoutConstraintable)? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
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
        to toItem: (any NSLayoutConstraintable)? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
        makeConstraints { item in
            edges.flatMap { (edge, offset) in
                NSLayoutConstraint.Attribute.Set.edges(edge).attributes.map { attribute in
                    NSLayoutConstraint.create(
                        attribute: attribute,
                        item: item,
                        attribute: attribute,
                        toItem: toItem,
                        options: NSLayoutConstraint.Options(options + [.offset(offset)]),
                        file: file,
                        line: line
                    )
                }
            }
        }
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
        of item: any NSLayoutConstraintable,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
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
        to toItem: (any NSLayoutConstraintable)? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
        makeConstraints { item in
            attributes.flatMap { (attributes, offset) in
                attributes.attributes.map { attribute in
                    NSLayoutConstraint.create(
                        attribute: attribute,
                        item: item,
                        attribute: attribute,
                        toItem: toItem,
                        options: NSLayoutConstraint.Options(options + [.offset(offset)]),
                        file: file,
                        line: line
                    )
                }
            }
        }
    }

    /// Pin a given view to another view
    @discardableResult
    func pin(
        _ firstAttributes: NSLayoutConstraint.Attribute.Set,
        to secondAttributes: NSLayoutConstraint.Attribute.Set,
        of item: any NSLayoutConstraintable,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> ConstraintsCollection {
        let secondAttributesArray = secondAttributes.attributes
        let options = NSLayoutConstraint.Options(options)
        return makeConstraints { item in
            firstAttributes.attributes.flatMap { firstAttribute in
                secondAttributesArray.filter { $0.isCompatible(with: firstAttribute) }.map { secondAttribute in
                    NSLayoutConstraint.create(
                        attribute: firstAttribute,
                        item: item,
                        attribute: secondAttribute,
                        toItem: item,
                        options: options,
                        file: file,
                        line: line
                    )
                }
            }
        }
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
    ) -> ConstraintsCollection {
        let options = NSLayoutConstraint.Options(options + [.multiplier(aspectRatio)])
        return makeConstraints { item in
            [
                NSLayoutConstraint.create(
                    attribute: .height,
                    item: item,
                    attribute: .width,
                    toItem: item,
                    options: options,
                    file: file,
                    line: line
                )
            ]
        }
    }
}
