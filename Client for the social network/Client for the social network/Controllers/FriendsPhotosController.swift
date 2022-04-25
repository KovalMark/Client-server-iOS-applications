import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosController: UICollectionViewController {
    
    var friendsPhotos: UIImageView!
    
    var photosVK = VKService()
    var photo: [PhotoVKArray] = []
    var photoFriends: [SizesVKArray] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        photosVK.photoAdd { [weak self] photo in
            self?.photo = photo
            self?.collectionView?.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoFriends.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotosCell", for: indexPath) as? FriendsPhotosCell else {
            preconditionFailure("Нет друзей")
        }
        
        let photos = photoFriends[indexPath.row]
        
        cell.friendsPhotos.image = UIImage(named: photos.url)
        
        return cell
    }
}
