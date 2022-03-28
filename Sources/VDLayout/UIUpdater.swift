//
//  File.swift
//  
//
//  Created by Данил Войдилов on 26.03.2022.
//

import Foundation

open class UIUpdater<Parent: UIRender> where Parent.Parent == Parent {
	private var _render: AnyUIRender<Parent>?
	open var children: [AnyHashable: UIUpdater] = [:]
	open var uiStructure: AnyUIStructure<Parent>
	
	open var render: AnyUIRender<Parent> {
		if let render = _render {
			return render
		} else {
			let render = uiStructure.createRender()
			_render = render
			return render
		}
	}

	public init(_ uiStructure: AnyUIStructure<Parent>) {
		self.uiStructure = uiStructure
	}
	
	open func update() {
		let render = self.render
		let structChildren = uiStructure.children
		
		children.forEach { args in
			guard !structChildren.contains(where: { $0.id == args.key }) else { return }
			if args.value._render?.exists(onAny: render) == true {
				args.value._render?.remove(fromAny: render)
			}
		}
		
		uiStructure.updateRender(render)
		
		structChildren.forEach(update)
	}
	
	private func update(structure: AnyUIStructure<Parent>) {
		let updater: UIUpdater
		if let _updater = children[structure.id] {
			updater = _updater
		} else {
			updater = UIUpdater(structure)
			children[structure.id] = updater
		}
		if !updater.render.exists(onAny: render) {
			updater.render.add(toAny: render)
		}
		updater.update()
	}
}
