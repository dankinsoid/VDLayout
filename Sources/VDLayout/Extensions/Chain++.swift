import UIKit
import VDChain

extension Chain: SubviewProtocol where Base.Root: SubviewProtocol & AnyObject, Base: ValueChaining {
    
    public func createViewToAdd() -> UIView {
        base.root.createViewToAdd()
    }
    
    public func configureAfterAddToSuperview() {
        _ = apply()
    }
}
