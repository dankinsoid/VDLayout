//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
import Combine
import VDKit
@testable import VDLayout

@available(iOS 13.0, *)
final class VDTests: XCTestCase {
	
	func tests() {
	}
	
	@SubviewsBuilder
	func subview() -> [SubviewProtocol] {
		UIView()
			.chain
			.backgroundColor(.red)
			.tintColor(.black)
			.isHidden(true)
			.edges(0)
			.size(.zero)
			.width.equal(to: { $0.height })
			.height.equal(to: .zero)
	}
	
	static var allTests = [
		("tests", tests),
	]
}
