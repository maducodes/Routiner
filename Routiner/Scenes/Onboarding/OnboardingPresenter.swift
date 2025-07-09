import Foundation

protocol OnboardingPresentationLogic {
    func presentSliderItems(currentPage: Int, numberOfPages: Int)
    func presentCurrentPage(newCurrentPage: Int)
}

final class OnboardingPresenter: OnboardingPresentationLogic {
    weak var viewController: OnboardingDisplayLogic?
    
    init() {}
    
    func presentSliderItems(currentPage: Int, numberOfPages: Int) {
        let items = getSliderItems()
        let viewModel = Onboarding.Model.ViewModel(items: items,
                                                   currentPage: currentPage,
                                                   numberOfPages: numberOfPages)
        viewController?.displaySliderItems(viewModel: viewModel)
    }
    
    func presentCurrentPage(newCurrentPage: Int) {
        viewController?.displayCurrentPage(newCurrentPage: newCurrentPage)
    }
    
    private func getSliderItems() -> [Onboarding.SliderItem] {
        
        return [
            Onboarding.SliderItem(image: Images.createHabits,
                                  title: OnboardingKeys.stepOneTitle.string(),
                                  description: OnboardingKeys.stepOneDescription.string()),
            Onboarding.SliderItem(image: Images.trackProgress,
                                  title: OnboardingKeys.stepTwoTitle.string(),
                                  description: OnboardingKeys.stepTwoDescription.string()),
            Onboarding.SliderItem(image: Images.stayTogether,
                                  title: OnboardingKeys.stepThreeTitle.string(),
                                  description: OnboardingKeys.stepThreeDescription.string())
        ]
    }
}
