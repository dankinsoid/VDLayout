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
	public func layout(codeID: CodeID = CodeID(file: #file, line: #line, column: #column), embeded: Bool = true) -> UILayout {
		if let element = self as? AnyUIElementType {
			return UILayout(element: element, id: UIIdentity(codeID: codeID, type: Self.self))
		} else if embeded {
			return layout.in(element: Self.self, codeID: codeID)
		} else {
			return layout
		}
	}
}
