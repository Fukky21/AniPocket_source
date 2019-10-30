//  SettingThemeViewController.swift

import RealmSwift
import UIKit

class SettingThemeViewController: UIViewController {

    var cancelBtn: UIButton!
    var mainLabel: UILabel!
    var themeTV: UITableView!
    var okBtn: UIButton!
    let themes = ["Default", "Simple", "Lovely Candy", "Happy Bitter", "Nature", "ROCK-mode", "Deep Ocean", "Ice", "Sunset"]
    var selectedCell: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkCurrentTheme()
        setupCancelBtn()
        setupMainLabel()
        setupThemeTV()
        setupOkBtn()
        themeTV.selectRow(at: [0, selectedCell], animated: false, scrollPosition: .bottom)
    }
    
    func checkCurrentTheme() {
        switch Theme.themeName {
            case "simple":
                selectedCell = 1
            case "lovely-candy":
                selectedCell = 2
            case "happy-bitter":
                selectedCell = 3
            case "nature":
                selectedCell = 4
            case "rock-mode":
                selectedCell = 5
            case "deep-ocean":
                selectedCell = 6
            case "ice":
                selectedCell = 7
            case "sunset":
                selectedCell = 8
            default:
                selectedCell = 0
        }
    }

    func setupCancelBtn() {
        cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.frame = CGRect(x: 5,
                                 y: 30,
                                 width: 100,
                                 height: 60)
        cancelBtn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(cancelBtn)
    }
    
    func setupMainLabel() {
        mainLabel = UILabel(frame: CGRect(x: 20,
                                          y: cancelBtn.frame.maxY + 20,
                                          width: 250,
                                          height: 40))
        mainLabel.text = Language.settingTVItems[1]
        mainLabel.textColor = .black
        mainLabel.font = .boldSystemFont(ofSize: 25)
        
        view.addSubview(mainLabel)
    }
    
    func setupThemeTV() {
        themeTV = UITableView(frame: CGRect(x: 0,
                                            y: mainLabel.frame.maxY + 20,
                                            width: view.frame.width,
                                            height: view.frame.height - mainLabel.frame.maxY - 130))
        themeTV.delegate = self
        themeTV.dataSource = self
        themeTV.backgroundColor = .white
        themeTV.tableFooterView = UIView(frame: .zero)
        themeTV.allowsMultipleSelection = false
        
        view.addSubview(themeTV)
    }
    
    func setupOkBtn() {
        okBtn = UIButton(type: .system)
        okBtn.setTitle("OK", for: .normal)
        okBtn.frame = CGRect(x: (view.frame.width - 100) / 2,
                             y: view.frame.maxY - 90,
                             width: 100,
                             height: 60)
        okBtn.addTarget(self, action: #selector(okBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(okBtn)
    }
    
    @objc func cancelBtnEvent(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func okBtnEvent(_ sender: UIButton) {
        let realm = try! Realm()
        
        let settingData = realm.objects(SettingData.self).first
        
        try! realm.write {
            switch selectedCell {
                case 1:
                    settingData!.themeName = "simple"
                case 2:
                    settingData!.themeName = "lovely-candy"
                case 3:
                    settingData!.themeName = "happy-bitter"
                case 4:
                    settingData!.themeName = "nature"
                case 5:
                    settingData!.themeName = "rock-mode"
                case 6:
                    settingData!.themeName = "deep-ocean"
                case 7:
                    settingData!.themeName = "ice"
                case 8:
                    settingData!.themeName = "sunset"
                default:
                    settingData!.themeName = "default"
            }
        }
        
        self.presentingViewController?.children[0].navigationController?.popViewController(animated: false)
        self.presentingViewController?.children[0].navigationController?.viewDidLoad()
        
        let homeVC = self.presentingViewController?.children[0] as! HomeViewController
        homeVC.circleMenu.removeFromSuperview()
        homeVC.view.backgroundColor = Theme.baseColor
        homeVC.setupMenu()
        homeVC.setupCircleMenu()
        
        dismiss(animated: true, completion: nil)
    }
}

extension SettingThemeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = themes[indexPath.item]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        if indexPath.item == selectedCell {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        selectedCell = indexPath.item
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
