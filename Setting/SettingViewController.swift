//  SettingViewController.swift

import UIKit

class SettingViewController: UIViewController {

    var settingTV: UITableView!
    let items = Language.settingTVItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.settingTitle
        view.backgroundColor = Theme.baseColor
        setupSettingTV()
    }
    
    func setupSettingTV() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        settingTV = UITableView(frame: CGRect(x: 0,
                                              y: statusBarHeight + navigationBarHeight + 20,
                                              width: view.frame.width,
                                              height: view.frame.height - statusBarHeight - navigationBarHeight - 20))
        settingTV.backgroundColor = Theme.baseColor
        settingTV.delegate = self
        settingTV.dataSource = self
        settingTV.tableFooterView = UIView(frame: .zero)
        
        view.addSubview(settingTV)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items![indexPath.item]
        cell.textLabel?.textColor = Theme.baseLetterColor
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = Theme.baseColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
            case 0:
                let settingUsageVC = SettingUsageViewController()
                settingUsageVC.modalPresentationStyle = .fullScreen
                
                self.present(settingUsageVC, animated: true)
            case 1:
                let settingThemeVC = SettingThemeViewController()
                settingThemeVC.modalPresentationStyle = .fullScreen
                
                self.present(settingThemeVC, animated: true)
            case 2:
                let settingLanguageVC = SettingLanguageViewController()
                settingLanguageVC.modalPresentationStyle = .fullScreen
                
                self.present(settingLanguageVC, animated: true)
            case 3:
                let settingQuestionVC = SettingQuestionViewController()
                settingQuestionVC.modalPresentationStyle = .fullScreen
                
                self.present(settingQuestionVC, animated: true)
            case 4:
                let settingLicenseVC = SettingLicenseViewController()
                settingLicenseVC.modalPresentationStyle = .fullScreen
                
                self.present(settingLicenseVC, animated: true)
            case 5:
                let settingPrivacyPolicyVC = SettingPrivacyPolicyViewController()
                settingPrivacyPolicyVC.modalPresentationStyle = .fullScreen
                
                self.present(settingPrivacyPolicyVC, animated: true)
            default:
                let settingContactVC = SettingContactViewController()
                settingContactVC.modalPresentationStyle = .fullScreen
                
                self.present(settingContactVC, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
