//
//  OverlayLayout.swift
//  CollectionKitExample
//
//  Created by Luke Zhao on 2017-08-29.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct OverlayLayout: CollectionLayout {
	public var contentSize: CGSize { simple.contentSize }
	public let simple: SimpleLayout
	
	private init(_ simple: SimpleLayout) {
		self.simple = simple
	}
	
	public init() {
		simple = SimpleLayout(simpleLayout: { context, _ in
			var frames: [CGRect] = []
			for i in 0..<context.numberOfItems {
				let size = context.size(at: i, collectionSize: context.collectionSize)
				frames.append(CGRect(origin: .zero, size: size))
			}
			return frames
		})
	}
	
	public func layout(context: LayoutContext) -> CollectionLayout {
		OverlayLayout(simple.simple(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		simple.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		simple.visibleIndexes(visibleFrame: visibleFrame)
	}
	
}
