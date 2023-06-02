import SwiftUI
import VDChain
import VDPin

public extension Chain where Base.Root: UIView {

	@available(*, deprecated, message: "Use cornerRadius instead")
	func rounded(radius: CGFloat) -> Chain<DoChain<Base>> {
		cornerRadius(radius)
	}

	@available(*, deprecated, message: "Use cornerRadius instead")
	func rounded(radius: CGFloat, corners: CACornerMask, _ others: CACornerMask...) -> Chain<DoChain<Base>> {
		cornerRadius(radius, at: corners.union(CACornerMask(others)))
	}

	func cornerRadius(_ radius: CGFloat, at corners: CACornerMask, _ others: CACornerMask...) -> Chain<DoChain<Base>> {
		self.do {
			$0.layer.cornerRadius = radius
			$0.clipsToBounds = true
			$0.layer.maskedCorners = corners.union(CACornerMask(others))
		}
	}

	func cornerRadius(_ radius: CGFloat) -> Chain<DoChain<Base>> {
		self.do {
			$0.layer.cornerRadius = radius
			$0.clipsToBounds = true
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

	func margins(_ value: CGFloat) -> Chain<DoChain<Base>> {
		margins(.all, value)
	}

	func margins(_ edges: Edge.Set, _ value: CGFloat) -> Chain<DoChain<Base>> {
		margins(NSDirectionalEdgeInsets(edges, value))
	}

	func margins(_ insets: NSDirectionalEdgeInsets, _ other: NSDirectionalEdgeInsets...) -> Chain<DoChain<Base>> {
		self.do {
			$0.directionalLayoutMargins += other.reduce(into: insets, +=)
		}
	}

	func restorationID(_ id: String) -> Chain<DoChain<Base>> {
		self.do {
			$0.restorationIdentifier = id
		}
	}

	func restorationID(file: String = #fileID, line: UInt = #line, function: String = #function) -> Chain<DoChain<Base>> {
		self.do {
			$0.setRestorationID(fileID: file, line: line, function: function)
		}
	}
}

public extension Chain where Base.Root: UIView, Base: SubviewChaining {

	func scrollable(
		_ axis: NSLayoutConstraint.Axis,
		showsIndicators: Bool = false,
		bounce: Bool = true
	) -> SubviewChain<UIScrollView> {
		let scroll = UIScrollView()
		switch axis {
		case .horizontal:
			scroll.alwaysBounceHorizontal = bounce
			scroll.alwaysBounceVertical = false
			scroll.showsHorizontalScrollIndicator = showsIndicators
			scroll.showsVerticalScrollIndicator = false
		case .vertical:
			scroll.alwaysBounceHorizontal = false
			scroll.alwaysBounceVertical = bounce
			scroll.showsHorizontalScrollIndicator = false
			scroll.showsVerticalScrollIndicator = showsIndicators
		@unknown default:
			break
		}
		return scroll.chain.subview {
			switch axis {
			case .horizontal:
				self.pin(.edges).pin(.centerY)
			case .vertical:
				self.pin(.edges).pin(.centerX)
			@unknown default:
				self.pin(.edges)
			}
		}
		.any()
	}
}

public extension Chain where Base: SubviewInstallerChaining, Base.Root: UIView {

	func subview(
		@SubviewBuilder subview: () -> any Subview
	) -> Chain<SubviewInstallerChain<Base>> {
		let installer = subview().subviewInstaller
		return on { root, _ in
			installer.install(on: root)
		} configure: { root, _ in
			installer.configure(on: root)
		}
	}
}
