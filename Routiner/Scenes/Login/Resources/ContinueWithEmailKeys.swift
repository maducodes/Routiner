import Foundation

enum ContinueWithEmailKeys: String, Localizable {
    case headerTitle
    case headerButtonAcessibility
    case textFieldEmail
    case textFieldEmailPlaceholder
    case textFieldPassword
    case textFieldPasswordPlaceholder
    case forgotPassword
    case createAccount
    case next
    case nextAccessibility

    var tableName: String {
        return "ContinueWithEmail"
    }
}
