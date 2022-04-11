import UIKit

class FriendsPhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var friendsPhotos: UIImageView!
    
    @IBOutlet var likeControl: LikeControl!
    
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        /*
        // Создаем переменную которая будет отрабатывать нажатие на картинку.
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(FriendsPhotosCell.imageTapped))
        
        // Вызываем GestureRecognizer для нашей картинки.
        friendsPhotos.addGestureRecognizer(pictureTap)
        */
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hadleTap))
        tap.numberOfTapsRequired = 2
        container.addGestureRecognizer(tap)
    }
    
    /*
    // Добавляем действие для отображения картинки на полный экран с черными полосами.
    // Предварительно я установил UserInteractionEnabled для соответсвующего имеджвью.
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)

    }

    // Код почему-то не срабатывает. Картинка на полный экран не открывается
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    */
    
    @objc func hadleTap(_ :UITapGestureRecognizer) {
        likeControl.islike.toggle()
        
        if likeControl.islike {
            UIView.transition(with: likeControl,
                              duration: 0.3,
                              options: .transitionCurlUp) {
                self.likeControl.likeImage.image = UIImage(named: "fulllike")
            }
        } else {
            UIView.transition(with: likeControl,
                              duration: 0.3,
                              options: .transitionCurlUp) {
                self.likeControl.likeImage.image = UIImage(named: "emptylike")
            }
        }
    }
}
