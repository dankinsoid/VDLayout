import Foundation

public protocol UIStructure {
	associatedtype UIRenderType: UIRender
	var id: AnyHashable { get }
	var children: [AnyUIStructure<UIRenderType.Parent>] { get }
	func createRender() -> UIRenderType
	func updateRender(_ render: UIRenderType)
	func asAnyUIStructure() -> AnyUIStructure<UIRenderType.Parent>
}

extension UIStructure {
	public var id: AnyHashable { ObjectIdentifier(Self.self) }
	
	public func updateRender(_ render: UIRenderType) {}
	
	public func asAnyUIStructure() -> AnyUIStructure<UIRenderType.Parent> {
		AnyUIStructure(structure: self)
	}
	
	public func asAnyUIStructure(id: AnyHashable) -> AnyUIStructure<UIRenderType.Parent> {
		AnyUIStructure(structure: self, id: id)
	}
}

public struct AnyUIStructure<Parent: UIRender>: UIStructure where Parent.Parent == Parent {
	public let base: Any
	public var id: AnyHashable { _id() }
	public var children: [AnyUIStructure<Parent>] { _children() }
	private let _id: () -> AnyHashable
	private let _children: () -> [AnyUIStructure<Parent>]
	private let _createRender: () -> AnyUIRender<Parent>
	private let _updateRender: (AnyUIRender<Parent>) -> Void
	
	public init<T: UIStructure>(_ structure: T) where T.UIRenderType.Parent == Parent {
		self = structure.asAnyUIStructure()
	}
	
	fileprivate init<T: UIStructure>(structure: T, id: AnyHashable? = nil) where T.UIRenderType.Parent == Parent {
		base = structure
		_id = {
			if let id = id {
				return structure.id.combined(with: id)
			} else {
				return structure.id
			}
		}
		_children = { structure.children }
		_createRender = { structure.createRender().asAnyUIRender() }
		_updateRender = {
			if let render = $0.base as? T.UIRenderType {
				structure.updateRender(render)
			}
		}
	}
	
	public func createRender() -> AnyUIRender<Parent> {
		_createRender()
	}
	
	public func updateRender(_ render: AnyUIRender<Parent>) {
		_updateRender(render)
	}
	
	public func asAnyUIStructure() -> AnyUIStructure<Parent> { self }
}

#if canImport(UIKit)
import UIKit

//public typealias UI
#elseif canImport(Cocoa)
import Cocoa
#endif
