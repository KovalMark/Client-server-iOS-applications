import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var firstRound: UIView!
    
    @IBOutlet weak var secondRound: UIView!
    
    @IBOutlet weak var thrirdRound: UIView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: .repeat) {
            self.firstRound.alpha = 0
        }
        
        UIView.animate(withDuration: 2.01,
                       delay: 0.01,
                       options: .repeat) {
            self.secondRound.alpha = 0
        }
        
        UIView.animate(withDuration: 2.02,
                       delay: 0.02,
                       options: .repeat) {
            self.thrirdRound.alpha = 0
        }
    }
}
