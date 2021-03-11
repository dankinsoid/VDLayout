//
//  StickyLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-08-31.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct StickyLayout: Layout {
	let rootLayout: Layout
  public var isStickyFn: (Int) -> Bool
  var stickyFrames: [(index: Int, frame: CGRect)] = []
  var visibleFrame: CGRect = .zero
  var topFrameIndex: Int = 0
	
	public var contentSize: CGSize {
		rootLayout.contentSize
	}

  public init(_ rootLayout: Layout, isStickyFn: @escaping (Int) -> Bool = { $0 % 2 == 0 }) {
    self.isStickyFn = isStickyFn
		self.rootLayout = rootLayout
  }

  public func layout(context: LayoutContext) -> Layout {
    let stickyFrames = (0..<context.numberOfItems).filter {
      isStickyFn($0)
    }.map {
      (index: $0, frame: rootLayout.frame(at: $0))
    }
		let topFrameIndex = stickyFrames.binarySearch { $0.frame.minY < visibleFrame.minY } - 1
		var result = StickyLayout(rootLayout.layout(context: context))
		result.stickyFrames = stickyFrames
		result.visibleFrame = CGRect(center: .zero, size: context.collectionSize)
		result.topFrameIndex = topFrameIndex
		result.isStickyFn = isStickyFn
		return result
  }

  public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
    if let index = stickyFrames.get(topFrameIndex)?.index, index >= 0 {
      var oldVisible = rootLayout.visibleIndexes(visibleFrame: visibleFrame)
      if let index = oldVisible.firstIndex(of: index) {
        oldVisible.remove(at: index)
      }
      return oldVisible + [index]
    }
    return rootLayout.visibleIndexes(visibleFrame: visibleFrame)
  }

  public func frame(at: Int) -> CGRect {
    let superFrame = rootLayout.frame(at: at)
    if superFrame.minY < visibleFrame.minY, let index = stickyFrames.get(topFrameIndex)?.index, index == at {
      let pushedY: CGFloat
      if topFrameIndex < stickyFrames.count - 1 {
        pushedY = rootLayout.frame(at: stickyFrames[topFrameIndex + 1].index).minY - superFrame.height
      } else {
        pushedY = visibleFrame.maxY - superFrame.height
      }
      return CGRect(origin: CGPoint(x: superFrame.minX, y: min(visibleFrame.minY, pushedY)), size: superFrame.size)
    }
    return superFrame
  }
}
