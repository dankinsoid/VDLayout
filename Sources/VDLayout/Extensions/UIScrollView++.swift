import Foundation
import UIKit
import VDPin
import VDChain

public extension SubviewProtocol where Self: UIScrollView {
    
    static func V(
        spacing: CGFloat = 0,
        alignment: UIStackView.VAlignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }
    ) -> SubviewChain<Self> {
        Self.subviews {
            UIStackView.V(
                spacing: spacing,
                alignment: alignment,
                distribution: distribution,
                file: file,
                line: line,
                function: function,
                subviews
            )
            .pin(.edges)
            .pin(.centerX)
        }
        .bounces(.vertical)
        .showsIndicators(.vertical)
        .any()
    }
    
    static func H(
        spacing: CGFloat = 0,
        alignment: UIStackView.HAlignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder _ subviews: () -> [SubviewProtocol] = { [] }
    ) -> SubviewChain<Self> {
        Self.subviews {
            UIStackView.H(
                spacing: spacing,
                alignment: alignment,
                distribution: distribution,
                file: file,
                line: line,
                function: function,
                subviews
            )
            .pin(.edges)
            .pin(.centerY)
        }
        .bounces(.horizontal)
        .showsIndicators(.horizontal)
        .any()
    }
}
