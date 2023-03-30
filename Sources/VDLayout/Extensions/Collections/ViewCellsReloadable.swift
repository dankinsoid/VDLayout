import UIKit

public protocol ViewCellsReloadable {
	
	func reload<Cell: UIView>(
		cells: [ViewCell<Cell>]
	)
}

public extension ViewCellsReloadable {
	
	func reload<Data: Collection, Cell: UIView>(
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.reload(
			cells: data.map { data in
				ViewCell<Cell> {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
}
