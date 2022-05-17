import UIKit
import Alamofire
import RealmSwift

final class GroupVKService {
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
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
}
