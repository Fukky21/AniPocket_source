//  CustomNavigationController.swift

import Hero
import RealmSwift
import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        setting()
        setup()
    }
    
    func setting() {
        let realm = try! Realm()
        
        let currentTheme = realm.objects(SettingData.self).first?.themeName
        let currentLanguage = realm.objects(SettingData.self).first?.langName
        
        // When first launch app, add SettingData.
        if currentTheme == nil {
            let settingData = SettingData()
            
            try! realm.write {
                realm.add(settingData)
            }
            
            Theme.setTheme(themeName: "default")
            Language.setLanguage(langName: "default")
        } else {
            Theme.setTheme(themeName: currentTheme!)
            Language.setLanguage(langName: currentLanguage!)
        }
    }
    
    func setup() {
        navigationBar.barTintColor = Theme.navigationbarBarTintColor
        navigationBar.tintColor = Theme.baseLetterColor
        navigationBar.titleTextAttributes = [.foregroundColor: Theme.baseLetterColor!]
        
        switch Theme.themeName {
            case "simple":
                if #available(iOS 13.0, *) {
                    UIApplication.shared.statusBarStyle = .darkContent
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.statusBarStyle = .default
                }
            case "lovely-candy":
                if #available(iOS 13.0, *) {
                    UIApplication.shared.statusBarStyle = .darkContent
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.statusBarStyle = .default
                }
            case "happy-bitter":
                if #available(iOS 13.0, *) {
                    UIApplication.shared.statusBarStyle = .darkContent
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.statusBarStyle = .default
                }
            case "nature":
                UIApplication.shared.statusBarStyle = .lightContent
            case "rock-mode":
                UIApplication.shared.statusBarStyle = .lightContent
            case "deep-ocean":
                UIApplication.shared.statusBarStyle = .lightContent
            case "ice":
                if #available(iOS 13.0, *) {
                    UIApplication.shared.statusBarStyle = .darkContent
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.statusBarStyle = .default
                }
            case "sunset":
                UIApplication.shared.statusBarStyle = .lightContent
            default:
                UIApplication.shared.statusBarStyle = .lightContent
        }
    }
}
