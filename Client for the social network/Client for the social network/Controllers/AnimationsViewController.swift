import UIKit

class AnimationsViewController: UIViewController {

    
    @IBOutlet weak var red: UIView!
    
    @IBOutlet weak var yellow: UIView!
    
    @IBOutlet weak var green: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.repeat]) {
            self.red.alpha = 0
        }
        
        UIView.animate(withDuration: 2.01,
                       delay: 0.01,
                       options: [.repeat]) {
            self.yellow.alpha = 0
        }
        
        UIView.animate(withDuration: 2.02,
                       delay: 0.02,
                       options: [.repeat]) {
            self.green.alpha = 0
        }
    }


}
