//
//  SubviewsBuilder.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit
import VDKit
#if canImport(SwiftUI)
import SwiftUI
#endif

public typealias SubviewsBuilder = ArrayBuilder<SubviewProtocol>

extension ArrayBuilder where T == SubviewProtocol {
	
	@inline(__always)
	public static func buildExpression<S: SubviewProtocol>(_ expression: S) -> [T] {
		[expression]
	}
	
	@available(iOS 13.0, *)
	@inline(__always)
	public static func buildExpression<S: View>(_ expression: S) -> [T] {
		[expression.uiKit]
	}
	
}

@available(iOS 13.0, *)
extension ViewBuilder {
	
	@inline(__always)
	public static func buildExpression<V: View>(_ expression: V) -> V {
		expression
	}
	
	@inline(__always)
	public static func buildExpression<V: SubviewProtocol>(_ expression: @escaping @autoclosure () -> V) -> SubviewView<V> {
		SubviewView(expression)
	}
	
}
