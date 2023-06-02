import Foundation

public protocol Subview {

	associatedtype _Body
	typealias Body = _Body

	@SubviewBuilder
	var body: Body { get }
	var subviewInstaller: any SubviewInstaller { get }
}

public extension Subview where Body == Never {

	var body: Never {
		fatalError()
	}
}

public extension Subview where Body == any Subview {

	var subviewInstaller: any SubviewInstaller {
		body.subviewInstaller
	}
}

public protocol SingleSubview<Root>: Subview {

	associatedtype Root
	func asSingleSubview() -> Root
}
