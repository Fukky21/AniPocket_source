//  WatchingPresentView.swift

import Material
import RealmSwift
import UIKit

class WatchingPresentView: UIView {

    var noDataLabel: UILabel!
    static var watchingPresentCV: UICollectionView!
    var watchingVC: WatchingViewController!
    var sunAnime: Results<AnimeData>?
    var monAnime: Results<AnimeData>?
    var tueAnime: Results<AnimeData>?
    var wedAnime: Results<AnimeData>?
    var thuAnime: Results<AnimeData>?
    var friAnime: Results<AnimeData>?
    var satAnime: Results<AnimeData>?
    
    func setInstance(instance: WatchingViewController) {
        watchingVC = instance
    }
    
    func setup() {
        setupNoDataLabel()
        loadPresentAnime()
        setupWatchingPresentCV()
        dataExistCheck()
    }
    
    func setupNoDataLabel() {
        noDataLabel = UILabel(frame: CGRect(x: (self.frame.width - 200) / 2,
                                            y: (self.frame.height - 40) / 2,
                                            width: 200,
                                            height: 40))
        noDataLabel.text = "No Data"
        noDataLabel.textColor = Theme.baseLetterColor
        noDataLabel.font = .boldSystemFont(ofSize: 20)
        noDataLabel.textAlignment = .center
        
        self.addSubview(noDataLabel)
    }

    func loadPresentAnime() {
        let realm = try! Realm()
        
        sunAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Sun'").sorted(byKeyPath: "startTime", ascending: true)
        monAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Mon'").sorted(byKeyPath: "startTime", ascending: true)
        tueAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Tue'").sorted(byKeyPath: "startTime", ascending: true)
        wedAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Wed'").sorted(byKeyPath: "startTime", ascending: true)
        thuAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Thu'").sorted(byKeyPath: "startTime", ascending: true)
        friAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Fri'").sorted(byKeyPath: "startTime", ascending: true)
        satAnime = realm.objects(AnimeData.self).filter("status == 'present' AND dayOfTheWeek == 'Sat'").sorted(byKeyPath: "startTime", ascending: true)
    }
    
    
    func setupWatchingPresentCV() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.frame.width * 17) / 20,
                                 height: (self.frame.width * 17) / 40)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        WatchingPresentView.watchingPresentCV = UICollectionView(frame: CGRect(x: 0,
                                                                               y: 0,
                                                                               width: self.frame.width,
                                                                               height: self.frame.height),
                                                                 collectionViewLayout: layout)
        
        WatchingPresentView.watchingPresentCV.backgroundColor = Theme.baseColor
        WatchingPresentView.watchingPresentCV.delegate = self
        WatchingPresentView.watchingPresentCV.dataSource = self
        
        WatchingPresentView.watchingPresentCV.register(WatchingPresentCVCell.self, forCellWithReuseIdentifier: "WatchingPresentCVCell")
        WatchingPresentView.watchingPresentCV.register(WatchingPresentCRV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WatchingPresentCRV")
        
        let longPressRecognizerOfWatchingPresentCV = UILongPressGestureRecognizer(target: self, action: #selector(longPressWatchingPresentCV(recognizer:)))
        longPressRecognizerOfWatchingPresentCV.minimumPressDuration = 1.0
        longPressRecognizerOfWatchingPresentCV.delegate = self as? UIGestureRecognizerDelegate
        WatchingPresentView.watchingPresentCV.addGestureRecognizer(longPressRecognizerOfWatchingPresentCV)
        
        WatchingPresentView.watchingPresentCV.hero.modifiers = [.cascade]
        
        self.addSubview(WatchingPresentView.watchingPresentCV)
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let presentAnimeData = realm.objects(AnimeData.self).filter("status == 'present'")
        
        if presentAnimeData.count > 0 {
            noDataLabel.isHidden = true
            WatchingPresentView.watchingPresentCV.isHidden = false
        } else {
            noDataLabel.isHidden = false
            WatchingPresentView.watchingPresentCV.isHidden = true
        }
    }
    
    // Delete data by long press gesture
    @objc func longPressWatchingPresentCV(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: WatchingPresentView.watchingPresentCV)
        let indexPath = WatchingPresentView.watchingPresentCV.indexPathForItem(at: point)
        
        if indexPath != nil {
            if recognizer.state == UIGestureRecognizer.State.began {
                let alert = UIAlertController(title: Language.deleteAlertTitle, message: "", preferredStyle: .alert)
                
                let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
                    var animeData: AnimeData!
                    
                    let realm = try! Realm()
                    
                    switch indexPath!.section {
                        case 0:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.sunAnime?[indexPath!.item].registeredTime as Any).first
                        case 1:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.monAnime?[indexPath!.item].registeredTime as Any).first
                        case 2:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.tueAnime?[indexPath!.item].registeredTime as Any).first
                        case 3:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.wedAnime?[indexPath!.item].registeredTime as Any).first
                        case 4:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.thuAnime?[indexPath!.item].registeredTime as Any).first
                        case 5:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.friAnime?[indexPath!.item].registeredTime as Any).first
                        default:
                            animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.satAnime?[indexPath!.item].registeredTime as Any).first
                    }
                    
                    // Delete image from Documents
                    if animeData.imgName != "" {
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let filePath = path.appendingPathComponent(animeData.imgName)
                        
                        try! FileManager.default.removeItem(at: filePath)
                    }
                    
                    // Delete animeData from Realm
                    try! realm.write() {
                        realm.delete(animeData)
                    }
                    
                    WatchingPresentView.watchingPresentCV.reloadData()
                    
                    self.dataExistCheck()
                })
                
                alert.addAction(cancelBtn)
                alert.addAction(okBtn)
                
                watchingVC.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func editBtnEvent(_ sender: IconButton) {
        let section = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[1])!
        let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
        
        let watchingEditVC = WatchingEditViewController()
        
        switch section {
            case 0:
                watchingEditVC.getRegisteredTime = sunAnime?[item].registeredTime
            case 1:
                watchingEditVC.getRegisteredTime = monAnime?[item].registeredTime
            case 2:
                watchingEditVC.getRegisteredTime = tueAnime?[item].registeredTime
            case 3:
                watchingEditVC.getRegisteredTime = wedAnime?[item].registeredTime
            case 4:
                watchingEditVC.getRegisteredTime = thuAnime?[item].registeredTime
            case 5:
                watchingEditVC.getRegisteredTime = friAnime?[item].registeredTime
            default:
                watchingEditVC.getRegisteredTime = satAnime?[item].registeredTime
        }
        
        watchingEditVC.modalPresentationStyle = .fullScreen
        
        watchingVC.present(watchingEditVC, animated: true)
    }
    
    @objc func moveBtnEvent(_ sender: UIButton) {
        let alert = UIAlertController(title: Language.moveAlertTitleInWatchingPresent,
                                      message: Language.moveAlertMessageInWatchingPresent,
                                      preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            let section = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[1])!
            let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
            
            let moveVC = MoveViewController()
            
            switch section {
                case 0:
                    moveVC.getRegisteredTime = self.sunAnime?[item].registeredTime
                case 1:
                    moveVC.getRegisteredTime = self.monAnime?[item].registeredTime
                case 2:
                    moveVC.getRegisteredTime = self.tueAnime?[item].registeredTime
                case 3:
                    moveVC.getRegisteredTime = self.wedAnime?[item].registeredTime
                case 4:
                    moveVC.getRegisteredTime = self.thuAnime?[item].registeredTime
                case 5:
                    moveVC.getRegisteredTime = self.friAnime?[item].registeredTime
                default:
                    moveVC.getRegisteredTime = self.satAnime?[item].registeredTime
            }
            
            moveVC.getSourceView = "watchingPresent"
            moveVC.modalPresentationStyle = .fullScreen
            
            self.watchingVC.present(moveVC, animated: true)
        })
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        watchingVC.present(alert, animated: true, completion: nil)
    }
}

