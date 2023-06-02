import Foundation

public struct EmptySubview: Subview {

	public var subviewInstaller: any SubviewInstaller {
		AnySubviewInstaller(install: { _ in }, configure: { _ in })
	}

	public init() {}
}
