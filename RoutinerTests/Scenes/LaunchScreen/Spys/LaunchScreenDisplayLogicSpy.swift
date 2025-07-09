import Foundation
@testable import Routiner

class LaunchScreenDisplayLogicSpy: LaunchScreenDisplayLogic {
    
    private(set) var displayOnboardingCount = 0
    func displayOnboarding() {
        displayOnboardingCount += 1
    }
}
