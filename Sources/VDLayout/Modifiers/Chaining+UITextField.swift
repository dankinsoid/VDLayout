import UIKit
import VDChain

public extension Chain where Base.Root: UITextField {

	func alignment(_ alignment: NSTextAlignment) -> Chain<Base> {
		self.do {
			$0.textAlignment = alignment
		}
	}

	func font(_ font: UIFont) -> Chain<Base> {
		self.do {
			$0.font = font
		}
	}

	func textColor(_ color: UIColor) -> Chain<Base> {
		self.do {
			$0.textColor = color
		}
	}

	func tintColor(_ color: UIColor) -> Chain<Base> {
		self.do {
			$0.tintColor = color
		}
	}

	func keyboard(type: UIKeyboardType) -> Chain<Base> {
		self.do {
			$0.keyboardType = type
		}
	}

	func placeholder(_ placeholder: String) -> Chain<Base> {
		self.do {
			$0.placeholder = placeholder
		}
	}

	func enabled(_ isEnabled: Bool = true) -> Chain<Base> {
		self.do {
			$0.isEnabled = isEnabled
		}
	}

	func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Chain<Base> {
		self.do {
			$0.autocorrectionType = autocorrectionType
		}
	}
}
