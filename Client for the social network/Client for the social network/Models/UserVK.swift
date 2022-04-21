import UIKit

// MARK: - получаем данные для отображения наших друзей

struct UserVK: Decodable {
    let items: [ItemsUserVK]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct ItemsUserVK: Decodable {
    let userID: Int
    let firstNameUser: String
    let lastNameUser: String
    let photoUser: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case firstNameUser = "first_name"
        case lastNameUser = "last_name"
        case photoUser = "photo_50"
    }
}
