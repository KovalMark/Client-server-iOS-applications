import Foundation
import UIKit

class Animated: UIViewController {
    
    override func viewDidLoad() {
        UIImageView.animate(withDuration: 2,
                            delay: 0,
                            usingSpringWithDamping: 1,
                            initialSpringVelocity: 1,
                            options: .curveEaseInOut) {
            self.imageAllFriendsCell.alpha = 0
        }
    }
    
}
