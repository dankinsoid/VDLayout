//
//  File.swift
//  
//
//  Created by Данил Войдилов on 01.01.2022.
//

import Foundation

//public struct UIForEach<Data: Collection, ID: Hashable>: UI {
//	public let data: Data
//	public let element: (Data.Element) -> UI
//	public let getID: (Data.Element) -> ID
//	
//	public var layout: UI {
//		UI(flat: data.map {
//			element($0).id(getID($0))
//		})
//	}
//	
//	public init(_ data: Data, id: @escaping (Data.Element) -> ID, @UIBuilder element: @escaping (Data.Element) -> UI) {
//		self.data = data
//		self.element = element
//		self.getID = id
//	}
//}
//
//extension UIForEach where Data.Element: Identifiable, Data.Element.ID == ID {
//	
//	public init(_ data: Data, @UIBuilder element: @escaping (Data.Element) -> UI) {
//		self.data = data
//		self.element = element
//		self.getID = { $0.id }
//	}
//}
//
//extension UIForEach where Data.Element: Hashable, Data.Element == ID {
//	
//	public init(_ data: Data, @UIBuilder element: @escaping (Data.Element) -> UI) {
//		self.data = data
//		self.element = element
//		self.getID = { $0 }
//	}
//}
