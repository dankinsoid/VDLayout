//
//  UICollection.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

#if canImport(Carbon)
import Foundation
import UIKit
import Carbon
import Combine

open class UICollection: UICollectionView, RenderableView {
	
	open var renderer = Renderer(adapter: UICollectionAdapter(), updater: UICollectionViewUpdater())
	
	open weak var scrollDelegate: UIScrollViewDelegate? {
		get { renderer.adapter.scrollDelegate }
		set { renderer.adapter.scrollDelegate = newValue }
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
	
	private func afterInit() {
		renderer.target = self
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
