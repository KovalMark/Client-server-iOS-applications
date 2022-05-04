import UIKit
import RealmSwift

class AllFriendsController: UITableViewController {
    
    // Заводим переменную для вызова сервисного слоя
    private let friendsVK = UserVKService()
    
    // переменная для получения массива, который мы будем отображать
    var friend: [UserVKArray] = []
    
    // создаем элемент realm'a
    let realm = RealmCacheService()
    
    // создаем в кэше метод read
    private var friendResponse: Results<UserVKArray>? {
        realm.read(UserVKArray.self)
    }
    
    // токен для уведомлений
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationToken()
        loadFriendDataRealm()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsCell", for: indexPath) as? AllFriendsCell else {
            preconditionFailure("Failed to create a cell")
        }
        let friends = friend[indexPath.row]
        
        cell.labelAllFriendsCell.text = friends.firstName
        cell.secondLabelAllFriendsCell.text = friends.lastName
        cell.imageAllFriendsCell.loadImage(with: friends.photo)
        
        return cell
    }
    
    // вызываем метод prepare, который содержит информацию о наших segue, именно через него, будем передавать фото для конкретного id
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCollectionFriend",
           let destinationVC = segue.destination as? FriendsPhotosController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            // указываем title для выбранной ячейки
            destinationVC.title = friend[indexPath.row].firstName
            
            // тут мы должны передать id выбранного пользователя?
            // destinationVC.photo = friend[indexPath.row].id
        }
    }
    
    // Подбираем дизайн для хедера
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // Создаём константу, имена через неё мы будем обращаться к свойствам и изменять их
        let header = view as! UITableViewHeaderFooterView
        
        // Установить цвет текста в label
        header.textLabel?.textColor = #colorLiteral(red: 0.4331377745, green: 0.7129762769, blue: 0.7476240993, alpha: 1)
        
        // Установить цвет фона для секции
        header.tintColor = #colorLiteral(red: 0.2156862915, green: 0.2156862915, blue: 0.2156862915, alpha: 1)
    }
    
    // Пишем метод для получения данных.
    func loadFriendData() {
        do {
            let realm = try Realm()
            let userVKArray = realm.objects(UserVKArray.self)
            self.friend = Array(userVKArray)
        } catch {
            print(error)
        }
    }
    
    // Отправляем запрос для получения данных из Realm
    func loadFriendDataRealm() {
        friendsVK.friendAdd { [weak self] friend in
            self?.loadFriendData()
            self?.tableView?.reloadData()
        }
    }
    
    // метод для автоматического обновления информации при изменении данных в Realm через notifications
    func createNotificationToken() {
        notificationToken = friendResponse?.observe { [ weak self ] result in
            guard let self = self else { return }
            switch result {
                // кейс подготовки к обновлению данных
            case .initial(let groupsData):
                print("\(groupsData.count)")
                // здесь хранятся индексы на удаление / добавление / изменение + хранится модель данных
            case .update(let groups,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                // находим индексы для удаления
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }
                
                // на главном потоке начинаем обновлять таблицу
                DispatchQueue.main.async {
                    // обновили таблицу
                    self.tableView.beginUpdates()
                    // удалили ненужный элемент
                    self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    // добавили новый элемент
                    self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    // обновили ячейки по индексу
                    self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    // сообщаем о том, что закончили обновление таблицы
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
