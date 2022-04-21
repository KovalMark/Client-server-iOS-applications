import UIKit

// MARK: - получаем данные для отображения списка групп в которые мы вступили

struct GroupVK: Decodable {
    let items: [ItemsGroupVK]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct ItemsGroupVK: Decodable {
    let name: String
    let photoGroup: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoGroup = "photo_50"
    }
}
