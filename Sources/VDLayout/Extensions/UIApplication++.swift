import UIKit

extension UIApplication {
    
    var isLTRLanguage: Bool {
        userInterfaceLayoutDirection == .leftToRight
    }
}
