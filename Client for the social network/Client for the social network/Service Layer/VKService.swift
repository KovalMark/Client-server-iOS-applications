import UIKit

// MARK: - кидаем наши запросы для получения списка друзей, фотографий, групп и групп по поисковому запросу

final class VKService {
    
    func friends() {
        
        guard let urlFriends = URL(string: "https://api.vk.com/method/friends.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&fields=photo_50&v=5.131") else { return }
        
        let requestFriends = URLRequest(url: urlFriends)
        
        URLSession.shared.dataTask(with: requestFriends) { dataFriends, responseFriends, errorFriends in
            if errorFriends != nil {
                print("errorFriends")
            }
            guard let dataFriends = dataFriends else {
                return
            }
            do {
                let resultFriends = try JSONSerialization.jsonObject(with: dataFriends, options: .fragmentsAllowed)
                print("\nСписок друзей\n")
                print(resultFriends)
            } catch {
                print(errorFriends as Any)
            }
        } .resume()
    }
    
    func photos() {
        
        guard let urlPhotos = URL(string: "https://api.vk.com/method/photos.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&album_id=profile&v=5.131") else { return }
        
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
    
    func groups() {
        
        guard let urlGroups = URL(string: "https://api.vk.com/method/groups.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&extended=1&v=5.131") else { return }
        
        let requestGroups = URLRequest(url: urlGroups)
        
        URLSession.shared.dataTask(with: requestGroups) { dataGroups, responseGroups, errorGroups in
            if errorGroups != nil {
                print("errorGroups")
            }
            guard let dataGroups = dataGroups else {
                return
            }
            do {
                let resultGroups = try JSONSerialization.jsonObject(with: dataGroups, options: .fragmentsAllowed)
                print("\nСписок групп\n")
                print(resultGroups)
            } catch {
                print(errorGroups as Any)
            }
        } .resume()
    }
    
    func search() {
        
        guard let urlSearch = URL(string: "https://api.vk.com/method/search.getHints?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&type=group&v=5.131") else { return }
        
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

