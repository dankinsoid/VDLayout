//
//  ComposeLayout.swift
//  VDKitFix
//
//  Created by Данил Войдилов on 07.03.2021.
//

import UIKit
import VDKit

public struct ComposeLayout: CollectionLayout {
	public var contentSize: CGSize { layout.contentSize }
	public var layout: CollectionLayout
	public var new: (Int) -> [CollectionLayout]
	public var layouts: [CollectionLayout]
	public var countAt: (_ index: Int, _ common: Int) -> Int
	public var indexPathAt: (Int) -> IndexPath
	public var indexAt: (IndexPath) -> Int
	public var maxSizeAt: (Int, CGSize) -> CGSize
	
	public init(_ layout: CollectionLayout, new: @escaping (_ common: Int) -> [CollectionLayout], countAt: @escaping (_ index: Int, _ common: Int) -> Int, indexPath: @escaping (Int) -> IndexPath, index: @escaping (IndexPath) -> Int, maxSize: @escaping (Int, CGSize) -> CGSize) {
		self.layout = layout
		self.layouts = []
		self.countAt = countAt
		self.indexPathAt = indexPath
		self.indexAt = index
		self.new = new
		self.maxSizeAt = maxSize
	}
	
	func _layout(context: LayoutContext) -> ComposeLayout {
		_layout(
			context: PathsLayoutContext(
				collectionSize: context.collectionSize,
				numberOfItems: context.numberOfItems,
				ids: { context.identifier(at: indexAt($0)) },
				sizes: { context.size(at: indexAt($0), collectionSize: $1) }
			)
		)
	}
	
	public func layout(context: LayoutContext) -> CollectionLayout {
		_layout(context: context)
	}
	
	public func layout(context: PathsLayoutContext) -> CollectionLayout {
		_layout(context: context)
	}
	
	func _layout(context: PathsLayoutContext) -> ComposeLayout {
		let newItems = new(context.numberOfItems)
		let _new = newItems.enumerated()
		let scan = _new.scan(0, { $0 + countAt($1.offset, context.numberOfItems) })
		let maxI = scan.firstIndex(where: { $0 > context.numberOfItems })
		let newLayouts = _new.prefix(maxI.map { $0 + 1 } ?? newItems.count).map { args in
			args.element.layout(
				context: Context(
					collectionSize: maxSizeAt(args.offset, context.collectionSize),
					numberOfItems: args.offset == maxI ?
						context.numberOfItems - (scan[safe: args.offset - 1] ?? 0) :
						countAt(args.offset, context.numberOfItems),
					ids: { context.identifier(at: IndexPath(row: $0, section: args.offset)) },
					sizes: { i, size in
						context.size(at: IndexPath(row: i, section: args.offset), collectionSize: size)
					}
				)
			)
		}
		let baseLayout = layout.layout(
			context: Context(
				collectionSize: context.collectionSize,
				numberOfItems: newLayouts.count,
				ids: { $0 },
				sizes: { i, _ in
					newLayouts[i].contentSize
				}
			)
		)
		var result = ComposeLayout(baseLayout, new: new, countAt: countAt, indexPath: indexPathAt, index: indexAt, maxSize: maxSizeAt)
		result.layouts = newLayouts
		return result
	}
	
	public func frame(at: Int) -> CGRect {
		frame(at: indexPathAt(at))
	}
	
	public func frame(at path: IndexPath) -> CGRect {
		let ltFrame = layout.frame(at: path.section)
		var frame = layouts[safe: path.section]?.frame(at: path.row) ?? .zero
		frame.origin += ltFrame.origin
		return frame
	}
	
	public func visiblePaths(visibleFrame: CGRect) -> [IndexPath] {
		layout.visibleIndexes(visibleFrame: visibleFrame).map { i -> [IndexPath] in
			let lt = layouts[i]
			let ltFrame = layout.frame(at: i)
			var frame = ltFrame.intersection(visibleFrame)
			frame.origin -= ltFrame.origin
			return lt.visibleIndexes(visibleFrame: frame).map {
				IndexPath(row: $0, section: i)
			}
		}.joinedArray()
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		visiblePaths(visibleFrame: visibleFrame).map(indexAt)
	}
	
}

extension ComposeLayout {
	
	public static func one(_ layout: CollectionLayout) -> ComposeLayout {
		ComposeLayout(
			SimpleLayout(),
			new: { _ in [layout] },
			countAt: { _, common in common },
			indexPath: { IndexPath(row: $0, section: 0) },
			index: { $0.row },
			maxSize: { _, size in size }
		)
	}
	
	public static func equal(_ layout: CollectionLayout, each: @escaping (Int) -> CollectionLayout, by count: Int, maxSize: @escaping (Int, CGSize) -> CGSize = { _, s in s }) -> ComposeLayout {
		ComposeLayout(
			layout,
			new: {
				guard $0 > 0, count > 0 else { return [] }
				return (0..<Int(ceil(Double($0) / Double(count)))).map(each)
			},
			countAt: { i, common in
				count
			},
			indexPath: {
				guard count > 0 else { return IndexPath() }
				return IndexPath(row: $0 % count, section: $0 / count)
			},
			index: {
				$0.section * count + $0.row
			},
			maxSize: maxSize
		)
	}
	
	public static func sectioned(_ layout: CollectionLayout, section: @escaping (_ section: Int) -> CollectionLayout, for collection: UICollectionView) -> ComposeLayout {
		ComposeLayout(
			layout,
			new: {[weak collection] _ in
				(0...(collection?.numberOfSections ?? 0)).dropLast().map(section)
			},
			countAt: {[weak collection] section, _ in
				collection?.numberOfItems(inSection: section) ?? 0
			},
			indexPath: {[weak collection] i in
				guard let coll = collection else { return IndexPath() }
				return
					(0...coll.numberOfSections)
					.dropLast()
					.lazy
					.map {[weak coll] s in
						(coll?.numberOfItems(inSection: s)).map { (0...$0).dropLast().map { (s, $0) } } ?? []
					}
					.joined()
					.prefix(i + 1)
					.map {
						IndexPath(row: $0.1, section: $0.0)
					}
					.last ?? IndexPath()
			},
			index: {[weak collection] path in
				(0...path.section).dropLast().reduce(0, { $0 + (collection?.numberOfItems(inSection: $1) ?? 0) }) + path.row
			},
			maxSize: { _, size in size }
		)
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

public struct PathsLayoutContext {
	public var collectionSize: CGSize
	public var numberOfItems: Int
	public var ids: (IndexPath) -> AnyHashable
	public var sizes: (IndexPath, CGSize) -> CGSize
	
	public func identifier(at: IndexPath) -> AnyHashable {
		ids(at)
	}
	
	public func size(at indexPath: IndexPath, collectionSize: CGSize) -> CGSize {
		sizes(indexPath, collectionSize)
	}
}
