import UIKit

extension UIButton {
    
    public var title: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    public var titles: UIControl.States<String> {
        UIControl.States(get: title, set: setTitle)
    }
    
    public var image: UIImage? {
        get { image(for: .normal) }
        set { setImage(newValue, for: .normal) }
    }
    
    public var images: UIControl.States<UIImage> {
        UIControl.States(get: image, set: setImage)
    }
    
    public var backgroundImage: UIImage? {
        get { backgroundImage(for: .normal) }
        set { setBackgroundImage(newValue, for: .normal) }
    }
    
    public var backgroundImages: UIControl.States<UIImage> {
        UIControl.States(get: backgroundImage, set: setBackgroundImage)
    }
    
    public var titleColor: UIColor? {
        get { titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    public var titleColors: UIControl.States<UIColor> {
        UIControl.States(get: titleColor, set: setTitleColor)
    }
}
