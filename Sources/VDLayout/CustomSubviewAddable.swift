//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit

public protocol CustomSubviewAddable: UIView {
	func customAddSubview(_ subview: UIView)
}

extension UIStackView: CustomSubviewAddable {
	public func customAddSubview(_ subview: UIView) {
		addArrangedSubview(subview)
	}
}
