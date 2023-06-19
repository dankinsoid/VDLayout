import SwiftUI
import VDChain
@_exported import VDPin

extension Chain: Pinnable where Base: ValueChaining, Base.Root: NSLayoutConstraintable {

	public typealias ConstraintsCollection = Chain<Base>

	public func makeConstraints(_ constraints: @escaping (NSLayoutConstraintable) -> [NSLayoutConstraint]) -> Chain<Base> {
		var made = false
		return self.do { [base] _ in
			guard !made else { return }
			_ = constraints(base.root)
			made = true
		}
	}
}
