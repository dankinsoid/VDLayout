//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import Foundation

@dynamicMemberLookup
public final class AssociatedValues<Base: AnyObject> {
	private var values: [PartialKeyPath<Base>: Any] = [:]
	
	public init() {}
	
	public subscript<T>(_ keyPath: KeyPath<Base, T>) -> T? {
		get {
			if let any = values[keyPath], type(of: any) == T.self {
				return any as? T
			}
			return nil
		}
		set {
			guard let newValue = newValue else { return }
			values[keyPath] = newValue
		}
	}
	
	public subscript<T>(dynamicMember keyPath: KeyPath<Base, T>) -> T? {
		get {
			self[keyPath]
		}
		set {
			self[keyPath] = newValue
		}
	}
}

extension NSObjectProtocol {
	public var associated: AssociatedValues<Self> {
		get {
			if let result = objc_getAssociatedObject(self, &key) as? AssociatedValues<Self> {
				return result
			}
			let result = AssociatedValues<Self>()
			objc_setAssociatedObject(self, &key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			return result
		}
		set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}
}

private var key = "key"
