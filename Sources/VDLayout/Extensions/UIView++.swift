import UIKit
import VDChain

extension UIView: SingleSubview {

	public typealias _Body = Never

	public var subviewInstaller: any SubviewInstaller {
		UIViewInstaller(self)
	}
}

private struct UIViewInstaller: SubviewInstaller {

	let view: UIView

	init(_ view: UIView) {
		self.view = view
	}

	func install(on superview: UIView?) {
		if let customAdd = superview as? CustomAddSubviewType {
			customAdd.customAdd(subview: view)
		} else {
			superview?.addSubview(view)
		}
	}

	func configure(on superview: UIView?) {}
}

public extension UIView {

	/// Method that adds a `Subview` to the `UIView`.
	///
	/// - Parameter subview: The `Subview` to add.
	/// - Returns: The `UIView` with the added `Subview`.
	@discardableResult
	func add(@SubviewBuilder subview: () -> any Subview) -> Self {
		add(subview: subview())
		return self
	}

	/// Method that adds a `Subview` to the `UIView`.
	///
	/// - Parameter subview: The `Subview` to add.
	func add(subview: some Subview) {
		let installer = subview.subviewInstaller
		installer.install(on: self)
		installer.configure(on: self)
	}

	func setRestorationID(fileID: String, line: UInt, function: String) {
		restorationIdentifier = "\(fileID) \(line)"
	}

	var controller: UIViewController? {
		(next as? UIViewController) ?? superview?.controller
	}

	func asSingleSubview() -> UIView {
		self
	}
}

public extension NSObjectProtocol where Self: UIView {

	func withID(
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function
	) -> Self {
		setRestorationID(fileID: file, line: line, function: function)
		return self
	}
}

public extension Subview where Self: UIView {

	static func subview(
		file: String = #fileID,
		line: UInt = #line,
		function: String = #function,
		@SubviewBuilder subview: () -> any Subview
	) -> SubviewChain<Self> {
		Self().chain
			.subview(subview: subview)
			.restorationID(file: file, line: line, function: function)
			.any()
	}

	func callAsFunction(@SubviewBuilder subview: () -> any Subview) -> Chain<SubviewInstallerChain<EmptyChaining<Self>>> {
		with(subview: subview)
	}

	func with(@SubviewBuilder subview: () -> any Subview) -> Chain<SubviewInstallerChain<EmptyChaining<Self>>> {
		chain.subview(subview: subview)
	}
}
