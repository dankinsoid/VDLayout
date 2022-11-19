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
    
    public convenience init(_ title: String, type: ButtonType = .system, action: @escaping () -> Void) {
        self.init(type: type)
        setTitle(title, for: .normal)
        setAction(action)
    }
    
    public func setAction(_ action: @escaping () -> Void) {
        if let actions = objc_getAssociatedObject(self, &buttonActionsKey) as? ButtonActions {
            actions.action = action
            return
        }
        let actions = ButtonActions()
        actions.action = action
        addTarget(actions, action: #selector(ButtonActions.objcAction), for: .touchUpInside)
        objc_getAssociatedObject(self, &buttonActionsKey)
    }
    
    public func addAction(_ action: @escaping () -> Void) {
        guard let actions = objc_getAssociatedObject(self, &buttonActionsKey) as? ButtonActions else {
            setAction(action)
            return
        }
        let oldAction = actions.action
        actions.action = {
            oldAction()
            action()
        }
    }
}

private final class ButtonActions {
    
    var action: () -> Void = {}

    @objc func objcAction() {
        action()
    }
}

private var buttonActionsKey = "buttonActionsKey"
