import Foundation
import UIKit

protocol ContinueWithEmailDisplayLogic: UIViewController{
    func displayScreen(viewModel: ContinueWithEmail.Model.ViewModel)
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType)
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType)
}

final class ContinueWithEmailViewController: UIViewController, ContinueWithEmailDisplayLogic {
    private var contentView: ContinueWithEmailViewProtocol?
    var interactor: ContinueWithEmailBusinessLogic?
    var router: (ContinueWithEmailRoutingLogic & ContinueWithEmailDataPassing)?
    
    override func loadView() {
        contentView = ContinueWithEmailView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.loadScreen()
    }
    
    private func setup() {
        let viewController = self
        let presenter = ContinueWithEmailPresenter()
        let interactor = ContinuewithEmailInteractor()
        let router = ContinueWithEmailRouter()
        
        contentView?.delegate = self
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func displayScreen(viewModel: ContinueWithEmail.Model.ViewModel) {
        contentView?.showScreen(viewModel: viewModel)
    }
    
    func updateVisibilityImageTextField(_ isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType) {
        contentView?.changeVisibilityImageTextField(isVisible: isVisible, textFieldType)
    }
    
    func clearTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        contentView?.clear(textFieldType)
    }
}

extension ContinueWithEmailViewController: ContinueWithEmailViewDelegate {
    func onTapLogin(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    func onChangeTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType) {
        interactor?.updateVisibilityImageTextField(value, textFieldType)
    }
    
    func onTapButtonTextField(_ textFieldType: ContinueWithEmailTextFieldType) {
        interactor?.clearTextField(textFieldType)
    }
    
    func onTapLeftIcon() {
        router?.dismiss()
    }
    
    func onTapCreateAccount() {
        router?.routeToCreateAccount()
    }
    
    func onTapForgotPassword() {
        router?.routeToForgotPassword()
    }
}
