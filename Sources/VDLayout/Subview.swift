import Foundation

/// A `Subview` is a fundamental building block of views in your library. It is an interface
/// that defines the structure and behavior of the views in the library.
public protocol Subview {

	associatedtype _Body
	typealias Body = _Body

	/// `body` is a computed property that returns the body content of the view.
	@SubviewBuilder
	var body: Body { get }

	/// `subviewInstaller` is a computed property that returns an instance of `SubviewInstaller`.
	var subviewInstaller: any SubviewInstaller { get }
}

/// When `Body` is `Never`, calling `body` will cause a runtime error.
public extension Subview where Body == Never {

	var body: Never {
		fatalError()
	}
}

/// When `Body` is a `Subview`, `subviewInstaller` will return the `SubviewInstaller` of the `body`.
public extension Subview where Body == any Subview {

	var subviewInstaller: any SubviewInstaller {
		body.subviewInstaller
	}
}

/// When `Body` is a subtype of `Subview`, `subviewInstaller` will return the `SubviewInstaller` of the `body`.
public extension Subview where Body: Subview {

	var subviewInstaller: any SubviewInstaller {
		body.subviewInstaller
	}
}

/// `SingleSubview` is a protocol that represents a single view in your library.
/// It extends the `Subview` protocol and introduces a new associated type `Root`.
public protocol SingleSubview<Root>: Subview {

	associatedtype Root

	/// Method that converts the instance to a single view of type `Root`.
	func asSingleSubview() -> Root
}
