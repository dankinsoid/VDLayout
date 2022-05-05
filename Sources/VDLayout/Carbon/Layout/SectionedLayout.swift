//
//  SectionedLayout.swift
//  VDKitFix
//
//  Created by Данил Войдилов on 11.03.2021.
//

import UIKit
import VDKit
import CarbonTable

public struct SectionedLayout: Layout {
	private let compose: ComposeLayout
	public var contentSize: CGSize { compose.contentSize }
	
	private init(_ compose: ComposeLayout) {
		self.compose = compose
	}
	
	public init(_ layout: Layout, section: @escaping (_ section: Int) -> Layout, for collection: UICollectionView) {
		self = .init(.sectioned(layout, section: section, for: collection))
	}
	
	public func layout(context: LayoutContext) -> Layout {
		SectionedLayout(compose._layout(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		compose.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		compose.visibleIndexes(visibleFrame: visibleFrame)
	}
	
	public func layout(context: PathsLayoutContext) -> Layout {
		SectionedLayout(compose._layout(context: context))
	}
	
	public func frame(at: IndexPath) -> CGRect {
		compose.frame(at: at)
	}
	
	public func visiblePaths(visibleFrame: CGRect) -> [IndexPath] {
		compose.visiblePaths(visibleFrame: visibleFrame)
	}
}

public struct LayoutedSection {
	public var section: Section
	public var layout: Layout
	
	public init(layout: Layout, _ section: Section) {
		self.layout = layout
		self.section = section
	}
}

extension Section {
	public func layouted(_ layout: Layout) -> LayoutedSection {
		LayoutedSection(layout: layout, self)
	}
}
