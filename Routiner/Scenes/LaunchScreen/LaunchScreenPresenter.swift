import Foundation

protocol LaunchScreenPresentationLogic: AnyObject {
    func presentOnboarding()
}

final class LaunchScreenPresenter: LaunchScreenPresentationLogic {
    
    var viewController: LaunchScreenDisplayLogic?
    
    func presentOnboarding() {
        viewController?.displayOnboarding()
    }
}
