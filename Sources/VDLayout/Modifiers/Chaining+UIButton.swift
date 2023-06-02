import UIKit
import VDChain

public extension Chain where Base.Root: UIButton {

	func insets(
		title: UIEdgeInsets,
		image: UIEdgeInsets = .zero
	) -> Chain<DoChain<Base>> {
		self.do {
			$0.contentEdgeInsets = UIEdgeInsets(
				top: title.top + image.top,
				left: title.left + image.right,
				bottom: title.bottom + image.bottom,
				right: title.right + image.right
			)
			$0.titleEdgeInsets = UIEdgeInsets(
				top: -title.top,
				left: -title.left,
				bottom: -title.bottom,
				right: -title.right
			)
			$0.imageEdgeInsets = UIEdgeInsets(
				top: -image.top,
				left: -image.left,
				bottom: -image.bottom,
				right: -image.right
			)
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

	func horizontalAlignment(_: NSTextAlignment) -> Chain<DoChain<Base>> {
		self.do {
			$0.contentHorizontalAlignment = .left
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

			if let spacing {
				$0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
				$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
			}
		}
	}

	func onTap(_ action: @escaping () -> Void) -> Chain<DoChain<Base>> {
		self.do {
			$0.addAction(action)
		}
	}
}
