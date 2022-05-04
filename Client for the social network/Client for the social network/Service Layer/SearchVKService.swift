import UIKit
import Alamofire
import RealmSwift

final class SearchVKService {
    
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
