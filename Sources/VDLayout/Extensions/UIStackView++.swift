import UIKit

extension UIStackView: CustomAddSubviewType {
    
    public func customAdd(subview: UIView) {
        addArrangedSubview(subview)
    }
}

public extension UIStackView {
    
    static func V(spacing: CGFloat = 0, alignment: VAlignment = .fill, distribution: Distribution = .fill, @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }) -> Self {
        let result = Self.init()
        result.axis = .vertical
        result.spacing = spacing
        result.alignment = alignment.origin
        result.distribution = distribution
        subviews().forEach(result.add)
        return result
    }
    
    static func H(spacing: CGFloat = 0, alignment: HAlignment = .fill, distribution: Distribution = .fill, @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }) -> Self {
        let result = Self.init()
        result.axis = .horizontal
        result.spacing = spacing
        result.alignment = alignment.origin
        result.distribution = distribution
        subviews().forEach(result.add)
        return result
    }
    
    @frozen
    enum VAlignment {
        
        case сenter, fill, leading, trailing
        
        public var origin: Alignment {
            switch self {
            case .сenter: return .center
            case .fill: return .fill
            case .leading: return .leading
            case .trailing: return .trailing
            }
        }
    }
    
    @frozen
    enum HAlignment {
        
        case сenter, fill, top, bottom
        
        public var origin: Alignment {
            switch self {
            case .сenter: return .center
            case .fill: return .fill
            case .top: return .top
            case .bottom: return .bottom
            }
        }
    }
}
