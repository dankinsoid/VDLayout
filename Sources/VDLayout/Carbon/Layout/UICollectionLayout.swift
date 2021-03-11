//
//  UICollectionViewLayout.swift
//  VDKitFix
//
//  Created by Данил Войдилов on 07.03.2021.
//

import Foundation
import Carbon
import UIKit

open class UICollectionLayout: UICollectionViewLayout {
	open var layout: Layout
	
	public init(_ layout: Layout) {
		self.layout = layout
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		layout = FlowLayout()
		super.init(coder: coder)
	}
	
	open override var collectionViewContentSize: CGSize {
		layout.contentSize
	}
	
	open override func prepare() {
		super.prepare()
		if let sectioned = layout as? SectionedLayout {
			prepareSectioned(layout: sectioned)
			return
		}
		let sizeAt: (Int, CGSize) -> CGSize?
		let idAt: (Int) -> AnyHashable
		let count = commonCount
		if let adapter = collectionView?.delegate as? UICollectionViewAdapter {
			let cells = adapter.data.reduce([], { $0 + $1.cells })
			idAt = { cells[$0].id }
			sizeAt = {
				cells[$0].component.referenceSize(in: CGRect(origin: .zero, size: $1))
			}
		} else if let cv = collectionView, let delegate = cv.delegate as? UICollectionViewDelegateFlowLayout {
			idAt = { $0 }
			let paths = count > 0 ? indexPaths(for: Array(0..<count)) : [:]
			sizeAt = {[weak delegate] i, _ in
				delegate?.collectionView?(cv, layout: self, sizeForItemAt: paths[i] ?? IndexPath())
			}
		} else {
			idAt = { $0 }
			sizeAt = { _, _ in nil }
		}
		layout = layout.layout(
			context: Context(
				collectionSize: collectionView?.frame.size ?? .zero,
				numberOfItems: count,
				ids: idAt,
				sizes: { sizeAt($0, $1) ?? .zero }
			)
		)
	}
	
	private func prepareSectioned(layout: SectionedLayout) {
		let sizeAt: (IndexPath, CGSize) -> CGSize?
		let idAt: (IndexPath) -> AnyHashable
		let count = commonCount
		if let adapter = collectionView?.delegate as? UICollectionViewAdapter {
			let sections = adapter.data
			idAt = { sections[$0.section].cells[$0.row].id }
			sizeAt = {
				sections[$0.section].cells[$0.row].component.referenceSize(in: CGRect(origin: .zero, size: $1))
			}
		} else if let cv = collectionView, let delegate = cv.delegate as? UICollectionViewDelegateFlowLayout {
			idAt = { $0 }
			sizeAt = {[weak delegate] i, _ in
				delegate?.collectionView?(cv, layout: self, sizeForItemAt: i)
			}
		} else {
			idAt = { $0 }
			sizeAt = { _, _ in nil }
		}
		self.layout = layout.layout(
			context: PathsLayoutContext(
				collectionSize: collectionView?.frame.size ?? .zero,
				numberOfItems: count,
				ids: idAt,
				sizes: { sizeAt($0, $1) ?? .zero }
			)
		)
	}
	
	open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		if let sectionedLayout = layout as? SectionedLayout {
			return sectionedLayout.visiblePaths(visibleFrame: rect).map {
				let result = UICollectionViewLayoutAttributes(forCellWith: $0)
				result.frame = sectionedLayout.frame(at: $0)
				return result
			}
		}
		return indexPaths(for: layout.visibleIndexes(visibleFrame: rect)).map {
			let result = UICollectionViewLayoutAttributes(forCellWith: $0.value)
			result.frame = layout.frame(at: $0.key)
			return result
		}
	}
	
	private func indexPaths(for indexes: [Int]) -> [Int: IndexPath] {
		let sectionsCount = collectionView?.numberOfSections ?? 0
		guard sectionsCount > 0 else { return [:] }
		var result: [Int: IndexPath] = [:]
		var need = Set(indexes)
		var count = 0
		var j = 0
		while j < sectionsCount {
			let this = need.filter { count + (collectionView?.numberOfItems(inSection: j) ?? 0) > $0 }
			this.forEach {
				result[$0] = IndexPath(row: $0 - count, section: j)
			}
			need.subtract(this)
			if need.isEmpty {
				return result
			}
			count += collectionView?.numberOfItems(inSection: j) ?? 0
			j += 1
		}
		return result
	}
	
	open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		let result = UICollectionViewLayoutAttributes(forCellWith: indexPath)
		guard let sectionedLayout = layout as? SectionedLayout else {
			var i = indexPath.row
			if indexPath.section > 0 {
				i += (0..<indexPath.section).reduce(0) { $0 + (collectionView?.numberOfItems(inSection: $1) ?? 0) }
			}
			result.frame = layout.frame(at: i)
			return result
		}
		result.frame = sectionedLayout.frame(at: indexPath)
		return result
	}
	
	private var commonCount: Int {
		let sections = collectionView?.numberOfSections ?? 0
		guard sections > 0 else { return 0 }
		return (0..<sections).reduce(0, { $0 + (collectionView?.numberOfItems(inSection: $1) ?? 0) })
	}
}

private struct Context: LayoutContext {
	var collectionSize: CGSize
	var numberOfItems: Int
	var ids: (Int) -> AnyHashable
	var sizes: (Int, CGSize) -> CGSize
	
	func identifier(at: Int) -> AnyHashable {
		ids(at)
	}
	
	func size(at index: Int, collectionSize: CGSize) -> CGSize {
		sizes(index, collectionSize)
	}
}

extension UICollectionView {
	
	public var layout: Layout {
		get {
			(collectionViewLayout as? UICollectionLayout)?.layout ?? FlowLayout()
		}
		set {
			if let viewLayout = collectionViewLayout as? UICollectionLayout {
				viewLayout.layout = newValue
			} else {
				collectionViewLayout = UICollectionLayout(newValue)
			}
			collectionViewLayout.invalidateLayout()
		}
	}
}
