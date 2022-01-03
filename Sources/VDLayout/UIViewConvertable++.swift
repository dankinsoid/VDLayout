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
			action()
			update(uiLayout: uiLayout, for: asUIView)
		}
	}
	
	public func update(elements: @autoclosure () -> [AnyUIElementType], codeID: CodeID = CodeID(file: #file, line: #line, column: #column)) {
		update {
			UILayout(
				flat: elements().enumerated().map {
					UILayout(element: $0.element, id: UIIdentity(codeID: codeID, type: type(of: $0.element)).id($0.offset))
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
			uiElements.compactMap { view in view.associated.nodeID.map { ($0, view) } }
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
		if let pin = self.context.environments.pin {
			subscribeLayout {[weak self] in
				self?.layout(pin: pin)
			}
		}
	}
	
	internal(set) public var isUpdating: Bool {
		get { associated.isUpdating }
		set { associated.isUpdating = newValue }
	}
	
	public var updaters: [CodeID: Any] {
		get { associated.updaters }
		set { associated.updaters = newValue }
	}
	
	public func applyEnvironments() {
		context.environments.uiElement.apply(for: self)
	}
	
	private(set) var _layout: UILayout {
		get { associated._layout }
		set { associated._layout = newValue }
	}
	
	var uiElements: [UIViewConvertable] {
		get { associated.uiElements }
		set { associated.uiElements = newValue }
	}
}

private extension AssociatedValues {
	
	var isUpdating: Bool {
		get { self[\.isUpdating] ?? false }
		set { self[\.isUpdating] = newValue }
	}
	
	var updaters: [CodeID: Any] {
		get { self[\.updaters] ?? [:] }
		set { self[\.updaters] = newValue }
	}
	
	var _layout: UILayout {
		get { self[\._layout] ?? [] }
		set { self[\._layout] = newValue }
	}
	
	var uiElements: [UIViewConvertable] {
		get { self[\.uiElements] ?? [] }
		set { self[\.uiElements] = newValue }
	}
}

extension AssociatedValues {
	var nodeID: UIIdentity? {
		get { self[\.nodeID] ?? nil }
		set { self[\.nodeID] = newValue }
	}
}
