import UIKit
import RealmSwift

// MARK: - получаем данные для отображения фотографий наших друзей

class PhotoVKResponse: Decodable {
    let response: PhotoVK
}

class PhotoVK: Decodable {
    let items: [PhotoVKArray]
}

class PhotoVKArray: Object, Decodable {
    @objc dynamic var ownerID = 0
    var sizes: [SizesVKArray] = []
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.ownerID = try values.decode(Int.self, forKey: .ownerID)
        self.sizes = try values.decode(Array.self, forKey: .sizes)
    }
}

class SizesVKArray: Object, Decodable {
    @objc dynamic  var type = "q"
    @objc dynamic var height = 427
    @objc dynamic var width = 320
    @objc dynamic var url = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case height
        case width
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        self.height = try values.decode(Int.self, forKey: .height)
        self.width = try values.decode(Int.self, forKey: .width)
        self.url = try values.decode(String.self, forKey: .url)
    }
}

