//
//  File.swift
//  
//
//  Created by Данил Войдилов on 19.02.2021.
//

import UIKit

extension UIImageView: _ExpressibleByImageLiteral {}
extension UIView: _ExpressibleByColorLiteral {}

extension _ExpressibleByImageLiteral where Self: UIImageView {
	public init(imageLiteralResourceName path: String) {
		self.init(image: UIImage(imageLiteralResourceName: path))
	}
}

extension _ExpressibleByColorLiteral where Self: UIView {
	public init(_colorLiteralRed: Float, green: Float, blue: Float, alpha: Float) {
		self.init()
		backgroundColor = UIColor(_colorLiteralRed: _colorLiteralRed, green: green, blue: blue, alpha: alpha)
	}
}
