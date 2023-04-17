import UIKit
import VDPin
import VDChain

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
			reloadData(oldValue: oldValue)
		}
	}
	
	public var isAnimated = false
	
	public weak var tableView: UITableView? {
		didSet {
			guard let tableView, tableView !== oldValue else { return }
			prepareTableView()
		}
	}
	
	public var insertAnimation: UITableView.RowAnimation = .automatic
	public var removeAnimation: UITableView.RowAnimation = .automatic
	public var reloadAnimation: UITableView.RowAnimation = .none
	public var maxAnimatableCount = 1_000
	public var animateFirstReload = false
	
	private var registeredIDs: Set<String> = []
	private var isFirstAnimation = true
	
	public init(isAnimated: Bool = false) {
		self.isAnimated = isAnimated
	}
	
	public func reloadData() {
		tableView?.reloadData()
	}
	
	public func reload(
		cells: [ViewCell]
	) {
		sections = [
			CellsSection(id: "main", cells: cells)
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

extension UITableViewSource: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = CGSize(width: tableView.frame.width, height: tableView.rowHeight)
        return sections[indexPath.section].cells[indexPath.row].size(size).height
    }
}

private extension UITableViewSource {
	
	func reloadData(oldValue: [CellsSection]) {
		guard let tableView else { return }
		defer {
			isFirstAnimation = false
		}
		guard
			isAnimated,
			tableView.window != nil,
			!(isFirstAnimation && !animateFirstReload),
			(sections + oldValue).reduce(0, { $1.cells.count + $0 }) < maxAnimatableCount * 2
		else {
			tableView.reloadData()
			return
		}
		let contentOffsetBeforeUpdates = tableView.contentOffset
		let sectionChanges = computeChanges(oldData: oldValue, newData: sections)
		var updates: [(IndexPath, IndexPath)] = []
		
		tableView.performBatchUpdates {
			if !sectionChanges.deletions.isEmpty {
				tableView.deleteSections(IndexSet(sectionChanges.deletions), with: insertAnimation)
			}
			if !sectionChanges.insertions.isEmpty {
				tableView.insertSections(IndexSet(sectionChanges.insertions), with: removeAnimation)
			}
			var deletions: [IndexPath] = []
			var insertions: [IndexPath] = []
			for (oldIndex, newIndex) in sectionChanges.moves {
				if oldIndex != newIndex {
					tableView.moveSection(oldIndex, toSection: newIndex)
				}
				
				let changeset = computeChanges(oldData: oldValue[oldIndex].cells, newData: sections[newIndex].cells)
				deletions.append(contentsOf: changeset.deletions.map { IndexPath(row: $0, section: oldIndex) })
				insertions.append(contentsOf: changeset.insertions.map { IndexPath(row: $0, section: newIndex) })
				
				for (oldRaw, newRaw) in changeset.moves {
					let (old, new) = (
						IndexPath(row: oldRaw, section: oldIndex),
						IndexPath(row: newRaw, section: newIndex)
					)
					if oldRaw != newRaw {
						tableView.moveRow(at: old, to: new)
					}
					updates.append((old, new))
				}
			}
			
			if !deletions.isEmpty {
				tableView.deleteRows(at: deletions, with: insertAnimation)
			}
			
			if !insertions.isEmpty {
				tableView.insertRows(at: insertions, with: removeAnimation)
			}
			
			let reloads = updates.filter {
				oldValue[$0.0.section].cells[$0.0.row].type != sections[$0.1.section].cells[$0.1.row].type
			}
			updates = updates.filter {
				oldValue[$0.0.section].cells[$0.0.row].type == sections[$0.1.section].cells[$0.1.row].type
			}
			if !reloads.isEmpty {
				tableView.reloadRows(at: reloads.map(\.1), with: reloadAnimation)
			}
		}
		if !updates.isEmpty {
			tableView.performBatchUpdates {
				for update in updates {
					let cell = tableView.cellForRow(at: update.1) as? AnyTableViewCell
					cell?.reload(cell: sections[update.1.section].cells[update.1.row])
				}
			}
		}
		tableView._setAdjustedContentOffsetIfNeeded(contentOffsetBeforeUpdates)
	}
	
	func prepareTableView() {
		guard let tableView else { return }
		tableView.dataSource = self
        if tableView.delegate == nil {
            tableView.delegate = self
        }
		registeredIDs = []
	}
	
	func registerIfNeeded(cell: ViewCell) {
		guard !registeredIDs.contains(cell.typeIdentifier) else { return }
		tableView?.register(AnyTableViewCell.self, forCellReuseIdentifier: cell.typeIdentifier)
		registeredIDs.insert(cell.typeIdentifier)
	}
	
	func computeChanges<Data: Identifiable>(oldData: [Data], newData: [Data]) -> (deletions: [Int], insertions: [Int], moves: [(Int, Int)]) {
		
		// Compute the deletions
		let newIDs = Set(newData.map(\.id))
		let deletions = oldData.enumerated().filter { !newIDs.contains($0.element.id) }.map { $0.offset }
		
		// Compute the insertions
		let oldIDs = Set(oldData.map(\.id))
		let insertions = newData.enumerated().filter { !oldIDs.contains($0.element.id) }.map { $0.offset }
		
		// Compute the modifications
		let moves = oldData.enumerated().compactMap { i, old in
			if let newIndex = newData.firstIndex(where: { $0.id == old.id }) {
				return (i, newIndex)
			} else {
				return nil
			}
		}
		
		return (deletions, insertions, moves)
	}
}

private final class AnyTableViewCell: UITableViewCell {
	
	private var cellView: UIView?
	
	func reload(cell: ViewCell) {
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
