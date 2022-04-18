import UIKit

class AllFriendsController: UITableViewController {
    
    let friends = [
        Friends(image: UIImage.init(named: "shrekphoto1"), name: "Шрек", photo: photoShrek),
        Friends(image: UIImage.init(named: "Donkey"), name: "Осел", photo: photoDonkey),
        Friends(image: UIImage.init(named: "Lord Farquaad"), name: "Лорд Фаркуад", photo: photoLordFarquaad),
        Friends(image: UIImage.init(named: "Fiona"), name: "Фиона", photo: photoFiona),
        Friends(image: UIImage.init(named: "Pryanya"), name: "Пряня", photo: photoPryanya),
        Friends(image: UIImage.init(named: "Pinocchio"), name: "Пиноккио", photo: photoPinocchio),
        Friends(image: UIImage.init(named: "King Harold"), name: "Король Гарольд", photo: photoKingHarold),
        Friends(image: UIImage.init(named: "Robin Hood"), name: "Робин Гуд", photo: photoRobinHood),
        Friends(image: UIImage.init(named: "Mirror"), name: "Зеркало", photo: photoMirror),
        Friends(image: UIImage.init(named: "Puss in Boots"), name: "Кот в сапогах", photo: photoPussInBoots),
    ]
    
    // Заводим переменную для вызова сервисного слоя
    let service = VKService()
    
    var sortedFriends = [Character: [Friends]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // кидаем наши запросы в контроллер открывающийся по дефолту
        service.friends()
        service.photos()
        service.groups()
        service.search()
        
        UIImageView.animate(withDuration: 1,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.5,
                            options: .curveEaseInOut) {
            
        }
        
        self.sortedFriends = sort(friends: friends)
    }
 // Сортировка по первой букве в списке друзей
    
    private func sort(friends: [Friends]) -> [Character: [Friends]] {
        
        var friendsDict = [Character: [Friends]]()
        
        friends.forEach() {friend in
            guard let firstChar = friend.name.first else {return}
            
            if var thisCharFriends = friendsDict[firstChar] {
                thisCharFriends.append(friend)
                friendsDict[firstChar] = thisCharFriends
            } else {
                friendsDict[firstChar] = [friend]
            }
            
        }
        return friendsDict
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let keySorted = sortedFriends.keys.sorted()
        
        let friends = sortedFriends[keySorted[section]]?.count ?? 0
        
        return friends
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsCell", for: indexPath) as? AllFriendsCell else {
            preconditionFailure("Нет друзей")
        }
        
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: Friends = friends[indexPath.row]

        cell.labelAllFriendsCell.text = friend.name
        cell.imageAllFriendsCell.image = friend.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriends.keys.sorted()[section])
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCollecrionFriend",
           
        let destinationVC = segue.destination as? FriendsPhotosController,
        let indexPath = tableView.indexPathForSelectedRow {
                
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
            
        let friend: Friends = friends[indexPath.row]
                
        destinationVC.title = friend.name
        destinationVC.arrayPhoto = friends[indexPath.row].photo
        }
            
    }
    
    // Подбираем человеческий дизайн для хедера

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

    // Создаём константу, именна через неё мы будем обращаться к свойствам и изменять их
    let header = view as! UITableViewHeaderFooterView

    // Установить цвет текста в label
    header.textLabel?.textColor = #colorLiteral(red: 0.4331377745, green: 0.7129762769, blue: 0.7476240993, alpha: 1)

    // Установить цвет фона для секции
    header.tintColor = #colorLiteral(red: 0.2156862915, green: 0.2156862915, blue: 0.2156862915, alpha: 1)
    }
}
  
