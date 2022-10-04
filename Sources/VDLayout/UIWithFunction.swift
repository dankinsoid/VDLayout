import UIKit

open class LtView: UIView {
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		afterInit()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		afterInit()
	}
	
	open func afterInit() {
		add(createLayout)
	}
	
	@SubviewsBuilder
	open func createLayout() -> [SubviewProtocol] {}
	
}

open class LtViewController: UIViewController {
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		view.add(createLayout)
	}
	
	@SubviewsBuilder
	open func createLayout() -> [SubviewProtocol] {}
	
}
