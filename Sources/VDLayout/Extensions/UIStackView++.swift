import UIKit
import VDChain

extension UIStackView: CustomAddSubviewType {

	public func customAdd(subview: UIView) {
		addArrangedSubview(subview)
	}
}

public extension Subview where Self: UIStackView {

	static func V(
		spacing: CGFloat = 0,
		alignment: VAlignment = .fill,
		distribution: Distribution = .fill,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function,
		@SubviewBuilder _ subviews: () -> any Subview = { EmptySubview() }
	) -> Chain<SubviewInstallerChain<EmptyChaining<Self>>> {
		let result = Self()
		result.axis = .vertical
		result.spacing = spacing
		result.alignment = alignment.origin
		result.distribution = distribution
		result.setRestorationID(fileID: file, line: line, function: function)
		return result.chain.subview(subview: subviews)
	}

	static func H(
		spacing: CGFloat = 0,
		alignment: HAlignment = .fill,
		distribution: Distribution = .fill,
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function,
		@SubviewBuilder _ subviews: () -> any Subview = { EmptySubview() }
	) -> Chain<SubviewInstallerChain<EmptyChaining<Self>>> {
		let result = Self()
		result.axis = .horizontal
		result.spacing = spacing
		result.alignment = alignment.origin
		result.distribution = distribution
		result.setRestorationID(fileID: file, line: line, function: function)
		return result.chain.subview(subview: subviews)
	}
}

public extension UIStackView {

	@frozen
	enum VAlignment {

		case center, fill, leading, trailing

		public var origin: Alignment {
			switch self {
			case .center: return .center
			case .fill: return .fill
			case .leading: return .leading
			case .trailing: return .trailing
			}
		}
	}

	@frozen
	enum HAlignment {

		case center, fill, top, bottom, firstBaseline, lastBaseline

		public var origin: Alignment {
			switch self {
			case .center: return .center
			case .fill: return .fill
			case .top: return .top
			case .bottom: return .bottom
			case .firstBaseline: return .firstBaseline
			case .lastBaseline: return .lastBaseline
			}
		}
	}
}
