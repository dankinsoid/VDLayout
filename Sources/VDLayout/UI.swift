//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public protocol UI {
	@UIBuilder var layout: UILayout { get }
}

extension UI where Self: AnyUIElementType {
	public var layout: UILayout {
		fatalError("don`t call layout directly for UIElementType, call layout()")
	}
}

extension UI {
	
	public func layout(codeID: CodeID) -> UILayout {
		if let layout = self as? UILayout {
			return layout
		} else if let element = self as? AnyUIElementType {
			return UILayout(element: element, id: UIIdentity(codeID: codeID, type: Self.self))
		} else {
			return layout.id(UIIdentity(codeID: codeID, type: Self.self))
		}
	}
	
	public func layout(file: String = #filePath, line: UInt = #line, column: UInt = #column) -> UILayout {
		layout(codeID: CodeID(file: file, line: line, column: column))
	}
}
