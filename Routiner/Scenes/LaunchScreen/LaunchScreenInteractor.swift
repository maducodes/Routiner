import Foundation

protocol LaunchScreenBusinessLogic {
    func loadOnboarding()
}

final class LaunchScreenInteractor: LaunchScreenBusinessLogic {
    
    var presenter: LaunchScreenPresentationLogic?
    
    func loadOnboarding() {
        presenter?.presentOnboarding()
    }
}
