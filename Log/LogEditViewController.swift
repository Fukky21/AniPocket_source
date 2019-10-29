//  LogEditViewController.swift

import CropViewController
import RealmSwift
import TextFieldEffects
import UIKit

class LogEditViewController: InputFormBaseViewController {
    
    var cancelBtn: UIButton!
    var scrollView: UIScrollView!
    var contentView: UIView!
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
                                                y: cancelBtn.frame.maxY + 5,
                                                width: view.frame.width,
                                                height: view.frame.height - cancelBtn.frame.maxY - 5))
        
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
    
    // "Title" and "Start date" are required, and "End date" must be after "Start date".
    func invalidInputCheck() -> Bool {
        if checkTitleAndStart(titleTF: titleTF, startTF: startTF) {
            return checkStartAndEnd(startTF: startTF, endTF: endTF)
        } else {
            return false
        }
    }
    
    @objc func cancelBtnEvent(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func okBtnEvent(_ sender: UIButton) {
        if checkCharacterLimit(titleTF: titleTF, fullEpTF: fullEpTF, broadcasterTF: nil) && invalidInputCheck() {
            let yearBeforeEditing = animeData.startYear
            
            try! realm?.write {
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
                
                animeData.startYear = Int(startTF.text!.components(separatedBy: ".")[0])!
                animeData.startMonth = Int(startTF.text!.components(separatedBy: ".")[1])!
                
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
            
            postProcess(yearBeforeEditing: yearBeforeEditing)
        }
    }
    
    // The post process changes depending on whether startYear is changed and so on.
    // When startYear is not changed, update logYearCV and go back to LogYearViewController.
    // When startYear is changed and the edited animeData is the last data of the year, update logCV and go back to LogViewController.
    // When startYear is changed and the edited animeData is not the last data of the year, update logCV and logYearCV, and go back to LogYearViewController.
    func postProcess(yearBeforeEditing: Int) {
        if animeData.startYear == yearBeforeEditing {
            LogYearViewController.logYearCV.reloadData()
        } else {
            let numOfLogAnimeInBeforeYear = realm.objects(NumOfLogAnime.self).filter("year == %@", yearBeforeEditing).first
            let numOfLogAnimeInAfterYear = realm.objects(NumOfLogAnime.self).filter("year == %@", animeData.startYear).first
            
            // When the edited animeData is the first data of the new startYear, add new NumOfLogAnime.
            if numOfLogAnimeInAfterYear != nil {
                try! realm.write {
                    numOfLogAnimeInBeforeYear?.num -= 1
                    numOfLogAnimeInAfterYear?.num += 1
                }
            } else {
                let newNumOfLogAnime = NumOfLogAnime()
                newNumOfLogAnime.year = animeData.startYear
                newNumOfLogAnime.num = 1
                    
                try! realm.write {
                    numOfLogAnimeInBeforeYear?.num -= 1
                    realm.add(newNumOfLogAnime)
                }
            }
            
            LogViewController.logCV.removeFromSuperview()
            
            let logVC = self.presentingViewController?.presentingViewController?.children[1] as! LogViewController
            logVC.loadNumOfLogAnime()
            logVC.setupLogCV()
            
            if numOfLogAnimeInBeforeYear!.num == 0 {
                self.presentingViewController?.presentingViewController?.children[0].navigationController?.popViewController(animated: false)
            } else {
                LogYearViewController.logYearCV.reloadData()
            }
        }
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}
