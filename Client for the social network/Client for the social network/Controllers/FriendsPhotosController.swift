import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosController: UICollectionViewController {
    
    var arrayPhoto: [PhotoFriend] = []
    
    var friendsPhotos: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrayPhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotosCell", for: indexPath) as? FriendsPhotosCell else {
            preconditionFailure("Error")
        }
    
        cell.friendsPhotos.image = arrayPhoto[indexPath.row].image

        return cell
    }
    
    // передаем выбранное фото в GalleryViewController для просмотра на весь экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            
            let selectedPhoto = collectionView.indexPathsForSelectedItems?.first
            let galleryPhotoVC = segue.destination as? GalleryViewController
            
            galleryPhotoVC?.galleryPhoto = arrayPhoto
            galleryPhotoVC?.selectedPhotoIndex = selectedPhoto!.row
        }
    }
}
