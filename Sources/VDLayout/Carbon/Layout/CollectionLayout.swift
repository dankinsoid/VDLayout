//
//  Layout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-07-20.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public protocol CollectionLayout {
 	func layout(context: LayoutContext) -> CollectionLayout
	var contentSize: CGSize { get }
	func frame(at: Int) -> CGRect
	func visibleIndexes(visibleFrame: CGRect) -> [Int]
}

extension CollectionLayout {
  public func transposed() -> TransposeLayout {
    return TransposeLayout(self)
  }

  public func inset(by insets: UIEdgeInsets) -> InsetLayout {
    return InsetLayout(self, insets: insets)
  }

  public func insetVisibleFrame(by insets: UIEdgeInsets) -> VisibleFrameInsetLayout {
    return VisibleFrameInsetLayout(self, insets: insets)
  }
	
	public func inset(by insets: CGFloat) -> InsetLayout {
		return InsetLayout(self, insets: UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets))
	}
	
	public func top(by insets: CGFloat) -> InsetLayout {
		return InsetLayout(self, insets: UIEdgeInsets(top: insets, left: 0, bottom: 0, right: 0))
	}
	
	public func left(by insets: CGFloat) -> InsetLayout {
		return InsetLayout(self, insets: UIEdgeInsets(top: 0, left: insets, bottom: 0, right: 0))
	}
	
	public func bottom(by insets: CGFloat) -> InsetLayout {
		return InsetLayout(self, insets: UIEdgeInsets(top: 0, left: 0, bottom: insets, right: 0))
	}
	
	public func right(by insets: CGFloat) -> InsetLayout {
		return InsetLayout(self, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insets))
	}
}
