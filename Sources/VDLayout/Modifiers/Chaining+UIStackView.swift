import SwiftUI
import VDChain

public extension Chain where Base.Root: UIStackView {

	/// Method to set the stack view to vertical orientation.
	///
	/// - Parameter spacing: The space between each subview.
	/// - Returns: The updated Chain object.
	func vertical(_ spacing: CGFloat = .zero) -> Chain<Base> {
		self.do {
			$0.axis = .vertical
			$0.distribution = .fill
			$0.spacing = spacing
		}
	}

	/// Method to set the stack view to horizontal orientation.
	///
	/// - Parameter spacing: The space between each subview.
	/// - Returns: The updated Chain object.
	func horizontal(_ spacing: CGFloat = .zero) -> Chain<Base> {
		self.do {
			$0.axis = .horizontal
			$0.distribution = .fill
			$0.spacing = spacing
		}
	}

	/// Method to set the alignment of a UIStackView.
	///
	/// - Parameter alignment: The UIStackView.Alignment to set.
	/// - Returns: The updated Chain object.
	func alignment(_ alignment: UIStackView.Alignment) -> Chain<Base> {
		self.do {
			$0.alignment = alignment
		}
	}

	/// Method to set the distribution of a UIStackView.
	///
	/// - Parameter distribution: The UIStackView.Distribution to set.
	/// - Returns: The updated Chain object.
	func distribution(_ distribution: UIStackView.Distribution) -> Chain<Base> {
		self.do {
			$0.distribution = distribution
		}
	}

	func margins(
		top: CGFloat = .zero,
		left: CGFloat = .zero,
		right: CGFloat = .zero,
		bottom: CGFloat = .zero
	) -> Chain<Base> {
		self.do {
			$0.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
			$0.isLayoutMarginsRelativeArrangement = true
		}
	}

	func layoutMargins(_ insets: UIEdgeInsets) -> Chain<Base> {
		self.do {
			$0.layoutMargins = insets
			$0.isLayoutMarginsRelativeArrangement = true
		}
	}

	func margins(_ value: CGFloat) -> Chain<Base> {
		margins(.all, value)
	}

	func margins(_ edges: Edge.Set, _ value: CGFloat) -> Chain<Base> {
		margins(NSDirectionalEdgeInsets(edges, value))
	}

	func margins(_ insets: NSDirectionalEdgeInsets, _ other: NSDirectionalEdgeInsets...) -> Chain<Base> {
		self.do {
			$0.isLayoutMarginsRelativeArrangement = true
			$0.directionalLayoutMargins += other.reduce(into: insets, +=)
		}
	}
}
