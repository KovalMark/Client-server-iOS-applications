import UIKit
import Alamofire
import RealmSwift

final class PhotoVKService {
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    // MARK: - Запрос на фото
    func loadVKPhoto(userID: String) {
        let path = "/method/photos.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "album_id": "wall",
            "owner_id": userID,
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
            print("\nСписок фото\n")
            print(response.value ?? "")
        }
    }
    
    func photoAdd(userID: String, completion: @escaping ([PhotoVKArray]) -> Void){
        let path = "/method/photos.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "album_id": "wall",
            "owner_id": userID,
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(PhotoVKResponse.self, from: data)
            self?.savePhotoData(userArray.response.items)
            completion(userArray.response.items)
        }
    }
    
    func savePhotoData(_ userPhoto: [PhotoVKArray]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(userPhoto)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
