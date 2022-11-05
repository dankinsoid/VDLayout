#if canImport(UIKit)
import UIKit
import Combine
import CombineCocoa

public protocol SubviewProtocol {
	func createViewToAdd() -> UIView
}

extension UIView: SubviewProtocol {
	public func createViewToAdd() -> UIView { self }
}

extension UIViewController: SubviewProtocol {
	
	public func createViewToAdd() -> UIView {
		loadViewIfNeeded()
        let disposable = view.cb.movedToWindow.sink {[weak self] in
            guard let `self` = self else { return }
            self.view.superview?.vc?.addChild(self)
        }
        objc_setAssociatedObject(self, &disposeBagKey, disposable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return view
	}
}

private var disposeBagKey = "disposeBag"

extension UIView {
	
	fileprivate var vc: UIViewController? {
		(next as? UIViewController) ?? (next as? UIView)?.vc
	}
}

extension UIView {
	
	public convenience init(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) {
		self.init()
		subviews().forEach(add)
	}
	
	public func add(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) {
		subviews().forEach(add)
	}
	
	public func with(_ subviews: [SubviewProtocol]) -> Self {
		subviews.forEach(add)
		return self
	}
	
	public func with(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) -> Self {
		with(subviews())
	}
	
	public func callAsFunction(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) -> Self {
		with(subviews())
	}
	
	public func add(subview: SubviewProtocol) {
		let view = subview.createViewToAdd()
		view.translatesAutoresizingMaskIntoConstraints = false
		if let stack = self as? UIStackView {
			stack.addArrangedSubview(view)
		} else {
			addSubview(view)
		}
	}
}

extension UIViewController {
	
	public func add(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) {
		subviews().forEach(add)
	}
	
	public func with(_ subviews: [SubviewProtocol]) -> Self {
		subviews.forEach(add)
		return self
	}
	
	public func with(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) -> Self {
		with(subviews())
	}
	
	public func callAsFunction(@SubviewsBuilder _ subviews: () -> [SubviewProtocol]) -> Self {
		with(subviews())
	}
	
	public func add(subview: SubviewProtocol) {
		loadViewIfNeeded()
		view.add(subview: subview)
	}
}

final class CancelWrapper {
	var cancel: (() -> Void)?
}

extension UIColor: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		let view = UIView()
		view.backgroundColor = self
		return view
	}
}

extension UIImage: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		let view = UIImageView(image: self)
		view.contentMode = .scaleAspectFit
		return view
	}
}

extension String: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		let result = UILabel()
		result.text = self
		return result
	}
}
#endif
