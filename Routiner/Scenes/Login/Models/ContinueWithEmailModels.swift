
import Foundation
import UIKit

enum ContinueWithEmail {
    enum Model {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let headerViewModel: HeaderViewModel
            let emailTextField: TextFieldViewModel
            let passwordTextField: TextFieldViewModel
            let forgotPasswordTitle: NSAttributedString
            let createAccountTitle: NSAttributedString
            let forgotPasswordTitleColor: UIColor
            let createAccountTitleColor: UIColor
            let buttonContinueViewModel: ButtonViewModel
        }
    }
}

enum ContinueWithEmailTextFieldType {
    case email
    case password
}
