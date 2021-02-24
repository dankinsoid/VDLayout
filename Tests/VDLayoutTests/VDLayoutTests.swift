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
		let observable = Observable<[Int]>.from([[1, 2, 3, 4], [2, 3, 6, 8], [1, 3, 6]])
		UIList(observable, id: \.self) {
			UILabel("\($0)")
		}
	}
	
//	@SubviewsBuilder
//	func subview() -> [SubviewProtocol] {
//		UIView()
//			.chain
//			.backgroundColor[.red]
//			.edges().equal(to: 0)
//	}
	
	static var allTests = [
		("tests", tests),
	]
	
}

struct Cmp: IdentifiableComponent {
	var id: String { "" }
	func renderContent() -> UIView {
		UIView()
	}
	func render(in content: UIView) {
		
	}
}

@UISectionsBuilder
func cells(array: [Int]) -> [Section] {
	Section(id: "", items: array) { i in
		UILabel("\(i)")
	}
}
