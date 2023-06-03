import UIKit

open class UISubview: UIView {

	private var didCallAfterInit = false

	override public init(frame: CGRect) {
		super.init(frame: frame)
		afterInit()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		afterInit()
	}

	open func afterInit() {
		guard !didCallAfterInit else {
			return
		}
		didCallAfterInit = true
		add(subview: content)
		configureConstraints()
	}

	@SubviewBuilder
	open var content: any Subview { EmptySubview() }
	open func configureConstraints() {}
}

open class UISubviewController: UIViewController {

	override open func viewDidLoad() {
		super.viewDidLoad()
		view.add(subview: content)
		configureConstraints()
	}

	@SubviewBuilder
	open var content: any Subview { EmptySubview() }
	open func configureConstraints() {}
}
