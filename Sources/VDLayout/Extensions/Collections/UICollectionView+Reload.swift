import UIKit

public extension UICollectionView {
	
	convenience init(
		_ source: UICollectionViewSource
	) {
		self.init()
		source.collectionView = self
	}
	
	convenience init(
		_ source: UICollectionViewSource,
		@CellsSectionsBuilder sections: () -> [CellsSection]
	) {
		self.init(source)
		source.sections = sections()
	}
}

public final class UICollectionViewSource: NSObject, UICollectionViewDataSource, ViewCellsReloadable {
	
	public var sections: [CellsSection] = [] {
		didSet {
			reloadData()
		}
	}
	
	public weak var collectionView: UICollectionView? {
		didSet {
			guard let collectionView, collectionView !== oldValue else { return }
			prepareCollectionView()
		}
	}
	
	private var registeredIDs: Set<String> = []
	
	public func reloadData() {
		collectionView?.reloadData()
	}
	
	public func reload<Cell>(
		cells: [ViewCell<Cell>]
	) {
		self.sections = [
			CellsSection(cells: cells)
		]
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		sections[section].cells.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let section = sections[indexPath.section]
		let cell = section.cells[indexPath.row]
		registerIfNeeded(cell: cell)
		guard let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? AnyCollectionViewCell else {
			return UICollectionViewCell()
		}
		cellView.reload(cell: cell)
		return cellView
	}
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		sections.count
	}
	
	
//	// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//	@available(iOS 6.0, *)
//	optional func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
//
//
//	@available(iOS 9.0, *)
//	optional func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
//
//	@available(iOS 9.0, *)
//	optional func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
//
//
//	/// Returns a list of index titles to display in the index view (e.g. ["A", "B", "C" ... "Z", "#"])
//	@available(iOS 14.0, *)
//	optional func indexTitles(for collectionView: UICollectionView) -> [String]?
//
//
//	/// Returns the index path that corresponds to the given title / index. (e.g. "B",1)
//	/// Return an index path with a single index to indicate an entire section, instead of a specific item.
//	@available(iOS 14.0, *)
//	optional func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath
}

private extension UICollectionViewSource {
	
	func prepareCollectionView() {
		guard let collectionView else { return }
		collectionView.dataSource = self
		registeredIDs = []
	}
	
	func registerIfNeeded(cell: ViewCellProtocol) {
		guard !registeredIDs.contains(cell.identifier) else { return }
		collectionView?.register(AnyCollectionViewCell.self, forCellWithReuseIdentifier: cell.identifier)
		registeredIDs.insert(cell.identifier)
	}
}

private final class AnyCollectionViewCell: UICollectionViewCell {
	
	private var cellView: UIView?
	
	func reload(cell: ViewCellProtocol) {
		guard cell.identifier == reuseIdentifier else { return }
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
