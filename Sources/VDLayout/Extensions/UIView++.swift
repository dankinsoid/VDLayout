import UIKit
import VDChain

extension UIView: SubviewProtocol {
    
    public func createViewToAdd() -> UIView { self }
}

public extension UIView {
    
    func add(@SubviewsBuilder subviews: () -> [SubviewProtocol]) {
        add(subviews: subviews())
    }
    
    func add(subviews: [SubviewProtocol]) {
        subviews.forEach(add)
    }
    
    func add(subview: SubviewProtocol) {
        let view = subview.createViewToAdd()
        if let customAdd = self as? CustomAddSubviewType {
            customAdd.customAdd(subview: view)
        } else {
            addSubview(view)
        }
        subview.configureAfterAddToSuperview()
    }
}

public extension SubviewProtocol where Self: UIView {
    
    static func subviews(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Chain<DoChain<EmptyChaining<Self>>> {
        Self.init().chain.subviews(subviews: subviews)
    }
    
    func callAsFunction(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Chain<DoChain<EmptyChaining<Self>>> {
        chain.subviews(subviews: subviews)
    }
}

extension UIView {
    
    var allSuperviews: [UIView] {
        superview.map { [$0] + $0.allSuperviews } ?? []
    }
    
    func commonAncestor(with views: [UIView]) -> UIView? {
        var superviews = [self] + allSuperviews
        for view in views {
            superviews = superviews.commonSuffix(with: [view] + view.allSuperviews)
            guard !superviews.isEmpty else { return nil }
        }
        return superviews.first
    }
    
    func commonAncestor(with view: UIView, _ views: UIView...) -> UIView? {
        commonAncestor(with: [view] + views)
    }
}
