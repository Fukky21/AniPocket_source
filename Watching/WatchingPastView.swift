//  WatchingPastView.swift

import Material
import RealmSwift
import UIKit

class WatchingPastView: UIView {

    var noDataLabel: UILabel!
    static var watchingPastCV: UICollectionView!
    var watchingVC: WatchingViewController!
    var pastAnime: Results<AnimeData>?
    
    func setInstance(instance: WatchingViewController) {
        watchingVC = instance
    }
    
    func setup() {
        setupNoDataLabel()
        loadPastAnime()
        setupWatchingPastCV()
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
    
    func loadPastAnime() {
        let realm = try! Realm()
        
        pastAnime = realm.objects(AnimeData.self).filter("status == 'past'")
    }
    
    func setupWatchingPastCV() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.frame.width * 17) / 20,
                                 height: (self.frame.width * 17) / 40)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        WatchingPastView.watchingPastCV = UICollectionView(frame: CGRect(x: 0,
                                                                         y: 0,
                                                                         width: self.frame.width,
                                                                         height: self.frame.height),
                                                           collectionViewLayout: layout)
        
        WatchingPastView.watchingPastCV.backgroundColor = Theme.baseColor
        WatchingPastView.watchingPastCV.delegate = self
        WatchingPastView.watchingPastCV.dataSource = self
        
        WatchingPastView.watchingPastCV.register(WatchingPastCVCell.self, forCellWithReuseIdentifier: "WatchingPastCVCell")
        
        let longPressRecognizerOfWatchingPastCV = UILongPressGestureRecognizer(target: self, action: #selector(longPressWatchingPastCV(recognizer:)))
        longPressRecognizerOfWatchingPastCV.minimumPressDuration = 1.0
        longPressRecognizerOfWatchingPastCV.delegate = self as? UIGestureRecognizerDelegate
        WatchingPastView.watchingPastCV.addGestureRecognizer(longPressRecognizerOfWatchingPastCV)
        
        WatchingPastView.watchingPastCV.hero.modifiers = [.cascade]
        
        self.addSubview(WatchingPastView.watchingPastCV)
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let pastAnimeData = realm.objects(AnimeData.self).filter("status == 'past'")
        
        if pastAnimeData.count > 0 {
            noDataLabel.isHidden = true
            WatchingPastView.watchingPastCV.isHidden = false
        } else {
            noDataLabel.isHidden = false
            WatchingPastView.watchingPastCV.isHidden = true
        }
    }
    
    // Delete data by long press gesture
    @objc func longPressWatchingPastCV(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: WatchingPastView.watchingPastCV)
        let indexPath = WatchingPastView.watchingPastCV.indexPathForItem(at: point)
        
        if indexPath != nil {
            if recognizer.state == UIGestureRecognizer.State.began {
                let alert = UIAlertController(title: Language.deleteAlertTitle, message: "", preferredStyle: .alert)
                
                let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
                    let realm = try! Realm()
                    
                    let animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", self.pastAnime?[indexPath!.item].registeredTime as Any).first
                    
                    // Delete image from Documents
                    if animeData!.imgName != "" {
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let filePath = path.appendingPathComponent(animeData!.imgName)
                        
                        try! FileManager.default.removeItem(at: filePath)
                    }
                    
                    // Delete animeData from Realm
                    try! realm.write() {
                        realm.delete(animeData!)
                    }
                    
                    WatchingPastView.watchingPastCV.reloadData()
                    
                    self.dataExistCheck()
                })
                
                alert.addAction(cancelBtn)
                alert.addAction(okBtn)
                
                watchingVC.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func editBtnEvent(_ sender: IconButton) {
        let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
        
        let watchingEditVC = WatchingEditViewController()
        watchingEditVC.getRegisteredTime = pastAnime?[item].registeredTime
        watchingEditVC.modalPresentationStyle = .fullScreen
        
        watchingVC.present(watchingEditVC, animated: true)
    }
    
    @objc func moveBtnEvent(_ sender: UIButton) {
        let alert = UIAlertController(title: Language.moveAlertTitleInWatchingPast,
                                      message: Language.moveAlertMessageInWatchingPast,
                                      preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            let item = Int(sender.accessibilityIdentifier!.components(separatedBy: ["[", ",", " ", "]"])[3])!
            
            let moveVC = MoveViewController()
            moveVC.getRegisteredTime = self.pastAnime?[item].registeredTime
            moveVC.getSourceView = "watchingPast"
            moveVC.modalPresentationStyle = .fullScreen
            
            self.watchingVC.present(moveVC, animated: true)
        })
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        watchingVC.present(alert, animated: true, completion: nil)
    }
}

extension WatchingPastView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastAnime?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WatchingPastView.watchingPastCV.dequeueReusableCell(withReuseIdentifier: "WatchingPastCVCell", for: indexPath) as! WatchingPastCVCell
        
        // Refresh cell to avoid overlapping display
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        cell.setupCell(imgName: pastAnime?[indexPath.item].imgName,
                       title: pastAnime?[indexPath.item].title,
                       startYear: pastAnime?[indexPath.item].startYear,
                       startMonth: pastAnime?[indexPath.item].startMonth,
                       endYear: pastAnime?[indexPath.item].endYear,
                       endMonth: pastAnime?[indexPath.item].endMonth,
                       nowEp: pastAnime?[indexPath.item].nowEp,
                       fullEp: pastAnime?[indexPath.item].fullEp,
                       genre: pastAnime?[indexPath.item].genre,
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
        var sendAnimeData = SendAnimeData()
        sendAnimeData.title = pastAnime?[indexPath.item].title ?? ""
        sendAnimeData.fullEp = pastAnime?[indexPath.item].fullEp ?? 0
        sendAnimeData.nowEp = pastAnime?[indexPath.item].nowEp ?? 0
        sendAnimeData.registeredTime = pastAnime?[indexPath.item].registeredTime ?? ""
        
        let watchingPastInfoVC = WatchingPastInfoViewController()
        watchingPastInfoVC.getAnimeData = sendAnimeData
        watchingPastInfoVC.modalPresentationStyle = .overCurrentContext
        watchingPastInfoVC.hero.isEnabled = true
        
        watchingVC.present(watchingPastInfoVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
