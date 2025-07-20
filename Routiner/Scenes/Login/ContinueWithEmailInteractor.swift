import Foundation

protocol ContinueWithEmailBusinessLogic {
    func loadScreen()
    func updateVisibilityImageTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType)
    func login(email: String, password: String)
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType)
}

protocol ContinueWithEmailDataStore {
    
}

final class ContinuewithEmailInteractor: ContinueWithEmailBusinessLogic, ContinueWithEmailDataStore {
    var presenter: ContinueWithEmailPresentationLogic?
    var worker: ContinueWithEmailWorkerLogic?
    
    func loadScreen() {
        presenter?.presentScreenValues()
    }
    
    func updateVisibilityImageTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType) {
        presenter?.updateVisibilityImageTextField(value.count > 0, textFieldType)
    }
    
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        presenter?.clearTextField(textFieldType)
    }
    
    func login(email: String, password: String) {
        // TODO: Realizar login
        print(email)
        print(password)
    }
}
