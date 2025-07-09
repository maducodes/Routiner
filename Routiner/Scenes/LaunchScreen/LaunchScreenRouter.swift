import Foundation
import UIKit

protocol LaunchScreenRoutingLogic {
    func routeToOnboarding()
}

final class LaunchScreenRouter: LaunchScreenRoutingLogic {
    var viewController: LaunchScreenDisplayLogic?
    
    func routeToOnboarding() {
        let nextViewController = OnboardingViewController()
        nextViewController.navigationItem.hidesBackButton = true
        viewController?.navigationController?.pushViewController(nextViewController, animated: false)
    }
}
