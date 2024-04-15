import UIKit
import VDChain

public extension Chain where Base.Root: UIControl {
    
    func onTap(replace: Bool = false, _ action: @escaping () -> Void) -> Chain<Base> {
        on(.touchUpInside, action)
    }

    func on(_ event: UIControl.Event, replace: Bool = false, _ action: @escaping () -> Void) -> Chain<Base> {
        self.do {
            if replace {
                $0.setAction(for: event, action)
            } else {
                $0.addAction(for: event, action)
            }
        }
    }
}
