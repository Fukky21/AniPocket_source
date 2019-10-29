//  DataTabBarController.swift

import UIKit

class DataTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.dataTitle
        self.tabBar.tintColor = Theme.tintColor
        setup()
    }
    
    func setup() {
        var viewControllers: [UIViewController] = []
        
        let dataTableVC = DataTableViewController()
        dataTableVC.tabBarItem = UITabBarItem(title: Language.dataTabBarItemTitles[0],
                                              image: UIImage(named: "icon_dataTable"),
                                              tag: 0)
        viewControllers.append(dataTableVC)
        
        let dataBarChartVC = DataBarChartViewController()
        dataBarChartVC.tabBarItem = UITabBarItem(title: Language.dataTabBarItemTitles[1],
                                                 image: UIImage(named: "icon_dataBarChart"),
                                                 tag: 1)
        viewControllers.append(dataBarChartVC)
        
        let dataPieChartVC = DataPieChartViewController()
        dataPieChartVC.tabBarItem = UITabBarItem(title: Language.dataTabBarItemTitles[2],
                                                 image: UIImage(named: "icon_dataPieChart"),
                                                 tag: 2)
        viewControllers.append(dataPieChartVC)
        
        self.setViewControllers(viewControllers, animated: false)
    }
}
