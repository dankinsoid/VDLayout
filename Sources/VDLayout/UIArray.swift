//
//  File.swift
//  
//
//  Created by Данил Войдилов on 27.03.2022.
//

import Foundation

public struct UIArrayStructure<Parent: UIRender>: UIStructure where Parent.Parent == Parent {
	public var children: [AnyUIStructure<Parent>]
	
	public init(_ children: [AnyUIStructure<Parent>]) {
		self.children = children
	}
	
	public func createRender() -> UIArrayRender<Parent> {
		UIArrayRender(children.map { ($0.id, $0.createRender()) })
	}
	
	public func updateRender(_ render: UIArrayRender<Parent>) {
		children.forEach { structure in
			if let item = render.renders.first(where: { $0.0 == structure.id }) {
				structure.updateRender(item.1)
			}
		}
	}
}

public struct UIArrayRender<Parent: UIRender>: UIRender where Parent.Parent == Parent {
	
	public var renders: [(AnyHashable, AnyUIRender<Parent>)]
	
	public init(_ renders: [(AnyHashable, AnyUIRender<Parent>)]) {
		self.renders = renders
	}
	
	public func exists(on parent: Parent) -> Bool {
		!renders.contains(where: { !$0.1.exists(on: parent) })
	}
	
	public func add(to parent: Parent) {
		renders.filter({ !$0.1.exists(on: parent) }).forEach {
			$0.1.add(to: parent)
		}
	}
	
	public func remove(from parent: Parent) {
		renders.forEach {
			$0.1.remove(from: parent)
		}
	}
}
