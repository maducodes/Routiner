import Foundation
@testable import Routiner

class LaunchScreenPresentationLogicSpy: LaunchScreenPresentationLogic {
    
    private(set) var presentOnboardingCount = 0
    func presentOnboarding() {
        presentOnboardingCount += 1
    }
}
