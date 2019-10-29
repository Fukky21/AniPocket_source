//  WatchingViewController.swift

import RealmSwift
import UIKit

class WatchingViewController: UIViewController {
    
    var barAddBtn: UIBarButtonItem!
    var viewSwitch: UISegmentedControl!
    var watchingPresentView: WatchingPresentView!
    var watchingPastView: WatchingPastView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.watchingTitle
        view.backgroundColor = Theme.baseColor
        setupbarAddBtn()
        setupViewSwitch()
        setupViewFrames()
        watchingPresentView.setInstance(instance: self)
        watchingPresentView.setup()
        watchingPastView.setInstance(instance: self)
        watchingPastView.setup()
        view.addSubview(watchingPresentView)
    }
    
    func setupbarAddBtn() {
        barAddBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barAddBtnEvent(_:)))
        self.navigationItem.rightBarButtonItem = barAddBtn
    }
    
    func setupViewSwitch() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        viewSwitch = UISegmentedControl(items: Language.watchingViewSwitchItems as [AnyObject])
        viewSwitch.frame = CGRect(x: (view.frame.width - 250) / 2,
                                  y: statusBarHeight + navigationBarHeight + 20,
                                  width: 250,
                                  height: 30)
        
        if #available(iOS 13.0, *) {
            viewSwitch.selectedSegmentTintColor = Theme.mainColor
            viewSwitch.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Theme.mainLetterColor], for: .selected)
        } else {
            // Fallback on earlier versions
            viewSwitch.tintColor = Theme.mainColor
        }
        
        viewSwitch.addTarget(self, action: #selector(tapSegment(_:)), for: .valueChanged)
        viewSwitch.selectedSegmentIndex = 0
        
        view.addSubview(viewSwitch)
    }
    
    func setupViewFrames() {
        watchingPresentView = WatchingPresentView()
        watchingPastView = WatchingPastView()
        
        let frame = CGRect(x: 0,
                           y: viewSwitch.frame.maxY + 20,
                           width: view.frame.width,
                           height: view.frame.height - viewSwitch.frame.maxY - 30)
        
        watchingPresentView.frame = frame
        watchingPastView.frame = frame
    }
    
    @objc func barAddBtnEvent(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(WatchingAddViewController(), animated: true)
    }
    
    @objc func tapSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            watchingPastView.removeFromSuperview()
            view.addSubview(watchingPresentView)
        } else {
            watchingPresentView.removeFromSuperview()
            view.addSubview(watchingPastView)
        }
    }
}
