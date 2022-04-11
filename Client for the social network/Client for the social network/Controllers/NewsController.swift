import UIKit

class NewsController: UITableViewController {

    let news = [
        News(image: UIImage.init(named: "shrekphoto1"), name: "Шрек", text: "Стою быкую !!!", newsPhoto: UIImage.init(named: "shrekphoto3")),
        News(image: UIImage.init(named: "shrekphoto1"), name: "Шрек", text: "Жостко замарался, бывает...", newsPhoto: UIImage.init(named: "shrekphoto4")),
        News(image: UIImage.init(named: "Donkey"), name: "Осел", text: "Лопаю вафли!", newsPhoto: UIImage.init(named: "donkeyphoto4")),
        News(image: UIImage.init(named: "Mirror"), name: "Зеркало", text: "Кто? Может быть ты?!", newsPhoto: UIImage.init(named: "mirrorphoto2"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsXIBCell", bundle: nil), forCellReuseIdentifier: "NewsXIBCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsXIBCell")! as! NewsXIBCell
        
    
        cell.profileNameLabelView.text = news[indexPath.row].name
        cell.profilePphotoImageView.image = news[indexPath.row].image
        cell.newsPostTextView.text = news[indexPath.row].text
        cell.newsPhotoImageView.image = news[indexPath.row].newsPhoto

        return cell
    }
}
