import UIKit

protocol ViewCellProtocol {
	
	var id: String? { get }
	var type: Any.Type { get }
	func createView() -> UIView
	func reloadView(_ view: UIView)
}

extension ViewCellProtocol {
	
	var typeIdentifier: String {
		String(reflecting: type)
	}
}

public struct ViewCell<Cell: UIView>: ViewCellProtocol {
	
	let create: () -> Cell
	let reload: (Cell) -> Void
	let id: String?
	var type: Any.Type { Cell.self }
	
	public init(
		id: String? = nil,
		create: @escaping () -> Cell,
		reload: @escaping (Cell) -> Void
	) {
		self.id = id
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
