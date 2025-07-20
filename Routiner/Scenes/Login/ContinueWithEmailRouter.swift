import Foundation

protocol ContinueWithEmailRoutingLogic {
    func routeToForgotPassword()
    func routeToCreateAccount()
    func dismiss()
}

protocol ContinueWithEmailDataPassing {
    var dataStore: ContinueWithEmailDataStore? { get }
}

final class ContinueWithEmailRouter: ContinueWithEmailRoutingLogic, ContinueWithEmailDataPassing {
    weak var viewController: ContinueWithEmailDisplayLogic?
    var dataStore: ContinueWithEmailDataStore?

    func dismiss()  {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToForgotPassword() {
        
    }
    
    func routeToCreateAccount() {
        
    }
}
