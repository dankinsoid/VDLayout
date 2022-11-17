import SwiftUI
import VDChain

public extension Chain where Base.Root: NSLayoutConstraintable {
    
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
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                attributes,
                to: toItem,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
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
        to toItem: NSLayoutConstraintable? = nil,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                attributes,
                value,
                to: toItem,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
        }
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
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                edges: edges,
                to: toItem,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
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
        of item: NSLayoutConstraintable,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                to: edge,
                of: item,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
        }
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
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                attributes,
                to: toItem,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
        }
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
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                firstAttributes,
                to: secondAttributes,
                of: item,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
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
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(
                aspectRatio: aspectRatio,
                options: NSLayoutConstraint.Options(options),
                file: file,
                line: line
            )
        }
    }
}
