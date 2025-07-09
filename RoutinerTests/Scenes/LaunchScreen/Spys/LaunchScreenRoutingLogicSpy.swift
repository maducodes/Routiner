import Foundation
@testable import Routiner

class LaunchScreenRoutingLogicSpy: LaunchScreenRoutingLogic {
   
    private(set) var routeToOnboardingCalled = 0
    func routeToOnboarding() {
        routeToOnboardingCalled += 1
    }
}
