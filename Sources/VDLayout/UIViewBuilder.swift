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
	
	public static func buildExpression<S: SubviewProtocol>(_ expression: S) -> [T] {
		[expression]
	}
	
	@available(iOS 13.0, *)
	public static func buildExpression<S: View>(_ expression: S) -> [T] {
		[expression.uiKit]
	}
	
}
