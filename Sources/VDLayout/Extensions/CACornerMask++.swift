import UIKit

public extension CACornerMask {

	static var topLeft: CACornerMask { .layerMinXMinYCorner }
	static var topRight: CACornerMask { .layerMaxXMinYCorner }
	static var bottomLeft: CACornerMask { .layerMinXMaxYCorner }
	static var bottomRight: CACornerMask { .layerMaxXMaxYCorner }

	static var all: CACornerMask { [.topRight, .topLeft, .bottomRight, .bottomLeft] }
	static var top: CACornerMask { [.topRight, .topLeft] }
	static var bottom: CACornerMask { [.bottomRight, .bottomLeft] }
	static var left: CACornerMask { [.topLeft, .bottomLeft] }
	static var right: CACornerMask { [.topRight, .bottomRight] }

	static func excluding(_ corners: CACornerMask, _ other: CACornerMask...) -> CACornerMask {
		CACornerMask.all.subtracting(corners.union(CACornerMask(other)))
	}
}
