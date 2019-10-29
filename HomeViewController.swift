//  HomeViewController.swift

import CircleMenu
import UIKit

class HomeViewController: UIViewController {
    
    var circleMenu: CircleMenu!
    var menu: [(icon: String, color: UIColor)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.homeTitle
        view.backgroundColor = Theme.baseColor
        setupMenu()
        setupCircleMenu()
    }
    
    func setupMenu() {
        menu = [("icon_watching", Theme.mainColor),
                ("icon_log", Theme.mainColor),
                ("icon_watchLater", Theme.mainColor),
                ("icon_data", Theme.mainColor),
                ("icon_setting", Theme.mainColor)]
    }

    func setupCircleMenu() {
        circleMenu = CircleMenu(
            frame: CGRect(x: (view.bounds.width - 70) / 2 ,
                          y: (view.bounds.height - 70) / 2,
                          width: 70,
                          height: 70),
            normalIcon: "icon_menu",
            selectedIcon: "icon_close",
            buttonsCount: menu.count,
            duration: 0.5,
            distance: 130)
        circleMenu.backgroundColor = .white
        circleMenu.layer.cornerRadius = circleMenu.frame.size.width / 2.0
        circleMenu.delegate = self
        
        view.addSubview(circleMenu)
    }
}

extension HomeViewController: CircleMenuDelegate {
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = menu[atIndex].color
        button.setImage(UIImage(named: menu[atIndex].icon), for: .normal)
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        switch atIndex {
            case 0:
                self.navigationController?.pushViewController(WatchingViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(LogViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(WatchLaterViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(DataTabBarController(), animated: true)
            default:
                self.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }
}

