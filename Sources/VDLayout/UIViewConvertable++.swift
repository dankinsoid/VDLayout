//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

extension UIUpdatableStorage {
	
	public func updating<T>(action: () -> T) -> T {
		UIContext.current = context
		UIContext.current.updating = self
		let result = action()
		UIContext.current.updating = nil
		return result
	}
}

extension UIViewConvertable {
	var uiLayout: UILayout {
		(self as? UILayoutable)?.layout ?? _layout
	}
	
	public func updateUILayout() {
		updateUILayout() {}
	}
	
	public func updateUILayout(action: () -> Void) {
		updating {
			update(uiLayout: uiLayout, for: asUIView)
			action()
		}
	}
	
	public func update(elements: @autoclosure () -> [AnyUIElementType], codeID: CodeID = CodeID(file: #file, line: #line, column: #column)) {
		update {
			UILayout(
				flat: elements().enumerated().map {
					var code = codeID
					code.line += UInt($0.offset) + 1
					return UILayout(element: $0.element, id: UIIdentity(codeID: code, type: type(of: $0.element)))
				}
			)
		}
	}
	
	public func update(layout: @autoclosure () -> UILayout) {
		update(layout: layout)
	}
	
	public func update(@UIBuilder layout: () -> UILayout) {
		updating {
			update(uiLayout: layout(), for: asUIView)
		}
	}
	
	private(set) var _layout: UILayout {
		get { associated._layout ?? [] }
		set { associated._layout = newValue }
	}
	
	func update(uiLayout: UILayout, for uiView: UIView) {
		guard !isUpdating, Thread.isMainThread else {
			return
		}
		associated.isUpdating = true
		defer { associated.isUpdating = false }
		if !(self is UILayoutable) {
			self._layout = uiLayout
		}
		var subviewNodes = Dictionary(
			uiElements.compactMap { view in view.nodeID.map { ($0, view) } }
		) { _, new in
			new
		}
		for node in uiLayout.nodes {
			node.update(superview: uiView, current: subviewNodes[node.id])
			subviewNodes[node.id] = nil
		}
		for (_, view) in subviewNodes {
			view.remove(from: uiView)
		}
		
		let pin = self.context.environments.pin
		subscribeLayout {[weak self] in
			self?.layout(pin: pin)
		}
	}
	
	internal(set) public var isUpdating: Bool {
		get { associated.isUpdating ?? false }
		set { associated.isUpdating = newValue }
	}
	
	public var updaters: [CodeID: Any] {
		get { associated.updaters ?? [:] }
		set { associated.updaters = newValue }
	}
	
	public func applyEnvironments() {
		context.environments.uiElement.apply(for: self)
	}
	
	var uiElements: [UIViewConvertable] {
		get { associated.uiElements ?? [] }
		set { associated.uiElements = newValue }
	}
}