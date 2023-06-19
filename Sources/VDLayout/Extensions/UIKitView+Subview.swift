import SwiftUI
@_exported import UIKitViews

public extension UIKitView {

	init<C: SubviewInstallerChaining & ValueChaining>(
		_ make: @escaping () -> Chain<C>
	) where Base == UIKitViewChaining<AnyUIViewRepresentable<C.Root>> {
		self.init {
			let chain = make()
      let installer = chain.subviewInstaller
      installer.install(on: nil)
      installer.configure(on: nil)
      return chain.base.root
		}
	}

	init<C: SubviewInstallerChaining & ValueChaining>(
		_ make: @escaping () -> Chain<C>
	) where Base == UIKitViewChaining<AnyUIViewControllerRepresentable<C.Root>> {
		self.init {
			let chain = make()
      let installer = chain.subviewInstaller
      installer.install(on: nil)
      installer.configure(on: nil)
      return chain.base.root
		}
	}
}
