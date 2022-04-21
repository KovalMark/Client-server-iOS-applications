import UIKit

// MARK: - кидаем наши запросы для получения списка друзей, фотографий, групп и групп по поисковому запросу

final class VKService {
    
    func friends(completion: @escaping ((Result<UserVK, Error>) -> ())) {
        
        guard let urlFriends = URL(string: "https://api.vk.com/method/friends.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&fields=photo_50&v=5.131") else { return }
        
        let requestFriends = URLRequest(url: urlFriends)
        
        URLSession.shared.dataTask(with: requestFriends) { dataFriends, responseFriends, errorFriends in
            if errorFriends != nil {
                print("errorFriends")
            }
            guard let dataFriends = dataFriends else {
                return
            }
            let decoderFriends = JSONDecoder()
            do {
                let resultFriends = try decoderFriends.decode(UserVK.self, from: dataFriends)
                completion(.success(resultFriends))
            } catch {
                print(errorFriends as Any)
            }
        } .resume()
    }
    
    func photos(userID: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "owner_id", value: userID),
            URLQueryItem(name: "v", value: "5.131")
            ]
        
        guard let urlPhotos = urlComponents.url else { return }
        
        let requestPhotos = URLRequest(url: urlPhotos)
        
        URLSession.shared.dataTask(with: requestPhotos) { dataPhotos, responsePhotos, errorPhotos in
            if errorPhotos != nil {
                print("errorPhotos")
            }
            guard let dataPhotos = dataPhotos else {
                return
            }
            do {
                let resultPhotos = try JSONSerialization.jsonObject(with: dataPhotos, options: .fragmentsAllowed)
                print("\nСписок фото\n")
                print(resultPhotos)
            } catch {
                print(errorPhotos as Any)
            }
        } .resume()
    }
    
    func groups(completion: @escaping ((Result<GroupVK, Error>) -> ())) {
        
        guard let urlGroups = URL(string: "https://api.vk.com/method/groups.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&extended=1&v=5.131") else { return }
        
        let requestGroups = URLRequest(url: urlGroups)
        
        URLSession.shared.dataTask(with: requestGroups) { dataGroups, responseGroups, errorGroups in
            if errorGroups != nil {
                print("errorGroups")
            }
            guard let dataGroups = dataGroups else {
                return
            }
            let decoderGroups = JSONDecoder()
            do {
                let resultGroups = try decoderGroups.decode(GroupVK.self, from: dataGroups)
                completion(.success(resultGroups))
            } catch {
                print(errorGroups as Any)
            }
        } .resume()
    }
    
    func search(groupsSearch: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c"),
            URLQueryItem(name: "q", value: groupsSearch),
            URLQueryItem(name: "v", value: "5.131")
            ]
        
        guard let urlSearch = urlComponents.url else { return }
        
        let requestSearch = URLRequest(url: urlSearch)
        
        URLSession.shared.dataTask(with: requestSearch) { dataSearch, responseSearch, errorSearch in
            if errorSearch != nil {
                print("errorSearch")
            }
            guard let dataSearch = dataSearch else {
                return
            }
            do {
                let resultSearch = try JSONSerialization.jsonObject(with: dataSearch, options: .fragmentsAllowed)
                print("\nРезультат поиска групп\n")
                print(resultSearch)
            } catch {
                print(errorSearch as Any)
            }
        } .resume()
    }
}
