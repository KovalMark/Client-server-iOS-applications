import UIKit

// Синглтон для хранения данных о текущей сессии

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token: String?
    var userID: Int?
    
}
