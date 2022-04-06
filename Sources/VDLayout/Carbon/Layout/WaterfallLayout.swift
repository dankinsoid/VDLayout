//
//  WaterfallLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-08-15.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct WaterfallLayout: CollectionLayout {
	public var contentSize: CGSize { vertical.contentSize }
	public let vertical: VerticalSimpleLayout

  public init(columns: Int = 2, spacing: CGFloat = 0) {
		vertical = VerticalSimpleLayout(SimpleLayout(simpleLayout: { context, _ in
			WaterfallLayout.simpleLayout(context: context, columns: columns, spacing: spacing)
		}))
  }

	private init(vertical: VerticalSimpleLayout) {
		self.vertical = vertical
	}
	
	public func layout(context: LayoutContext) -> CollectionLayout {
		WaterfallLayout(vertical: vertical.vertical(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		vertical.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		vertical.visibleIndexes(visibleFrame: visibleFrame)
	}
	
	static func simpleLayout(context: LayoutContext, columns: Int, spacing: CGFloat) -> [CGRect] {
    var frames: [CGRect] = []

    let columnWidth = (context.collectionSize.width - CGFloat(columns - 1) * spacing) / CGFloat(columns)
    var columnHeight = [CGFloat](repeating: 0, count: columns)

    func getMinColomn() -> (Int, CGFloat) {
      var minHeight: (Int, CGFloat) = (0, columnHeight[0])
      for (index, height) in columnHeight.enumerated() where height < minHeight.1 {
        minHeight = (index, height)
      }
      return minHeight
    }

    for i in 0..<context.numberOfItems {
      var cellSize = context.size(at: i, collectionSize: CGSize(width: columnWidth,
                                                                height: context.collectionSize.height))
      cellSize = CGSize(width: columnWidth, height: cellSize.height)
      let (columnIndex, offsetY) = getMinColomn()
      columnHeight[columnIndex] += cellSize.height + spacing
      let frame = CGRect(origin: CGPoint(x: CGFloat(columnIndex) * (columnWidth + spacing),
                                         y: offsetY),
                         size: cellSize)
      frames.append(frame)
    }

    return frames
  }
}
