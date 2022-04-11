 import Foundation
import UIKit

protocol SplashPresenterDescriptions {
    func present()
    func dismiss(completion: (() -> Void)?)
}

final class SplashPresenter: SplashPresenterDescriptions {
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashWindow = UIWindow()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil )
        let splashViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewControllerID") as? SplashViewController
        
        splashWindow.windowLevel = .normal + 1
        splashWindow.rootViewController = splashViewController
        
        return splashWindow
         
    }()
    
    func present() {
        foregroundSplashWindow.isHidden = false
        
        let splashViewController = foregroundSplashWindow.rootViewController as? SplashViewController
        UIView.animate(withDuration: 3) {
        splashViewController?.iconImage.transform = CGAffineTransform(scaleX: 88 / 72, y: 88 / 72)
        }
        
    }
    
    func dismiss(completion: (() -> Void)?) {
        
    }
    
}


/*
 
 UIView.animate(withDuration: 2,
                delay: 0,
                options: [.repeat]) {
     self.firstRound.alpha = 0
 }
 
 UIView.animate(withDuration: 2.01,
                delay: 0.01,
                options: [.repeat]) {
     self.secondRound.alpha = 0
 }
 
 UIView.animate(withDuration: 2.02,
                delay: 0.02,
                options: [.repeat]) {
     self.thrirdRound.alpha = 0
 }
 
 */
