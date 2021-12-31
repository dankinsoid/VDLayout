//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public struct UIIdentity: Hashable {
	public var codeID: CodeID
	public var type: String
	public var path: [UIIdentity] = []
	
	public init(codeID: CodeID, type: UI.Type, path: [UIIdentity] = []) {
		self.codeID = codeID
		self.type = String(reflecting: type)
		self.path = path
	}
	
	public func `in`(element: UI.Type, codeID: CodeID) -> UIIdentity {
		UIIdentity(codeID: codeID, type: element, path: [self])
	}
}
