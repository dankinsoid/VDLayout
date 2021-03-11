//
//  InsetLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-09-08.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public struct InsetLayout: Layout {
  public var insets: UIEdgeInsets
  public var insetProvider: ((CGSize) -> UIEdgeInsets)?
	private let rootLayout: Layout

  struct InsetLayoutContext: LayoutContext {
    var original: LayoutContext
    var insets: UIEdgeInsets

    var collectionSize: CGSize {
      return original.collectionSize.insets(by: insets)
    }
    var numberOfItems: Int {
      return original.numberOfItems
    }
    func identifier(at: Int) -> AnyHashable {
      return original.identifier(at: at)
    }
    func size(at: Int, collectionSize: CGSize) -> CGSize {
      return original.size(at: at, collectionSize: collectionSize)
    }
  }

  public init(_ rootLayout: Layout, insets: UIEdgeInsets = .zero) {
    self.insets = insets
		self.rootLayout = rootLayout
  }

  public init(_ rootLayout: Layout, insetProvider: @escaping ((CGSize) -> UIEdgeInsets)) {
    self.insets = .zero
    self.insetProvider = insetProvider
		self.rootLayout = rootLayout
  }

 	public var contentSize: CGSize {
		rootLayout.contentSize.insets(by: -insets)
  }

	public func layout(context: LayoutContext) -> Layout {
		var insets = self.insets
    if let insetProvider = insetProvider {
      insets = insetProvider(context.collectionSize)
    }
		var result = InsetLayout(rootLayout.layout(context: InsetLayoutContext(original: context, insets: insets)))
		result.insets = insets
		result.insetProvider = insetProvider
		return result
  }

	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		rootLayout.visibleIndexes(visibleFrame: visibleFrame.inset(by: -insets))
  }

	public func frame(at: Int) -> CGRect {
		rootLayout.frame(at: at) + CGPoint(x: insets.left, y: insets.top)
  }
}
