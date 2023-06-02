import SwiftUI

extension NSDirectionalEdgeInsets: ExpressibleByDictionaryLiteral {

	public init(dictionaryLiteral elements: (Edge.Set, CGFloat)...) {
		self = .zero
		elements.forEach { edges, value in
			Edge.allCases
				.filter { edges.contains(Edge.Set($0)) }
				.forEach {
					self[$0] += value
				}
		}
	}

	public subscript(_ edge: Edge) -> CGFloat {
		get {
			self[keyPath: NSDirectionalEdgeInsets.keyPath(for: edge)]
		}
		set {
			self[keyPath: NSDirectionalEdgeInsets.keyPath(for: edge)] = newValue
		}
	}

	public static func keyPath(for edge: Edge) -> WritableKeyPath<NSDirectionalEdgeInsets, CGFloat> {
		switch edge {
		case .top: return \.top
		case .leading: return \.leading
		case .bottom: return \.bottom
		case .trailing: return \.trailing
		}
	}

	public static func top(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: value, leading: 0, bottom: 0, trailing: 0)
	}

	public static func leading(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: 0, leading: value, bottom: 0, trailing: 0)
	}

	public static func bottom(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: value, trailing: 0)
	}

	public static func trailing(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: value)
	}

	public static func vertical(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: value, leading: 0, bottom: value, trailing: 0)
	}

	public static func horizontal(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: 0, leading: value, bottom: 0, trailing: value)
	}

	public static func all(_ value: CGFloat) -> NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(top: value, leading: value, bottom: value, trailing: value)
	}

	public static func += (_ lhs: inout NSDirectionalEdgeInsets, _ rhs: NSDirectionalEdgeInsets) {
		lhs.trailing += rhs.trailing
		lhs.leading += rhs.leading
		lhs.top += rhs.top
		lhs.bottom += rhs.bottom
	}

	public static func + (_ lhs: NSDirectionalEdgeInsets, _ rhs: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
		var result = lhs
		result += rhs
		return result
	}
}

public extension NSDirectionalEdgeInsets {

	init(_ edges: Edge.Set, _ value: CGFloat) {
		self = [edges: value]
	}
}
