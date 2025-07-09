import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        displayLaunchScreen()
    }
    
    // MARK: - Display LaunchScreen
    
    private func displayLaunchScreen() {
        let launchView = LaunchScreenViewController()
        let navigationController = UINavigationController(rootViewController: launchView)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
