//  MoveViewController.swift

import CropViewController
import RealmSwift
import UIKit

class MoveViewController: InputFormBaseViewController {
    
    var cancelBtn: UIButton!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var getSourceView: String!
    var getRegisteredTime: String!
    var realm: Realm!
    var animeData: AnimeData!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.baseColor
        loadAnimeData()
        setupYearList()
        setupCancelBtn()
        setupScroll()
        setupImgView(contentView: contentView, minY: 20)
        setupResetImgBtn(contentView: contentView)
        setupSetImgBtn(contentView: contentView)
        setupTitleTF(contentView: contentView)
        setupStartTF(contentView: contentView)
        setupEndTF(contentView: contentView)
        setupFullEpTF(contentView: contentView)
        setupGenreTF(contentView: contentView)
        setupOkBtn(contentView: contentView)
        setupSelectStartPV()
        setupSelectEndPV()
        setupSelectGenrePV()
        ready()
    }
    
    func loadAnimeData() {
        realm = try! Realm()
        
        animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", getRegisteredTime as Any).first
    }
    
    
    func setupCancelBtn() {
        cancelBtn = UIButton(type: .system)
        cancelBtn.frame = CGRect(x: 5,
                                 y: 30,
                                 width: 100,
                                 height: 60)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = Theme.tintColor
        cancelBtn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(cancelBtn)
    }
    
    func setupScroll() {
        scrollView = UIScrollView(frame: CGRect(x: 0,
                                                y: 95,
                                                width: view.frame.width,
                                                height: view.frame.height - 95))
        
        contentView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: view.frame.width,
                                           height: 1000))
        contentView.backgroundColor = Theme.baseColor
        
        let contentRect = contentView.bounds
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    func ready() {
        titleTF.text = animeData.title
        
        readyImg(imgName: animeData.imgName)
        
        readyStart(startYear: animeData.startYear, startMonth: animeData.startMonth)
       
        readyEnd(endYear: animeData.endYear, endMonth: animeData.endMonth)
    
        if animeData.fullEp != 0 {
            fullEpTF.text = String(animeData.fullEp)
        }
    
        readyGenre(genre: animeData.genre)
    }
    
    // When the animeData is moved from Watch Later to Watching(Past), "Title" is required, and "End date" must be after "Start date".
    // When the animeData is moved from Watching(Present/Past) to Log, "Title" and "Start date" are required, and "End date" must be after "Start date".
    func invalidInputCheck() -> Bool {
        if getSourceView == "watchLater"{
            if checkTitle(titleTF: titleTF) {
                return checkStartAndEnd(startTF: startTF, endTF: endTF)
            } else {
                return false
            }
        } else {
            if checkTitleAndStart(titleTF: titleTF, startTF: startTF) {
                return checkStartAndEnd(startTF: startTF, endTF: endTF)
            } else {
                return false
            }
        }
    }

    @objc func cancelBtnEvent(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func okBtnEvent(_ sender: UIButton) {
        if checkCharacterLimit(titleTF: titleTF, fullEpTF: fullEpTF, broadcasterTF: nil) && invalidInputCheck() {
            try! realm?.write {
                if getSourceView == "watchLater" {
                    animeData.status = "past"
                } else {
                    animeData.status = "log"
                }
                
                animeData.title = titleTF.text!
                
                if resetImgBtn.isEnabled && (animeData.imgName != "") {
                    // Set image exist & saved image exist
                    saveImg(imgName: "tmp.png")
                    removeImg(imgName: animeData.imgName)
                    renameImg(currentImgName: "tmp.png", newImgName: animeData.imgName)
                } else if resetImgBtn.isEnabled && (animeData.imgName == "") {
                    // Set image exist & saved image not exist
                    animeData.imgName = animeData.registeredTime + ".png"
                    saveImg(imgName: animeData.imgName)
                } else if !(resetImgBtn.isEnabled) && (animeData.imgName != "") {
                    // Set image not exist & saved image exist
                    removeImg(imgName: animeData.imgName)
                    animeData.imgName = ""
                }
                
                if startTF.text == "" {
                    animeData.startYear = 0
                    animeData.startMonth = 0
                } else {
                    animeData.startYear = Int(startTF.text!.components(separatedBy: ".")[0])!
                    animeData.startMonth = Int(startTF.text!.components(separatedBy: ".")[1])!
                }
                
                if endTF.text == "" {
                    animeData.endYear = 0
                    animeData.endMonth = 0
                } else {
                    animeData.endYear = Int(endTF.text!.components(separatedBy: ".")[0])!
                    animeData.endMonth = Int(endTF.text!.components(separatedBy: ".")[1])!
                }
                
                animeData.fullEp = Int(fullEpTF.text!) ?? 0
                
                if genreTF.text == "" {
                    animeData.genre = 0
                } else {
                    for i in 0 ..< Language.genreList.count {
                        if genreTF.text == Language.genreList[i] {
                            animeData.genre = i + 1
                            break
                        }
                    }
                }
            }
            
            // When the animeData is moved from Watching(Present/Past) to Log, change or add NumOfLogAnime
            if getSourceView != "watchLater" {
                let numOfLogAnime = realm.objects(NumOfLogAnime.self).filter("year == %@", animeData.startYear).first
                
                if numOfLogAnime == nil {
                    let newNumOfLogAnime = NumOfLogAnime()
                    newNumOfLogAnime.year = animeData.startYear
                    newNumOfLogAnime.num = 1
                    
                    try! realm.write {
                        realm.add(newNumOfLogAnime)
                    }
                } else {
                    try! realm.write {
                        numOfLogAnime?.num += 1
                    }
                }
            }
            
            switch getSourceView {
                case "watchingPresent":
                    let watchingVC = self.presentingViewController?.children[1] as! WatchingViewController
                    WatchingPresentView.watchingPresentCV.reloadData()
                    watchingVC.watchingPresentView.dataExistCheck()
                case "watchingPast":
                    let watchingVC = self.presentingViewController?.children[1] as! WatchingViewController
                    WatchingPastView.watchingPastCV.reloadData()
                    watchingVC.watchingPastView.dataExistCheck()
                default:
                    let watchLaterVC = self.presentingViewController?.children[1] as! WatchLaterViewController
                    WatchLaterViewController.watchLaterCV.reloadData()
                    watchLaterVC.dataExistCheck()
            }
            
            dismiss(animated: true)
        }
    }
}
