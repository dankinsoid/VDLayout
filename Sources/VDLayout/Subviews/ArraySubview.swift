import UIKit

extension [any Subview]: Subview {

	public var subviewInstaller: any SubviewInstaller {
		ArraySubviewInstaller(map(\.subviewInstaller))
	}
}

public struct ArraySubviewInstaller: SubviewInstaller {

	private let installers: [any SubviewInstaller]

	public init(_ installers: [any SubviewInstaller]) {
		self.installers = installers
	}

	public func install(on superview: UIView?) {
		installers.forEach { $0.install(on: superview) }
	}

	public func configure(on superview: UIView?) {
		installers.forEach { $0.configure(on: superview) }
	}
}
