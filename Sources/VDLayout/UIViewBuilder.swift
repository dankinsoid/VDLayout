import UIKit
#if canImport(SwiftUI)
import SwiftUI
#endif

@resultBuilder
public enum SubviewsBuilder {
    
    public static func buildBlock(_ components: [SubviewProtocol]...) -> [SubviewProtocol] {
        Array(components.joined())
    }
    
    @inlinable
    public static func buildArray(_ components: [[SubviewProtocol]]) -> [SubviewProtocol] {
        Array(components.joined())
    }
    
    @inlinable
    public static func buildEither(first component: [SubviewProtocol]) -> [SubviewProtocol] {
        component
    }
    
    @inlinable
    public static func buildEither(second component: [SubviewProtocol]) -> [SubviewProtocol] {
        component
    }
    
    @inlinable
    public static func buildOptional(_ component: [SubviewProtocol]?) -> [SubviewProtocol] {
        component ?? []
    }
    
    @inlinable
    public static func buildLimitedAvailability(_ component: [SubviewProtocol]) -> [SubviewProtocol] {
        component
    }
    
    @inlinable
    public static func buildExpression(_ expression: some SubviewProtocol) -> [SubviewProtocol] {
        [expression]
    }
    
    @inlinable
    public static func buildExpression(_ expression: any SubviewProtocol) -> [SubviewProtocol] {
        [expression]
    }
    
    @inlinable
    public static func buildExpression(_ expression: some Sequence<SubviewProtocol>) -> [SubviewProtocol] {
        Array(expression)
    }
}
