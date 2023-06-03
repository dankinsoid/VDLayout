import UIKit

/// `SubviewInstaller` protocol defines the requirements for an object that can install
/// and configure a `Subview` on a `UIView`.
public protocol SubviewInstaller {

	/// Method for installing a `Subview` on a `UIView`.
	///
	/// - Parameter superview: The `UIView` where the `Subview` is to be installed.
	func install(on superview: UIView?)

	/// Method for configuring a `Subview` on a `UIView`.
	///
	/// - Parameter superview: The `UIView` to be configured.
	func configure(on superview: UIView?)
}

/// `AnySubviewInstaller` is a type-erased wrapper around any type that conforms to the
/// `SubviewInstaller` protocol. It enables you to work with disparate types in a
/// uniform way.
public struct AnySubviewInstaller: SubviewInstaller {

	private let _install: (UIView?) -> Void
	private let _configure: (UIView?) -> Void

	public init(
		install: @escaping (UIView?) -> Void,
		configure: @escaping (UIView?) -> Void
	) {
		_install = install
		_configure = configure
	}

	public init(_ base: SubviewInstaller) {
		self.init(install: base.install, configure: base.configure)
	}

	public func install(on superview: UIView?) {
		_install(superview)
	}

	public func configure(on superview: UIView?) {
		_configure(superview)
	}
}
