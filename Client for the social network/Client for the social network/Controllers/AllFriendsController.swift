import UIKit

class AllFriendsController: UITableViewController {
    
    // Заводим переменную для вызова сервисного слоя
    let service = VKService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // кидаем наши запросы в контроллер, для отображения json в консоли
        service.photos(userID: "210469101")
        service.search(groupsSearch: "iOS")
        
        
        UIImageView.animate(withDuration: 1,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.5,
                            options: .curveEaseInOut) {
            
        }
    }
    
    // Подбираем человеческий дизайн для хедера

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

    // Создаём константу, имена через неё мы будем обращаться к свойствам и изменять их
    let header = view as! UITableViewHeaderFooterView

    // Установить цвет текста в label
    header.textLabel?.textColor = #colorLiteral(red: 0.4331377745, green: 0.7129762769, blue: 0.7476240993, alpha: 1)

    // Установить цвет фона для секции
    header.tintColor = #colorLiteral(red: 0.2156862915, green: 0.2156862915, blue: 0.2156862915, alpha: 1)
    }
}
  
