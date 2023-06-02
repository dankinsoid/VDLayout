import UIKit
import VDChain

public extension Chain where Base.Root: UILabel {

	func alignment(_ alignment: NSTextAlignment) -> Chain<DoChain<Base>> {
		self.do {
			$0.textAlignment = alignment
		}
	}

	func multiline() -> Chain<DoChain<Base>> {
		self.do {
			$0.numberOfLines = .zero
		}
	}

	func linesLimit(_ limit: Int) -> Chain<DoChain<Base>> {
		self.do {
			$0.numberOfLines = limit
		}
	}

	func text(_ text: String) -> Chain<DoChain<Base>> {
		self.do {
			$0.text = text
		}
	}

	func attributedText(_ text: NSAttributedString) -> Chain<DoChain<Base>> {
		self.do {
			$0.attributedText = text
		}
	}

	func strikeThrough(_ text: String) -> Chain<DoChain<Base>> {
		self.do {
			$0.add(
				[.strikethroughStyle: NSUnderlineStyle.single.rawValue],
				newText: text
			)
		}
	}

	func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> Chain<DoChain<Base>> {
		self.do {
			let style = NSMutableParagraphStyle()
			style.lineHeightMultiple = lineHeightMultiple
			$0.add([.paragraphStyle: style])
		}
	}

	func kern(_ kern: CGFloat) -> Chain<DoChain<Base>> {
		self.do {
			$0.add([.kern: kern])
		}
	}

	func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Chain<DoChain<Base>> {
		self.do {
			$0.lineBreakMode = lineBreakMode
		}
	}

	func font(_ font: UIFont, adjustsFontSizeToFitWidth: Bool = false) -> Chain<DoChain<Base>> {
		self.do {
			$0.font = font
			$0.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}
	}

	func textColor(_ color: UIColor) -> Chain<DoChain<Base>> {
		self.do {
			$0.textColor = color
		}
	}
}

private extension UILabel {

	// MARK: - Private functions

	func add(
		_ attributes: [NSAttributedString.Key: Any],
		newText: String? = nil
	) {
		if let attributedText {
			let mutable = NSMutableAttributedString(attributedString: attributedText)
			let range: NSRange
			if let newText, let stringRange = text?.range(of: newText) {
				range = NSRange(stringRange, in: text ?? "")
			} else {
				range = NSRange(location: 0, length: mutable.length)
			}
			mutable.addAttributes(attributes, range: range)
			self.attributedText = mutable
		} else {
			attributedText = NSMutableAttributedString(
				string: newText ?? text ?? "",
				attributes: attributes
			)
		}
	}
}
