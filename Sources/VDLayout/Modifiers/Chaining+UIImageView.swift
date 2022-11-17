import UIKit
import VDChain

public extension Chain where Base.Root: UIImageView {

    func image(_ image: UIImage?) -> Chain<DoChain<Base>> {
        self.do {
            $0.image = image?.imageFlippedForRightToLeftLayoutDirection()
        }
    }

    func tinted(with color: UIColor?) -> Chain<DoChain<Base>> {
        self.do {
            guard let color = color else { return }
            $0.image = $0.image?.withTintColor(color)
        }
    }
}
