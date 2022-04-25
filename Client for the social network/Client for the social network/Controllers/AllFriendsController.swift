import UIKit

class AllFriendsController: UITableViewController {
    
    // Заводим переменную для вызова сервисного слоя
    var friendsVK = VKService()
    
    var friend: [UserVKArray] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        UIImageView.animate(withDuration: 1,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.5,
                            options: .curveEaseInOut) {
            
        }
        
        friendsVK.friendAdd { [weak self] friend in
            self?.friend = friend
            self?.tableView?.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsCell", for: indexPath) as? AllFriendsCell else {
            preconditionFailure("Нет друзей")
        }
        let friends = friend[indexPath.row]
        
        cell.labelAllFriendsCell.text = friends.firstName
        cell.secondLabelAllFriendsCell.text = friends.lastName
        cell.imageAllFriendsCell.image = UIImage(named: friends.photo)
        
        return cell
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
  
