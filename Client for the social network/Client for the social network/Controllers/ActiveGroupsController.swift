import UIKit

class ActiveGroupsController: UITableViewController {
    
    var group = [String] ()

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
