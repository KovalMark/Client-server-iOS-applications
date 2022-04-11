import UIKit

class Singleton {
    
    static let session = Singleton()
    
    private init() {}
    
    var token: String?
    var userID: Int?
    
}
