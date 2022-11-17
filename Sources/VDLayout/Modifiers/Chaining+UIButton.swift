import UIKit
import VDChain

public extension Chain where Base.Root: UIButton {

    func edgeInsets(_ insets: UIEdgeInsets) -> Chain<DoChain<Base>> {
        self.do {
            $0.contentEdgeInsets = insets
        }
    }

    func title(_ title: String, for state: UIControl.State = .normal) -> Chain<DoChain<Base>> {
        self.do {
            $0.setTitle(title, for: state)
        }
    }

    func attributedTitle(_ title: NSAttributedString, for state: UIControl.State = .normal) -> Chain<DoChain<Base>> {
        self.do {
            $0.setAttributedTitle(title, for: state)
        }
    }

    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Chain<DoChain<Base>> {
        self.do {
            $0.setTitleColor(color, for: state)
        }
    }

    func horizontalAlignment(_ alignment: NSTextAlignment) -> Chain<DoChain<Base>> {
        self.do {
            $0.contentHorizontalAlignment = .left
        }
    }

    func titleEdgeInsets(_ insets: UIEdgeInsets) -> Chain<DoChain<Base>> {
        self.do {
            $0.titleEdgeInsets = insets
        }
    }

    func contentEdgeInsets(_ insets: UIEdgeInsets) -> Chain<DoChain<Base>> {
        self.do {
            $0.contentEdgeInsets = insets
        }
    }

    func font(_ font: UIFont) -> Chain<DoChain<Base>> {
        self.do {
            $0.titleLabel?.font = font
        }
    }

    func image(
        _ image: UIImage?,
        trailing: Bool = false,
        spacing: CGFloat? = nil,
        for state: UIControl.State = .normal
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.setImage(image, for: state)

            if trailing {
                let transform = CGAffineTransform(scaleX: -1, y: 1)

                $0.transform = transform
                $0.titleLabel?.transform = transform
                $0.imageView?.transform = transform
            }

            if let spacing = spacing {
                $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
                $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
            }
        }
    }
}
