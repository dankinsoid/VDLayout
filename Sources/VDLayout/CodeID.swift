//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation

public struct CodeID: Hashable {
	public static var none: CodeID { CodeID(file: "", line: 0, column: 0) }
	
	public var file: String
	public var line: UInt
	public var column: UInt
	
	public init(file: String, line: UInt, column: UInt) {
		self.file = file
		self.line = line
		self.column = column
	}
}
