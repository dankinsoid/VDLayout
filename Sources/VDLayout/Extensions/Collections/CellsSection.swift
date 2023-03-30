import UIKit

public struct CellsSection {
	
	public var header: String?
	public var footer: String?
	
	let cells: [ViewCellProtocol]
	
	public init<Cell>(
		header: String? = nil,
		footer: String? = nil,
		cells: [ViewCell<Cell>]
	) {
		self.header = header
		self.footer = footer
		self.cells = Array(cells)
	}
	
	public init<Data: Collection, Cell: UIView>(
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		id: (Data.Element) -> String,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.init(
			header: header,
			footer: footer,
			cells: data.map { data in
				ViewCell(id: id(data)) {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
	
	public init<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) where Data.Element: Identifiable<ID> {
		self.init(
			header: header,
			footer: footer,
			data: data,
			id: \.id.description,
			create: create,
			reload: reload
		)
	}
	
	public init<Data: Collection, Cell: UIView>(
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void
	) {
		self.init(
			header: header,
			footer: footer,
			cells: data.map { data in
				ViewCell {
					create(data)
				} reload: {
					reload($0, data)
				}
			}
		)
	}
}
