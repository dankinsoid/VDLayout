import Foundation
import UIKit
import VDChain
import VDPin

public extension Subview where Self: UIScrollView {

	static func V(
		spacing: CGFloat = 0,
		alignment: UIStackView.VAlignment = .fill,
		distribution: UIStackView.Distribution = .fill,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function,
		@SubviewBuilder _ subviews: () -> any Subview = { EmptySubview() }
	) -> SubviewChain<Self> {
		Self.subview {
			UIStackView.V(
				spacing: spacing,
				alignment: alignment,
				distribution: distribution,
				file: file,
				line: line,
				function: function,
				subviews
			)
			.pin(.edges)
			.pin(.centerX)
		}
		.bounces(.vertical)
		.showsIndicators(.vertical)
		.any()
	}

	static func H(
		spacing: CGFloat = 0,
		alignment: UIStackView.HAlignment = .fill,
		distribution: UIStackView.Distribution = .fill,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function,
		@SubviewBuilder _ subviews: () -> any Subview = { EmptySubview() }
	) -> SubviewChain<Self> {
		Self.subview {
			UIStackView.H(
				spacing: spacing,
				alignment: alignment,
				distribution: distribution,
				file: file,
				line: line,
				function: function,
				subviews
			)
			.pin(.edges)
			.pin(.centerY)
		}
		.bounces(.horizontal)
		.showsIndicators(.horizontal)
		.any()
	}
}

extension UIScrollView {

	var _isScrolling: Bool {
		isTracking || isDragging || isDecelerating
	}

	func _setAdjustedContentOffsetIfNeeded(_ contentOffset: CGPoint) {
		let maxContentOffsetX = contentSize.width + adjustedContentInset.right - bounds.width
		let maxContentOffsetY = contentSize.height + adjustedContentInset.bottom - bounds.height
		let isContentRectContainsBounds = CGRect(origin: .zero, size: contentSize)
			.inset(by: adjustedContentInset.inverted)
			.contains(bounds)

		if isContentRectContainsBounds, !_isScrolling {
			self.contentOffset = CGPoint(
				x: min(maxContentOffsetX, contentOffset.x),
				y: min(maxContentOffsetY, contentOffset.y)
			)
		}
	}
}

private extension UIEdgeInsets {

	var inverted: UIEdgeInsets {
		UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
	}
}
