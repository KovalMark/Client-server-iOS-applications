import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var firstRound: UIView!
    
    @IBOutlet weak var secondRound: UIView!
    
    @IBOutlet weak var thirdRound: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.curveEaseInOut, .autoreverse]) {
            self.firstRound.alpha = 0
        }
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       options: [.curveEaseInOut, .autoreverse]) {
            self.secondRound.alpha = 0
        }
        
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.curveEaseInOut, .autoreverse]) {
            self.thirdRound.alpha = 0
        }
        
        UIView.animate(withDuration: 1,
                       delay: 1.5,
                       options: [.curveEaseInOut, .autoreverse]) {
            self.logoImageView.alpha = 0
            self.logoImageView.transform = CGAffineTransform(scaleX: 100, y: 100)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(2.5)), execute: {
                    self.performSegue(withIdentifier: "Stop animation", sender: nil)
        })
    }
    
    
}
    
    

