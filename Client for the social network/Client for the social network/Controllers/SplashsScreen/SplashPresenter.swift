import UIKit

protocol SplashPresenterDescription {
    
    func present()
    func dismiss(completion: (() -> Void)?)
    
}

class SplashPresenter: SplashPresenterDescription {
    
    private lazy var foregroundSplashWindow: UIWindow = {
        
        let splashWindow = UIWindow()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewControllerID") as? SplashViewController
        
        splashWindow.windowLevel = .normal + 1
        splashWindow.rootViewController = splashViewController
        
        return splashWindow
    }()
    
    func present() {
        
        foregroundSplashWindow.isHidden = false
        
        let splashViewController = foregroundSplashWindow.rootViewController as? SplashViewController
        
        UIView.animate(withDuration: 0.3) {
            splashViewController?.logoImageView.transform = CGAffineTransform(scaleX: 170, y: 170)
        }

    }
    
    func dismiss(completion: (() -> Void)?) {
        
    }
    
    
}

