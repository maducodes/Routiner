
import UIKit

enum InputState {
    case disabled
    case _default
    case active
    case filled
}

struct TextFieldViewModel {
    var placeholder: String
    var label: String
    var imageIcon: UIImage?
    var isVisibleImageIcon: Bool
    var isEnabled: Bool
    var borderColor: UIColor?
    var keyboardType: UIKeyboardType?
    var isSecutiryTextEntry: Bool
    
    init(placeholder: String,
         label: String,
         imageIcon: UIImage? = nil,
         isEnabled: Bool,
         borderColor: UIColor? = nil,
         keyboardType: UIKeyboardType? = nil,
         isSecutiryTextEntry: Bool = false,
         isVisibleImageIcon: Bool = false) {
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
