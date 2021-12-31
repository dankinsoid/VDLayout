import UIKit

public protocol AnyUIElementType: UI {
	func _createUIView() -> UIViewConvertable
	func _updateUIView(_ view: UIViewConvertable)
}

public protocol UIElementType: AnyUIElementType {
	associatedtype UIViewType: UIViewConvertable
	func createUIView() -> UIViewType
	func updateUIView(_ view: UIViewType)
}

extension UIElementType {
	public func updateUIView(_ view: UIViewType) {}
}

extension AnyUIElementType where Self: UIElementType {
	
	public func _createUIView() -> UIViewConvertable {
		createUIView()
	}
	
	public func _updateUIView(_ view: UIViewConvertable) {
		guard let typedView = view as? UIViewType else { return }
		updateUIView(typedView)
	}
}
