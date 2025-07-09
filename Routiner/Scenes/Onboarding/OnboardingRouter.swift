import Foundation

protocol OnboardRoutingLogic {
    func routeContinueWithEmail()
}

protocol OnboardingDataPassing {
    var dataStore: OnboardingDataStore? { get }
}

final class OnboardingRouter: OnboardRoutingLogic, OnboardingDataPassing {
    weak var viewController: OnboardingDisplayLogic?
    var dataStore: OnboardingDataStore?
    
    func routeContinueWithEmail() {
//        let nextViewController = ContinueWithEmailViewController()
//        nextViewController.navigationItem.hidesBackButton = true
//        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
