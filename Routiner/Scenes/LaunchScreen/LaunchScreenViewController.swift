import Foundation
import UIKit

protocol LaunchScreenDisplayLogic: UIViewController {
    func displayOnboarding()
}

final class LaunchScreenViewController: UIViewController, LaunchScreenDisplayLogic {
    private var contentView: LaunchScreenViewProtocol?
    private var router: LaunchScreenRoutingLogic?
    private var interactor: LaunchScreenBusinessLogic?
    
    private var timer: Timer?
    
    override func loadView() {
        contentView = LaunchScreenView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0,
                                     target: self,
                                     selector: #selector(handleTimer),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc private func handleTimer() {
        interactor?.loadOnboarding()
    }
    
    private func setup() {
        let viewController = self
        let presenter = LaunchScreenPresenter()
        let interactor = LaunchScreenInteractor()
        let router = LaunchScreenRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func displayOnboarding() {
        router?.routeToOnboarding()
    }
}
