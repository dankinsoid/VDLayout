//
//  Stack.swift
//  TestUI (iOS)
//
//  Created by Данил Войдилов on 09.02.2021.
//

import UIKit

extension UIStackView {
	
	public static func V(alignment: VAlignment = .fill, distribution: Distribution = .fill, @UIViewBuilder _ subviews: () -> AnySubviews) -> Self {
		let result = Self.init()
		result.axis = .vertical
		result.alignment = alignment.origin
		result.distribution = distribution
		subviews().asSubviews().forEach(result.add)
		return result
	}
	
	public static func H(alignment: HAlignment = .fill, distribution: Distribution = .fill, @UIViewBuilder _ subviews: () -> AnySubviews) -> Self {
		let result = Self.init()
		result.axis = .horizontal
		result.alignment = alignment.origin
		result.distribution = distribution
		subviews().asSubviews().forEach(result.add)
		return result
	}
	
	@frozen
	public enum VAlignment {
		case сenter, fill, leading, trailing
		public var origin: Alignment {
			switch self {
			case .сenter:		return .center
			case .fill:			return .fill
			case .leading:	return .leading
			case .trailing:	return .trailing
			}
		}
	}
	
	@frozen
	public enum HAlignment {
		case сenter, fill, top, bottom
		public var origin: Alignment {
			switch self {
			case .сenter:	return .center
			case .fill:		return .fill
			case .top:		return .top
			case .bottom:	return .bottom
			}
		}
	}
	
}
