//
//  UICollection.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

#if canImport(Carbon)
import Foundation
import UIKit
import VDKit
import Carbon
import Combine
import CombineOperators

open class UICollection: UICollectionView, RenderableView {
	
	open var renderer = Renderer(adapter: UICollectionAdapter(), updater: UICollectionViewUpdater())
	
	open var sizeDependsOnContent = false {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}
	
	open weak var scrollDelegate: UIScrollViewDelegate? {
		get { renderer.adapter.scrollDelegate }
		set { renderer.adapter.scrollDelegate = newValue }
	}
	
	override open var contentSize: CGSize {
		didSet {
			if sizeDependsOnContent {
				invalidateIntrinsicContentSize()
			}
		}
	}
	
	override open var intrinsicContentSize: CGSize {
		if sizeDependsOnContent {
			return contentSize
		} else {
			return super.intrinsicContentSize
		}
	}
	
	required public init() {
		super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		afterInit()
	}
	
	public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		afterInit()
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		afterInit()
	}
	
	public convenience init<C: Collection>(sectionsLayout: Layout, _ data: C) where C.Element == LayoutedSection {
		self.init()
		render(sectionsLayout: sectionsLayout, data)
	}
	
	public convenience init(sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: () -> [LayoutedSection]) {
		self.init()
		render(sectionsLayout: sectionsLayout, sections: sections)
	}
	
	public convenience init<C: Swift.Collection>(_ data: C, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: (C.Element) -> [LayoutedSection]) {
		self.init()
		render(data, sectionsLayout: sectionsLayout, sections: sections)
	}
	
	public convenience init<O: Publisher>(one binder: O, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: @escaping (O.Output) -> [LayoutedSection]) {
		self.init()
		bind(one: binder, sectionsLayout: sectionsLayout, sections: sections)
	}
	
	public convenience init<O: Publisher>(_ binder: O, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection>sections: @escaping (O.Output.Element) -> [LayoutedSection]) where O.Output: Collection {
		self.init()
		bind(binder, sectionsLayout: sectionsLayout, sections: sections)
	}
	
	private func afterInit() {
		renderer.target = self
	}
	
	public func render<C: Collection>(sectionsLayout: Layout, _ data: C) where C.Element == LayoutedSection {
		render(data.map { $0.section })
		let layouts = data.map { $0.layout }
		layout = SectionedLayout(sectionsLayout, section: { layouts[$0 % layouts.count] }, for: self)
	}
	
	public func render(sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: () -> [LayoutedSection]) {
		render(sectionsLayout: sectionsLayout, sections())
	}
	
	public func render<C: Swift.Collection>(_ data: C, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: (C.Element) -> [LayoutedSection]) {
		render(sectionsLayout: sectionsLayout, data.map(sections).joined())
	}
	
	public func bind<O: Publisher>(one binder: O, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: @escaping (O.Output) -> [LayoutedSection]) {
		binder.asDriver() => {[weak self] in
			self?.render(sectionsLayout: sectionsLayout, sections($0))
		}
	}
	
	public func bind<O: Publisher>(_ binder: O, sectionsLayout: Layout, @ArrayBuilder<LayoutedSection> sections: @escaping (O.Output.Element) -> [LayoutedSection]) where O.Output: Collection {
		binder.asDriver() => {[weak self] in
			self?.render($0, sectionsLayout: sectionsLayout, sections: sections)
		}
	}
}

extension UICollectionView {
	public var flowLayout: UICollectionViewFlowLayout? {
		collectionViewLayout as? UICollectionViewFlowLayout
	}
}

public final class UICollectionAdapter: UICollectionViewFlowLayoutAdapter {
	
	public weak var scrollDelegate: UIScrollViewDelegate?
	
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidScroll?(scrollView)
	}
	
	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidZoom?(scrollView)
	}
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
	}
	
	public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		scrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
	}
	
	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
	}
	
	public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
	}
	
	public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
	}
	
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		scrollDelegate?.viewForZooming?(in: scrollView)
	}
	
	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		scrollDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
	}
	
	public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
		scrollDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
	}
	
	public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
		scrollDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
	}
	
	public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
	}
	
	public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
		scrollDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
	}
	
}
#endif
