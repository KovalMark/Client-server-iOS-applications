import UIKit
import Alamofire
import RealmSwift

// Кидаем наши запросы для получения списка друзей, фотографий, групп и групп по поисковому запросу

// MARK: - Запрос на друзей
final class VKService {
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
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
