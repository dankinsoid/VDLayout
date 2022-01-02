//
//  File.swift
//  
//
//  Created by Данил Войдилов on 28.12.2021.
//

import UIKit
import VDChain
import Combine
																									
extension ChainProperty where Base.Value: NSObject {
	
	public func callAsFunction<P: Publisher>(_ publisher: P, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> Base where P.Output == Value {
		guard let kp = getter as? ReferenceWritableKeyPath<Base.Value, Value> else { return chaining }
		return subscribe(publisher, file: file, line: line, column: column) {
			$0?[keyPath: kp] = $1
		}
	}
	
	public func callAsFunction<P: Publisher>(_ publisher: P, file: String = #filePath, line: UInt = #line, column: UInt = #column) -> Base where P.Output? == Value {
		guard let kp = getter as? ReferenceWritableKeyPath<Base.Value, Value> else { return chaining }
		return subscribe(publisher, file: file, line: line, column: column) {
			$0?[keyPath: kp] = $1
		}
	}
	
	private func subscribe<P: Publisher>(_ value: P, file: String, line: UInt, column: UInt, set: @escaping (Base.Value?, P.Output) -> Void) -> Base {
		var result = chaining
		let id = CodeID(file: file, line: line, column: column)
		let apply = result.apply
		result.apply = {
			apply(&$0)
			var bags = $0.bags
			guard bags[id] == nil else { return }
			bags[id] = value.sink(receiveCompletion: { _ in }) {[weak base = $0] value in
				set(base, value)
			}
			$0.associated.bags = bags
		}
		return result
	}
}

extension NSObject {
	var bags: [CodeID: AnyCancellable] {
		get { associated.bags ?? [:] }
		set { associated.bags = newValue }
	}
}
