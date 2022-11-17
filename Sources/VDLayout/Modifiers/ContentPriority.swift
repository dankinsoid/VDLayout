import UIKit
import VDChain

public extension Chain where Base.Root: UIView {
    
    func contentPriority(
        _ priority: UILayoutPriority,
        axis: NSLayoutConstraint.AxisSet = .both,
        type: UIView.LayoutPriorityDirectionSet = .both
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.set(contentPriority: priority, axis: axis, type: type)
        }
    }
}

public extension NSLayoutConstraint {
    
    struct AxisSet: OptionSet {
        
        public var rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        public init(axis: [Axis]) {
            var result = AxisSet()
            if axis.contains(.vertical) {
                result.insert(.vertical)
            }
            if axis.contains(.horizontal) {
                result.insert(.horizontal)
            }
            self = result
        }
        
        public static let vertical = AxisSet(rawValue: 1)
        public static let horizontal = AxisSet(rawValue: 2)
        public static var both: AxisSet { [.horizontal, .vertical] }
        
        public var axis: [Axis] {
            var result: [Axis] = []
            if contains(.vertical) {
                result.append(.vertical)
            }
            if contains(.horizontal) {
                result.append(.horizontal)
            }
            return result
        }
    }
}

public extension UIView {
    
    func set(
        contentPriority priority: UILayoutPriority,
        axis: NSLayoutConstraint.AxisSet = .both,
        type: UIView.LayoutPriorityDirectionSet = .both
    ) {
        axis.axis.forEach { axe in
            if type.contains(.compression) {
                setContentCompressionResistancePriority(priority, for: axe)
            }
            if type.contains(.hugging) {
                setContentHuggingPriority(priority, for: axe)
            }
        }
    }
    
    struct LayoutPriorityDirectionSet: OptionSet {
        
        public var rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        public static let hugging = LayoutPriorityDirectionSet(rawValue: 1)
        public static let compression = LayoutPriorityDirectionSet(rawValue: 2)
        public static var both: LayoutPriorityDirectionSet { [.compression, .hugging] }
    }
}
