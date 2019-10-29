//  DataTableViewController.swift

import RealmSwift
import UIKit

class DataTableViewController: UIViewController {
    
    var dataTV: UITableView!
    let sectionTitles = [Language.watchingTitle, Language.logTitle, Language.watchLaterTitle]
    let items = Language.dataTVItems
    var data = [[0, 0], [0, 0], [0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.baseColor
        loadData()
        setupDataTV()
    }
    
    func loadData() {
        let realm = try! Realm()
        
        let watchingPresentAnime = realm.objects(AnimeData.self).filter("status == 'present'")
        let watchingPastAnime = realm.objects(AnimeData.self).filter("status == 'past'")
        let logAnime = realm.objects(AnimeData.self).filter("status == 'log'")
        let watchLaterAnime = realm.objects(AnimeData.self).filter("status == 'later'")
        
        data[0][0] = watchingPresentAnime.count
        data[0][1] = watchingPastAnime.count
        data[1][0] = logAnime.count
        
        for anime in logAnime {
            data[1][1] += anime.fullEp
        }
        
        data[2][0] = watchLaterAnime.count
    }
    
    func setupDataTV() {
        dataTV = UITableView(frame: view.frame, style: .grouped)
        dataTV.backgroundColor = Theme.baseColor
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.tableFooterView = UIView(frame: .zero)
        dataTV.allowsSelection = false
        
        view.addSubview(dataTV)
    }
}

extension DataTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items![section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = items![indexPath.section][indexPath.item]
        cell.textLabel?.textColor = Theme.baseLetterColor
        cell.detailTextLabel?.text = String(data[indexPath.section][indexPath.item])
        cell.detailTextLabel?.textColor = Theme.baseLetterColor
        cell.backgroundColor = Theme.baseColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {
            return
        }
        
        headerView.textLabel?.text = sectionTitles[section]
        headerView.textLabel?.textColor = Theme.grayColor
    }
}
