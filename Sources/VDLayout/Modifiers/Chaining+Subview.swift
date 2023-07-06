import UIKit
import VDChain

public extension ChainValues where Root: Subview {

	var installer: (_ root: Root) -> SubviewInstaller {
		get { get(\.installer) ?? { $0.subviewInstaller } }
		set { set(\.installer, newValue) }
	}
}

/// Extension that enables `Chain` to conform to `Subview` protocol when `Base.Root` is
/// a subclass of `AnyObject` and `Base` conforms to `SubviewInstallerChaining` and `ValueChaining`.
extension Chain where Base.Root: Subview {

	public func installer(
		_ installer: @escaping (SubviewInstaller, Base.Root) -> SubviewInstaller
	) -> Chain<Base> {
		reduce(\.installer) { installerFor in
            return { [installerFor] root in
				installer(installerFor(root), root)
			}
		}
	}

	func on(
		install: @escaping (Base.Root, UIView?) -> Void,
		configure: @escaping (Base.Root, UIView?) -> Void
	) -> Chain<Base> {
		installer { installer, root in
			AnySubviewInstaller { superview in
				installer.install(on: superview)
				install(root, superview)
			} configure: { superview in
				installer.configure(on: superview)
				configure(root, superview)
			}
		}
	}
}
