import SwiftUI
import VDChain

public extension Chain where Base.Root: UIView {

    func rounded(radius: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.cornerRadius = radius
            $0.clipsToBounds = true
        }
    }
    
    func rounded(radius: CGFloat, corners: CACornerMask, _ others: CACornerMask...) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.cornerRadius = radius
            $0.clipsToBounds = true
            $0.layer.maskedCorners = corners.union(CACornerMask(others))
        }
    }

    func alpha(_ value: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.alpha = value
        }
    }

    func filled(_ color: UIColor?) -> Chain<DoChain<Base>> {
        self.do {
            $0.backgroundColor = color
        }
    }

    func clipped(_ isClipped: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.clipsToBounds = isClipped
        }
    }

    func userInteractionEnabled(_ isUserInteractionEnabled: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    func contentMode(_ mode: UIView.ContentMode) -> Chain<DoChain<Base>> {
        self.do {
            $0.contentMode = mode
        }
    }

    func hidden(_ isHidden: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isHidden = isHidden
        }
    }

    func border(color: UIColor, width: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.borderColor = color.cgColor
            $0.layer.borderWidth = width
        }
    }

    func shadowed(
        color: UIColor = .black,
        opacity: Float = 0.4,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 6
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.shadowColor = color.cgColor
            $0.layer.shadowOpacity = opacity
            $0.layer.shadowOffset = offset
            $0.layer.shadowRadius = radius
        }
    }

    func wrapped() -> Chain<DoChain<Base>> {
        self.do {
            let stackView = UIStackView().chain.vertical().apply()
            stackView.addArrangedSubview($0)
        }
    }
    
    func subviews(
        @SubviewsBuilder subviews: () -> [SubviewProtocol]
    ) -> Chain<DoChain<Base>> {
        let views = subviews()
        return self.do {
            $0.add(subviews: views)
        }
    }
}
