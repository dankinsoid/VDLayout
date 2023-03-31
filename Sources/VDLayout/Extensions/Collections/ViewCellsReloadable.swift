import SwiftUI

public protocol ViewCellsReloadable {
	
	func reload<Cell: UIView>(
		cells: [ViewCell<Cell>]
	)
}

public extension ViewCellsReloadable {
	
	func reload<Data: Collection, Cell: UIView>(
		data: Data,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.reload(
			cells: data.enumerated().map { index, data in
				ViewCell<Cell>(id: "\(index)") {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	func reload<Data: Collection, Cell: View>(
		data: Data,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		reload(data: data) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
	
	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		data: Data,
		id: (Data.Element) -> ID,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.reload(
			cells: data.map { data in
				ViewCell<Cell>(id: id(data).description) {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	
	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		data: Data,
		id: (Data.Element) -> ID,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		reload(data: data, id: id) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
	
	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		data: Data,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) where Data.Element: Identifiable<ID> {
		self.reload(
			data: data,
			id: \.id.description,
			create: create,
			reload: reload
		)
	}
	
	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		data: Data,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) where Data.Element: Identifiable<ID> {
		reload(data: data) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
}
