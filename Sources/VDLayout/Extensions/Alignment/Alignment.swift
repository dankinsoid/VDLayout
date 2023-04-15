import UIKit
import VDPin

extension UIView {
	
	public typealias VerticalAlignment = UIStackView.HAlignment
	public typealias HorizontalAlignment = UIStackView.VAlignment
	
	public struct Alignment: Hashable {
		
		public var vertical: VerticalAlignment
		public var horizontal: HorizontalAlignment
		
		public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
			self.vertical = vertical
			self.horizontal = horizontal
		}
	}
}


extension UIView.Alignment {
	
	/// A guide that marks the center of the view.
	///
	/// This alignment combines the ``VerticalAlignment/center``
	/// horizontal guide and the ``HorizontalAlignment/center``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, Center, appears at the center of the
	/// square.](Alignment-center-1-iOS)
	public static var center: UIView.Alignment {
		UIView.Alignment(horizontal: .center, vertical: .center)
	}
	
	public static var fill: UIView.Alignment {
		UIView.Alignment(horizontal: .fill, vertical: .fill)
	}
	
	/// A guide that marks the leading edge of the view.
	///
	/// This alignment combines the ``VerticalAlignment/leading``
	/// horizontal guide and the ``HorizontalAlignment/center``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, Leading, appears on the left edge of the
	/// square, centered vertically.](Alignment-leading-1-iOS)
	public static var leading: UIView.Alignment {
		UIView.Alignment(horizontal: .leading, vertical: .center)
	}
	
	/// A guide that marks the trailing edge of the view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/center``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, Trailing, appears on the right edge of the
	/// square, centered vertically.](Alignment-trailing-1-iOS)
	public static var trailing: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .center)
	}
	
	/// A guide that marks the trailing edge of the view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/fill``
	/// vertical guide
	public static var trailingFill: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .fill)
	}
	
	/// A guide that marks the top edge of the view.
	///
	/// This alignment combines the ``VerticalAlignment/center``
	/// horizontal guide and the ``HorizontalAlignment/top``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, Top, appears on the top edge of the
	/// square, centered horizontally.](Alignment-top-1-iOS)
	public static var top: UIView.Alignment {
		UIView.Alignment(horizontal: .center, vertical: .top)
	}
	
	public static var topFill: UIView.Alignment {
		UIView.Alignment(horizontal: .fill, vertical: .top)
	}
	
	/// A guide that marks the bottom edge of the view.
	///
	/// This alignment combines the ``VerticalAlignment/center``
	/// horizontal guide and the ``HorizontalAlignment/bottom``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, Bottom, appears on the bottom edge of the
	/// square, centered horizontally.](Alignment-bottom-1-iOS)
	public static var bottom: UIView.Alignment {
		UIView.Alignment(horizontal: .center, vertical: .bottom)
	}
	
	public static var bottomFill: UIView.Alignment {
		UIView.Alignment(horizontal: .fill, vertical: .bottom)
	}
	
	/// A guide that marks the top and leading edges of the view.
	///
	/// This alignment combines the ``VerticalAlignment/leading``
	/// horizontal guide and the ``HorizontalAlignment/top``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, topLeading, appears in the upper-left corner of
	/// the square.](Alignment-topLeading-1-iOS)
	public static var topLeading: UIView.Alignment {
		UIView.Alignment(horizontal: .leading, vertical: .top)
	}
	
	/// A guide that marks the top and trailing edges of the view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/top``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, topTrailing, appears in the upper-right corner of
	/// the square.](Alignment-topTrailing-1-iOS)
	public static var topTrailing: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .top)
	}
	
	/// A guide that marks the bottom and leading edges of the view.
	///
	/// This alignment combines the ``VerticalAlignment/leading``
	/// horizontal guide and the ``HorizontalAlignment/bottom``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, bottomLeading, appears in the lower-left corner of
	/// the square.](Alignment-bottomLeading-1-iOS)
	public static var bottomLeading: UIView.Alignment {
		UIView.Alignment(horizontal: .leading, vertical: .bottom)
	}
	
	/// A guide that marks the bottom and trailing edges of the view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/bottom``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, bottomTrailing, appears in the lower-right corner of
	/// the square.](Alignment-bottomTrailing-1-iOS)
	public static var bottomTrailing: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .bottom)
	}
	
	/// A guide that marks the top-most text baseline in a view.
	///
	/// This alignment combines the ``VerticalAlignment/center``
	/// horizontal guide and the ``HorizontalAlignment/firstTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, centerFirstTextBaseline, appears aligned with, and
	/// partially overlapping, the first line of the text in the upper quadrant,
	/// centered horizontally.](Alignment-centerFirstTextBaseline-1-iOS)
	public static var centerFirstBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .center, vertical: .firstBaseline)
	}
	
	public static var fillFirstBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .fill, vertical: .firstBaseline)
	}
	
	/// A guide that marks the bottom-most text baseline in a view.
	///
	/// This alignment combines the ``VerticalAlignment/center``
	/// horizontal guide and the ``HorizontalAlignment/lastTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, centerLastTextBaseline, appears aligned with, and
	/// partially overlapping, the last line of the text in the lower quadrant,
	/// centered horizontally.](Alignment-centerLastTextBaseline-1-iOS)
	public static var centerLastBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .center, vertical: .lastBaseline)
	}
	
	public static var fillLastBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .fill, vertical: .lastBaseline)
	}
	
	/// A guide that marks the leading edge and top-most text baseline in a
	/// view.
	///
	/// This alignment combines the ``VerticalAlignment/leading``
	/// horizontal guide and the ``HorizontalAlignment/firstTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, leadingFirstTextBaseline, appears aligned with, and
	/// partially overlapping, the first line of the text in the upper quadrant.
	/// The box aligns with the left edge of the
	/// square.](Alignment-leadingFirstTextBaseline-1-iOS)
	public static var leadingFirstBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .leading, vertical: .firstBaseline)
	}
	
	/// A guide that marks the leading edge and bottom-most text baseline
	/// in a view.
	///
	/// This alignment combines the ``VerticalAlignment/leading``
	/// horizontal guide and the ``HorizontalAlignment/lastTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, leadingLastTextBaseline, appears aligned with the
	/// last line of the text in the lower quadrant. The box aligns with the
	/// left edge of the square.](Alignment-leadingLastTextBaseline-1-iOS)
	public static var leadingLastBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .leading, vertical: .lastBaseline)
	}
	
	/// A guide that marks the trailing edge and top-most text baseline in
	/// a view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/firstTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, trailingFirstTextBaseline, appears aligned with the
	/// first line of the text in the upper quadrant. The box aligns with the
	/// right edge of the square.](Alignment-trailingFirstTextBaseline-1-iOS)
	public static var trailingFirstBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .firstBaseline)
	}
	
	/// A guide that marks the trailing edge and bottom-most text baseline
	/// in a view.
	///
	/// This alignment combines the ``VerticalAlignment/trailing``
	/// horizontal guide and the ``HorizontalAlignment/lastTextBaseline``
	/// vertical guide:
	///
	/// ![A square that's divided into four equal quadrants. The upper-
	/// left quadrant contains the text, Some text in an upper quadrant. The
	/// lower-right quadrant contains the text, More text in a lower quadrant.
	/// In both cases, the text is split over two lines. A blue box that
	/// contains the text, trailingLastTextBaseline, appears aligned with the
	/// last line of the text in the lower quadrant. The box aligns with the
	/// right edge of the square.](Alignment-trailingLastTextBaseline-1-iOS)
	public static var trailingLastBaseline: UIView.Alignment {
		UIView.Alignment(horizontal: .trailing, vertical: .lastBaseline)
	}
}

