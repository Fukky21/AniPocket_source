//  SettingLanguageViewController.swift

import RealmSwift
import UIKit

class SettingLanguageViewController: UIViewController {

    var cancelBtn: UIButton!
    var mainLabel: UILabel!
    var langTV: UITableView!
    var okBtn: UIButton!
    let languages = ["日本語", "English"]
    var selectedCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkCurrentLanguage()
        setupCancelBtn()
        setupMainLabel()
        setupLangTV()
        setupOkBtn()
        langTV.selectRow(at: [0, selectedCell], animated: false, scrollPosition: .bottom)
    }

    func checkCurrentLanguage() {
        switch Language.langName {
            case "english":
                selectedCell = 1
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
        mainLabel.text = Language.settingTVItems[2]
        mainLabel.textColor = .black
        mainLabel.font = .boldSystemFont(ofSize: 25)
        
        view.addSubview(mainLabel)
    }
    
    func setupLangTV() {
        langTV = UITableView(frame: CGRect(x: 0,
                                           y: mainLabel.frame.maxY + 20,
                                           width: view.frame.width,
                                           height: view.frame.height - mainLabel.frame.maxY - 130))
        langTV.delegate = self
        langTV.dataSource = self
        langTV.tableFooterView = UIView(frame: .zero)
        langTV.allowsMultipleSelection = false
        
        view.addSubview(langTV)
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
                    settingData!.langName = "english"
                default:
                    settingData!.langName = "default"
            }
        }
        
        self.presentingViewController?.children[0].navigationController?.popViewController(animated: false)
        self.presentingViewController?.children[0].navigationController?.viewDidLoad()
        self.presentingViewController?.children[0].title = Language.homeTitle
        
        dismiss(animated: true)
    }
}

extension SettingLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = languages[indexPath.item]
        cell.textLabel?.textColor = .black
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
