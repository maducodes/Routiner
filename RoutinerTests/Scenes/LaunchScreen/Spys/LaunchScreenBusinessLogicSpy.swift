import Foundation
@testable import Routiner

class LaunchScreenBusinessLogicSpy: LaunchScreenBusinessLogic {
    
    private(set) loadOnboardingCount = 0
    func loadOnboarding() {
        loadOnboardingCount += 1
    }
}
