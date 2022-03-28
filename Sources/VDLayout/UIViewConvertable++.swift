//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

//extension UIViewConvertable {
//	var UI: UI {
//		(self as? UILayoutable)?.layout ?? _layout
//	}
//	
//	public func updateUILayout() {
//		updateUILayout() {}
//	}
//	
//	public func updateUILayout(action: () -> Void) {
//		update {
//			action()
//			update(UI: UI, for: asUIView)
//		}
//	}
//	
//	public func update(elements: @autoclosure () -> [AnyUIElementType], codeID: CodeID = CodeID(file: #file, line: #line, column: #column)) {
//		update {
//			UI(
//				flat: elements().enumerated().map {
//					UI(element: $0.element, id: UIIdentity(codeID: codeID, type: type(of: $0.element)).id($0.offset))
//				}
//			)
//		}
//	}
//	
//	public func update(layout: @autoclosure () -> UI) {
//		update(layout: layout)
//	}
//	
//	public func update(@UIBuilder layout: () -> UI) {
//		update {
//			update(UI: layout(), for: asUIView)
//		}
//	}
//	
//	func update(UI: UI, for uiView: UIView) {
//		guard !isUpdating, Thread.isMainThread else {
//			return
//		}
//		isUpdating = true
//		defer { isUpdating = false }
//		let UI = UI(flat: [UI] + associated._layouts.map { $0.value })
//		var subviewNodes = Dictionary(
//			uiElements.compactMap { view in view.associated.nodeID.map { ($0, view) } }
//		) { _, new in
//			new
//		}
//		uiElements = []
//		for node in UI.nodes {
//			uiElements.append(node.update(superview: uiView, current: subviewNodes[node.id]))
//			subviewNodes[node.id] = nil
//		}
//		for (_, view) in subviewNodes {
//			view.remove(from: uiView)
//		}
//		if let pin = self.context.environments.pin {
//			subscribeLayout {[weak self] in
//				self?.layout(pin: pin)
//			}
//		}
//	}
//	
//	internal(set) public var isUpdating: Bool {
//		get { associated.isUpdating }
//		set { associated.isUpdating = newValue }
//	}
//	
//	public var updaters: [CodeID: Any] {
//		get { associated.updaters }
//		set { associated.updaters = newValue }
//	}
//	
//	public func applyEnvironments() {
//		context.environments.uiElement.apply(for: self)
//	}
//	
//	private(set) var _layout: UI {
//		get { associated._layout }
//		set { associated._layout = newValue }
//	}
//	
//	var uiElements: [UIViewConvertable] {
//		get { associated.uiElements }
//		set { associated.uiElements = newValue }
//	}
//}
//
//private extension AssociatedValues {
//	
//	var isUpdating: Bool {
//		get { self[\.isUpdating] ?? false }
//		set { self[\.isUpdating] = newValue }
//	}
//	
//	var updaters: [CodeID: Any] {
//		get { self[\.updaters] ?? [:] }
//		set { self[\.updaters] = newValue }
//	}
//	
//	var _layout: UI {
//		get { self[\._layout] ?? [] }
//		set { self[\._layout] = newValue }
//	}
//	
//	var uiElements: [UIViewConvertable] {
//		get { self[\.uiElements] ?? [] }
//		set { self[\.uiElements] = newValue }
//	}
//}
//
//extension AssociatedValues {
//	var nodeID: UIIdentity? {
//		get { self[\.nodeID] ?? nil }
//		set { self[\.nodeID] = newValue }
//	}
//}
