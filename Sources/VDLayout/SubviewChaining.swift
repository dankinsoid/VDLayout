import UIKit
import VDChain

public protocol SubviewChaining<Root>: Chaining {
    
    func installer(for root: Root) -> SubviewInstaller
}

public struct SubviewChain<Base: SubviewChaining>: SubviewChaining {
    
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

public extension Chain where Base: SubviewChaining {
    
    func installer(
        _ installer: @escaping (SubviewInstaller, Base.Root) -> SubviewInstaller
    ) -> Chain<SubviewChain<Base>> {
        SubviewChain(base, installer: installer).wrap()
    }
    
    func on(
        install: @escaping (Base.Root, UIView) -> Void,
        configure: @escaping (Base.Root, UIView) -> Void
    ) -> Chain<SubviewChain<Base>> {
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

extension SubviewChain: ValueChaining where Base: ValueChaining {
    
    public var root: Base.Root { base.root }
}

extension SubviewChain: ConsistentChaining where Base: ConsistentChaining {
    
    public func getAllValues(for root: Base.Root) -> Base.AllValues {
        base.getAllValues(for: root)
    }
    
    public func applyAllValues(_ values: Base.AllValues, for root: inout Base.Root) {
        base.applyAllValues(values, for: &root)
    }
}

extension SubviewChain: KeyPathChaining where Base: KeyPathChaining {
    
    public var values: [PartialKeyPath<Base.Root>: Any] {
        base.values
    }
}

extension EmptyChaining: SubviewChaining where Root: SubviewProtocol {
    
    public func installer(for root: Root) -> SubviewInstaller {
        root.subviewInstaller
    }
}

extension TypeChain: SubviewChaining where Root: SubviewProtocol {
    
    public func installer(for root: Root) -> SubviewInstaller {
        root.subviewInstaller
    }
}

extension KeyPathChain: SubviewChaining where Base: SubviewChaining {
    
    public func installer(for root: Base.Root) -> SubviewInstaller {
        base.installer(for: root)
    }
}

extension ChainedChain: SubviewChaining where Base: SubviewChaining {
    
    public func installer(for root: Base.Root) -> SubviewInstaller {
        base.installer(for: root)
    }
}

extension DoChain: SubviewChaining where Base: SubviewChaining {
    
    public func installer(for root: Base.Root) -> SubviewInstaller {
        base.installer(for: root)
    }
}

extension ModifierChain: SubviewChaining where Base: SubviewChaining {
    
    public func installer(for root: Base.Root) -> SubviewInstaller {
        base.installer(for: root)
    }
}

extension Chain: SubviewProtocol where Base.Root: AnyObject, Base: SubviewChaining & ValueChaining {
    
    public var subviewInstaller: SubviewInstaller {
        ChainInstaller(chain: self)
    }
}

private struct ChainInstaller<Base: SubviewChaining & ValueChaining>: SubviewInstaller where Base.Root: AnyObject {
    
    var chain: Chain<Base>
    
    func install(on superview: UIView) {
        chain.base.installer(for: chain.base.root).install(on: superview)
    }
    
    func configure(on superview: UIView) {
        chain.base.installer(for: chain.base.root).configure(on: superview)
        chain.apply()
    }
}
