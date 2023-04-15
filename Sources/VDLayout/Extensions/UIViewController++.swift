import UIKit

extension UIViewController: SingleSubview {
    
    public var subviewInstaller: any SubviewInstaller {
        UIViewControllerInstaller(self)
    }
}

private struct UIViewControllerInstaller: SubviewInstaller {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func install(on superview: UIView?) {
        let parent = superview?.controller
        if parent == nil {
            debugPrint("Attempt to add UIViewController \(type(of: viewController)) to UIView \(type(of: superview)) when UIView's controller is not determined")
        }
        if let parent {
            viewController.willMove(toParent: parent)
        }
        viewController.view.subviewInstaller.install(on: superview)
    }
    
    func configure(on superview: UIView?) {
        guard let parent = superview?.controller else {
            return
        }
        parent.addChild(viewController)
        viewController.didMove(toParent: parent)
    }
}
