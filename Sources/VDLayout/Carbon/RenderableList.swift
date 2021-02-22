//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

import UIKit
import VDKit
import RxSwift
import Carbon
import ConstraintsOperators

public protocol AnyRenderableView: UIView {
	init()
}

public protocol RenderableView: AnyRenderableView {
	associatedtype Updater: Carbon.Updater
	var renderer: Renderer<Updater> { get }
}

extension RenderableView {
	
	public init<S: SectionsBuildable, O: ObservableConvertibleType>(_ binder: O, @SectionsBuilder sections: @escaping (O.Element) -> S) {
		self.init()
		bind(binder, sections: sections)
	}
	
	public init<C: CellsBuildable, O: ObservableConvertibleType>(_ binder: O, @CellsBuilder cells: @escaping (O.Element) -> C) {
		self.init()
		bind(binder, cells: cells)
	}
	
	public init<C: SubviewProtocol>(header: ViewNode?, @LazyBuilder cells: @escaping () -> LazyBuilder.Collection<C>, footer: ViewNode?) {
		self.init()
		reload(header: header, cells: cells, footer: footer)
	}
	
	public init<S: SectionsBuildable>(@SectionsBuilder sections: @escaping () -> S) {
		self.init()
		reload(sections: sections)
	}
	
	public func reload<S: SectionsBuildable>(@SectionsBuilder sections: @escaping () -> S) {
		renderer.render(sections: sections)
	}
	
	public func reload<C: CellsBuildable>(@CellsBuilder cells: @escaping () -> C) {
		renderer.render(cells: cells)
	}
	
	public func reload(_ sections: [Section]) {
		renderer.render(sections)
	}
	
	public func reload<T: SubviewProtocol>(header: ViewNode? = nil, @LazyBuilder cells: @escaping () -> LazyBuilder.Collection<T>, footer: ViewNode? = nil) {
		reload([Section(id: UniqueIdentifier(), header: header, cells: cells().items.enumerated().map { CellNode(LazyComponent(id: $0.offset, create: $0.element)) }, footer: footer)])
	}
	
	public func bind<S: SectionsBuildable, O: ObservableConvertibleType>(_ binder: O, @SectionsBuilder sections: @escaping (O.Element) -> S) {
		disposeBag = DisposeBag()
		binder.asObservable().subscribe(onNext: {[weak self] in
			self?.renderer.render(sections($0).buildSections())
		}).disposed(by: disposeBag)
	}
	
	public func bind<C: CellsBuildable, O: ObservableConvertibleType>(_ binder: O, @CellsBuilder cells: @escaping (O.Element) -> C) {
		disposeBag = DisposeBag()
		binder.asObservable().subscribe(onNext: {[weak self] in
			self?.renderer.render(Section(id: UniqueIdentifier(), cells: cells($0).buildCells()))
		}).disposed(by: disposeBag)
	}
	
	public func bind<C: CellsBuildable, O: ObservableConvertibleType>(_ binder: O, @CellsBuilder cells: @escaping (O.Element.Element) -> C) where O.Element: Collection {
		disposeBag = DisposeBag()
		binder.asObservable().subscribe(onNext: {[weak self] in
			self?.renderer.render(Section(id: UniqueIdentifier(), cells: $0.map { cells($0).buildCells() }.joined()))
		}).disposed(by: disposeBag)
	}
	
	public func bind<C: SubviewProtocol, O: ObservableConvertibleType>(_ binder: O, @GenericBuilder cells: @escaping (O.Element.Element) -> C) where O.Element: Collection {
		disposeBag = DisposeBag()
		binder.asObservable().subscribe(onNext: {[weak self] in
			self?.renderer.render(Section(id: UniqueIdentifier(), cells: $0.map { item in CellNode(LazyComponent(id: UniqueIdentifier(), create: { cells(item) })) }))
		}).disposed(by: disposeBag)
	}
	
	public func bind<S: SectionsBuildable, O: ObservableConvertibleType>(_ binder: O, @SectionsBuilder sections: @escaping (O.Element.Element) -> S) where O.Element: Collection {
		disposeBag = DisposeBag()
		binder.asObservable().subscribe(onNext: {[weak self] in
			self?.renderer.render($0.map { sections($0).buildSections() }.joined())
		}).disposed(by: disposeBag)
	}
	
	private var disposeBag: DisposeBag {
		get {
			let current = objc_getAssociatedObject(self, &bagKey) as? DisposeBag
			let bag = current ?? DisposeBag()
			if current == nil {
				objc_setAssociatedObject(self, &bagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			}
			return bag
		}
		set {
			objc_setAssociatedObject(self, &bagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
}

private var bagKey = "disposeBagKey043400"

struct LazyComponent<ID: Hashable>: IdentifiableComponent {
	let id: ID
	var create: () -> SubviewProtocol
	
	func renderContent() -> UIView {
		CellView {
			create()
		}
	}
	
	func render(in content: UIView) {}
	
}

fileprivate final class CellView: UIView {
	
	override func addSubview(_ view: UIView) {
		super.addSubview(view)
		view.ignoreAutoresizingMask()
		view.edges() =| 0
	}
	
}

extension Section {
	
	public init<I: Hashable, ID: Hashable, C: Swift.Collection>(id: I, header: ViewNode? = nil, items: C, cellId: KeyPath<C.Element, ID>, @GenericBuilder cells: @escaping (C.Element) -> SubviewProtocol, footer: ViewNode? = nil) {
		self = Section(id: id, header: header, cells: items.map { item in
			CellNode(LazyComponent(id: id, create: { cells(item) }))
		}, footer: footer)
	}
	
	public init<I: Hashable, C: Swift.Collection>(id: I, header: ViewNode? = nil, items: C, @GenericBuilder cells: @escaping (C.Element) -> SubviewProtocol, footer: ViewNode? = nil) where C.Element: Hashable {
		self = Section(id: id, header: header, items: items, cellId: \.self, cells: cells, footer: footer)
	}
	
//	public init<I: Hashable, T: SubviewProtocol>(id: I, header: ViewNode? = nil, @LazyBuilder cells: @escaping () -> LazyBuilder.Collection<T>, footer: ViewNode? = nil) {
//		self = Section(id: id, header: header, cells: cells(), footer: footer)
//	}
//	
//	public init<I: Hashable, T: SubviewProtocol>(id: I, header: ViewNode? = nil, cells: LazyBuilder.Collection<T>, footer: ViewNode? = nil) {
//	self = Section(id: id, header: header, cells: cells.items.enumerated().map { CellNode(LazyComponent(id: $0.offset, create: $0.element)) }, footer: footer)
//	}
//	
}

private struct UniqueIdentifier: Hashable {}

extension CellsBuilder {

	public static func buildExpression(_ expression: @escaping @autoclosure () -> UIView) -> CellsBuildable {
		LazyComponent(id: UUID(), create: expression)
	}
	
//	@inlinable
//	public static func buildExpression<C: CellsBuildable>(_ expression: C) -> CellsBuildable {
//		expression
//	}
	
}