extension Pinnable {
	
	@discardableResult
	public func pin(
		alignment: UIView.Alignment,
		to toItem: (any NSLayoutConstraintable)? = nil,
		options: NSLayoutConstraint.Options...,
		file: String = #fileID,
		line: UInt = #line
	) -> ConstraintsCollection {
		pin(alignment: alignment, CGFloat(0), to: toItem, options: NSLayoutConstraint.Options(options), file: file, line: line)
	}
	
	@discardableResult
	public func pin<Value: ConstraintsRangeConvertable>(
		alignment: UIView.Alignment,
			_ value: Value,
			to toItem: (any NSLayoutConstraintable)? = nil,
			options: NSLayoutConstraint.Options...,
			file: String = #fileID,
			line: UInt = #line
	) -> ConstraintsCollection {
		pin(alignment.attributes, value, to: toItem, options: NSLayoutConstraint.Options(options), file: file, line: line)
	}
}

extension UIView.Alignment {
	
	public var attributes: NSLayoutConstraint.Attribute.Set {
		[horizontal.attributes, vertical.attributes]
	}
}

extension UIStackView.VAlignment {
	
	public var attributes: NSLayoutConstraint.Attribute.Set {
		switch self {
		case .center: return .centerY
		case .fill: return .edges(.vertical)
		case .leading: return .leading
		case .trailing: return .trailing
		}
	}
}

extension UIStackView.HAlignment {
	
	public var attributes: NSLayoutConstraint.Attribute.Set {
		switch self {
		case .center: return .centerX
		case .fill: return .edges(.horizontal)
		case .top: return .top
		case .bottom: return .bottom
		case .firstBaseline: return .firstBaseline
		case .lastBaseline: return .lastBaseline
		}
	}
}
