import Foundation
import UIKit

protocol ContinueWithEmailPresentationLogic {
    func presentScreenValues()
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType)
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType)
}

final class ContinueWithEmailPresenter: ContinueWithEmailPresentationLogic {
    weak var viewController: ContinueWithEmailDisplayLogic?
    
    init() {}
    
    func presentScreenValues() {
        let headerViewModel = setupHeaderViewModel()
        let emailViewModel = setupEmailTextFieldViewModel()
        let passwordViewModel = setupPasswordTextFieldViewModel()
        let buttonContinueViewModel = setupButtonContinueViewModel()
        let fogotPasswordTitle = setupTitle(ContinueWithEmailKeys.forgotPassword.string())
        let createAccountTitle = setupTitle(ContinueWithEmailKeys.createAccount.string())
        let viewModel = ContinueWithEmail.Model.ViewModel(headerViewModel: headerViewModel,
                                                          emailTextField: emailViewModel,
                                                          passwordTextField: passwordViewModel,
                                                          forgotPasswordTitle: fogotPasswordTitle,
                                                          createAccountTitle: createAccountTitle,
                                                          forgotPasswordTitleColor: Colors.Primary.Black.black60 ?? UIColor(),
                                                          createAccountTitleColor: Colors.Primary.Blue.blue100 ?? UIColor(),
                                                          buttonContinueViewModel: buttonContinueViewModel)
        viewController?.displayScreen(viewModel: viewModel)
    }
    
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType) {
        viewController?.updateVisibilityImageTextField(isVisible, textFieldType)
    }
    
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        viewController?.clearTextField(textFieldType)
    }
    
    // MARK: - Privates
    
    private func setupEmailTextFieldViewModel() -> TextFieldViewModel {
        let label = NSAttributedString(string: ContinueWithEmailKeys.textFieldEmail.string().uppercased(),
                                   attributes: [.font: Typography.setTypography(using: .chip)])
        let placeholder = NSAttributedString(string: ContinueWithEmailKeys.textFieldEmailPlaceholder.string(),
                                   attributes: [.font: Typography.setTypography(using: .title)])
    
        return TextFieldViewModel(placeholder: placeholder,
                                  label: label,
                                  imageIcon: Images.clear,
                                  borderColor: Colors.Primary.Black.black20,
                                  keyboardType: .emailAddress)
    }
    
    private func setupPasswordTextFieldViewModel() -> TextFieldViewModel {
        let label = NSAttributedString(string: ContinueWithEmailKeys.textFieldPassword.string().uppercased(),
                                   attributes: [.font: Typography.setTypography(using: .chip)])
        let placeholder = NSAttributedString(string: ContinueWithEmailKeys.textFieldPasswordPlaceholder.string(),
                                   attributes: [.font: Typography.setTypography(using: .title)])
        
        return TextFieldViewModel(placeholder: placeholder,
                                  label: label,
                                  imageIcon: Images.clear,
                                  borderColor: Colors.Primary.Black.black20,
                                  keyboardType: .default)
    }
    
    private func setupHeaderViewModel() -> HeaderViewModel {
        return HeaderViewModel(leftIcon: Images.arrowLeft,
                               leftIconAccessibility: ContinueWithEmailKeys.headerButtonAcessibility.string(),
                               title: ContinueWithEmailKeys.headerTitle.string(),
                               background: Colors.Primary.Base.white,
                               hasBottomLine: true)
    }
    
    private func setupButtonContinueViewModel() -> ButtonViewModel {
        return ButtonViewModel(showIcon: true,
                               iconTint: Colors.Primary.Blue.blue100,
                               weigth: .large,
                               type: .primary,
                               isEnabled: true,
                               title:  ContinueWithEmailKeys.next.string(),
                               accessibilityLabel: ContinueWithEmailKeys.nextAccessibility.string())
    }
    
    private func setupTitle(_ title: String) -> NSAttributedString {
        return  NSAttributedString(string: title,
                                   attributes: [.font: Typography.setTypography(using: .paragraph2)])
    }
}
