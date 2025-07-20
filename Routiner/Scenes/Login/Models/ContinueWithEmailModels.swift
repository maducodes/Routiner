
import Foundation
import UIKit

enum ContinueWithEmail {
    enum Model {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let emailBorderColor: UIColor?
            let passwordBorderColor: UIColor?
            let emailIcon: UIImage?
            let passwordIcon: UIImage?
            let isVisibleEmailIcon: Bool
            let isVisiblePasswordIcon: Bool
        }
    }
}

enum ContinueWithEmailTextFieldType {
    case email
    case password
}
