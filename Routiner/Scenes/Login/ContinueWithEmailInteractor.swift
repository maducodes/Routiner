import Foundation

protocol ContinueWithEmailBusinessLogic {
    func loadScreen()
    func updateVisibilityImageTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType)
    func login()
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType)
    func validateField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType)
}

protocol ContinueWithEmailDataStore {}

final class ContinuewithEmailInteractor: ContinueWithEmailBusinessLogic, ContinueWithEmailDataStore {
    var presenter: ContinueWithEmailPresentationLogic?
    var worker: ContinueWithEmailWorkerLogic?

    private var email: String?
    private var password: String?

    func loadScreen() {
        presenter?.presentScreenValues()
    }
    
    func updateVisibilityImageTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType) {
        presenter?.updateVisibilityImageTextField(value.count > 0, textFieldType)
    }
    
    func validateField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType) {
        // TODO: Regras de validação de campos
        switch textFieldType {
        case .email:
            email = value
        case .password:
            password = value
        }
    }
    
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        presenter?.clearTextField(textFieldType)
        presenter?.updateVisibilityImageTextField(false, textFieldType)
    }
    
    func login() {
        // TODO: Realizar Login
        guard let email = email, let password = password else { return }
        print(email)
        print(password)
    }
}
