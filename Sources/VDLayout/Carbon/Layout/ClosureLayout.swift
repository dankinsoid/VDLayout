//
//  ClosureLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-08-15.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct ClosureLayout: CollectionLayout {
	public var contentSize: CGSize { simple.contentSize }
	let simple: SimpleLayout

	private init(simple: SimpleLayout) {
		self.simple = simple
	}
	
  public init(frameProvider: @escaping (Int, CGSize) -> CGRect) {
		simple = SimpleLayout(simpleLayout: { context, _ in
			ClosureLayout.simpleLayout(context: context, frameProvider: frameProvider)
		})
  }

	public func layout(context: LayoutContext) -> CollectionLayout {
		ClosureLayout(simple: simple.simple(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		simple.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		simple.visibleIndexes(visibleFrame: visibleFrame)
	}
	
	static func simpleLayout(context: LayoutContext, frameProvider: @escaping (Int, CGSize) -> CGRect) -> [CGRect] {
    var frames: [CGRect] = []
    for i in 0..<context.numberOfItems {
      let frame = frameProvider(i, context.collectionSize)
      frames.append(frame)
    }
    return frames
  }
}
