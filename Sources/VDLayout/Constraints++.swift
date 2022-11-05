import UIKit
import Combine
import CombineCocoa
import ConstraintsOperators

public typealias AttributableSubview = SubviewProtocol & Attributable

extension Constraints: SubviewProtocol where Item: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		let view = item?.createViewToAdd() ?? UIView()
		view.ignoreAutoresizingMask()
        let disposable = view.cb.movedToWindow.sink { [weak self] in
			self?.isActive = true
		}
        objc_setAssociatedObject(self, &disposeBagKey, disposable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return view
	}
}

private var disposeBagKey = "disposeBag"
