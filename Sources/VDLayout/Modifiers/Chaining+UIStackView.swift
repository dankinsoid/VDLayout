import SwiftUI
import VDChain

public extension Chain where Base.Root: UIStackView {

    func vertical(_ spacing: CGFloat = .zero) -> Chain<DoChain<Base>> {
        self.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = spacing
        }
    }

    func horizontal(_ spacing: CGFloat = .zero) -> Chain<DoChain<Base>> {
        self.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = spacing
        }
    }

    func alignment(_ alignment: UIStackView.Alignment) -> Chain<DoChain<Base>> {
        self.do {
            $0.alignment = alignment
        }
    }

    func distribution(_ distribution: UIStackView.Distribution) -> Chain<DoChain<Base>> {
        self.do {
            $0.distribution = distribution
        }
    }

    func margins(
        top: CGFloat = .zero,
        left: CGFloat = .zero,
        right: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }

    func layoutMargins(_ insets: UIEdgeInsets) -> Chain<DoChain<Base>> {
        self.do {
            $0.layoutMargins = insets
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    func margins(_ value: CGFloat) -> Chain<DoChain<Base>> {
        margins(.all, value)
    }
    
    func margins(_ edges: Edge.Set, _ value: CGFloat) -> Chain<DoChain<Base>> {
        margins(NSDirectionalEdgeInsets(edges, value))
    }
    
    func margins(_ insets: NSDirectionalEdgeInsets, _ other: NSDirectionalEdgeInsets...) -> Chain<DoChain<Base>> {
        self.do {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins += other.reduce(into: insets, +=)
        }
    }
}
