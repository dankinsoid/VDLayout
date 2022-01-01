//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation
import SwiftUI

public struct SwiftUIElement<Content: View>: UIElementType {
	public let content: Content
	
	public init(_ content: Content) {
		self.content = content
	}
	
	public func createUIView() -> UIHostingController<Content> {
		UIHostingController(rootView: content)
	}
	
	public func updateUIView(_ view: UIHostingController<Content>) {
		view.rootView = content
	}
}
