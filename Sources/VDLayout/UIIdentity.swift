//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public struct UIIdentity: Hashable {
	public var id: AnyHashable
	
	public init(codeID: CodeID, type: UI.Type) {
		self.id = codeID.combined(with: String(reflecting: type))
	}
	
	public func `in`(element: UI.Type, codeID: CodeID) -> UIIdentity {
		UIIdentity(codeID: codeID, type: element).id(id)
	}
	
	public func id<T: Hashable>(_ id: T) -> UIIdentity {
		var result = self
		result.id = result.id.combined(with: id)
		return result
	}
}
