//
//  File.swift
//  
//
//  Created by Данил Войдилов on 02.01.2022.
//

import Foundation
import UIKit

extension UIWindow {
	public static var key: UIWindow? {
		UIApplication.shared.windows.first(where: { $0.isKeyWindow })
	}
}
