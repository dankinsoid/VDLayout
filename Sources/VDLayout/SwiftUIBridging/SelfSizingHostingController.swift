import SwiftUI

open class SelfSizingHostingController<Content>: UIHostingController<Content> where Content: View {
	
	private var wasLoad = false
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		view.setContentHuggingPriority(.required, for: .vertical)
		wasLoad = true
	}
	
	open override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		// viewDidLoad is not being called on iOS 13
		guard !wasLoad else { return }
		loadViewIfNeeded()
		guard !wasLoad else { return }
		viewDidLoad()
	}
	
	open override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.invalidateIntrinsicContentSize()
	}
}
