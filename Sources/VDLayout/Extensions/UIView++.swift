import UIKit

extension UIView: SubviewProtocol {
    
    public func createViewToAdd() -> UIView { self }
}

public extension UIView {
    
    convenience init(@SubviewsBuilder subviews: () -> [SubviewProtocol]) {
        self.init()
        add(subviews: subviews)
    }
    
    func add(@SubviewsBuilder subviews: () -> [SubviewProtocol]) {
        add(subviews: subviews())
    }
    
    func add(subviews: [SubviewProtocol]) {
        subviews.forEach(add)
    }
    
    func with(subviews: [SubviewProtocol]) -> Self {
        add(subviews: subviews)
        return self
    }
    
    func callAsFunction(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Self {
        with(subviews: subviews)
    }
    
    func with(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Self {
        with(subviews: subviews())
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
