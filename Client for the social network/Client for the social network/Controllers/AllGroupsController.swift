import UIKit
import RealmSwift

class AllGroupsController: UITableViewController {
    
    var groupsVK = VKService()
    
    var group: [GroupVKArray] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsVK.groupAdd { [weak self] group in
            self?.loadGroupData()
            self?.tableView?.reloadData()
        }
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsCell else {
                preconditionFailure("Нет активных групп")
            }
        
        let groups = group[indexPath.row]
        
        cell.labelAllGroups.text = groups.name
        cell.ImageAllGroups.image = UIImage(named: groups.photo)
            
            return cell
    }
}
