import SwiftUI
import VDChain

public extension Chain where Base.Root: UIView {

    func rounded(radius: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.cornerRadius = radius
            $0.clipsToBounds = true
        }
    }
    
    func rounded(radius: CGFloat, corners: CACornerMask, _ others: CACornerMask...) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.cornerRadius = radius
            $0.clipsToBounds = true
            $0.layer.maskedCorners = corners.union(CACornerMask(others))
        }
    }

    func alpha(_ value: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.alpha = value
        }
    }

    func filled(_ color: UIColor?) -> Chain<DoChain<Base>> {
        self.do {
            $0.backgroundColor = color
        }
    }

    func clipped(_ isClipped: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.clipsToBounds = isClipped
        }
    }

    func userInteractionEnabled(_ isUserInteractionEnabled: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    func contentMode(_ mode: UIView.ContentMode) -> Chain<DoChain<Base>> {
        self.do {
            $0.contentMode = mode
        }
    }

    func hidden(_ isHidden: Bool = true) -> Chain<DoChain<Base>> {
        self.do {
            $0.isHidden = isHidden
        }
    }

    func border(color: UIColor, width: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.borderColor = color.cgColor
            $0.layer.borderWidth = width
        }
    }

    func shadowed(
        color: UIColor = .black,
        opacity: Float = 0.4,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 6
    ) -> Chain<DoChain<Base>> {
        self.do {
            $0.layer.shadowColor = color.cgColor
            $0.layer.shadowOpacity = opacity
            $0.layer.shadowOffset = offset
            $0.layer.shadowRadius = radius
        }
    }
    
    func margins(_ value: CGFloat) -> Chain<DoChain<Base>> {
        margins(.all, value)
    }
    
    func margins(_ edges: Edge.Set, _ value: CGFloat) -> Chain<DoChain<Base>> {
        self.do {
            if edges.contains(.leading) {
                $0.directionalLayoutMargins.leading += value
            }
            if edges.contains(.trailing) {
                $0.directionalLayoutMargins.trailing += value
            }
            if edges.contains(.top) {
                $0.directionalLayoutMargins.top += value
            }
            if edges.contains(.bottom) {
                $0.directionalLayoutMargins.bottom += value
            }
        }
    }
    
    func margins(insets: NSDirectionalEdgeInsets) -> Chain<DoChain<Base>> {
        self.do {
            $0.directionalLayoutMargins.leading += insets.leading
            $0.directionalLayoutMargins.trailing += insets.trailing
            $0.directionalLayoutMargins.top += insets.top
            $0.directionalLayoutMargins.bottom += insets.bottom
        }
    }
    
    func restorationID(_ id: String) -> Chain<DoChain<Base>> {
        self.do {
            $0.restorationIdentifier = id
        }
    }
    
    func restorationID(file: String = #fileID, line: UInt = #line, function: String = #function) -> Chain<DoChain<Base>> {
        self.do {
            $0.setRestorationID(fileID: file, line: line, function: function)
        }
    }
}

public extension Chain where Base: SubviewChaining, Base.Root: UIView {
    
    func subviews(
        @SubviewsBuilder subviews: () -> [SubviewProtocol]
    ) -> Chain<SubviewChain<Base>> {
        let installers = subviews().map(\.subviewInstaller)
        return self.on { root, superview in
            installers.forEach {
                $0.install(on: root)
            }
        } configure: { root, superview in
            installers.forEach {
                $0.configure(on: root)
            }
        }
    }
}
