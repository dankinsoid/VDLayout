//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
@testable import VDKit
@testable import VDLayout

final class VDTests: XCTestCase {
	
	func tests() {
		UIButton().chain
			.title[""]
			.titleColor[.red]
			.alpha[1]
			.tap[{}]
	}
	
	static var allTests = [
		("tests", tests),
	]
	
}