extension WatchingPresentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Language.dayOfTheWeekList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return sunAnime?.count ?? 0
            case 1:
                return monAnime?.count ?? 0
            case 2:
                return tueAnime?.count ?? 0
            case 3:
                return wedAnime?.count ?? 0
            case 4:
                return thuAnime?.count ?? 0
            case 5:
                return friAnime?.count ?? 0
            default:
                return satAnime?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = WatchingPresentView.watchingPresentCV.dequeueReusableCell(withReuseIdentifier: "WatchingPresentCVCell", for: indexPath) as! WatchingPresentCVCell
        
        // Refresh cell to avoid overlapping display
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        switch indexPath.section {
            case 0:
                cell.setupCell(imgName: sunAnime?[indexPath.item].imgName,
                               title: sunAnime?[indexPath.item].title,
                               startTime: sunAnime?[indexPath.item].startTime,
                               broadcaster: sunAnime?[indexPath.item].broadcaster,
                               genre: sunAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            case 1:
                cell.setupCell(imgName: monAnime?[indexPath.item].imgName,
                               title: monAnime?[indexPath.item].title,
                               startTime: monAnime?[indexPath.item].startTime,
                               broadcaster: monAnime?[indexPath.item].broadcaster,
                               genre: monAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            case 2:
                cell.setupCell(imgName: tueAnime?[indexPath.item].imgName,
                               title: tueAnime?[indexPath.item].title,
                               startTime: tueAnime?[indexPath.item].startTime,
                               broadcaster: tueAnime?[indexPath.item].broadcaster,
                               genre: tueAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            case 3:
                cell.setupCell(imgName: wedAnime?[indexPath.item].imgName,
                               title: wedAnime?[indexPath.item].title,
                               startTime: wedAnime?[indexPath.item].startTime,
                               broadcaster: wedAnime?[indexPath.item].broadcaster,
                               genre: wedAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            case 4:
                cell.setupCell(imgName: thuAnime?[indexPath.item].imgName,
                               title: thuAnime?[indexPath.item].title,
                               startTime: thuAnime?[indexPath.item].startTime,
                               broadcaster: thuAnime?[indexPath.item].broadcaster,
                               genre: thuAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            case 5:
                cell.setupCell(imgName: friAnime?[indexPath.item].imgName,
                               title: friAnime?[indexPath.item].title,
                               startTime: friAnime?[indexPath.item].startTime,
                               broadcaster: friAnime?[indexPath.item].broadcaster,
                               genre: friAnime?[indexPath.item].genre,
                               indexPath: indexPath)
            default:
                cell.setupCell(imgName: satAnime?[indexPath.item].imgName,
                               title: satAnime?[indexPath.item].title,
                               startTime: satAnime?[indexPath.item].startTime,
                               broadcaster: satAnime?[indexPath.item].broadcaster,
                               genre: satAnime?[indexPath.item].genre,
                               indexPath: indexPath)
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WatchingPresentCRV", for: indexPath) as! WatchingPresentCRV
        
        // Refresh header to avoid overlapping display
        for subview in header.subviews{
            subview.removeFromSuperview()
        }
        
        if kind == UICollectionView.elementKindSectionHeader {
            header.setupHeader(headerText: Language.dayOfTheWeekList[indexPath.section])
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 20)
    }
}
