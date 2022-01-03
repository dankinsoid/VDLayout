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
				.environment(\UILabel.textColor, .red)
			
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

class MyView: UIView {
	@UIEnvironment(\.self) var environment
	@UIEnvironment(\UILabel.textColor) var textColor
	@UIState var string = ""
	
	func tt() {
		update {
			EmptyUI()
		}
	}
}


class MyUIView: UIView, UILayoutable {
	@UIEnvironment(\.self) var environment
	@UIState var string = ""
	
	var layout: UILayout {
		EmptyUI()
	}
}

struct MyStructView: UI {
	@UIEnvironment(\.self) var environment
	@UIEnvironment(\.someString) var someString
	@UIState var string = ""
	
	var layout: UILayout {
		EmptyUI()
		
		UILayout {
			
		}
	
		UIView()§
			.tintColor(.red)
		
		
	}
}

extension UI {
	public var someString: UIEnvironmentValue<String> {
		environments.value(\.someString, default: "")
	}
}
