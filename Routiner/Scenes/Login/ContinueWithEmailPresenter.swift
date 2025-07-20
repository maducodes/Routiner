import Foundation

protocol ContinueWithEmailPresentationLogic {
    func presentScreenValues()
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType)
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType)
}

final class ContinueWithEmailPresenter: ContinueWithEmailPresentationLogic {
    weak var viewController: ContinueWithEmailDisplayLogic?
    
    init() {}
    
    func presentScreenValues() {
        let viewModel =  ContinueWithEmail.Model.ViewModel(emailBorderColor: Colors.Primary.Black.black20,
                                                           passwordBorderColor: Colors.Primary.Black.black20,
                                                           emailIcon: Images.clear,
                                                           passwordIcon: Images.clear,
                                                           isVisibleEmailIcon: false,
                                                           isVisiblePasswordIcon: false)
        viewController?.displayScreen(viewModel: viewModel)
    }
    
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType) {
        viewController?.updateVisibilityImageTextField(isVisible, textFieldType)
    }
    
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        viewController?.clearTextField(textFieldType)
    }
}
