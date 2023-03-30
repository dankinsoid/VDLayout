import UIKit

protocol ViewCellProtocol {
	
	var id: String { get }
	var type: Any.Type { get }
	func createView() -> UIView
	func reloadView(_ view: UIView)
}

extension ViewCellProtocol {
	
	var typeIdentifier: String {
		String(reflecting: type)
	}
	
	var asAny: ViewCell<UIView> {
		ViewCell(id: id, create: createView, reload: reloadView)
	}
}

public struct ViewCell<Cell: UIView>: ViewCellProtocol, Identifiable {
	
	public let create: () -> Cell
	public let reload: (Cell) -> Void
	public let id: String
	public var type: Any.Type { Cell.self }
	
	public init(
		id: String,
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
