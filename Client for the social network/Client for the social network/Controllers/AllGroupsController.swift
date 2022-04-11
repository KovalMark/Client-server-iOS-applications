import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {

    var group = [
        Group(image: UIImage.init(named: "Dragon's Lair"), name: "Логово драконихи"),
        Group(image: UIImage.init(named: "Duloc"), name: "Дулок"),
        Group(image: UIImage.init(named: "Far far away palace"), name: "Далекий далекий дворец"),
        Group(image: UIImage.init(named: "Shrek's House"), name: "Дом Шрека"),
        Group(image: UIImage.init(named: "The Faraway Kingdom"), name: "Тридевятое королевство")
    ]

    var filteredGroup = [Group]()
     
    @IBOutlet weak var searcBarGroup: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcBarGroup.delegate = self
        
        // приравниваем 2 переменных друг к другу для выполнения поиска
        filteredGroup = group
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsCell else {
            preconditionFailure("Нет активных групп")
        }

        cell.labelAllGroups.text = filteredGroup[indexPath.row].name
        cell.ImageAllGroups.image = filteredGroup[indexPath.row].image

        return cell
    }
    
    // настройка нашего searcBarGroup
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredGroup = group
        } else {
            func filterTableView(text:String) {
                let search = text.lowercased()
                filteredGroup = group.filter({ (mod) -> Bool in
                    return mod.name.lowercased().contains(search)
                })
            self.tableView.reloadData()
            }
        filterTableView(text: searchText)
        }
    }
}
