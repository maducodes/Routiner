
import UIKit

enum TextFieldState {
    case disabled
    case _default
    case active
    case error(errorLabel: String)
    case success(borderColor: UIColor)
}

struct TextFieldViewModel {
    var placeholder: NSAttributedString?
    var label: NSAttributedString?
    var imageIcon: UIImage?
    var isVisibleImageIcon: Bool
    var isEnabled: Bool
    var borderColor: UIColor?
    var keyboardType: UIKeyboardType
    var isSecutiryTextEntry: Bool
    var state: TextFieldState
    
    init(state: TextFieldState = .active,
         placeholder: NSAttributedString?,
         label: NSAttributedString?,
         imageIcon: UIImage?,
         isEnabled: Bool = true,
         borderColor: UIColor? = nil,
         keyboardType: UIKeyboardType,
         isSecutiryTextEntry: Bool = false,
         isVisibleImageIcon: Bool = false) {
        self.state = state
        self.placeholder = placeholder
        self.label = label
        self.imageIcon = imageIcon
        self.isEnabled = isEnabled
        self.borderColor = borderColor
        self.keyboardType = keyboardType
        self.isSecutiryTextEntry = isSecutiryTextEntry
        self.isVisibleImageIcon = isVisibleImageIcon
    }
}
