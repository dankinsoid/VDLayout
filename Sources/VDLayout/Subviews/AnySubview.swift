import Foundation

/// `AnySubview` is a type-erased wrapper around any type that conforms to the `Subview`
/// protocol. It enables you to work with disparate types in a uniform way.
public struct AnySubview: Subview {

	public let subviewInstaller: SubviewInstaller

	public init(_ subview: any Subview) {
		subviewInstaller = subview.subviewInstaller
	}
}
