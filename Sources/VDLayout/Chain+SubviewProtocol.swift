import UIKit
import VDChain

extension Chain: SubviewProtocol where Base.Root: AnyObject, Base: SubviewInstallerChaining & ValueChaining {
    
    public var subviewInstaller: SubviewInstaller {
        ChainInstaller(chain: self, installer: base.installer(for: base.root))
    }
}

extension Chain: SingleSubviewProtocol where Base.Root: AnyObject & SingleSubviewProtocol, Base: SubviewInstallerChaining & ValueChaining {
    
    public func asSubview() -> Base.Root {
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
