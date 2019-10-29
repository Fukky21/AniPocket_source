//  WatchLaterViewController.swift

import Material
import RealmSwift
import UIKit

class WatchLaterViewController: UIViewController {

    var barAddBtn: UIBarButtonItem!
    var selectSortKeyBtn: UIButton!
    var changeOrderBtn: UIButton!
    var noDataLabel: UILabel!
    static var watchLaterCV: UICollectionView!
    var laterAnime: Results<AnimeData>?
    var currentSortKey = "add"
    var currentOrder = "desc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.watchLaterTitle
        view.backgroundColor = Theme.baseColor
        setupbarAddBtn()
        setupSelectSortKeyBtn()
        setupChangeOrderBtn()
        setupNoDataLabel()
        loadLaterAnime()
        setupWatchLaterCV()
        dataExistCheck()
    }
    
    func setupbarAddBtn() {
        barAddBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barAddBtnEvent(_:)))
        self.navigationItem.rightBarButtonItem = barAddBtn
    }
    
    func setupSelectSortKeyBtn() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        selectSortKeyBtn = UIButton(type: .system)
        selectSortKeyBtn.frame = CGRect(x: 10,
                                        y: statusBarHeight + navigationBarHeight + 10,
                                        width: 100,
                                        height: 60)
        selectSortKeyBtn.setTitle(Language.sortByAdd, for: .normal)
        selectSortKeyBtn.tintColor = Theme.tintColor
        selectSortKeyBtn.backgroundColor = Theme.mainColor
        selectSortKeyBtn.layer.cornerRadius = 10.0
        selectSortKeyBtn.addTarget(self, action: #selector(selectSortKeyBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(selectSortKeyBtn)
    }
    
    func setupChangeOrderBtn() {
        changeOrderBtn = UIButton(type: .custom)
        changeOrderBtn.frame = CGRect(x: selectSortKeyBtn.frame.maxX + 10,
                                      y: selectSortKeyBtn.frame.minY,
                                      width: 60,
                                      height: 60)
        changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
        changeOrderBtn.tintColor = Theme.tintColor
        changeOrderBtn.backgroundColor = Theme.mainColor
        changeOrderBtn.layer.cornerRadius = 10.0
        changeOrderBtn.addTarget(self, action: #selector(changeOrderBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(changeOrderBtn)
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
    
    func loadLaterAnime() {
        let realm = try! Realm()
        
        switch currentSortKey {
            case "add":
                selectSortKeyBtn.setTitle(Language.sortByAdd, for: .normal)
                
                if currentOrder == "asc" {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "registeredTime", ascending: true)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "registeredTime", ascending: false)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
            case "title":
                selectSortKeyBtn.setTitle(Language.sortByTitle, for: .normal)
                
                if currentOrder == "asc" {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "title", ascending: true)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "title", ascending: false)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
            case "start":
                selectSortKeyBtn.setTitle(Language.sortByStart, for: .normal)
                
                if currentOrder == "asc" {
                    let sortProperties = [SortDescriptor(keyPath: "startYear", ascending: true), SortDescriptor(keyPath: "startMonth", ascending: true)]
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(by: sortProperties)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    let sortProperties = [SortDescriptor(keyPath: "startYear", ascending: false), SortDescriptor(keyPath: "startMonth", ascending: false)]
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(by: sortProperties)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
            case "end":
                selectSortKeyBtn.setTitle(Language.sortByEnd, for: .normal)
                
                if currentOrder == "asc" {
                    let sortProperties = [SortDescriptor(keyPath: "endYear", ascending: true), SortDescriptor(keyPath: "endMonth", ascending: true)]
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(by: sortProperties)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    let sortProperties = [SortDescriptor(keyPath: "endYear", ascending: false), SortDescriptor(keyPath: "endMonth", ascending: false)]
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "endYear", ascending: false).sorted(by: sortProperties)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
            case "fullEp":
                selectSortKeyBtn.setTitle(Language.sortByFullEp, for: .normal)
                
                if currentOrder == "asc" {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "fullEp", ascending: true)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "fullEp", ascending: false)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
            default:
                selectSortKeyBtn.setTitle(Language.sortByGenre, for: .normal)
                
                if currentOrder == "asc" {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "genre", ascending: true)
                    changeOrderBtn.setImage(UIImage(named: "icon_asc"), for: .normal)
                } else {
                    laterAnime = realm.objects(AnimeData.self).filter("status == 'later'").sorted(byKeyPath: "genre", ascending: false)
                    changeOrderBtn.setImage(UIImage(named: "icon_desc"), for: .normal)
                }
        }
    }
    
    func setupWatchLaterCV() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width * 17) / 20,
                                 height: (view.frame.width * 17) / 40)
        layout.minimumLineSpacing = 10
        
        WatchLaterViewController.watchLaterCV = UICollectionView(frame: CGRect(x: 0,
                                                                               y: selectSortKeyBtn.frame.maxY + 5,
                                                                               width: view.frame.width,
                                                                               height: view.frame.height - selectSortKeyBtn.frame.maxY - 10),
                                                                 collectionViewLayout: layout)
        
        WatchLaterViewController.watchLaterCV.backgroundColor = Theme.baseColor
        WatchLaterViewController.watchLaterCV.delegate = self
        WatchLaterViewController.watchLaterCV.dataSource = self
        
        WatchLaterViewController.watchLaterCV.register(WatchLaterCVCell.self, forCellWithReuseIdentifier: "WatchLaterCVCell")
        
        let longPressRecognizerOfWatchLaterCV = UILongPressGestureRecognizer(target: self, action: #selector(longPressWatchLaterCV(recognizer:)))
        longPressRecognizerOfWatchLaterCV.minimumPressDuration = 1.0
        longPressRecognizerOfWatchLaterCV.delegate = self as? UIGestureRecognizerDelegate
        WatchLaterViewController.watchLaterCV.addGestureRecognizer(longPressRecognizerOfWatchLaterCV)
        
        WatchLaterViewController.watchLaterCV.hero.modifiers = [.cascade]
        
        view.addSubview(WatchLaterViewController.watchLaterCV)
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let watchLaterAnimeData = realm.objects(AnimeData.self).filter("status == 'later'")
        
        if watchLaterAnimeData.count > 0 {
            noDataLabel.isHidden = true
            WatchLaterViewController.watchLaterCV.isHidden = false
        } else {
            noDataLabel.isHidden = false
            WatchLaterViewController.watchLaterCV.isHidden = true
        }
    }
    
    @objc func barAddBtnEvent(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(WatchLaterAddViewController(), animated: true)
    }
    
    @objc func selectSortKeyBtnEvent(_ sender: Any) {
        let watchLaterSortVC = WatchLaterSortViewController()
        watchLaterSortVC.getSortKey = currentSortKey
        watchLaterSortVC.modalPresentationStyle = .overCurrentContext
        watchLaterSortVC.hero.isEnabled = true
        
        present(watchLaterSortVC, animated: true)
    }
    
    @objc func changeOrderBtnEvent(_ sender: Any) {
        if currentOrder == "asc" {
            currentOrder = "desc"
        } else {
            currentOrder = "asc"
        }
        
        loadLaterAnime()
        
        WatchLaterViewController.watchLaterCV.reloadData()
    }
    
    // Delete data by long press gesture
    @objc func longPressWatchLaterCV(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: WatchLaterViewController.watchLaterCV)
        let indexPath = WatchLaterViewController.watchLaterCV.indexPathForItem(at: point)
        
        if indexPath != nil {
            if recognizer.state == UIGestureRecognizer.State.began {
                let alert = UIAlertController(title: Language.deleteAlertTitle, message: "", preferredStyle: .alert)
                
                let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
                    let realm = try! Realm()
                    
                    let animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.laterAnime?[indexPath!.item].registeredTime as Any).first
                    
                    // Delete image from Documents
                    if animeData?.imgName != "" {
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let filePath = path.appendingPathComponent(animeData!.imgName)
                        
                        try! FileManager.default.removeItem(at: filePath)
                    }
                    
                    // Delete animeData from Realm
                    try! realm.write() {
                        realm.delete(animeData!)
                    }
                    
                    WatchLaterViewController.watchLaterCV.reloadData()
                    
                    self.dataExistCheck()
                })
                
                alert.addAction(cancelBtn)
                alert.addAction(okBtn)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func editBtnEvent(_ sender: IconButton) {
        let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
        
        let watchLaterEditVC = WatchLaterEditViewController()
        watchLaterEditVC.getRegisteredTime = laterAnime?[item].registeredTime
        watchLaterEditVC.modalPresentationStyle = .fullScreen
        
        present(watchLaterEditVC, animated: true)
    }
    
    @objc func moveBtnEvent(_ sender: UIButton) {
        let alert = UIAlertController(title: Language.moveAlertTitleInWatchLater,
                                      message: Language.moveAlertMessageInWatchLater,
                                      preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
            
            let moveVC = MoveViewController()
            moveVC.getSourceView = "watchLater"
            moveVC.getRegisteredTime = self.laterAnime?[item].registeredTime
            moveVC.modalPresentationStyle = .fullScreen
            
            self.present(moveVC, animated: true)
        })
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        present(alert, animated: true, completion: nil)
    }
}

extension WatchLaterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return laterAnime?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WatchLaterViewController.watchLaterCV.dequeueReusableCell(withReuseIdentifier: "WatchLaterCVCell", for: indexPath) as! WatchLaterCVCell
        
        // Refresh cell to avoid overlapping display
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }

        cell.setupCell(imgName: laterAnime?[indexPath.item].imgName,
                       title: laterAnime?[indexPath.item].title,
                       startYear: laterAnime?[indexPath.item].startYear,
                       startMonth: laterAnime?[indexPath.item].startMonth,
                       endYear: laterAnime?[indexPath.item].endYear,
                       endMonth: laterAnime?[indexPath.item].endMonth,
                       fullEp: laterAnime?[indexPath.item].fullEp,
                       genre: laterAnime?[indexPath.item].genre,
                       indexPath: indexPath)
        
        cell.editBtn.addTarget(self, action: #selector(editBtnEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.moveBtn.addTarget(self, action: #selector(moveBtnEvent(_:)), for: UIControl.Event.touchUpInside)
        
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
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
