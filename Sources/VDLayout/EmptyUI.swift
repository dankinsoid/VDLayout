//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import Foundation

public struct EmptyUIStructure<Parent: UIRender>: UIStructure where Parent.Parent == Parent {
	public var children: [AnyUIStructure<Parent>] { [] }
	
	public init() {}
	
	public func createRender() -> EmptyUIRender<Parent> { EmptyUIRender() }
	public func updateRender(_ render: EmptyUIRender<Parent>) {}
}

public struct EmptyUIRender<Parent: UIRender>: UIRender where Parent.Parent == Parent {
	
	public func exists(on parent: Parent) -> Bool { false }
	public func add(to parent: Parent) {}
	public func remove(from parent: Parent) {}
	
	public init() {}
}

#if canImport(UIKit)
import UIKit

public typealias EmptyUI = EmptyUIStructure<UIView>
#endif
