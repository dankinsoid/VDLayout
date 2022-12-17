import SwiftUI
import VDChain
@_exported import VDPin

extension Chain: Pinnable where Base: ValueChaining, Base.Root: NSLayoutConstraintable {
    
    public typealias ConstraintsCollection = Chain<DoChain<Base>>
    
    public func makeConstraints(_ constraints: @escaping (NSLayoutConstraintable) -> [NSLayoutConstraint]) -> Chain<DoChain<Base>> {
        var made = false
        return self.do { subview in
            guard !made else { return }
            _ = constraints(subview)
            made = true
        }
    }
}
