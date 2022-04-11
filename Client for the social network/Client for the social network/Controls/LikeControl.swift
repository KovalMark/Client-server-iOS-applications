import UIKit

class LikeControl: UIControl {

    @IBOutlet var likeImage: UIImageView!
    
    var islike: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.backgroundColor = .clear
        likeImage.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }

}
