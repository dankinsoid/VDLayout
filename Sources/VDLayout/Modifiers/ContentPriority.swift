import UIKit
import VDChain

public extension Chain where Base.Root: UIView {

	func contentPriority(
		_ priority: UILayoutPriority,
		axis: NSLayoutConstraint.AxisSet = .both,
		type: UIView.LayoutPriorityDirectionSet = .both
	) -> Chain<DoChain<Base>> {
		self.do {
			$0.set(contentPriority: priority, axis: axis, type: type)
		}
	}
}
