//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
@testable import RxSwift
@testable import Carbon
@testable import VDKit
@testable import VDLayout

final class VDTests: XCTestCase {
	
	func tests() {
		let observable = Observable<[Int]>.just([1, 2, 3, 4])
		UIStackView.V {
			UIList(observable) { element in
				Section(id: "") {
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
