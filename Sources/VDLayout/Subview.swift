import Foundation

/// A `Subview` is a fundamental building block of views in your library. It is an interface
/// that defines the structure and behavior of the views in the library.
public protocol Subview {

	/// `subviewInstaller` is a computed property that returns an instance of `SubviewInstaller`.
	var subviewInstaller: any SubviewInstaller { get }
}
