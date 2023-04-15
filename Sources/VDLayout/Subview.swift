import Foundation

public protocol Subview {
	
	associatedtype _Body
	typealias Body = _Body
	
	@SubviewBuilder
	var body: Body { get }
	var subviewInstaller: any SubviewInstaller { get }
}

extension Subview where Body == Never {
	
	public var body: Never {
		fatalError()
	}
}

extension Subview where Body == any Subview {
	
	public var subviewInstaller: any SubviewInstaller {
		body.subviewInstaller
	}
}

public protocol SingleSubview<Root>: Subview {
	
	associatedtype Root
	func asSingleSubview() -> Root
}
