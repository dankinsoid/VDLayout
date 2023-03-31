import SwiftUI

public struct CellsSection: Identifiable {
	
	public var id: String
	public var header: String?
	public var footer: String?
	
	let cells: [ViewCellProtocol]
	
	public init<Cell>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		cells: [ViewCell<Cell>]
	) {
		self.id = id
		self.header = header
		self.footer = footer
		self.cells = Array(cells)
	}
	
	public init<Data: Collection, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		cellID: (Data.Element) -> String,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.init(
			id: id,
			header: header,
			footer: footer,
			cells: data.map { data in
				ViewCell(id: cellID(data)) {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	public init<Data: Collection, Cell: View>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		cellID: (Data.Element) -> String,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data,
			cellID: cellID
		) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
	
	public init<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) where Data.Element: Identifiable<ID> {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data,
			cellID: \.id.description,
			create: create,
			reload: reload
		)
	}
	
	public init<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) where Data.Element: Identifiable<ID> {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data
		) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
	
	public init<Data: Collection, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		@ValueBuilder<Cell> create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.init(
			id: id,
			header: header,
			footer: footer,
			cells: data.enumerated().map { index, data in
				ViewCell(id: "\(index)") {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	public init<Data: Collection, Cell: View>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data
		) {
			HostingView(create($0))
		} reload: {
			$0.rootView = create($1)
		}
	}
}
