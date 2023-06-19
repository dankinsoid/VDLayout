import UIKit
import VDChain

public extension Chain where Base.Root: UILabel {

	/// Method to set the text alignment of a UILabel.
	///
	/// - Parameter alignment: The NSTextAlignment to set.
	/// - Returns: The updated Chain object.
	func alignment(_ alignment: NSTextAlignment) -> Chain<Base> {
		self.do {
			$0.textAlignment = alignment
		}
	}

	/// Method to make the UILabel multiline.
	///
	/// - Returns: The updated Chain object.
	func multiline() -> Chain<Base> {
		self.do {
			$0.numberOfLines = .zero
		}
	}

	/// Method to set the line limit of a UILabel.
	///
	/// - Parameter limit: The number of lines limit to set.
	/// - Returns: The updated Chain object.
	func linesLimit(_ limit: Int) -> Chain<Base> {
		self.do {
			$0.numberOfLines = limit
		}
	}

	/// Method to set the text of a UILabel.
	///
	/// - Parameter text: The string to set.
	/// - Returns: The updated Chain object.
	func text(_ text: String) -> Chain<Base> {
		self.do {
			$0.text = text
		}
	}

	/// Method to set the attributed text of a UILabel.
	///
	/// - Parameter text: The NSAttributedString to set.
	/// - Returns: The updated Chain object.
	func attributedText(_ text: NSAttributedString) -> Chain<Base> {
		self.do {
			$0.attributedText = text
		}
	}

	/// Method to set a strikethrough text in a UILabel.
	///
	/// - Parameter text: The string to strikethrough.
	/// - Returns: The updated Chain object.
	func strikeThrough(_ text: String) -> Chain<Base> {
		self.do {
			$0.add(
				[.strikethroughStyle: NSUnderlineStyle.single.rawValue],
				newText: text
			)
		}
	}

	/// Method to set the line height multiple of a UILabel.
	///
	/// - Parameter lineHeightMultiple: The line height multiple to set.
	/// - Returns: The updated Chain object.
	func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> Chain<Base> {
		self.do {
			let style = NSMutableParagraphStyle()
			style.lineHeightMultiple = lineHeightMultiple
			$0.add([.paragraphStyle: style])
		}
	}

	/// Method to set the kern value of a UILabel.
	///
	/// - Parameter kern: The kern value to set.
	/// - Returns: The updated Chain object.
	func kern(_ kern: CGFloat) -> Chain<Base> {
		self.do {
			$0.add([.kern: kern])
		}
	}

	/// Method to set the line break mode of a UILabel.
	///
	/// - Parameter lineBreakMode: The NSLineBreakMode to set.
	/// - Returns: The updated Chain object.
	func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Chain<Base> {
		self.do {
			$0.lineBreakMode = lineBreakMode
		}
	}

	/// Method to set the font of a UILabel and optionally allow the font size to adjust to width.
	///
	/// - Parameters:
	///   - font: The UIFont to set.
	///   - adjustsFontSizeToFitWidth: Whether the font size should adjust to the UILabel's width.
	/// - Returns: The updated Chain object.
	func font(_ font: UIFont, adjustsFontSizeToFitWidth: Bool = false) -> Chain<Base> {
		self.do {
			$0.font = font
			$0.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}
	}

	/// Method to set the text color of a UILabel.
	///
	/// - Parameter color: The UIColor to set.
	/// - Returns: The updated Chain object.
	func textColor(_ color: UIColor) -> Chain<Base> {
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
