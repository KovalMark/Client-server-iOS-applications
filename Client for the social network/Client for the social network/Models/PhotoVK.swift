import UIKit
import RealmSwift

// MARK: - получаем данные для отображения фотографий наших друзей

struct PhotoVKResponse: Decodable {
    let response: PhotoVK
}

struct PhotoVK: Decodable {
    let items: [PhotoVKArray]
    let count: Int
}

class PhotoVKArray: Object, Decodable {
    var sizes: [SizesVKArray] = []
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.sizes = try values.decode(Array.self, forKey: .sizes)
    }
}

class SizesVKArray: Object, Decodable {
    @objc dynamic  var type = "q"
    @objc dynamic var url = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        self.url = try values.decode(String.self, forKey: .url)
    }
}

