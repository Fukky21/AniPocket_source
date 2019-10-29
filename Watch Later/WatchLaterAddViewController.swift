//  WatchLaterAddViewController.swift

import CropViewController
import RealmSwift
import TextFieldEffects
import UIKit

class WatchLaterAddViewController: InputFormBaseViewController {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.watchLaterAddTitle
        view.backgroundColor = Theme.baseColor
        setupYearList()
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
    
    func setupScroll() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        scrollView = UIScrollView(frame: CGRect(x: 0,
                                                y: statusBarHeight + navigationBarHeight,
                                                width: view.frame.width,
                                                height: view.frame.height - statusBarHeight - navigationBarHeight))
        
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
        resetImgBtn.isEnabled = false
    }
    
    // "Title" is required, and "End date" must be after "Start date".
    func invalidInputCheck() -> Bool {
        if checkTitle(titleTF: titleTF) {
            return checkStartAndEnd(startTF: startTF, endTF: endTF)
        } else {
            return false
        }
    }
    
    override func okBtnEvent(_ sender: UIButton) {
        if checkCharacterLimit(titleTF: titleTF, fullEpTF: fullEpTF, broadcasterTF: nil) && invalidInputCheck() {
            let animeData = AnimeData()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"
            let now = formatter.string(from: NSDate() as Date)
            
            let realm = try! Realm()
            
            animeData.status = "later"
            animeData.title = titleTF.text!
            
            if resetImgBtn.isEnabled {
                animeData.imgName = now + ".png"
                saveImg(imgName: animeData.imgName)
            }
            
            if startTF.text != "" {
                animeData.startYear = Int((startTF.text?.components(separatedBy: ".")[0])!)!
                animeData.startMonth = Int((startTF.text?.components(separatedBy: ".")[1])!)!
            }
            
            if endTF.text != "" {
                animeData.endYear = Int((endTF.text?.components(separatedBy: ".")[0])!)!
                animeData.endMonth = Int((endTF.text?.components(separatedBy: ".")[1])!)!
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
            
            animeData.registeredTime = now
            
            try! realm.write {
                realm.add(animeData)
            }
            
            WatchLaterViewController.watchLaterCV.reloadData()
            
            let watchLaterVC = self.navigationController?.children[1] as! WatchLaterViewController
            watchLaterVC.dataExistCheck()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
