import Foundation

@resultBuilder
public enum CellsSectionsBuilder {
	
	public static func buildBlock(_ components: [CellsSection]...) -> [CellsSection] {
		Array(components.joined())
	}
	
	@inlinable
	public static func buildArray(_ components: [[CellsSection]]) -> [CellsSection] {
		Array(components.joined())
	}
	
	@inlinable
	public static func buildEither(first component: [CellsSection]) -> [CellsSection] {
		component
	}
	
	@inlinable
	public static func buildEither(second component: [CellsSection]) -> [CellsSection] {
		component
	}
	
	@inlinable
	public static func buildOptional(_ component: [CellsSection]?) -> [CellsSection] {
		component ?? []
	}
	
	@inlinable
	public static func buildLimitedAvailability(_ component: [CellsSection]) -> [CellsSection] {
		component
	}
	
	@inlinable
	public static func buildExpression(_ expression: CellsSection) -> [CellsSection] {
		[expression]
	}
	
	@inlinable
	public static func buildExpression<C: Sequence>(_ expression: C) -> [CellsSection] where C.Element == CellsSection {
		Array(expression)
	}
}

public extension Array<CellsSection> {
	
	init(@CellsSectionsBuilder _ builder: () -> [CellsSection]) {
		self = builder()
	}
}
