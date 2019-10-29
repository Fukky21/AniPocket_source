//  WatchLaterSortViewController.swift

import DLRadioButton
import UIKit

class WatchLaterSortViewController: UIViewController {

    var popupView: UIView!
    var sortLabel: UILabel!
    var sortOfAddBtn: DLRadioButton!
    var sortOfTitleBtn: DLRadioButton!
    var sortOfStartBtn: DLRadioButton!
    var sortOfEndBtn: DLRadioButton!
    var sortOfFullEpBtn: DLRadioButton!
    var sortOfGenreBtn: DLRadioButton!
    var cancelBtn: UIButton!
    var okBtn: UIButton!
    var getSortKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.6)
        setupPopupView()
        setupSortLabel()
        setupDLRadioBtns()
        setupCancelBtn()
        setupOkBtn()
    }
    
    func setupPopupView() {
        popupView = UIView(frame: CGRect(x: (view.frame.width - 300) / 2,
                                         y: (view.frame.height - 440) / 2,
                                         width: 300,
                                         height: 440))
        popupView.backgroundColor = Theme.baseColor
        popupView.layer.cornerRadius = 10.0
        
        view.addSubview(popupView)
    }
    
    func setupSortLabel() {
        sortLabel = UILabel(frame: CGRect(x: 10,
                                          y: 20,
                                          width: 130,
                                          height: 40))
        sortLabel.text = Language.sort
        sortLabel.textColor = Theme.baseLetterColor
        sortLabel.font = .boldSystemFont(ofSize: 25)
        sortLabel.textAlignment = .center
        
        popupView.addSubview(sortLabel)
    }
    
    func setupDLRadioBtns() {
        sortOfAddBtn = DLRadioButton(type: .custom)
        sortOfTitleBtn = DLRadioButton(type: .custom)
        sortOfStartBtn = DLRadioButton(type: .custom)
        sortOfEndBtn = DLRadioButton(type: .custom)
        sortOfFullEpBtn = DLRadioButton(type: .custom)
        sortOfGenreBtn = DLRadioButton(type: .custom)
        
        let radioBtns = [sortOfAddBtn, sortOfTitleBtn, sortOfStartBtn, sortOfEndBtn, sortOfFullEpBtn, sortOfGenreBtn]
        let radioBtnTitles = [Language.sortByAdd, Language.sortByTitle, Language.sortByStart, Language.sortByEnd, Language.sortByFullEp, Language.sortByGenre]
        
        let radioBtnWidth: CGFloat = 200
        let radioBtnHeight: CGFloat = 25
        let space: CGFloat = 20
        
        for i in 0 ..< radioBtns.count {
            radioBtns[i]?.frame = CGRect(x: 40,
                                         y: sortLabel.frame.maxY + 25 + (radioBtnHeight + space) * CGFloat(i),
                                         width: radioBtnWidth,
                                         height: radioBtnHeight)
            radioBtns[i]?.setTitle(radioBtnTitles[i], for: .normal)
            radioBtns[i]?.setTitleColor(Theme.baseLetterColor, for: .normal)
            radioBtns[i]?.contentHorizontalAlignment = .left
            radioBtns[i]?.iconSize = 25.0
            radioBtns[i]?.iconColor = Theme.mainColor
            radioBtns[i]?.iconStrokeWidth = 2.0
            radioBtns[i]?.indicatorColor = Theme.mainColor
            radioBtns[i]?.marginWidth = 50.0
        }
        
        sortOfAddBtn.otherButtons = [sortOfTitleBtn, sortOfStartBtn, sortOfEndBtn, sortOfFullEpBtn, sortOfGenreBtn]
        
        switch getSortKey {
            case "add":
                radioBtns[0]?.isSelected = true
            case "title":
                radioBtns[1]?.isSelected = true
            case "start":
                radioBtns[2]?.isSelected = true
            case "end":
                radioBtns[3]?.isSelected = true
            case "fullEp":
                radioBtns[4]?.isSelected = true
            case "genre":
                radioBtns[5]?.isSelected = true
            default:
                break
        }
        
        popupView.addSubview(sortOfAddBtn)
        popupView.addSubview(sortOfTitleBtn)
        popupView.addSubview(sortOfStartBtn)
        popupView.addSubview(sortOfEndBtn)
        popupView.addSubview(sortOfFullEpBtn)
        popupView.addSubview(sortOfGenreBtn)
    }
    
    func setupCancelBtn() {
        cancelBtn = UIButton(type: .system)
        cancelBtn.frame = CGRect(x: 35,
                                 y: popupView.frame.height - 80,
                                 width: 100,
                                 height: 60)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = Theme.tintColor
        cancelBtn.backgroundColor = Theme.mainColor
        cancelBtn.layer.cornerRadius = 10.0
        cancelBtn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        
        popupView.addSubview(cancelBtn)
    }
    
    func setupOkBtn() {
        okBtn = UIButton(type: .system)
        okBtn.frame = CGRect(x: popupView.frame.width - 135,
                             y: popupView.frame.height - 80,
                             width: 100,
                             height: 60)
        okBtn.setTitle("OK", for: .normal)
        okBtn.tintColor = Theme.tintColor
        okBtn.backgroundColor = Theme.mainColor
        okBtn.layer.cornerRadius = 10.0
        okBtn.addTarget(self, action: #selector(okBtnEvent(_:)), for: .touchUpInside)
        
        popupView.addSubview(okBtn)
    }
    
    @objc func cancelBtnEvent(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func okBtnEvent(_ sender: Any) {
        let watchLaterVC = self.presentingViewController?.children[1] as! WatchLaterViewController
        
        if sortOfAddBtn.isSelected {
            watchLaterVC.currentSortKey = "add"
        } else if sortOfTitleBtn.isSelected {
            watchLaterVC.currentSortKey = "title"
        } else if sortOfStartBtn.isSelected {
            watchLaterVC.currentSortKey = "start"
        } else if sortOfEndBtn.isSelected {
            watchLaterVC.currentSortKey = "end"
        } else if sortOfFullEpBtn.isSelected {
            watchLaterVC.currentSortKey = "fullEp"
        } else if sortOfGenreBtn.isSelected {
            watchLaterVC.currentSortKey = "genre"
        }
        
        watchLaterVC.loadLaterAnime()
        
        WatchLaterViewController.watchLaterCV.reloadData()
        
        dismiss(animated: true)
    }
}
