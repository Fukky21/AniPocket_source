// WatchingAddViewController.swift

import CropViewController
import RealmSwift
import TextFieldEffects
import UIKit

class WatchingAddViewController: InputFormBaseViewController {

    var scrollView: UIScrollView!
    var contentView: UIView!
    var statusSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.watchingAddTitle
        view.backgroundColor = Theme.baseColor
        setupYearList()
        setupStartTimeList()
        setupScroll()
        setupStatusSwitch()
        setupImgView(contentView: contentView, minY: statusSwitch.frame.maxY + 20)
        setupResetImgBtn(contentView: contentView)
        setupSetImgBtn(contentView: contentView)
        setupTitleTF(contentView: contentView)
        setupStartTF(contentView: contentView)
        setupEndTF(contentView: contentView)
        setupFullEpTF(contentView: contentView)
        setupDayOfTheWeekTF(contentView: contentView)
        setupStartTimeTF(contentView: contentView)
        setupBroadcasterTF(contentView: contentView)
        setupGenreTF(contentView: contentView)
        setupOkBtn(contentView: contentView)
        setupSelectStartPV()
        setupSelectEndPV()
        setupSelectDayOfTheWeekPV()
        setupSelectStartTimePV()
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
    
    func setupStatusSwitch() {
        statusSwitch = UISegmentedControl(items: Language.watchingViewSwitchItems as [AnyObject])
        statusSwitch.frame = CGRect(x: (contentView.frame.width - 250) / 2,
                                    y: 20,
                                    width: 250,
                                    height: 30)
        
        if #available(iOS 13.0, *) {
            statusSwitch.selectedSegmentTintColor = Theme.mainColor
            statusSwitch.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Theme.mainLetterColor], for: .selected)
        } else {
            // Fallback on earlier versions
            statusSwitch.tintColor = Theme.mainColor
        }
        
        statusSwitch.addTarget(self, action: #selector(tapSegment(_:)), for: .valueChanged)
        statusSwitch.selectedSegmentIndex = 0
        
        contentView.addSubview(statusSwitch)
    }
    
    func ready() {
        resetImgBtn.isEnabled = false
        endTF.isHidden = true
        fullEpTF.isHidden = true
    }
    
    // When the animeData to be added is Watching(Present) anime, "Title" and "DayOfTheWeek" are required.
    // When the animeData to be added is Watching(Past) anime, "Title" is required, and "End date" must be after "Start date".
    func invalidInputCheck() -> Bool {
        if statusSwitch.selectedSegmentIndex == 0 {
            return checkTitleAndDayOfTheWeek(titleTF: titleTF, dayOfTheWeekTF: dayOfTheWeekTF)
        } else {
            if checkTitle(titleTF: titleTF) {
                return checkStartAndEnd(startTF: startTF, endTF: endTF)
            } else {
                return false
            }
        }
    }
    
    @objc func tapSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            endTF.text = ""
            endTF.isHidden = true
            
            fullEpTF.text = ""
            fullEpTF.isHidden = true
            
            dayOfTheWeekTF.isHidden = false
            
            startTimeTF.isHidden = false
            
            broadcasterTF.isHidden = false
        } else {
            endTF.isHidden = false
            
            fullEpTF.isHidden = false
            
            dayOfTheWeekTF.text = ""
            dayOfTheWeekTF.isHidden = true
            
            startTimeTF.text = ""
            startTimeTF.isHidden = true
            
            broadcasterTF.text = ""
            broadcasterTF.isHidden = true
        }
    }
    
    override func okBtnEvent(_ sender: UIButton) {
        if checkCharacterLimit(titleTF: titleTF, fullEpTF: fullEpTF, broadcasterTF: broadcasterTF) && invalidInputCheck() {
            var animeData: AnimeData
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"
            let now = formatter.string(from: NSDate() as Date)
            
            let realm = try! Realm()
            
            if statusSwitch.selectedSegmentIndex == 0 {
                animeData = okBtnEventForPresent(now: now)
            } else {
                animeData = okBtnEventForPast(now: now)
            }
            
            try! realm.write {
                realm.add(animeData)
            }
            
            WatchingPresentView.watchingPresentCV.reloadData()
            WatchingPastView.watchingPastCV.reloadData()
            
            let watchingVC = self.navigationController?.children[1] as! WatchingViewController
            watchingVC.watchingPresentView.dataExistCheck()
            watchingVC.watchingPastView.dataExistCheck()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func okBtnEventForPresent(now: String) -> AnimeData {
        let animeData = AnimeData()
        animeData.status = "present"
        animeData.title = titleTF.text!
        
        if resetImgBtn.isEnabled {
            animeData.imgName = now + ".png"
            saveImg(imgName: animeData.imgName)
        }
        
        if startTF.text != "" {
            animeData.startYear = Int(startTF.text!.components(separatedBy: ".")[0])!
            animeData.startMonth = Int(startTF.text!.components(separatedBy: ".")[1])!
        }
        
        for i in 0 ..< dayOfTheWeekList.count {
            if dayOfTheWeekTF.text! == Language.dayOfTheWeekList[i] {
                animeData.dayOfTheWeek = dayOfTheWeekList[i]
                break
            }
        }
        
        animeData.startTime = startTimeTF.text!
        animeData.broadcaster = broadcasterTF.text!
        
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
        
        return animeData
    }
    
    func okBtnEventForPast(now: String) -> AnimeData {
        let animeData = AnimeData()
        animeData.status = "past"
        animeData.title = titleTF.text!
        
        if resetImgBtn.isEnabled {
            animeData.imgName = now + ".png"
            saveImg(imgName: animeData.imgName)
        }
        
        if startTF.text != "" {
            animeData.startYear = Int(startTF.text!.components(separatedBy: ".")[0])!
            animeData.startMonth = Int(startTF.text!.components(separatedBy: ".")[1])!
        }
        
        if endTF.text != "" {
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
        
        animeData.registeredTime = now
        
        return animeData
    }
}
