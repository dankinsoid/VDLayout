import UIKit

extension UIStackView: ViewCellsReloadable {
	
	public func reload<Cell>(
		cells: [ViewCell<Cell>]
	) {
		var subviews = arrangedSubviews
		for cell in cells {
			if let i = subviews.firstIndex(where: { $0.accessibilityIdentifier == cell.identifier }) {
				let subview = subviews[i]
				subviews.remove(at: i)
				addArrangedSubview(subview)
				cell.reloadView(subview)
			} else {
				let subview = cell.createView()
				subview.accessibilityIdentifier = cell.identifier
				addArrangedSubview(subview)
				cell.reloadView(subview)
			}
		}
		subviews.forEach {
			$0.removeFromSuperview()
		}
	}
}
