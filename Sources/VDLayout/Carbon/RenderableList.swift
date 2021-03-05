//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

#if canImport(Carbon)
import UIKit
import VDKit
import Combine
import Carbon
import CombineOperators
import ConstraintsOperators

public typealias UISectionsBuilder = ArrayBuilder<Section>

public protocol RenderableView: AnyObject {
	init()
	associatedtype Updater: Carbon.Updater
	var renderer: Renderer<Updater> { get }
}

extension RenderableView {
	
	public init<C: Collection>(_ data: C) where C.Element == Section {
		self.init()
		renderer.render(data)
	}
	
	/// Render given variadic number of sections with function builder syntax, immediately.
	///
	/// - Parameters:
	///   - sections: A closure that constructs sections.
	public init(@UISectionsBuilder sections: () -> [Section]) {
		self.init()
		render(sections: sections)
	}
	
	/// Render a single section contains given cells with function builder syntax, immediately.
	///
	/// - Parameters:
	///   - cells: A closure that constructs cells.
	public init(@UICellsBuilder cells: () -> CellsBuildable) {
		self.init()
		render(cells: cells)
	}
	
	public init<C: Collection>(cells: C) where C.Element == CellNode {
		self.init()
		render(cells: cells)
	}
	
	public init<C: Swift.Collection>(_ data: C, @UISectionsBuilder sections: (C.Element) -> [Section]) {
		self.init()
		render(data, sections: sections)
	}
	
	public init<C: Swift.Collection, ID: Hashable>(_ data: C, id: KeyPath<C.Element, ID>, @UICellsBuilder cells: (C.Element) -> CellsBuildable) {
		self.init()
		render(data, id: id, cells: cells)
	}
	
	public init<C: Swift.Collection>(_ data: C, @UICellsBuilder cells: (C.Element) -> CellsBuildable) where C.Element: Hashable {
		self.init()
		render(data, cells: cells)
	}
	
	public func render<C: Collection>(_ data: C) where C.Element == Section {
		renderer.render(data)
	}
	
	/// Render given collection sections, immediately.
	///
	/// - Parameters:
	///   - data: A variadic number of sections to be rendered.
	public func render(_ data: Section...) {
		render(data)
	}
	
	/// Render given variadic number of sections with function builder syntax, immediately.
	///
	/// - Parameters:
	///   - sections: A closure that constructs sections.
	public func render(@UISectionsBuilder sections: () -> [Section]) {
		render(sections())
	}
	
	/// Render given variadic number of sections with function builder syntax, immediately.
	///
	/// - Parameters:
	///   - sections: A closure that constructs sections.
	public func render<C: Swift.Collection>(_ data: C, @UISectionsBuilder sections: (C.Element) -> [Section]) {
		render(data.map(sections).joined())
	}
	
	/// Render a single section contains given cells with function builder syntax, immediately.
	///
	/// - Parameters:
	///   - cells: A closure that constructs cells.
	public func render(@UICellsBuilder cells: () -> CellsBuildable) {
		render(cells: cells().buildCells())
	}
	
	public func render<C: Collection>(cells: C) where C.Element == CellNode {
		render {
			Section(id: UniqueIdentifier(), cells: cells)
		}
	}
	
	public func render<C: Swift.Collection, ID: Hashable>(_ data: C, id: KeyPath<C.Element, ID>, @UICellsBuilder cells: (C.Element) -> CellsBuildable) {
		render(cells: data.map { item in cells(item).buildCells().map { CellNode($0.component.identified(by: item[keyPath: id])) } }.joined())
	}
	
	public func render<C: Swift.Collection>(_ data: C, @UICellsBuilder cells: (C.Element) -> CellsBuildable) where C.Element: Hashable {
		render(data, id: \.self, cells: cells)
	}
	
}

@available(iOS 13.0, *)
extension RenderableView {
	
	public init<O: Publisher>(one binder: O, @UISectionsBuilder sections: @escaping (O.Output) -> [Section]) {
		self.init()
		bind(one: binder, sections: sections)
	}
	
	public init<O: Publisher>(_ binder: O, @UISectionsBuilder sections: @escaping (O.Output.Element) -> [Section]) where O.Output: Collection {
		self.init()
		bind(binder, sections: sections)
	}
	
	public init<O: Publisher, ID: Hashable>(_ binder: O, id: KeyPath<O.Output.Element, ID>, @UICellsBuilder cells: @escaping (O.Output.Element) -> CellsBuildable) where O.Output: Collection {
		self.init()
		bind(binder, id: id, cells: cells)
	}
	
	public init<O: Publisher>(_ binder: O, @UICellsBuilder cells: @escaping (O.Output.Element) -> CellsBuildable) where O.Output: Collection, O.Output.Element: Hashable {
		self.init()
		bind(binder, cells: cells)
	}
	
	public init<O: Publisher>(one binder: O, @UICellsBuilder cells: @escaping (O.Output) -> CellsBuildable) {
		self.init()
		bind(one: binder, cells: cells)
	}
	
	public func bind<O: Publisher>(one binder: O, @UISectionsBuilder sections: @escaping (O.Output) -> [Section]) {
		binder.asDriver() => {[weak self] in
			self?.render(sections($0))
		}
	}
	
	public func bind<O: Publisher>(_ binder: O, @UISectionsBuilder sections: @escaping (O.Output.Element) -> [Section]) where O.Output: Collection {
		binder.asDriver() => {[weak self] in
			self?.render($0, sections: sections)
		}
	}
	
	public func bind<O: Publisher>(one binder: O, @UICellsBuilder cells: @escaping (O.Output) -> CellsBuildable) {
		bind(one: binder) {
			Section(id: UniqueIdentifier(), cells: cells($0).buildCells())
		}
	}
	
	public func bind<O: Publisher, ID: Hashable>(_ binder: O, id: KeyPath<O.Output.Element, ID>, @UICellsBuilder cells: @escaping (O.Output.Element) -> CellsBuildable) where O.Output: Collection {
		binder.asDriver() => {[weak self] in
			self?.render($0, id: id, cells: cells)
		}
	}
	
	public func bind<O: Publisher>(_ binder: O, @UICellsBuilder cells: @escaping (O.Output.Element) -> CellsBuildable) where O.Output: Collection, O.Output.Element: Hashable {
		bind(binder, id: \.self, cells: cells)
	}
}

private var bagKey = "disposeBagKey043400"

extension Section {
	
	public init<I: Hashable, ID: Hashable, C: Swift.Collection>(id: I, header: ViewNode? = nil, footer: ViewNode? = nil, items: C, cellId: KeyPath<C.Element, ID>, @UICellsBuilder cells: @escaping (C.Element) -> CellsBuildable) {
		self = Section(id: id, header: header, cells: items.map { item in
			cells(item).buildCells().map { CellNode($0.component.identified(by: item[keyPath: cellId])) }
		}.joined(), footer: footer)
	}
	
	public init<I: Hashable, C: Swift.Collection>(id: I, header: ViewNode? = nil, footer: ViewNode? = nil, items: C, @UICellsBuilder cells: @escaping (C.Element) -> CellsBuildable) where C.Element: Hashable {
		self = Section(id: id, header: header, footer: footer, items: items, cellId: \.self, cells: cells)
	}
	
	public static func `static`<I: Hashable>(id: I, header: ViewNode? = nil, footer: ViewNode? = nil, @UICellsBuilder cells: @escaping () -> CellsBuildable) -> Section {
		Section(id: id, header: header, cells: cells().buildCells(), footer: footer)
	}

}

private struct UniqueIdentifier: Hashable {}

#endif
