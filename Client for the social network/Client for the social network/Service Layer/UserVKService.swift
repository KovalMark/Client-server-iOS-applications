import UIKit
import Alamofire
import RealmSwift

final class UserVKService {
    
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
            // Если убрать completion то возникает ошибка "attempt to delete row 3 from section 0 which only contains 0 rows before the update"
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
}
