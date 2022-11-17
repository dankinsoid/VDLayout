import UIKit

public protocol SubviewProtocol {
    
		func createViewToAdd() -> UIView
    func configureAfterAddToSuperview()
}

public extension SubviewProtocol {
    
    func configureAfterAddToSuperview() {}
}
