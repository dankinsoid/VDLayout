//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

import Foundation

@_functionBuilder
public struct GenericBuilder {
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: T) -> T {
		c0
	}
	
	@inlinable
	public static func buildEither<T>(first: T) -> T {
		first
	}
	
	/// :nodoc:
	@inlinable
	public static func buildEither<T>(second: T) -> T {
		second
	}
}
