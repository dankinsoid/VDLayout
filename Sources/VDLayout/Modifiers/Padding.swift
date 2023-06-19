import SwiftUI
import VDChain
import VDPin

public extension Chain where Base.Root: UIView, Base: ValueChaining {

	@_disfavoredOverload
	func padding(_ value: CGFloat) -> Chain<EmptyChaining<PaddingView>> {
		padding(.all, value)
	}

	@_disfavoredOverload
	func padding(_ edges: Edge.Set, _ value: CGFloat) -> Chain<EmptyChaining<PaddingView>> {
		padding(NSDirectionalEdgeInsets(edges, value))
	}

	@_disfavoredOverload
	func padding(_ first: NSDirectionalEdgeInsets, _ last: NSDirectionalEdgeInsets...) -> Chain<EmptyChaining<PaddingView>> {
		PaddingView.subview {
			self
		}
		.insets(last.reduce(into: first, +=))
	}
}

public extension Chain<EmptyChaining<PaddingView>> {

	func padding(_ value: CGFloat) -> Chain {
		padding(.all, value)
	}

	func padding(_ edges: Edge.Set, _ value: CGFloat) -> Chain {
		padding(NSDirectionalEdgeInsets(edges, value))
	}

	func padding(_ first: NSDirectionalEdgeInsets, _ last: NSDirectionalEdgeInsets...) -> Chain {
		self.do {
			$0.insets = last.reduce(into: $0.insets + first, +=)
		}
	}
}

public final class PaddingView: UIView {

	var insets: NSDirectionalEdgeInsets = .zero {
		didSet {
			guard insets != oldValue else { return }
			invalidateIntrinsicContentSize()
			updateEdgesConstraints()
		}
	}

	private var edgesConstraints: [ObjectIdentifier: [Edge: Constraints]] = [:]

	override public var intrinsicContentSize: CGSize {
		guard subviews.count == 1 else {
			return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
		}
		var result = subviews[0].intrinsicContentSize
		result.width += insets.leading + insets.trailing
		result.height += insets.top + insets.bottom
		return result
	}

	override public func addSubview(_ view: UIView) {
		super.addSubview(view)
		edgesConstraints[ObjectIdentifier(view)] = [
			.leading: view.pin(.leading, insets.leading),
			.trailing: view.pin(.trailing, insets.trailing),
			.top: view.pin(.top, insets.top),
			.bottom: view.pin(.bottom, insets.bottom),
		]
		invalidateIntrinsicContentSize()
	}

	private func updateEdgesConstraints() {
		subviews.forEach {
			edgesConstraints[ObjectIdentifier($0)]?[.leading]?.update(constant: insets.leading)
			edgesConstraints[ObjectIdentifier($0)]?[.trailing]?.update(constant: insets.trailing)
			edgesConstraints[ObjectIdentifier($0)]?[.top]?.update(constant: insets.top)
			edgesConstraints[ObjectIdentifier($0)]?[.bottom]?.update(constant: insets.bottom)
		}
	}
}
