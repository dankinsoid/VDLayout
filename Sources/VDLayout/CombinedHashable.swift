//
//  File.swift
//  
//
//  Created by Данил Войдилов on 03.01.2022.
//

import Foundation

public struct CombinedHashable<L: Hashable, R: Hashable>: Hashable, CustomStringConvertible {
	public var first: L
	public var second: R
	
	public init(_ first: L, _ second: R) {
		self.first = first
		self.second = second
	}
	
	public var description: String {
		"(\(first) \(second))"
	}
}

extension Hashable {
	public func combined<H: Hashable>(with hashable: H) -> CombinedHashable<Self, H> {
		CombinedHashable(self, hashable)
	}
}
