import UIKit

class NewsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsXIBCell", bundle: nil), forCellReuseIdentifier: "NewsXIBCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
}
