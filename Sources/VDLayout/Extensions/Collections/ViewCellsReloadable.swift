import SwiftUI
import UIKitViews

public protocol ViewCellsReloadable {

	func reload(
		cells: [ViewCell]
	)
}

public extension ViewCellsReloadable {

	func reload(@ViewCellsBuilder _ cells: () -> [ViewCell]) {
		reload(cells: cells())
	}

	func reload<Data: Collection, Cell: UIView>(
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
	) {
		self.reload(
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

	func reload<Data: Collection, Cell: View>(
		data: Data,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		reload(data: data) {
			HostingView(create($0))
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}

	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		data: Data,
		id: (Data.Element) -> ID,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
	) {
		self.reload(
			cells: data.map { data in
				ViewCell(id: id(data).description) {
					create(data)
				} reload: {
					reload($0, data)
				} size: {
					size($0, data)
				}
			}
		)
	}

	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		data: Data,
		id: (Data.Element) -> ID,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) {
		reload(data: data, id: id) {
			HostingView(create($0))
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}

	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: UIView>(
		data: Data,
		create: @escaping (Data.Element) -> Cell,
		reload: @escaping (Cell, Data.Element) -> Void,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		}
	) where Data.Element: Identifiable<ID> {
		self.reload(
			data: data,
			id: \.id.description,
			create: create,
			reload: reload,
			size: size
		)
	}

	func reload<Data: Collection, ID: Hashable & CustomStringConvertible, Cell: View>(
		data: Data,
		size: @escaping (CGSize, Data.Element) -> CGSize = { rect, _ in
			rect
		},
		@ViewBuilder create: @escaping (Data.Element) -> Cell
	) where Data.Element: Identifiable<ID> {
		reload(data: data) {
			HostingView(create($0))
		} reload: { (cell: HostingView<Cell>, data) in
			cell.rootView = create(data)
		} size: {
			size($0, $1)
		}
	}
}
