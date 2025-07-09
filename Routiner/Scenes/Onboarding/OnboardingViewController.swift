import UIKit
import Foundation

protocol OnboardingDisplayLogic: UIViewController {
    func displaySliderItems(viewModel: Onboarding.Model.ViewModel)
    func displayCurrentPage(newCurrentPage: Int)
}

final class OnboardingViewController: UIViewController, OnboardingDisplayLogic {
    private var contentView: OnboardingViewProtocol?
    var interactor: OnboardingBusinessLogic?
    var router: (OnboardRoutingLogic & OnboardingDataPassing)?
    
    private var timer: Timer?
    
    private var onboardingSliderItems: [Onboarding.SliderItem] = []
    
    override func loadView() {
        contentView = OnboardingView()
        contentView?.delegate = self
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
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(handleTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func handleTimer() {
        interactor?.getNextItem(newCurrentPage: nil)
    }
    
    private func setup() {
        let viewController = self
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        self.interactor?.getSliderItems()
    }
    
    func displaySliderItems(viewModel: Onboarding.Model.ViewModel) {
        self.onboardingSliderItems = viewModel.items
        contentView?.setupView(viewModel: viewModel,
                               collectionViewDelegate: self,
                               collectionViewDataSource: self)
    }
    
    func displayCurrentPage(newCurrentPage: Int) {
        contentView?.changeCurrentPage(newCurrentPage: newCurrentPage)
    }
}

extension OnboardingViewController: OnboardingViewDelegate {
    func didTapPageControl() {
        interactor?.getNextItem(newCurrentPage: nil)
    }
    
    func didTapContinue(type: LoginType) {
        switch type {
        case .email:
            router?.routeContinueWithEmail()
            break
        case .apple:
            break
        case .facebook:
            break
        case .google:
            break
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingSliderItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingItemCell.identifier, for: indexPath) as! OnboardingItemCell
        cell.setupCell(image: onboardingSliderItems[indexPath.row].image,
                       title: onboardingSliderItems[indexPath.row].title,
                       description: onboardingSliderItems[indexPath.row].description)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let newCurrentPage = Int(scrollView.contentOffset.x / width)
        interactor?.getNextItem(newCurrentPage: newCurrentPage)
    }
}
