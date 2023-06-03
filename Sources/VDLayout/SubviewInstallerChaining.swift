import UIKit
import VDChain

public protocol SubviewInstallerChaining<Root>: Chaining {

	func installer(for root: Root) -> SubviewInstaller
}

public struct SubviewInstallerChain<Base: SubviewInstallerChaining>: SubviewInstallerChaining {

	public let base: Base
	private let installer: (SubviewInstaller, Base.Root) -> SubviewInstaller

	public init(
		_ base: Base,
		installer: @escaping (SubviewInstaller, Base.Root) -> SubviewInstaller
	) {
		self.base = base
		self.installer = installer
	}

	public func apply(on root: inout Base.Root) {
		base.apply(on: &root)
	}

	public func installer(for root: Base.Root) -> SubviewInstaller {
		installer(base.installer(for: root), root)
	}
}

/// Extension that enables `Chain` to conform to `Subview` protocol when `Base.Root` is
/// a subclass of `AnyObject` and `Base` conforms to `SubviewInstallerChaining` and `ValueChaining`.
extension Chain where Base: SubviewInstallerChaining {

	public func installer(
		_ installer: @escaping (SubviewInstaller, Base.Root) -> SubviewInstaller
	) -> Chain<SubviewInstallerChain<Base>> {
		SubviewInstallerChain(base, installer: installer).wrap()
	}

	func on(
		install: @escaping (Base.Root, UIView?) -> Void,
		configure: @escaping (Base.Root, UIView?) -> Void
	) -> Chain<SubviewInstallerChain<Base>> {
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

extension SubviewInstallerChain: ValueChaining where Base: ValueChaining {

	public var root: Base.Root { base.root }
}

extension SubviewInstallerChain: ConsistentChaining where Base: ConsistentChaining {

	public func getAllValues(for root: Base.Root) -> Base.AllValues {
		base.getAllValues(for: root)
	}

	public func applyAllValues(_ values: Base.AllValues, for root: inout Base.Root) {
		base.applyAllValues(values, for: &root)
	}
}

extension SubviewInstallerChain: KeyPathChaining where Base: KeyPathChaining {

	public var values: [PartialKeyPath<Base.Root>: Any] {
		base.values
	}
}

extension EmptyChaining: SubviewInstallerChaining where Root: Subview {

	public func installer(for root: Root) -> SubviewInstaller {
		root.subviewInstaller
	}
}

extension TypeChain: SubviewInstallerChaining where Root: Subview {

	public func installer(for root: Root) -> SubviewInstaller {
		root.subviewInstaller
	}
}

extension KeyPathChain: SubviewInstallerChaining where Base: SubviewInstallerChaining {

	public func installer(for root: Base.Root) -> SubviewInstaller {
		base.installer(for: root)
	}
}

extension ChainedChain: SubviewInstallerChaining where Base: SubviewInstallerChaining {

	public func installer(for root: Base.Root) -> SubviewInstaller {
		base.installer(for: root)
	}
}

extension DoChain: SubviewInstallerChaining where Base: SubviewInstallerChaining {

	public func installer(for root: Base.Root) -> SubviewInstaller {
		base.installer(for: root)
	}
}

extension ModifierChain: SubviewInstallerChaining where Base: SubviewInstallerChaining {

	public func installer(for root: Base.Root) -> SubviewInstaller {
		base.installer(for: root)
	}
}
