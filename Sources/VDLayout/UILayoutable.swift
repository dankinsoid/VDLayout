//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

import UIKit

public protocol UILayoutable: UIViewConvertable {
	@UIBuilder var layout: UILayout { get }
}
