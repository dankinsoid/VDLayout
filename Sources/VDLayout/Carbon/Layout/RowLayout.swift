//
//  RowLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-08-15.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct RowLayout: Layout {
	public var contentSize: CGSize { horizontal.contentSize }
	let horizontal: HorizontalSimpleLayout

	private init(horizontal: HorizontalSimpleLayout) {
		self.horizontal = horizontal
	}
	
	public init(fillIdentifiers: Set<AnyHashable>,
              spacing: CGFloat = 0,
              justifyContent: JustifyContent = .start,
              alignItems: AlignItem = .start,
							alwaysFillEmptySpaces: Bool = true) {
		horizontal = HorizontalSimpleLayout(SimpleLayout(simpleLayout: { context, _ in
			RowLayout.simpleLayout(context: context, justifyContent: justifyContent, spacing: spacing, alignItems: alignItems, alwaysFillEmptySpaces: alwaysFillEmptySpaces, fillIdentifiers: fillIdentifiers)
		}))
  }

	public init(_ fillIdentifiers: AnyHashable...,
                          spacing: CGFloat = 0,
                          justifyContent: JustifyContent = .start,
                          alignItems: AlignItem = .start,
													alwaysFillEmptySpaces: Bool = true) {
    self = .init(fillIdentifiers: Set(fillIdentifiers), spacing: spacing,
							justifyContent: justifyContent, alignItems: alignItems, alwaysFillEmptySpaces: alwaysFillEmptySpaces)
  }

	public func layout(context: LayoutContext) -> Layout {
		rowLayout(context: context)
	}
	
	public func rowLayout(context: LayoutContext) -> RowLayout {
		RowLayout(horizontal: horizontal.horizontal(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		horizontal.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		horizontal.visibleIndexes(visibleFrame: visibleFrame)
	}
	
	static func simpleLayout(context: LayoutContext, justifyContent: JustifyContent, spacing: CGFloat, alignItems: AlignItem, alwaysFillEmptySpaces: Bool, fillIdentifiers: Set<AnyHashable>) -> [CGRect] {

    let (sizes, totalWidth) = getCellSizes(context: context, fillIdentifiers: fillIdentifiers, alwaysFillEmptySpaces: alwaysFillEmptySpaces, spacing: spacing)

    let (offset, distributedSpacing) = LayoutHelper.distribute(justifyContent: justifyContent,
                                                               maxPrimary: context.collectionSize.width,
                                                               totalPrimary: totalWidth,
                                                               minimunSpacing: spacing,
                                                               numberOfItems: context.numberOfItems
		)

    let frames = LayoutHelper.alignItem(alignItems: alignItems,
                                        startingPrimaryOffset: offset,
																				spacing: distributedSpacing,
                                        sizes: sizes,
																				secondaryRange: 0...max(0, context.collectionSize.height)
		)

    return frames
  }
}

extension RowLayout {

	static func getCellSizes(context: LayoutContext, fillIdentifiers: Set<AnyHashable>, alwaysFillEmptySpaces: Bool, spacing: CGFloat) -> (sizes: [CGSize], totalWidth: CGFloat) {
    var sizes: [CGSize] = []
    let spacings = spacing * CGFloat(context.numberOfItems - 1)
    var freezedWidth = spacings
    var fillIndexes: [Int] = []

    for i in 0..<context.numberOfItems {
      if fillIdentifiers.contains(context.identifier(at: i)) {
        fillIndexes.append(i)
        sizes.append(.zero)
      } else {
        let size = context.size(at: i, collectionSize: context.collectionSize)
        sizes.append(size)
        freezedWidth += size.width
      }
    }

    let leftOverWidthPerItem: CGFloat = max(0, context.collectionSize.width - freezedWidth) / CGFloat(fillIndexes.count)
    for i in fillIndexes {
      let size = context.size(at: i, collectionSize: CGSize(width: leftOverWidthPerItem,
                                                            height: context.collectionSize.height))
      let width = alwaysFillEmptySpaces ? max(leftOverWidthPerItem, size.width) : size.width
      sizes[i] = CGSize(width: width, height: size.height)
      freezedWidth += sizes[i].width
    }

    return (sizes, freezedWidth - spacings)
  }
}
