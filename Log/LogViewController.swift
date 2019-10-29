//  LogViewController.swift

import UIKit
import RealmSwift

class LogViewController: UIViewController {
    
    var barAddBtn: UIBarButtonItem!
    var noDataLabel: UILabel!
    static var logCV: UICollectionView!
    var numOfLogAnime: Results<NumOfLogAnime>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.logTitle
        view.backgroundColor = Theme.baseColor
        setupbarAddBtn()
        setupNoDataLabel()
        loadNumOfLogAnime()
        setupLogCV()
        dataExistCheck()
    }
    
    func setupbarAddBtn() {
        barAddBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barAddBtnEvent(_:)))
        self.navigationItem.rightBarButtonItem = barAddBtn
    }
    
    func setupNoDataLabel() {
        noDataLabel = UILabel(frame: CGRect(x: (view.frame.width - 200) / 2,
                                            y: (view.frame.height - 40) / 2,
                                            width: 200,
                                            height: 40))
        noDataLabel.text = "No Data"
        noDataLabel.textColor = Theme.baseLetterColor
        noDataLabel.font = .boldSystemFont(ofSize: 20)
        noDataLabel.textAlignment = .center
        
        view.addSubview(noDataLabel)
    }
    
    func loadNumOfLogAnime() {
        let realm = try! Realm()
        
        numOfLogAnime = realm.objects(NumOfLogAnime.self).filter("num >= 1").sorted(byKeyPath: "year", ascending: false)
    }
    
    func setupLogCV() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        
        LogViewController.logCV = UICollectionView(frame: CGRect(x: 10,
                                                                 y: statusBarHeight + navigationBarHeight + 10,
                                                                 width: view.frame.width - 20,
                                                                 height: view.frame.height - statusBarHeight - navigationBarHeight - 10),
                                                   collectionViewLayout: layout)
        
        LogViewController.logCV.backgroundColor = Theme.baseColor
        LogViewController.logCV.delegate = self
        LogViewController.logCV.dataSource = self
        
        LogViewController.logCV.register(LogCVCell.self, forCellWithReuseIdentifier: "LogCVCell")
        
        LogViewController.logCV.hero.modifiers = [.cascade]
        
        view.addSubview(LogViewController.logCV)
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let numOfLogAnimeData = realm.objects(NumOfLogAnime.self).filter("num >= 1")
        
        if numOfLogAnimeData.count > 0 {
            noDataLabel.isHidden = true
            LogViewController.logCV.isHidden = false
        } else {
            noDataLabel.isHidden = false
            LogViewController.logCV.isHidden = true
        }
    }
    
    @objc func barAddBtnEvent(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(LogAddViewController(), animated: true)
    }
}

extension LogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfLogAnime?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = LogViewController.logCV.dequeueReusableCell(withReuseIdentifier: "LogCVCell", for: indexPath) as! LogCVCell
        
        cell.setupCell(year: numOfLogAnime?[indexPath.item].year ?? 0)
        
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = Theme.grayColor
        cell.selectedBackgroundView = selectedBackgroundView
        
        cell.backgroundColor = Theme.mainColor
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        cell.hero.modifiers = [.fade, .scale(0.5)]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let logYearVC = LogYearViewController()
        logYearVC.getYear = numOfLogAnime?[indexPath.item].year
        
        self.navigationController?.pushViewController(logYearVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
