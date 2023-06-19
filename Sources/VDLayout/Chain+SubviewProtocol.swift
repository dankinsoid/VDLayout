import UIKit
import VDChain

public typealias SubviewChain<Root: Subview> = Chain<EmptyChaining<Root>>

extension Chain: Subview where Base.Root: AnyObject & Subview, Base: ValueChaining {

	public var subviewInstaller: any SubviewInstaller {
		ChainInstaller(chain: self, installer: values.installer(base.root))
	}
}

private struct ChainInstaller<Base: ValueChaining>: SubviewInstaller where Base.Root: AnyObject & Subview {

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
