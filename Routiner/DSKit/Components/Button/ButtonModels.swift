
import UIKit

public enum ButtonType {
    case primary
    case secondary
    case outline
}

public enum ButtonWeigth {
    case small
    case medium
    case large
}

struct ButtonViewModel {
    let showIcon: Bool
    let icon: UIImage?
    let iconTint: UIColor?
    let weigth: ButtonWeigth
    let type: ButtonType
    let isEnabled: Bool
    let title: String
    let accessibilityLabel: String
    let accessibilityHint: String?
    let accessibilityValue: String?
    
    init(showIcon: Bool,
         icon: UIImage? = nil,
         iconTint: UIColor? = nil,
         weigth: ButtonWeigth,
         type: ButtonType,
         isEnabled: Bool,
         title: String,
         accessibilityLabel: String,
         accessibilityHint: String? = nil,
         accessibilityValue: String? = nil) {
        self.showIcon = showIcon
        self.icon = icon
        self.iconTint = iconTint
        self.weigth = weigth
        self.type = type
        self.isEnabled = isEnabled
        self.title = title
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.accessibilityValue = accessibilityValue
    }
}
