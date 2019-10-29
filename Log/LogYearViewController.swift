//  LogYearViewController.swift

import RealmSwift
import UIKit

class LogYearViewController: UIViewController {
    
    var barAddBtn: UIBarButtonItem!
    static var logYearCV: UICollectionView!
    var logYearAnime: Results<AnimeData>?
    var getYear: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.baseColor
        self.title = "\(getYear!)"
        setupbarAddBtn()
        loadLogYearAnime()
        setupLogYearCV()
    }
    
    func setupbarAddBtn() {
        barAddBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barAddBtnEvent(_:)))
        self.navigationItem.rightBarButtonItem = barAddBtn
    }
    
    func loadLogYearAnime() {
        let realm = try! Realm()
        
        logYearAnime = realm.objects(AnimeData.self).filter("status == 'log' AND startYear == %@", getYear as Any).sorted(byKeyPath: "startMonth", ascending: true)
    }
    
    func setupLogYearCV() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)

        LogYearViewController.logYearCV = UICollectionView(frame: CGRect(x: 10,
                                                                         y: statusBarHeight + navigationBarHeight + 10,
                                                                         width: view.frame.width - 20,
                                                                         height: view.frame.height - statusBarHeight - navigationBarHeight - 10),
                                                           collectionViewLayout: layout)
        
        LogYearViewController.logYearCV.backgroundColor = Theme.baseColor
        LogYearViewController.logYearCV.delegate = self
        LogYearViewController.logYearCV.dataSource = self
        
        LogYearViewController.logYearCV.register(LogYearCVCell.self, forCellWithReuseIdentifier: "LogYearCVCell")
        
        let longPressRecognizerOfLogYearCV = UILongPressGestureRecognizer(target: self, action: #selector(longPressLogYearCV(recognizer:)))
        longPressRecognizerOfLogYearCV.minimumPressDuration = 1.0
        longPressRecognizerOfLogYearCV.delegate = self as? UIGestureRecognizerDelegate
        LogYearViewController.logYearCV.addGestureRecognizer(longPressRecognizerOfLogYearCV)
        
        LogYearViewController.logYearCV.hero.modifiers = [.cascade]
        
        view.addSubview(LogYearViewController.logYearCV)
    }
    
    @objc func barAddBtnEvent(_ sender: UIBarButtonItem) {
        let logAddVC = LogAddViewController()
        logAddVC.getSourceView = "logYear"
        
        self.navigationController?.pushViewController(logAddVC, animated: true)
    }
    
    // Delete data by long press gesture
    @objc func longPressLogYearCV(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: LogYearViewController.logYearCV)
        let indexPath = LogYearViewController.logYearCV.indexPathForItem(at: point)
        
        if indexPath != nil {
            if recognizer.state == UIGestureRecognizer.State.began {
                let alert = UIAlertController(title: Language.deleteAlertTitle, message: "", preferredStyle: .alert)
                
                let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
                    let realm = try! Realm()
                    
                    let animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.logYearAnime?[indexPath!.item].registeredTime as Any).first
                    
                    let numOfLogAnime = realm.objects(NumOfLogAnime.self).filter("year == %@", self.getYear as Any).first
                    
                    // Delete image from Documents
                    if animeData?.imgName != "" {
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let filePath = path.appendingPathComponent(animeData!.imgName)
                        
                        try! FileManager.default.removeItem(at: filePath)
                    }
                    
                    // Delete animeData from Realm
                    try! realm.write() {
                        realm.delete(animeData!)
                        numOfLogAnime?.num -= 1
                    }
                    
                    // When the deleted animeData is the last data of the year, update logCV and go back to LogViewController.
                    if numOfLogAnime!.num == 0 {
                        LogViewController.logCV.removeFromSuperview()
                        
                        let logVC = self.navigationController?.children[1] as! LogViewController
                        logVC.loadNumOfLogAnime()
                        logVC.setupLogCV()
                        logVC.dataExistCheck()
                        
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        LogYearViewController.logYearCV.reloadData()
                    }
                })
                
                alert.addAction(cancelBtn)
                alert.addAction(okBtn)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension LogYearViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logYearAnime?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = LogYearViewController.logYearCV.dequeueReusableCell(withReuseIdentifier: "LogYearCVCell", for: indexPath) as! LogYearCVCell
        
        cell.setupCell(imgName: logYearAnime?[indexPath.item].imgName,
                       title: logYearAnime?[indexPath.item].title)
        
        cell.hero.modifiers = [.fade, .scale(0.5)]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sendAnimeData = SendAnimeData()
        sendAnimeData.title = logYearAnime?[indexPath.item].title ?? ""
        sendAnimeData.imgName = logYearAnime?[indexPath.item].imgName ?? ""
        sendAnimeData.startYear = logYearAnime?[indexPath.item].startYear ?? 0
        sendAnimeData.startMonth = logYearAnime?[indexPath.item].startMonth ?? 0
        sendAnimeData.endYear = logYearAnime?[indexPath.item].endYear ?? 0
        sendAnimeData.endMonth = logYearAnime?[indexPath.item].endMonth ?? 0
        sendAnimeData.fullEp = logYearAnime?[indexPath.item].fullEp ?? 0
        sendAnimeData.genre = logYearAnime?[indexPath.item].genre ?? 0
        sendAnimeData.registeredTime = logYearAnime?[indexPath.item].registeredTime ?? ""
        
        let logInfoVC = LogInfoViewController()
        logInfoVC.getAnimeData = sendAnimeData
        logInfoVC.modalPresentationStyle = .overCurrentContext
        logInfoVC.hero.isEnabled = true
        
        present(logInfoVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

