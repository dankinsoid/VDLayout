import SwiftUI
import VDChain
@_exported import VDPin

public protocol ConstraintableChaining<Root>: Chaining {

	func constraintable(for root: Root) -> NSLayoutConstraintable
}

public struct ConstraintableChain<Base: Chaining>: ConstraintableChaining {

	public let base: Base
	private let _constraintable: (Base.Root) -> NSLayoutConstraintable

	public init(
		_ base: Base,
		constraintable: @escaping (Base.Root) -> NSLayoutConstraintable
	) {
		self.base = base
		_constraintable = constraintable
	}

	public func apply(on root: inout Base.Root) {
		base.apply(on: &root)
	}

	public func constraintable(for root: Root) -> NSLayoutConstraintable {
		_constraintable(root)
	}
}

public extension Chain {

	func constraintsItem(for item: @escaping (Base.Root) -> NSLayoutConstraintable) -> Chain<ConstraintableChain<Base>> {
		ConstraintableChain(base, constraintable: item).wrap()
	}
}

extension ConstraintableChain: ValueChaining where Base: ValueChaining {

	public var root: Base.Root { base.root }
}

extension ConstraintableChain: ConsistentChaining where Base: ConsistentChaining {

	public func getAllValues(for root: Base.Root) -> Base.AllValues {
		base.getAllValues(for: root)
	}

	public func applyAllValues(_ values: Base.AllValues, for root: inout Base.Root) {
		base.applyAllValues(values, for: &root)
	}
}

extension ConstraintableChain: KeyPathChaining where Base: KeyPathChaining {

	public var values: [PartialKeyPath<Base.Root>: Any] {
		base.values
	}
}

extension ConstraintableChain: SubviewInstallerChaining where Base: SubviewInstallerChaining {

	public func installer(for root: Base.Root) -> SubviewInstaller {
		base.installer(for: root)
	}
}

extension SubviewInstallerChain: ConstraintableChaining where Base: ConstraintableChaining {

	public func constraintable(for root: Base.Root) -> NSLayoutConstraintable {
		base.constraintable(for: root)
	}
}

extension EmptyChaining: ConstraintableChaining where Root: NSLayoutConstraintable {

	public func constraintable(for root: Root) -> NSLayoutConstraintable {
		root
	}
}

extension TypeChain: ConstraintableChaining where Root: NSLayoutConstraintable {

	public func constraintable(for root: Root) -> NSLayoutConstraintable {
		root
	}
}

extension KeyPathChain: ConstraintableChaining where Base: ConstraintableChaining {

	public func constraintable(for root: Base.Root) -> NSLayoutConstraintable {
		base.constraintable(for: root)
	}
}

extension ChainedChain: ConstraintableChaining where Base: ConstraintableChaining {

	public func constraintable(for root: Base.Root) -> NSLayoutConstraintable {
		base.constraintable(for: root)
	}
}

extension DoChain: ConstraintableChaining where Base: ConstraintableChaining {

	public func constraintable(for root: Base.Root) -> NSLayoutConstraintable {
		base.constraintable(for: root)
	}
}

extension ModifierChain: ConstraintableChaining where Base: ConstraintableChaining {

	public func constraintable(for root: Base.Root) -> NSLayoutConstraintable {
		base.constraintable(for: root)
	}
}

extension Chain: Pinnable where Base: ConstraintableChaining {

	public typealias ConstraintsCollection = Chain<DoChain<Base>>

	public func makeConstraints(_ constraints: @escaping (NSLayoutConstraintable) -> [NSLayoutConstraint]) -> Chain<DoChain<Base>> {
		var made = false
		return self.do { [base] subview in
			guard !made else { return }
			_ = constraints(base.constraintable(for: subview))
			made = true
		}
	}
}

public extension Chain where Base.Root: UIView, Base: SubviewInstallerChaining {

	func wrap(
		in wrapper: UIView,
		configure: @escaping (Base.Root) -> Void
	) -> Chain<ConstraintableChain<SubviewInstallerChain<Base>>> {
		installer { installer, root in
			installer.wrap(in: wrapper) {
				configure(root)
			}
		}
		.constraintsItem { _ in
			wrapper
		}
	}
}

public extension SubviewInstaller {

	func wrap(in wrapper: UIView, configure: @escaping () -> Void = {}) -> SubviewInstaller {
		AnySubviewInstaller { [self] superview in
			install(on: wrapper)
			wrapper.subviewInstaller.install(on: superview)
		} configure: { [self] superview in
			self.configure(on: wrapper)
			wrapper.subviewInstaller.configure(on: superview)
			configure()
		}
	}
}

private struct WrappedConstraintable: NSLayoutConstraintable {

	var constraintItem: AnyObject

	init(base: NSLayoutConstraintable) {
		constraintItem = forConstraints(base.constraintItem)
	}
}

private func forConstraints(_ object: AnyObject) -> AnyObject {
	let associated = objc_getAssociatedObject(object, &constraintKey) as? ConstraintableWrapper
	if let associated {
		return associated
	}
	return object
}

private var constraintKey = "constraintKey"

private final class ConstraintableWrapper {

	weak var wrapper: UIView?
}
