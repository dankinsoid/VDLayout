import UIKit
import VDChain
import VDPin

public extension Chain where Base.Root: UIScrollView {
    
    func bounces(_ axis: NSLayoutConstraint.AxisSet = .both) -> Chain<DoChain<Base>> {
        self.do {
            $0.alwaysBounceVertical = axis.contains(.vertical)
            $0.alwaysBounceHorizontal = axis.contains(.horizontal)
        }
    }
    
    func showsIndicators(_ axis: NSLayoutConstraint.AxisSet = .both) -> Chain<DoChain<Base>> {
        self.do {
            $0.showsVerticalScrollIndicator = axis.contains(.vertical)
            $0.showsHorizontalScrollIndicator = axis.contains(.horizontal)
        }
    }
    
    func hideIndicators() -> Chain<DoChain<Base>> {
        showsIndicators([])
    }
    
    func paging(isEnabled: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isPagingEnabled = isEnabled
        }
    }
    
    func multitouch(isEnabled: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isMultipleTouchEnabled = isEnabled
        }
    }
    
    func directionalLock(isEnabled: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isDirectionalLockEnabled = isEnabled
        }
    }
}
