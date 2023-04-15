import SwiftUI

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
   
    @inlinable
    public static func buildExpression(_ expression: ViewCell) -> [CellsSection] {
        buildExpression(
            CellsSection(
                id: "\(expression.id)section",
                cells: [expression]
            )
        )
    }
    
    @inlinable
    public static func buildExpression<T: View>(_ expression: T, file: String = #fileID, line: UInt = #line, column: UInt = #column) -> [CellsSection] {
        buildExpression(
            ViewCell(
                id: "\(String(reflecting: T.self))\(file)\(line)\(column)"
            ) {
                HostingView(expression)
            } reload: { _ in
            }
        )
    }
    
    @inlinable
    public static func buildExpression<T: UIView>(_ expression: @autoclosure @escaping () -> T, file: String = #fileID, line: UInt = #line, column: UInt = #column) -> [CellsSection] {
        buildExpression(
            ViewCell(
                id: "\(String(reflecting: T.self))\(file)\(line)\(column)"
            ) {
                expression()
            } reload: { _ in
            }
        )
    }
    
    @inlinable
    public static func buildExpression<C: Sequence>(_ expression: C, file: String = #fileID, line: UInt = #line, column: UInt = #column) -> [CellsSection] where C.Element == ViewCell {
        buildExpression(
            CellsSection(
                id: "\(file)\(line)\(column)section",
                cells: Array(expression)
            )
        )
    }
}

public extension Array<CellsSection> {
	
	mutating func reload(@CellsSectionsBuilder _ builder: () -> [CellsSection]) {
        self = builder()
	}
}
