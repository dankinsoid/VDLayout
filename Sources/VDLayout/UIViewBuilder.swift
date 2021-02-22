//
//  SubviewsBuilder.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit

public struct SubviewsArrayCreator: ArrayInitable {
	public static func create(from: [SubviewsArrayConvertable]) -> SubviewsArrayConvertable {
		from.count == 1 ? from[0] : AnySubviews(from)
	}
}

public typealias SubviewsBuilder = ArrayBuilder<SubviewProtocol>

extension ArrayBuilder where T == SubviewProtocol {
	
	public static func buildExpression<S: SubviewProtocol>(_ expression: S) -> [T] {
		[expression]
	}
	
}

public struct AnySubviews: SubviewsArrayConvertable {
	public let items: [SubviewsArrayConvertable]
	
	public init(_ items: [SubviewsArrayConvertable]) {
		self.items = items
	}
	
	public func asSubviews() -> [SubviewProtocol] {
		items.map { $0.asSubviews() }.joinedArray()
	}
}
