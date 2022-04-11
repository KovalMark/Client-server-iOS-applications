import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryPhotoImageView: UIImageView! {
        didSet {
            galleryPhotoImageView.isUserInteractionEnabled = true
        }
    }
    
    var galleryPhoto: [PhotoFriend] = []
    var selectedPhotoIndex : Int = 0
    
    // добавляем скрытую имеджвью для загрузки нового фото (чтобы отрисовать плавную анимацию)
    private let additionalImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !galleryPhoto.isEmpty else {return}
        galleryPhotoImageView.image  = galleryPhoto[selectedPhotoIndex].image
        
        // создаем констрейнты для нашего additionalImageView
        view.addSubview(additionalImageView)
        view.sendSubviewToBack(additionalImageView)
        additionalImageView.translatesAutoresizingMaskIntoConstraints = false
        additionalImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
        
            additionalImageView.leadingAnchor.constraint(equalTo: galleryPhotoImageView.leadingAnchor),
            additionalImageView.trailingAnchor.constraint(equalTo:  galleryPhotoImageView.trailingAnchor),
            additionalImageView.topAnchor.constraint(equalTo: galleryPhotoImageView.topAnchor),
            additionalImageView.bottomAnchor.constraint(equalTo: galleryPhotoImageView.bottomAnchor)
            
        ])

        // создание свайпа кодом
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeFunc))
        leftSwipe.direction = .left
        galleryPhotoImageView.addGestureRecognizer(leftSwipe)
    }
    
    @objc func leftSwipeFunc() {
        
        guard selectedPhotoIndex + 1 <= galleryPhoto.count - 1 else {return}
        
        additionalImageView.transform = CGAffineTransform(translationX: 1.0 * additionalImageView.bounds.width, y: 0).concatenating(CGAffineTransform(translationX: 1.0, y: 1.0))
        
        additionalImageView.image = galleryPhoto[selectedPhotoIndex + 1].image
        
        // создаем анимацию при свайпе влево
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.galleryPhotoImageView.transform = CGAffineTransform(translationX: -1.5 * self.galleryPhotoImageView.bounds.width, y: 0).concatenating(CGAffineTransform(translationX: 1.0, y: 1.0))
            self.galleryPhotoImageView.alpha = 0.8
            
            self.additionalImageView.transform = .identity
            self.galleryPhotoImageView.alpha = 1
            
        } completion: { _ in
            self.selectedPhotoIndex += 1
            
            self.galleryPhotoImageView.image = self.galleryPhoto[self.selectedPhotoIndex].image
            self.galleryPhotoImageView.transform = .identity
            
            self.additionalImageView.image = nil
        }
    }

    // создание свайпа через storyboadr

    @IBAction func rightSwipeFunc(_ sender: UISwipeGestureRecognizer) {
        
        guard selectedPhotoIndex >= 1 else {return}
        
        additionalImageView.transform = CGAffineTransform(translationX: -1 * additionalImageView.bounds.width, y: 0).concatenating(CGAffineTransform(translationX: 1.0, y: 1.0))
        
        additionalImageView.image = galleryPhoto[selectedPhotoIndex - 1].image
        
        // создаем анимацию при свайпе вправо
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseIn) {
            self.galleryPhotoImageView.alpha = 1
            self.galleryPhotoImageView.transform = CGAffineTransform(translationX: 1.5 * self.galleryPhotoImageView.bounds.width, y: 0).concatenating(CGAffineTransform(translationX: 1.0, y: 1.0))
            self.galleryPhotoImageView.alpha = 0.8

            
            self.additionalImageView.transform = .identity
            self.galleryPhotoImageView.alpha = 1
            
        } completion: { _ in
            self.selectedPhotoIndex -= 1
            
            self.galleryPhotoImageView.image = self.galleryPhoto[self.selectedPhotoIndex].image
            self.galleryPhotoImageView.transform = .identity
            
            self.additionalImageView.image = nil
        }
    }
}
