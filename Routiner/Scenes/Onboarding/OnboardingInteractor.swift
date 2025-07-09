import Foundation

protocol OnboardingBusinessLogic {
    func getNextItem(newCurrentPage: Int?)
    func getSliderItems()
}

protocol OnboardingDataStore {
    
}

final class OnboardingInteractor: OnboardingBusinessLogic, OnboardingDataStore {
    var presenter: OnboardingPresentationLogic?
    var worker: OnboardingWorkerLogic?
    
    private var currentPage = 0
    private let numberOfPages = 3
    
    func getSliderItems() {
        presenter?.presentSliderItems(currentPage: currentPage,
                                      numberOfPages: numberOfPages)
    }
    
    func getNextItem(newCurrentPage: Int?) {
        if let newCurrentPage {
            currentPage = newCurrentPage
            presenter?.presentCurrentPage(newCurrentPage: newCurrentPage)
        } else {
            getNewCurrentPage()
        }
    }
    
    private func getNewCurrentPage() {
        if currentPage < 2 {
            currentPage += 1
        } else {
            currentPage = 0
        }
        
        presenter?.presentCurrentPage(newCurrentPage: currentPage)
    }
}
