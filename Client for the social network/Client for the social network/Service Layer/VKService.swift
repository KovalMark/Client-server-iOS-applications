import UIKit
import Alamofire
import RealmSwift

// Кидаем наши запросы для получения списка друзей, фотографий, групп и групп по поисковому запросу

// MARK: - Запрос на друзей
final class VKService {
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    func loadVKFriend() {
        let path = "/method/friends.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "fields": "photo_50",
            "v": "5.130"
        ]
        
        let url = baseUrl+path

        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
            print("\nСписок друзей\n")
            print(response.value ?? "")
        }
    }
   
// метод для загрузки данных
    func friendAdd(completion: @escaping ([UserVKArray]) -> Void){
// разбиваем наш url запрос, чтобы использовать переменные типа "apiKey"
        let path = "/method/friends.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "fields": "photo_50",
            "v": "5.130"
            ]
        
// составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        
// делаем запрос
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(UserVKResponse.self, from: data)
            self?.saveFriendData(userArray.response.items)
            completion(userArray.response.items)
            }
        }
    
// сохранение данных в realm
    func saveFriendData(_ userFriend: [UserVKArray]) {
// обработка исключений при работе с хранилищем
        do {
// получаем доступ к хранилищу
            let realm = try Realm()
// все старые данные модели
            let oldUserVKArray = realm.objects(UserVKArray.self)
// начинаем изменять хранилище
            realm.beginWrite()
// удаляем старые данные
            realm.delete(oldUserVKArray)
// кладем все объекты класса погоды в хранилище
            realm.add(userFriend)
// завершаем изменение хранилища
            try realm.commitWrite()
        } catch {
// если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
    
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
    
    func photoAdd(completion: @escaping ([PhotoVKArray]) -> Void){
            let path = "/method/photos.get"
            let methodName: Parameters = [
                "access_token": apiKey,
                "album_id": "wall",
                "owner_id": "210469101",
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
    
// MARK: - Запрос на группы
    func loadVKGroup() {
            let path = "/method/groups.get"
            let methodName: Parameters = [
                "access_token": apiKey,
                "extended": "1",
                "v": "5.130"
            ]
            
            let url = baseUrl+path

            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print("\nСписок групп\n")
                print(response.value ?? "")
            }
        }
    
    func groupAdd(completion: @escaping ([GroupVKArray]) -> Void){
            let path = "/method/groups.get"
            let methodName: Parameters = [
                "access_token": apiKey,
                "extended": "1",
                "v": "5.130"
            ]
        
            let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
                guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(GroupVKResponse.self, from: data)
            self?.saveGroupData(userArray.response.items)
            completion(userArray.response.items)
            }
        }
    
// сохранение данных в realm
        func saveGroupData(_ userGroup: [GroupVKArray]) {
// обработка исключений при работе с хранилищем
            do {
// получаем доступ к хранилищу
                let realm = try Realm()
// все старые данные модели
                let oldGroupVKArray = realm.objects(GroupVKArray.self)
// начинаем изменять хранилище
                realm.beginWrite()
// удаляем старые данные
                realm.delete(oldGroupVKArray)
// кладем все объекты класса погоды в хранилище
                realm.add(userGroup)
// завершаем изменение хранилища
                try realm.commitWrite()
            } catch {
// если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }

// MARK: - Запрос на поиск
    func loadVKSearch(search: String) {
            let path = "/method/groups.search"
            let methodName: Parameters = [
                "access_token": apiKey,
                "q": search,
                "v": "5.130"
            ]
            
            let url = baseUrl+path

            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print("\nРезультат поиска\n")
                print(response.value ?? "")
            }
        }
}
