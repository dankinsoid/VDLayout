//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

import UIKit
import Carbon


@_functionBuilder
public struct LazyBuilder {
	
	public struct Collection<T> {
		public var items: [() -> T]
		
		public init(items: [() -> T]) {
			self.items = items
		}
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T, _ c15: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T, _ c15: @escaping @autoclosure () -> T, _ c16: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T, _ c15: @escaping @autoclosure () -> T, _ c16: @escaping @autoclosure () -> T, _ c17: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T, _ c15: @escaping @autoclosure () -> T, _ c16: @escaping @autoclosure () -> T, _ c17: @escaping @autoclosure () -> T, _ c18: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18])
	}
	
	@_alwaysEmitIntoClient
	public static func buildBlock<T>(_ c0: @escaping @autoclosure () -> T, _ c1: @escaping @autoclosure () -> T, _ c2: @escaping @autoclosure () -> T, _ c3: @escaping @autoclosure () -> T, _ c4: @escaping @autoclosure () -> T, _ c5: @escaping @autoclosure () -> T, _ c6: @escaping @autoclosure () -> T, _ c7: @escaping @autoclosure () -> T, _ c8: @escaping @autoclosure () -> T, _ c9: @escaping @autoclosure () -> T, _ c10: @escaping @autoclosure () -> T, _ c11: @escaping @autoclosure () -> T, _ c12: @escaping @autoclosure () -> T, _ c13: @escaping @autoclosure () -> T, _ c14: @escaping @autoclosure () -> T, _ c15: @escaping @autoclosure () -> T, _ c16: @escaping @autoclosure () -> T, _ c17: @escaping @autoclosure () -> T, _ c18: @escaping @autoclosure () -> T, _ c19: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19])
	}
	
	/// :nodoc:
	@inlinable
	public static func buildEither<T>(first: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [first])
	}
	
	/// :nodoc:
	@inlinable
	public static func buildEither<T>(second: @escaping @autoclosure () -> T) -> Collection<T> {
		Collection(items: [second])
	}
	
}
