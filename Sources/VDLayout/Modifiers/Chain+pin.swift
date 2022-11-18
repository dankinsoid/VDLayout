import SwiftUI
import VDChain

extension Chain: Pinnable where Base: ValueChaining, Base.Root: NSLayoutConstraintable {
    
    public typealias ConstraintsCollection = Chain<DoChain<Base>>
    
    public func makeConstraints(_ constraints: @escaping (NSLayoutConstraintable) -> [NSLayoutConstraint]) -> Chain<DoChain<Base>> {
        var made = false
        return self.do {
            guard !made else { return }
            _ = constraints($0)
            made = true
        }
    }
}
