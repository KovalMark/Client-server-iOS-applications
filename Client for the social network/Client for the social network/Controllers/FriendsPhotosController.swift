import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosController: UICollectionViewController {
    
    private let photosVK = PhotoVKService()
    
    var photo: [PhotoVKArray] = []
    var friendId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadPhotoDataRealm()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotosCell", for: indexPath) as? FriendsPhotosCell else {
            preconditionFailure("Нет друзей")
        }
        cell.friendsPhotos.loadImage(with: photo.)
        // тут должны вызвать метод для открытия картинки из url и передать в нужный outlet
        // cell.friendsPhotos.loadImage(with: photoFriends.url)
        
        return cell
    }
    
    // Отправляем запрос для получения данных из Realm
    func loadPhotoDataRealm() {
        photosVK.photoAdd(userID: "") { [weak self] photo in
            self?.photo = photo
            self?.collectionView?.reloadData()
        }
    }
}
