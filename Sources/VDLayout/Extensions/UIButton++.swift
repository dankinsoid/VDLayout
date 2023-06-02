import UIKit

public extension UIButton {

	var title: String? {
		get { title(for: .normal) }
		set { setTitle(newValue, for: .normal) }
	}

	var titles: UIControl.States<String> {
		UIControl.States(get: title, set: setTitle)
	}

	var image: UIImage? {
		get { image(for: .normal) }
		set { setImage(newValue, for: .normal) }
	}

	var images: UIControl.States<UIImage> {
		UIControl.States(get: image, set: setImage)
	}

	var backgroundImage: UIImage? {
		get { backgroundImage(for: .normal) }
		set { setBackgroundImage(newValue, for: .normal) }
	}

	var backgroundImages: UIControl.States<UIImage> {
		UIControl.States(get: backgroundImage, set: setBackgroundImage)
	}

	var titleColor: UIColor? {
		get { titleColor(for: .normal) }
		set { setTitleColor(newValue, for: .normal) }
	}

	var titleColors: UIControl.States<UIColor> {
		UIControl.States(get: titleColor, set: setTitleColor)
	}

	convenience init(_ title: String, type: ButtonType = .system, action: @escaping () -> Void) {
		self.init(type: type)
		setTitle(title, for: .normal)
		setAction(action)
	}
}
