import UIKit
import VDChain

extension Chain: Subview where Base.Root: AnyObject, Base: SubviewInstallerChaining & ValueChaining {

	public var subviewInstaller: any SubviewInstaller {
		ChainInstaller(chain: self, installer: base.installer(for: base.root))
	}
}

extension Chain: SingleSubview where Base.Root: AnyObject & SingleSubview, Base: SubviewInstallerChaining & ValueChaining {

	public func asSingleSubview() -> Base.Root {
		subviewInstaller.install(on: nil)
		subviewInstaller.configure(on: nil)
		return apply()
	}
}

private struct ChainInstaller<Base: SubviewInstallerChaining & ValueChaining>: SubviewInstaller where Base.Root: AnyObject {

	let chain: Chain<Base>
	let installer: SubviewInstaller

	func install(on superview: UIView?) {
		installer.install(on: superview)
	}

	func configure(on superview: UIView?) {
		installer.configure(on: superview)
		chain.apply()
	}
}
