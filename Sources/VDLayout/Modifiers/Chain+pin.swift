import SwiftUI
import VDChain

extension Chain where Base.Root: NSLayoutConstraintable {
    
    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: set of attributes to be set
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin(
        _ attributes: NSLayoutConstraint.Attribute.Set,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(attributes, options: NSLayoutConstraint.Options(options), file: file, line: line)
        }
    }
    
    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: set of attributes to be set
    ///   - value: constant
    ///   - options: constraint options
    /// - Returns: array of constraints.
    @discardableResult
    func pin<Value: ConstraintsRangeConvertable>(
        _ attributes: NSLayoutConstraint.Attribute.Set,
        _ value: Value,
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(attributes, value, options: NSLayoutConstraint.Options(options), file: file, line: line)
        }
    }
    
    /// Pin edges of the view to a specified item or its superview.
    ///
    /// - Parameters:
    ///   - edges: dictionary of paddings
    ///   - options: constraint options
    /// - Returns: Array of created constraints.
    @discardableResult
    func pin(
        edges: [Edge.Set: CGFloat],
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(edges: edges, options: NSLayoutConstraint.Options(options), file: file, line: line)
        }
    }
    
    /// Set any constraints for a given view.
    /// - Parameters:
    ///   - attributes: dictionary of attributes to be set
    ///   - options: constraint options
    /// - Returns: Constraints
    @discardableResult
    func pin(
        _ attributes: [NSLayoutConstraint.Attribute.Set: CGFloat],
        options: NSLayoutConstraint.Options...,
        file: String = #filePath,
        line: UInt = #line
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.pin(attributes, options: NSLayoutConstraint.Options(options), file: file, line: line)
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
            $0.pin(aspectRatio: aspectRatio, options: NSLayoutConstraint.Options(options), file: file, line: line)
        }
    }
}
