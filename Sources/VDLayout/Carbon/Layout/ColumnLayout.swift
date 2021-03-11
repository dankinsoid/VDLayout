//
//  ColumnLayout.swift
//  VDKitFix
//
//  Created by Данил Войдилов on 11.03.2021.
//

import UIKit

public struct ColumnLayout: Layout {
	public var contentSize: CGSize { row.contentSize }
	private let row: TransposeLayout
	
	private init(_ row: TransposeLayout) {
		self.row = row
	}
	
	public init(fillIdentifiers: Set<AnyHashable>,
							spacing: CGFloat = 0,
							justifyContent: JustifyContent = .start,
							alignItems: AlignItem = .start,
							alwaysFillEmptySpaces: Bool = true) {
		row = RowLayout(fillIdentifiers: fillIdentifiers, spacing: spacing, justifyContent: justifyContent, alignItems: alignItems, alwaysFillEmptySpaces: alwaysFillEmptySpaces).transposed()
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
		columnLayout(context: context)
	}
	
	public func columnLayout(context: LayoutContext) -> ColumnLayout {
		ColumnLayout(row.transposeLayout(context: context))
	}
	
	public func frame(at: Int) -> CGRect {
		row.frame(at: at)
	}
	
	public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
		row.visibleIndexes(visibleFrame: visibleFrame)
	}
}
