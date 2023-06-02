import UIKit

public protocol SubviewInstaller {

	func install(on superview: UIView?)
	func configure(on superview: UIView?)
}

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
