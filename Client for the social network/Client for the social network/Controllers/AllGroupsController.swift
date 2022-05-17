import UIKit
import RealmSwift

class AllGroupsController: UITableViewController {
    
    // Заводим переменную для вызова сервисного слоя
    private let groupsVK = GroupVKService()
    
    // переменная для получения массива, который мы будем отображать
    var group: [GroupVKArray] = []
    
    // создаем элемент realm'a
    let realm = RealmCacheService()
    
    // создаем в кэше метод read
    private var groupResponse: Results<GroupVKArray>? {
        realm.read(GroupVKArray.self)
    }
    
    // токен для уведомлений
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationToken()
        loadGroupDataRealm()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsCell else {
            preconditionFailure("Failed to create a cell")
        }
        
        let groups = group[indexPath.row]
        
        cell.labelAllGroups.text = groups.name
        cell.ImageAllGroups.loadImage(with: groups.photo)
        
        return cell
    }
    
    // Пишем метод для получения данных.
    func loadGroupData() {
        do {
            let realm = try Realm()
            let userVKArray = realm.objects(GroupVKArray.self)
            self.group = Array(userVKArray)
        } catch {
            print(error)
        }
    }
    
    // Отправляем запрос для получения данных из Realm
    func loadGroupDataRealm() {
        groupsVK.groupAdd { [weak self] group in
            self?.loadGroupData()
            self?.tableView?.reloadData()
        }
    }
    
    // метод для автоматического обновления информации при изменении данных в Realm через notifications
    func createNotificationToken() {
        notificationToken = groupResponse?.observe { [ weak self ] result in
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
