import Foundation

/// `EmptySubview` is a `Subview` that has no content. It can be useful as a placeholder
/// or for cases where you want to conditionally display content.
public struct EmptySubview: Subview {

	public var subviewInstaller: any SubviewInstaller {
		AnySubviewInstaller(install: { _ in }, configure: { _ in })
	}

	public init() {}
}
