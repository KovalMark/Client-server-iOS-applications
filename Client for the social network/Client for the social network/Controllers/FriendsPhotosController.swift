import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosController: UICollectionViewController {
    
    var friendsPhotos: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
}
