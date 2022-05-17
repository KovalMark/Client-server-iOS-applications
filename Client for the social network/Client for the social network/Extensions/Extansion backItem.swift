import UIKit

extension UITableViewController {
    
    open override func viewDidLoad() {
        
        // Отключаем надпись Back у навигейшн контроллера
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
}

extension UICollectionViewController {
    
    open override func viewDidLoad() {
        
        // Отключаем надпись Back у навигейшн контроллера
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
}
