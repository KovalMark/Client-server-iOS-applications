import UIKit

class ActiveGroupsController: UITableViewController {
    
    var group = [String] ()
    
    var groups = [
        Group(image: UIImage.init(named: "Dragon's Lair"), name: "Логово драконихи"),
        Group(image: UIImage.init(named: "Duloc"), name: "Дулок"),
        Group(image: UIImage.init(named: "Far far away palace"), name: "Далекий далекий дворец"),
        Group(image: UIImage.init(named: "Shrek's House"), name: "Дом Шрека"),
        Group(image: UIImage.init(named: "The Faraway Kingdom"), name: "Тридевятое королевство")
    ]
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsController else {return}
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                _ = allGroupsController.group[indexPath.row]
                if !group.contains(groups[indexPath.row].name) {
                    group.append(groups[indexPath.row].name)
                    tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return group.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveGroupsCell", for: indexPath) as? ActiveGroupsCell else {
            preconditionFailure("Нет активных групп")
        }

        cell.labelActiveGroupsController.text = group[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            group.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

        }    
    }
}
