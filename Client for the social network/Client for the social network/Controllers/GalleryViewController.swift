import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryPhotoImageView: UIImageView! {
        didSet {
            galleryPhotoImageView.isUserInteractionEnabled = true
        }
    }
    
    var selectedPhotoIndex : Int = 0
    
    // добавляем скрытую имеджвью для загрузки нового фото (чтобы отрисовать плавную анимацию)
    private let additionalImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}
