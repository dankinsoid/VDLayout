import UIKit
import VDChain

extension UIView: SubviewProtocol {
    
    public var subviewInstaller: SubviewInstaller {
        UIViewInstaller(self)
    }
}

private struct UIViewInstaller: SubviewInstaller {
    
    let view: UIView
    
    init(_ view: UIView) {
        self.view = view
    }
    
    func install(on superview: UIView) {
        if let customAdd = superview as? CustomAddSubviewType {
            customAdd.customAdd(subview: view)
        } else {
            superview.addSubview(view)
        }
    }
    
    func configure(on superview: UIView) {
    }
}

public extension UIView {
    
    func add(@SubviewsBuilder subviews: () -> [SubviewProtocol]) {
        add(subviews: subviews())
    }
    
    func add(subviews: [SubviewProtocol]) {
        let installers = subviews.map(\.subviewInstaller)
        installers.forEach {
            $0.install(on: self)
        }
        installers.forEach {
            $0.configure(on: self)
        }
    }
    
    func add(subview: SubviewProtocol) {
        add(subviews: [subview])
    }
    
    func setRestorationID(fileID: String, line: UInt, function: String) {
        restorationIdentifier = "\(fileID) \(line)"
    }
    
    var controller: UIViewController? {
        (next as? UIViewController) ?? superview?.controller
    }
}

public extension NSObjectProtocol where Self: UIView {
    
    func withID(
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function
    ) -> Self {
        setRestorationID(fileID: file, line: line, function: function)
        return self
    }
}

public extension SubviewProtocol where Self: UIView {
    
    static func subviews(
        file: String = #fileID,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder subviews: () -> [SubviewProtocol]
    ) -> Chain<some SubviewChaining<Self>> {
        Self.init().chain
            .subviews(subviews: subviews)
            .restorationID(file: file, line: line, function: function)
            
    }
    
    func callAsFunction(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Chain<some SubviewChaining<Self>> {
        chain.subviews(subviews: subviews)
    }
}
