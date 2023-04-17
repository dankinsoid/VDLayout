import VDChain
import SwiftUI

/// A `SwiftUI` view that represents a `UIKit` view (`UIView`, `UIViewController`).
///
///  - Overview:
/// Create a `UIKitView` object when you want to integrate `UIKit` views into a `SwiftUI` view hierarchy.
/// At creation time, specify an autoclosure that creates the `UIKit` view and a closure that updates the view.
/// You can set view properties via method chaining and `uiKitViewEnvironment` modifier.
/// Use the `UIKitView` like you would any other view.
@dynamicMemberLookup
public struct UIKitView<Content: UIKitRepresentable>: View, Chaining {
	
	private let content: Content
	@Environment(\.uiKitView) private var environment
	@Environment(UIKitViewChainKey<Content.Content>.self) private var applier
	
	public var body: some View {
		var result = content
		let updater = result.updater
		result.updater = {
			var view = $0
			updater(view, $1)
			applier(&view)
			environment.apply(for: view)
		}
		return result
	}
	
	init(_ content: Content) {
		self.content = content
	}
	
	public subscript<A>(dynamicMember keyPath: KeyPath<Content.Content, A>) -> PropertyChain<UIKitView<Content>, A> {
		PropertyChain(self, getter: keyPath)
	}
	
	public func apply(on root: inout Content.Content) {
	}
}

public extension UIKitView {
	
	init<T>(_ make: @escaping @autoclosure () -> Content.Content, update: @escaping (Content.Content, Content.ViewContext) -> Void = { _, _ in })
	where Content == AnyUIViewRepresentable<T> {
		self.init(make, update: update)
	}
	
	init<T>(_ make: @escaping @autoclosure () -> Content.Content, update: @escaping (Content.Content, Content.ViewContext) -> Void = { _, _ in })
	where Content == AnyUIViewControllerRepresentable<T> {
		self.init(make, update: update)
	}
	
	init<T>(@ValueBuilder<Content.Content> _ make: @escaping () -> Content.Content, update: @escaping (Content.Content, Content.ViewContext) -> Void = { _, _ in })
	where Content == AnyUIViewRepresentable<T> {
		var wrapper = Content(make)
		wrapper.updater = update
		self = .init(wrapper)
	}
	
	init<T>(@ValueBuilder<Content.Content> _ make: @escaping () -> Content.Content, update: @escaping (Content.Content, Content.ViewContext) -> Void = { _, _ in })
	where Content == AnyUIViewControllerRepresentable<T> {
		var wrapper = Content(make)
		wrapper.updater = update
		self = .init(wrapper)
	}
}

public protocol UIKitRepresentable: View {
	
	associatedtype Content
	associatedtype ViewContext
	var updater: (Content, ViewContext) -> Void { get set }
	init(_ make: @escaping () -> Content)
}

public struct AnyUIViewRepresentable<Content: UIView>: UIKitRepresentable {
	
	let make: () -> Content
	public var updater: (Content, Context) -> Void = { _, _ in }
	
	public init(_ make: @escaping () -> Content) {
		self.make = make
	}
}

extension AnyUIViewRepresentable: UIViewRepresentable {
	
	public func makeUIView(context: Context) -> Content {
		make()
	}
	
	public func updateUIView(_ uiView: Content, context: Context) {
		updater(uiView, context)
	}
    
    @available(iOS 16.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: Content, context: Context) -> CGSize? {
        uiView.sizeThatFits(proposal)
    }
}

public struct AnyUIViewControllerRepresentable<Content: UIViewController>: UIKitRepresentable {
	
	let make: () -> Content
	public var updater: (Content, Context) -> Void = { _, _ in }
	
	public init(_ make: @escaping () -> Content) {
		self.make = make
	}
}

extension AnyUIViewControllerRepresentable: UIViewControllerRepresentable {
	
	public func makeUIViewController(context: Context) -> Content {
		make()
	}
	
	public func updateUIViewController(_ uiViewController: Content, context: Context) {
		updater(uiViewController, context)
	}
    
    @available(iOS 16.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: Content, context: Context) -> CGSize? {
        uiViewController.view.sizeThatFits(proposal)
    }
}

@available(iOS 16.0, *)
private extension UIView {
    
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize? {
        let targetSize = CGSize(
            width: proposal.width ?? intrinsicContentSize.width,
            height: proposal.height ?? intrinsicContentSize.height
        )
        let horizontalPriority: UILayoutPriority
        if intrinsicContentSize.width == UIView.noIntrinsicMetric {
            horizontalPriority = .defaultLow
        } else if targetSize.width > intrinsicContentSize.width {
            horizontalPriority = contentHuggingPriority(for: .horizontal)
        } else {
            horizontalPriority = contentCompressionResistancePriority(for: .horizontal)
        }
        let verticalPriority: UILayoutPriority
        if intrinsicContentSize.height == UIView.noIntrinsicMetric {
            verticalPriority = .defaultLow
        } else if targetSize.height > intrinsicContentSize.height {
            verticalPriority = contentHuggingPriority(for: .vertical)
        } else {
            verticalPriority = contentCompressionResistancePriority(for: .vertical)
        }
        return systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalPriority,
            verticalFittingPriority: verticalPriority
        )
    }
}
