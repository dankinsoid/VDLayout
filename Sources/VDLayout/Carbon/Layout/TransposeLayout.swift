//
//  TransposeLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-09-08.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct TransposeLayout: CollectionLayout {
  struct TransposeLayoutContext: LayoutContext {
    var original: LayoutContext

    var collectionSize: CGSize {
      return original.collectionSize.transposed
    }
    var numberOfItems: Int {
      return original.numberOfItems
    }
    func identifier(at: Int) -> AnyHashable {
			original.identifier(at: at)
    }
    func size(at: Int, collectionSize: CGSize) -> CGSize {
      return original.size(at: at, collectionSize: collectionSize.transposed).transposed
    }
  }
	
	public let rootLayout: CollectionLayout
	
	public init(_ rootLayout: CollectionLayout) {
		self.rootLayout = rootLayout
	}

	public var contentSize: CGSize {
		rootLayout.contentSize.transposed
  }

	public func transposeLayout(context: LayoutContext) -> TransposeLayout {
		TransposeLayout(
			rootLayout.layout(context: TransposeLayoutContext(original: context))
		)
	}
	
	public func layout(context: LayoutContext) -> CollectionLayout {
		transposeLayout(context: context)
  }

	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		rootLayout.visibleIndexes(visibleFrame: visibleFrame.transposed)
  }

	public func frame(at: Int) -> CGRect {
		rootLayout.frame(at: at).transposed
  }
}
