import UIKit

public protocol AnyUIElementType {
	func _createUIView() -> UIElementsUpdatable
	func _updateUIView(_ view: UIElementsUpdatable)
}

public protocol UIElementType: AnyUIElementType {
	associatedtype UIViewType: UIElementsUpdatable
	func createUIView() -> UIViewType
	func updateUIView(_ view: UIViewType)
}

extension UIElementType {
	public func updateUIView(_ view: UIViewType) {}
}

extension UIElementType where UIViewType: UIView {
	public func add(to parent: UIView, view: UIViewType) {
		parent.add(subview: view)
	}
	
	public func remove(from parent: UIView, view: UIViewType) {
		view.removeFromSuperview()
	}
}

extension UIElementType where UIViewType: Collection, UIViewType.Element == UIElementNode {
	
	public func updateUIView(_ view: UIViewType) {
		view.forEach {
			$0.update(view)
		}
	}
}

extension AnyUIElementType where Self: UIElementType {
	
	public func _createUIView() -> UIElementsUpdatable {
		createUIView()
	}
	
	public func _updateUIView(_ view: UIElementsUpdatable) {
		guard let typedView = view as? UIViewType else { return }
		updateUIView(typedView)
	}
}
