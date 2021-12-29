//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
import UIKit
import VDChain
import Combine
@testable import VDLayout

@available(iOS 13.0, *)
final class VDTests: XCTestCase {
	
	@BindingPublisher var text = ""
	
	func tests() {
		let text = CurrentValueSubject<String, Never>("")
		
		UIView().update {
			UILabel()§
				.textColor(.red)
				.text(text)
				.tag(0)
																																								
			UIViewController()§
				.tabBarItem(UITabBarItem(title: "", image: nil, selectedImage: nil))
				.environment(for: UILabel.self)
					.textColor(UIColor.red)
			
			UITextField()§
				.on(event: .valueChanged) { _ in }
			
			UILabel()§
				.text($text)
		}
	}
	
//	@SubviewsBuilder
//	func subview() -> [SubviewProtocol] {
//		UIView()
//			.chain
//			.backgroundColor(.red)
//			.tintColor(.black)
//			.isHidden(true)
//			.edges(0)
//			.size(.zero)
//			.width.equal(to: { $0.height })
//			.height.equal(to: .zero)
//	}
	
	static var allTests = [
		("tests", tests),
	]
}

postfix operator %

public postfix func %<T: BinaryFloatingPoint>(_ lhs: T) -> T {
	lhs / 100
}
