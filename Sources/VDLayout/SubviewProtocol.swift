import Foundation

public protocol SubviewProtocol {
    
    var subviewInstaller: SubviewInstaller { get }
}

public protocol SingleSubviewProtocol<Root>: SubviewProtocol {
    
    associatedtype Root
    func asSubview() -> Root
}
