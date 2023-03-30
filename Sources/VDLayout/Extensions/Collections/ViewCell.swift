import UIKit

protocol ViewCellProtocol {
	
	var identifier: String { get }
	func createView() -> UIView
	func reloadView(_ view: UIView)
}

public struct ViewCell<Cell: UIView>: ViewCellProtocol {
	
	let create: () -> Cell
	let reload: (Cell) -> Void
	let identifier: String
	
	public init(
		identifier: String? = nil,
		create: @escaping () -> Cell,
		reload: @escaping (Cell) -> Void
	) {
		self.identifier = identifier ?? String(reflecting: Cell.self)
		self.create = create
		self.reload = reload
	}
	
	func createView() -> UIView {
		create()
	}
	
	func reloadView(_ view: UIView) {
		guard let cell = view as? Cell else {
			return
		}
		reload(cell)
	}
}
