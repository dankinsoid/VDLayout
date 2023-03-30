import UIKit
import VDPin

public extension UITableView {
	
	convenience init(
		_ source: UITableViewSource
	) {
		self.init()
		rowHeight = UITableView.automaticDimension
		sectionFooterHeight = 0.001
		sectionHeaderHeight = 0.001
		separatorColor = .clear
		source.tableView = self
	}
	
	convenience init(
		_ source: UITableViewSource,
		@CellsSectionsBuilder sections: () -> [CellsSection]
	) {
		self.init(source)
		source.sections = sections()
	}
}

public final class UITableViewSource: NSObject, UITableViewDataSource, ViewCellsReloadable {
	
	public var sections: [CellsSection] = [] {
		didSet {
			reloadData()
		}
	}
	
	public weak var tableView: UITableView? {
		didSet {
			guard let tableView, tableView !== oldValue else { return }
			prepareTableView()
		}
	}
	
	private var registeredIDs: Set<String> = []
	
	public func reloadData() {
		tableView?.reloadData()
	}
	
	public func reload<Cell>(
		cells: [ViewCell<Cell>]
	) {
		self.sections = [
			CellsSection(cells: cells)
		]
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		sections[section].cells.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let section = sections[indexPath.section]
		let cell = section.cells[indexPath.row]
		registerIfNeeded(cell: cell)
		guard let cellView = tableView.dequeueReusableCell(withIdentifier: cell.typeIdentifier, for: indexPath) as? AnyTableViewCell else {
			return UITableViewCell()
		}
		cellView.reload(cell: cell)
		return cellView
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		sections.count
	}
	
	public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		sections[section].header
	}

	public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		sections[section].footer
	}

//	public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//	}
//
//	public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//
//	}
//
//	public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//
//	}
//
//	public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//
//	}
//
//	public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//	}
//
//	public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//
//	}
}

private extension UITableViewSource {
	
	func prepareTableView() {
		guard let tableView else { return }
		tableView.dataSource = self
		registeredIDs = []
	}
	
	func registerIfNeeded(cell: ViewCellProtocol) {
		guard !registeredIDs.contains(cell.typeIdentifier) else { return }
		tableView?.register(AnyTableViewCell.self, forCellReuseIdentifier: cell.typeIdentifier)
		registeredIDs.insert(cell.typeIdentifier)
	}
}

private final class AnyTableViewCell: UITableViewCell {
	
	private var cellView: UIView?
	
	func reload(cell: ViewCellProtocol) {
		guard cell.typeIdentifier == reuseIdentifier else { return }
		let view: UIView
		if let cellView {
			view = cellView
		} else {
			view = cell.createView()
			add(view: view)
			cellView = view
		}
		cell.reloadView(view)
	}
	
	private func add(view: UIView) {
		contentView.add(subview: view)
		view.pin(.edges)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}
