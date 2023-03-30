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
	
	func reload<Data: Collection, Cell: UIView>(
		data: Data,
		id: (Data.Element) -> String,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.reload(
			cells: data.map { data in
				ViewCell<Cell>(id: id(data)) {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) where Data.Element: Identifiable<ID> {
		self.reload(
			data: data,
			id: \.id.description,
			create: create,
			reload: reload
		)
	}
}
