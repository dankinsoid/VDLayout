//
//  SimpleLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-09-11.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct SimpleLayout: Layout {
	public let contentSize: CGSize
  public let frames: [CGRect]
	public let simpleLayout: (LayoutContext, SimpleLayout) -> [CGRect]

	public init() {
		self = SimpleLayout(simpleLayout: { context, _ in [CGRect(origin: .zero, size: context.collectionSize)]})
	}
	
	public init(frames: [CGRect] = [], contentSize: CGSize = .zero, simpleLayout: @escaping (LayoutContext, SimpleLayout) -> [CGRect]) {
		self.frames = frames
		self.contentSize = contentSize
		self.simpleLayout = simpleLayout
	}
	
	public func layout(context: LayoutContext) -> Layout {
		simple(context: context)
	}
	
	public func simple(context: LayoutContext) -> SimpleLayout {
    let frames = simpleLayout(context, self)
    let contentSize = frames.reduce(CGRect.zero) { (old, item) in
      old.union(item)
    }.size
		return SimpleLayout(frames: frames, contentSize: contentSize, simpleLayout: simpleLayout)
  }

	public func frame(at: Int) -> CGRect {
		guard at < frames.count else { return .zero }
		return frames[at]
  }

	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
    var result = [Int]()
    for (i, frame) in frames.enumerated() {
      if frame.intersects(visibleFrame) {
        result.append(i)
      }
    }
    return result
  }
}

public struct VerticalSimpleLayout: Layout {
	let maxFrameLength: CGFloat
	let simple: SimpleLayout
	public var contentSize: CGSize { simple.contentSize }

	public init(_ simple: SimpleLayout = SimpleLayout()) {
		maxFrameLength = simple.frames.max { $0.height < $1.height }?.height ?? 0
		self.simple = simple
	}
	
	public func vertical(context: LayoutContext) -> VerticalSimpleLayout {
		let _simple = simple.simple(context: context)
		return VerticalSimpleLayout(_simple)
	}
	
	public func layout(context: LayoutContext) -> Layout {
	 	vertical(context: context)
	}
	
	public func frame(at: Int) -> CGRect {
		simple.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		var index = simple.frames.binarySearch { $0.minY < visibleFrame.minY - maxFrameLength }
    var visibleIndexes = [Int]()
		while index < simple.frames.count {
			let frame = simple.frames[index]
      if frame.minY >= visibleFrame.maxY {
        break
      }
      if frame.maxY > visibleFrame.minY {
        visibleIndexes.append(index)
      }
      index += 1
    }
    return visibleIndexes
  }
	
}

open class HorizontalSimpleLayout: Layout {
  private var maxFrameLength: CGFloat = 0
	let simple: SimpleLayout
	public var contentSize: CGSize { simple.contentSize }
	
	public init(_ simple: SimpleLayout = SimpleLayout()) {
		maxFrameLength = simple.frames.max { $0.width < $1.width }?.width ?? 0
		self.simple = simple
	}
	
	public func horizontal(context: LayoutContext) -> HorizontalSimpleLayout {
		let _simple = simple.simple(context: context)
		return HorizontalSimpleLayout(_simple)
	}
	
	public func layout(context: LayoutContext) -> Layout {
		horizontal(context: context)
	}
	
	public func frame(at: Int) -> CGRect {
		simple.frame(at: at)
	}

	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		var index = simple.frames.binarySearch { $0.minX < visibleFrame.minX - maxFrameLength }
    var visibleIndexes = [Int]()
		while index < simple.frames.count {
			let frame = simple.frames[index]
      if frame.minX >= visibleFrame.maxX {
        break
      }
      if frame.maxX > visibleFrame.minX {
        visibleIndexes.append(index)
      }
      index += 1
    }
    return visibleIndexes
  }
}
