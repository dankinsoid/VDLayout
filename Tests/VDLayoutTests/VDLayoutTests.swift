//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
@testable import Carbon
@testable import VDKit
@testable import VDLayout

final class VDTests: XCTestCase {
	
	func tests() {
		UIStackView.V {
			UIList {
				Section(id: UUID()) {
					UIView()
					UIView()
					UIView()
				}
			}
		}
	}
	
	static var allTests = [
		("tests", tests),
	]
	
}
