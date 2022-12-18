import SwiftUI

@available(iOS 13.0, *)
public struct UIKitView<V: SingleSubviewProtocol>: UIViewRepresentable where V.Root: UIView {
    
    let make: () -> V
    
    public init(_ make: @escaping () -> V) {
        self.make = make
    }
    
    public init(_ make: @escaping @autoclosure () -> V) {
        self.make = make
    }
    
    public func makeUIView(context: Context) -> V.Root {
        make().asSubview()
    }
    
    public func updateUIView(_ uiView: V.Root, context: Context) {}
    
}

@available(iOS 13.0, *)
public struct UIKitViewController<V: SingleSubviewProtocol>: UIViewControllerRepresentable where V.Root: UIViewController {
    
    public let make: () -> V
    
    public init(_ make: @escaping () -> V) {
        self.make = make
    }
    
    public init(_ make: @escaping @autoclosure () -> V) {
        self.make = make
    }
    
    public func makeUIViewController(context: Context) -> V.Root {
        make().asSubview()
    }
    
    public func updateUIViewController(_ uiViewController: V.Root, context: Context) {}
}
