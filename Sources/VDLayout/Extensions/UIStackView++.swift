import UIKit
import VDChain

extension UIStackView: CustomAddSubviewType {
    
    public func customAdd(subview: UIView) {
        addArrangedSubview(subview)
    }
}

public extension SubviewProtocol where Self: UIStackView {
    
    static func V(
        spacing: CGFloat = 0,
        alignment: VAlignment = .fill,
        distribution: Distribution = .fill,
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }
    ) -> Chain<DoChain<EmptyChaining<Self>>> {
        let result = Self.init()
        result.axis = .vertical
        result.spacing = spacing
        result.alignment = alignment.origin
        result.distribution = distribution
        result.setRestorationID(fileID: file, line: line, function: function)
        return result.chain.subviews(subviews: subviews)
    }
    
    static func H(
        spacing: CGFloat = 0,
        alignment: HAlignment = .fill,
        distribution: Distribution = .fill,
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }
    ) -> Chain<DoChain<EmptyChaining<Self>>> {
        let result = Self.init()
        result.axis = .horizontal
        result.spacing = spacing
        result.alignment = alignment.origin
        result.distribution = distribution
        result.setRestorationID(fileID: file, line: line, function: function)
        return result.chain.subviews(subviews: subviews)
    }
}

public extension UIStackView {
    
    @frozen
    enum VAlignment {
        
        case center, fill, leading, trailing
        
        public var origin: Alignment {
            switch self {
            case .center: return .center
            case .fill: return .fill
            case .leading: return .leading
            case .trailing: return .trailing
            }
        }
    }
    
    @frozen
    enum HAlignment {
        
        case center, fill, top, bottom, firstBaseline, lastBaseline
        
        public var origin: Alignment {
            switch self {
            case .center: return .center
            case .fill: return .fill
            case .top: return .top
            case .bottom: return .bottom
            case .firstBaseline: return .firstBaseline
            case .lastBaseline: return .lastBaseline
            }
        }
    }
}
