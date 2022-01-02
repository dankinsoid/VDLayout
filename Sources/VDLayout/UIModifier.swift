//
//  File.swift
//  
//
//  Created by Данил Войдилов on 02.01.2022.
//

import Foundation

public protocol UIModifier {
	@UIBuilder func layout<T: UI>(content: T) -> UILayout
}

extension UI {
	public func modifier(_ modifier: UIModifier) -> some UI {
		modifier.layout(content: self)
	}
}
