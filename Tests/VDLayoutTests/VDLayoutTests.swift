//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.02.2021.
//

import XCTest
@testable import RxSwift
@testable import Carbon
@testable import VDKit
@testable import VDLayout

final class VDTests: XCTestCase {
	
	func tests() {
		let observable = Observable<[Int]>.just([1, 2, 3, 4])
	}
	
//	@SubviewsBuilder
//	func subview() -> [SubviewProtocol] {
//		UIView()
//			.chain
//			.backgroundColor[.red]
//			.edges().equal(to: 0)
//	}
	
	static var allTests = [
		("tests", tests),
	]
	
}

//struct Cmp: IdentifiableComponent {
//	var id: String { "" }
//	func renderContent() -> UIView {
//		UIView()
//	}
//	func render(in content: UIView) {
//		
//	}
//}
//
//@_functionBuilder
//struct _CellsBuilder: CellsBuildable {
//
//	private var cells: [CellNode]
//
//	func buildCells() -> [CellNode] {
//		cells
//	}
//
//	@inlinable
//	public static func buildBlock(_ components: CellsBuildable...) -> CellsBuildable {
//		_CellsBuilder(cells: Array(components.map { $0.buildCells() }.joined()))
//	}
//
//	@inlinable
//	public static func buildArray(_ components: [CellsBuildable]) -> CellsBuildable {
//		_CellsBuilder(cells: Array(components.map { $0.buildCells() }.joined()))
//	}
//
//	@inlinable
//	public static func buildEither(first component: CellsBuildable) -> CellsBuildable {
//		component
//	}
//
//	@inlinable
//	public static func buildEither(second component: CellsBuildable) -> CellsBuildable {
//		component
//	}
//
//	@inlinable
//	public static func buildOptional(_ component: CellsBuildable?) -> CellsBuildable {
//		component ?? _CellsBuilder(cells: [])
//	}
//
//	@inlinable
//	public static func buildLimitedAvailability(_ component: CellsBuildable) -> CellsBuildable {
//		component
//	}
//
//	@inlinable
//	public static func buildExpression<C: CellsBuildable>(_ expression: C) -> CellsBuildable {
//		expression
//	}
//
//	@inlinable
//	public static func buildExpression<C: UIView>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
//		_CellsBuilder(cells: [CellNode(LazyComponent(id: UUID(), create: expression))])
//	}
//
//}
//
//extension _CellsBuilder {
//
//	@inlinable
//	public static func buildExpression<C: SubviewProtocol>(_ expression: @escaping @autoclosure () -> C) -> CellsBuildable {
//		_CellsBuilder(cells: [CellNode(LazyComponent(id: UUID(), create: expression))])
//	}
//
//}
//
//@_CellsBuilder
//func cells() -> CellsBuildable {
//	Cmp()
//	Cmp()
//	if true {
//		Cmp()
//	}
//	UIView()
//}
