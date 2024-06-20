import SwiftUI
import VDChain
import VDPin

public extension Chain where Base.Root: UIView {

	@available(*, deprecated, message: "Use cornerRadius instead")
	func rounded(radius: CGFloat) -> Chain<Base> {
		cornerRadius(radius)
	}

	@available(*, deprecated, message: "Use cornerRadius instead")
	func rounded(radius: CGFloat, corners: CACornerMask, _ others: CACornerMask...) -> Chain<Base> {
		cornerRadius(radius, at: corners.union(CACornerMask(others)))
	}

	func cornerRadius(_ radius: CGFloat, style: CALayerCornerCurve = .continuous, at corners: CACornerMask, _ others: CACornerMask...) -> Chain<Base> {
		self.do {
			$0.layer.cornerRadius = radius
            $0.layer.cornerCurve = style
			$0.clipsToBounds = true
			$0.layer.maskedCorners = corners.union(CACornerMask(others))
		}
	}

    func cornerRadius(_ radius: CGFloat, style: CALayerCornerCurve = .continuous) -> Chain<Base> {
		self.do {
			$0.layer.cornerRadius = radius
            $0.layer.cornerCurve = style
			$0.clipsToBounds = true
		}
	}

	func alpha(_ value: CGFloat) -> Chain<Base> {
		self.do {
			$0.alpha = value
		}
	}

	func backgroundColor(_ color: UIColor?) -> Chain<Base> {
		self.do {
			$0.backgroundColor = color
		}
	}

	func clipped(_ isClipped: Bool = true) -> Chain<Base> {
		self.do {
			$0.clipsToBounds = isClipped
		}
	}

	func userInteractionEnabled(_ isUserInteractionEnabled: Bool = true) -> Chain<Base> {
		self.do {
			$0.isUserInteractionEnabled = isUserInteractionEnabled
		}
	}

	func contentMode(_ mode: UIView.ContentMode) -> Chain<Base> {
		self.do {
			$0.contentMode = mode
		}
	}

	func hidden(_ isHidden: Bool = true) -> Chain<Base> {
		self.do {
			$0.isHidden = isHidden
		}
	}

	func border(color: UIColor, width: CGFloat) -> Chain<Base> {
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
	) -> Chain<Base> {
		self.do {
			$0.layer.shadowColor = color.cgColor
			$0.layer.shadowOpacity = opacity
			$0.layer.shadowOffset = offset
			$0.layer.shadowRadius = radius
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
			$0.directionalLayoutMargins += other.reduce(into: insets, +=)
		}
	}

	func restorationID(_ id: String) -> Chain<Base> {
		self.do {
			$0.restorationIdentifier = id
		}
	}

	func restorationID(file: String = #fileID, line: UInt = #line, function: String = #function) -> Chain<Base> {
		self.do {
			$0.setRestorationID(fileID: file, line: line, function: function)
		}
	}

	func restorationIDIfNeeded(file: String = #fileID, line: UInt = #line, function: String = #function) -> Chain<Base> {
		self.do {
			if $0.restorationIdentifier == nil {
				$0.setRestorationID(fileID: file, line: line, function: function)
			}
		}
	}
}

public extension Chain where Base.Root: UIView, Base: ValueChaining {

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
	}
}

public extension Chain where Base.Root: UIView {

	func subview(
		@SubviewBuilder subview: () -> any Subview
	) -> Chain<Base> {
		let installer = subview().subviewInstaller
		return on { root, _ in
			installer.install(on: root)
		} configure: { root, _ in
			installer.configure(on: root)
		}
	}
}
