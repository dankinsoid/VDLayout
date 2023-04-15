import UIKit

extension UIStackView: ViewCellsReloadable {
	
	public func reload(
		cells: [ViewCell]
	) {
		var subviews = arrangedSubviews
		for cell in cells {
			if let i = firstMatch(for: cell, subviews: subviews) {
				let subview = subviews[i]
				subviews.remove(at: i)
				addArrangedSubview(subview)
				cell.reloadView(subview)
			} else {
				let subview = cell.createView()
				subview.accessibilityIdentifier = cell.id
				addArrangedSubview(subview)
				cell.reloadView(subview)
			}
		}
		subviews.forEach {
			$0.removeFromSuperview()
		}
	}
	
	private func firstMatch(for cell: ViewCell, subviews: [UIView]) -> Int? {
		let result = subviews.firstIndex {
			$0.accessibilityIdentifier == cell.id
		}
		return result ?? subviews.firstIndex {
			cell.type == type(of: $0)
		}
	}
}
