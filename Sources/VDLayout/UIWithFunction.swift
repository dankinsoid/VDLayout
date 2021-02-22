//
//  File.swift
//  
//
//  Created by Данил Войдилов on 14.02.2021.
//

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
	open func createLayout() -> SubviewsArrayConvertable {}
	
}

open class LtViewController: UIViewController {
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		view.add(createLayout)
	}
	
	@SubviewsBuilder
	open func createLayout() -> SubviewsArrayConvertable {}
	
}
