//
//  File.swift
//  
//
//  Created by Данил Войдилов on 03.01.2022.
//

import Foundation
import UIKit

extension UI {
	public func subviews(@UIBuilder _ view: () -> UILayout, codeID: CodeID = CodeID(file: #file, line: #line, column: #column)) -> some UI {
		let layout = view()
		return updateUIViewConvertable { view in
			view.associated._layouts[codeID] = layout
		}
	}
}

extension AssociatedValues {
	var _layouts: [CodeID: UILayout] {
		get { self[\._layouts] ?? [:] }
		set { self[\._layouts] = newValue }
	}
}
