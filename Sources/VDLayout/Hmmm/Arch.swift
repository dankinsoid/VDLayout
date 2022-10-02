//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.01.2022.
//

import Foundation
import SwiftUI

protocol Renderer {
	var parent: Self? { get }
	var children: [Self] { get }
	func add(to parent: Self)
	func remove(from parent: Self)
}

protocol Component {
	associatedtype RendererType: Renderer
	func createRenderer() -> RendererType
	func update(renderer: RendererType)
}

protocol Builder {
//	func build<C: Component>(component: Component)
}

func updateLayout(state: State) -> some UI {
}
