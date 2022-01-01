//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation

public enum Logs {
	public static var areEnabled = true
	
	static func log(_ action: () -> Void) {
		#if DEBUG
		guard areEnabled else { return }
		action()
		#endif
	}
}
