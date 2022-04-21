import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
     
    @IBOutlet weak var searcBarGroup: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcBarGroup.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
}
