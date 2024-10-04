import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
