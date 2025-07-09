import Foundation

enum OnboardingKeys: String, Localizable {
    case stepOneTitle
    case stepOneDescription
    case stepTwoTitle
    case stepTwoDescription
    case stepThreeTitle
    case stepThreeDescription
    case termsTitle
    case loginButtonName
    case pageAccessibility
    case loginAccessibilityButtonName
    case facebook
    case google
    case apple
    case email

    var tableName: String {
        return "Onboarding"
    }
}
