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
    
    func setRestorationID(filePath: String, line: UInt, function: String) {
        let path = filePath.components(separatedBy: ["/"]).suffix(1).joined(separator: "/")
        restorationIdentifier = "\(path) \(line) - \(function)"
    }
}

public extension NSObjectProtocol where Self: UIView {
    
    func withID(
        file: String = #file,
        line: UInt = #line,
        function: String = #function
    ) -> Self {
        setRestorationID(filePath: file, line: line, function: function)
        return self
    }
}

public extension SubviewProtocol where Self: UIView {
    
    static func subviews(
        file: String = #file,
        line: UInt = #line,
        function: String = #function,
        @SubviewsBuilder subviews: () -> [SubviewProtocol]
    ) -> Chain<some ValueChaining<Self>> {
        Self.init().chain
            .subviews(subviews: subviews)
            .restorationID(file: file, line: line, function: function)
            
    }
    
    func callAsFunction(@SubviewsBuilder subviews: () -> [SubviewProtocol]) -> Chain<some ValueChaining<Self>> {
        chain.subviews(subviews: subviews)
    }
}
