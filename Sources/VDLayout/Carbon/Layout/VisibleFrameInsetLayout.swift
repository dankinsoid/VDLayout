//
//  VisibleFrameInsetLayout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2018-03-23.
//  Copyright © 2018 lkzhao. All rights reserved.
//

import UIKit

public struct VisibleFrameInsetLayout: Layout {
	public var contentSize: CGSize { rootLayout.contentSize }
  public var insets: UIEdgeInsets
  public var insetProvider: ((CGSize) -> UIEdgeInsets)?
	public var rootLayout: Layout
	
  public init(_ rootLayout: Layout, insets: UIEdgeInsets = .zero) {
    self.insets = insets
		self.rootLayout = rootLayout
  }

  public init(_ rootLayout: Layout, insetProvider: @escaping ((CGSize) -> UIEdgeInsets)) {
    self.insets = .zero
    self.insetProvider = insetProvider
		self.rootLayout = rootLayout
  }

	public func layout(context: LayoutContext) -> Layout {
		var insets = self.insets
    if let insetProvider = insetProvider {
      insets = insetProvider(context.collectionSize)
    }
		var result = VisibleFrameInsetLayout(rootLayout.layout(context: context))
		result.insets = insets
		result.insetProvider = insetProvider
    return result
  }

	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		rootLayout.visibleIndexes(visibleFrame: visibleFrame.inset(by: insets))
  }
	
	public func frame(at: Int) -> CGRect {
		rootLayout.frame(at: at)
	}
}
