import Foundation

public protocol UIRender where Parent.Parent == Parent {
	associatedtype Parent: UIRender
	func exists(on parent: Parent) -> Bool
	func add(to parent: Parent)
	func remove(from parent: Parent)
	func asAnyUIRender() -> AnyUIRender<Parent>
}

extension UIRender {
	public func asAnyUIRender() -> AnyUIRender<Parent> {
		AnyUIRender(render: self)
	}
}

public struct AnyUIRender<Parent: UIRender>: UIRender where Parent.Parent == Parent {
	public let base: Any
	private let _exists: (Parent) -> Bool
	private let _add: (Parent) -> Void
	private let _remove: (Parent) -> Void
	
	public init<T: UIRender>(_ render: T) where T.Parent == Parent {
		self = render.asAnyUIRender()
	}
	
	fileprivate init<T: UIRender>(render: T) where T.Parent == Parent {
		base = render
		_exists = render.exists
		_add = render.add
		_remove = render.remove
	}
	
	public func exists(on parent: Parent) -> Bool {
		_exists(parent)
	}
	
	public func add(to parent: Parent) {
		_add(parent)
	}
	
	public func remove(from parent: Parent) {
		_remove(parent)
	}
	
	public func exists(onAny parent: AnyUIRender) -> Bool {
		guard let parent = parent.base as? Parent else { return false }
		return _exists(parent)
	}
	
	public func add(toAny parent: AnyUIRender) {
		guard let parent = parent.base as? Parent else { return }
		_add(parent)
	}
	
	public func remove(fromAny parent: AnyUIRender) {
		guard let parent = parent.base as? Parent else { return }
		_remove(parent)
	}
	
	public func asAnyUIRender() -> AnyUIRender<Parent> { self }
}
