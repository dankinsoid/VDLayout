import UIKit
import VDChain

public extension Chain where Base.Root: UITextView {

    func multiline() -> Chain<DoChain<Base>> {
        self.do {
            $0.textContainer.maximumNumberOfLines = .zero
        }
    }

    func removePaddings() -> Chain<DoChain<Base>> {
        self.do {
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = .zero
        }
    }

    func font(_ font: UIFont) -> Chain<DoChain<Base>> {
        self.do {
            $0.font = font
        }
    }

    func textColor(_ color: UIColor) -> Chain<DoChain<Base>> {
        self.do {
            $0.textColor = color
        }
    }

    func alignment(_ alignment: NSTextAlignment) -> Chain<DoChain<Base>> {
        self.do {
            $0.textAlignment = alignment
        }
    }

    func linesLimit(_ limit: Int) -> Chain<DoChain<Base>> {
        self.do {
            $0.textContainer.maximumNumberOfLines = limit
        }
    }

    func attributedText(_ attributedText: NSAttributedString) -> Chain<DoChain<Base>> {
        self.do {
            $0.attributedText = attributedText
        }
    }
}
