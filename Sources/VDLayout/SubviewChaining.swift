import Foundation
import VDChain
import VDPin

public typealias SubviewChaining = ConstraintableChaining & SubviewInstallerChaining & ValueChaining

public typealias SubviewChain<Root> = Chain<AnySubviewChaining<Root>>

public extension Chain where Base: SubviewChaining {
    
    func any() -> SubviewChain<Base.Root> {
        AnySubviewChaining(base).wrap()
    }
    
    func modify(_ modifier: @escaping (inout Base.Root) -> Void) -> SubviewChain<Base.Root> {
        self.do(modifier).any()
    }
}

public struct AnySubviewChaining<Root>: SubviewChaining {
    
    public var root: Root
    private let _constraintable: (_ root: Root) -> NSLayoutConstraintable
    private let _installer: (_ root: Root) -> SubviewInstaller
    private let _apply: (_ root: inout Root) -> Void
    
    public init(
        root: Root,
        _constraintable: @escaping (Root) -> NSLayoutConstraintable,
        _installer: @escaping (Root) -> SubviewInstaller,
        _apply: @escaping (inout Root) -> Void
    ) {
        self.root = root
        self._constraintable = _constraintable
        self._installer = _installer
        self._apply = _apply
    }
    
    public init<T: SubviewChaining>(_ base: T) where T.Root == Root {
        self.init(root: base.root, _constraintable: base.constraintable, _installer: base.installer, _apply: base.apply)
    }
    
    public func constraintable(for root: Root) -> NSLayoutConstraintable {
        _constraintable(root)
    }
    
    public func installer(for root: Root) -> SubviewInstaller {
        _installer(root)
    }
    
    public func apply(on root: inout Root) {
        _apply(&root)
    }
}
