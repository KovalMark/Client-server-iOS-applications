import UIKit

// MARK: - получаем данные для отображения фотографий наших друзей

struct PhotoVK: Decodable {
    let items: [ItemsPhotoVK]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct ItemsPhotoVK: Decodable {
    let photoID: Int
    let photoItem: [PhotoSize]
    
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case photoItem = "sizes"
    }
}

struct PhotoSize: Decodable {
    let height: Int
    let width: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case height = "height"
        case width = "width"
    }
}
