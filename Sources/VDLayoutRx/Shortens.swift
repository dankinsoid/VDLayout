//
//  File.swift
//  
//
//  Created by Данил Войдилов on 06.03.2021.
//

import UIKit

extension UIColor: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		let view = UIView()
		view.backgroundColor = self
		return view
	}
}

extension UIImage: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		let view = UIImageView(image: self)
		view.contentMode = .scaleAspectFit
		return view
	}
}

extension String: SubviewProtocol {
	public func createViewToAdd() -> UIView {
		UILabel(self)
	}
}
