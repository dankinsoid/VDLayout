//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public struct UIIdentity: Hashable {
	public var codeID: CodeID
	public var id: AnyHashable?
	public var type: String
	public var path: [UIIdentity] = []
	
	public init(codeID: CodeID, id: AnyHashable? = nil, type: UI.Type, path: [UIIdentity] = []) {
		self.codeID = codeID
		self.type = String(reflecting: type)
		self.path = path
		self.id = id
	}
	
	public func `in`(element: UI.Type, codeID: CodeID) -> UIIdentity {
		UIIdentity(codeID: codeID, type: element, path: [self])
	}
	
	public func id<T: Hashable>(_ id: T) -> UIIdentity {
		var result = self
		result.id = id
		return result
	}
}
