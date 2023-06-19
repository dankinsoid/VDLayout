import SwiftUI
@_exported import UIKitViews

public extension UIKitView {

	init<C: ValueChaining>(
		_ make: @escaping () -> Chain<C>
	) where C.Root: Subview, Base == UIKitViewChain<AnyUIViewRepresentable<C.Root>> {
		self.init {
			let chain = make()
			let installer = chain.subviewInstaller
			installer.install(on: nil)
			installer.configure(on: nil)
			return chain.base.root
		}
	}

	init<C: ValueChaining>(
		_ make: @escaping () -> Chain<C>
	) where C.Root: Subview, Base == UIKitViewChain<AnyUIViewControllerRepresentable<C.Root>> {
		self.init {
			let chain = make()
			let installer = chain.subviewInstaller
			installer.install(on: nil)
			installer.configure(on: nil)
			return chain.base.root
		}
	}
}
