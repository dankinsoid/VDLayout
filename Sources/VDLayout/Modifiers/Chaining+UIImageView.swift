import UIKit
import VDChain

public extension Chain where Base.Root: UIImageView {

	/// Method to set the image of a UIImageView.
	///
	/// - Parameter image: The UIImage to set.
	/// - Returns: The updated Chain object.
	func image(_ image: UIImage?) -> Chain<DoChain<Base>> {
		self.do {
			$0.image = image?.imageFlippedForRightToLeftLayoutDirection()
		}
	}

	/// Method to apply a tint color to a UIImageView.
	///
	/// - Parameter color: The UIColor to use for the tint.
	/// - Returns: The updated Chain object.
	func tinted(with color: UIColor?) -> Chain<DoChain<Base>> {
		self.do {
			guard let color else { return }
			$0.image = $0.image?.withTintColor(color)
		}
	}
}
