import SwiftUI
import UIKitViews

public struct CellsSection: Identifiable {

	public var id: String
	public var header: String?
	public var footer: String?
	public let cells: [ViewCell]

	public init(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		cells: [ViewCell]
	) {
		self.id = id
		self.header = header
		self.footer = footer
		self.cells = Array(cells)
	}

	public init(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		@ViewCellsBuilder _ cells: () -> [ViewCell]
	) {
		self.init(id: id, header: header, footer: footer, cells: cells())
	}

	public init<Data: Collection, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		cellID: (Data.Element) -> String,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
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
				} size: {
					size($0, data)
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
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
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
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}

	public init<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
	) where Data.Element: Identifiable<ID> {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data,
			cellID: \.id.description,
			create: create,
			reload: reload,
			size: size
		)
	}

	public init<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) where Data.Element: Identifiable<ID> {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data
		) {
			HostingView(create($0))
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}

	public init<Data: Collection, Cell: UIView>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
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
				} size: {
					size($0, data)
				}
			}
		)
	}

	public init<Data: Collection, Cell: View>(
		id: String,
		header: String? = nil,
		footer: String? = nil,
		data: Data,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		self.init(
			id: id,
			header: header,
			footer: footer,
			data: data
		) {
			HostingView(create($0))
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}
}
