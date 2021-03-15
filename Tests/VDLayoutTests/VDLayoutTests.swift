//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
import Combine
@testable import VDLayout

@available(iOS 13.0, *)
final class VDTests: XCTestCase {
	
	func tests() {
	}
	
	@SubviewsBuilder
	func subview() -> SubviewListProtocol {
		UIView()
			.chain
			.backgroundColor[.red]
			.edges().equal(to: 0)
	}
	
	static var allTests = [
		("tests", tests),
	]
	
}
