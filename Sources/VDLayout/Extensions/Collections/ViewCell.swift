import SwiftUI

public struct ViewCell: Identifiable {
	
	private let create: () -> UIView
    private let reload: (UIView) -> Void
	public let id: String
	public let type: Any.Type
	
    var typeIdentifier: String {
        String(reflecting: type)
    }
    
    public init<Cell: UIView>(
		id: String,
		create: @escaping () -> Cell,
		reload: @escaping (Cell) -> Void
	) {
        self.init(
            id: id,
            type: Cell.self
        ) {
            create()
        } reload: { view in
            guard let cell = view as? Cell else {
                return
            }
            reload(cell)
        }
	}
	
    public init(id: String, type: Any.Type, create: @escaping () -> UIView, reload: @escaping (UIView) -> Void) {
        self.create = create
        self.reload = reload
        self.id = id
        self.type = type
    }
    
    public func createView() -> UIView {
		create()
	}
	
    public func reloadView(_ view: UIView) {
		reload(view)
	}
}
