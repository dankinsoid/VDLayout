//
//  File.swift
//  
//
//  Created by Данил Войдилов on 09.03.2021.
//

import UIKit
import Carbon
import VDKit
import Combine

open class StackView: UIStackView {
	open var data: [CellNode] = [] {
		didSet {
			update()
		}
	}
	
	open func update() {
		let dif = arrangedSubviews.count - data.count
		arrangedSubviews.suffix(max(0, dif)).reversed().forEach {
			removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
		if dif < 0 {
			for i in arrangedSubviews.count..<data.count {
				if let value = data[i].component.renderContent() as? SubviewProtocol {
					addArrangedSubview(value.createViewToAdd())
				}
			}
		}
		zip(data, arrangedSubviews).forEach {
			$0.0.component.render(in: $0.1)
		}
	}
	
	open func update(@UICellsBuilder _ cells: () -> CellsBuildable) {
		data = cells().buildCells()
	}
	
	open func update<C: Collection>(_ array: C, @UICellsBuilder _ cells: (C.Element) -> CellsBuildable) {
		data = array.map { cells($0).buildCells() }.joinedArray()
	}
}

@available(iOS 13.0, *)
extension StackView {
	
	public convenience init<P: Publisher>(_ publisher: P, @UICellsBuilder _ cells: @escaping (P.Output.Element) -> CellsBuildable) where P.Output: Collection {
		self.init()
		bind(publisher, cells)
	}
	
	public static func V<P: Publisher>(_ publisher: P, @UICellsBuilder _ cells: @escaping (P.Output.Element) -> CellsBuildable) -> Self where P.Output: Collection {
		let result = V {}
		result.bind(publisher, cells)
		return result
	}
	
	public static func H<P: Publisher>(_ publisher: P, @UICellsBuilder _ cells: @escaping (P.Output.Element) -> CellsBuildable) -> Self where P.Output: Collection {
		let result = H {}
		result.bind(publisher, cells)
		return result
	}
	
	public func bind<P: Publisher>(one publisher: P, @UICellsBuilder _ cells: @escaping (P.Output) -> CellsBuildable) {
		publisher.subscribe(on: DispatchQueue.main).subscribe {[weak self] element in
			self?.data = cells(element).buildCells()
		}
	}
	
	public func bind<P: Publisher>(_ publisher: P, @UICellsBuilder _ cells: @escaping (P.Output.Element) -> CellsBuildable) where P.Output: Collection {
		publisher.subscribe(on: DispatchQueue.main).subscribe {[weak self] array in
			self?.update(array, cells)
		}
	}
}
