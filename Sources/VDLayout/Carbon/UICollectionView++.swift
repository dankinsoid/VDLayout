//
//  File.swift
//  
//
//  Created by Данил Войдилов on 07.03.2021.
//

import UIKit

//open class CollectionLayout: UICollectionViewFlowLayout {
//
//}
//
//open class SimpleLayout {
//	var _contentSize: CGSize = .zero
//	public private(set) var frames: [CGRect] = []
//
//	open func simpleLayout(context: LayoutContext) -> [CGRect] {
//
//	}
//	
//	open func doneLayout() {
//
//	}
//
//	open func layout(context: LayoutContext) {
//		frames = simpleLayout(context: context)
//		_contentSize = frames.reduce(CGRect.zero) { (old, item) in
//			old.union(item)
//		}.size
//		doneLayout()
//	}
//
//	open var contentSize: CGSize {
//		return _contentSize
//	}
//
//	open func frame(at: Int) -> CGRect {
//		return frames[at]
//	}
//
//	open func visibleIndexes(visibleFrame: CGRect) -> [Int] {
//		var result = [Int]()
//		for (i, frame) in frames.enumerated() {
//			if frame.intersects(visibleFrame) {
//				result.append(i)
//			}
//		}
//		return result
//	}
//}
//
//public protocol LayoutContext {
//	var collectionSize: CGSize { get }
//	var numberOfItems: Int { get }
//	func data(at: Int) -> Any
//	func identifier(at: Int) -> String
//	func size(at index: Int, collectionSize: CGSize) -> CGSize
//}
