//  WatchingPastInfoViewController.swift

import Material
import MBCircularProgressBar
import RealmSwift
import UIKit

class WatchingPastInfoViewController: UIViewController {

    var popupView: UIView!
    var titleLabel: UILabel!
    var MBCPBView: MBCircularProgressBarView!
    var nowEpLabel: UILabel!
    var fullEpLabel: UILabel!
    var minusBtn: FABButton!
    var plusBtn: FABButton!
    var okBtn: UIButton!
    var getAnimeData: SendAnimeData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.6)
        setupPopupView()
        setupTitleLabel()
        setupMBCPBView()
        setupNowEpLabel()
        setupFullEpLabel()
        setupMinusBtn()
        setupPlusBtn()
        setupOkBtn()
    }
    
    func setupPopupView() {
        popupView = UIView(frame: CGRect(x: (view.frame.width - 300) / 2,
                                         y: (view.frame.height - 400) / 2,
                                         width: 300,
                                         height: 400))
        popupView.backgroundColor = Theme.baseColor
        popupView.layer.cornerRadius = 10.0
        
        view.addSubview(popupView)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: (popupView.frame.width - 250) / 2,
                                           y: 20,
                                           width: 250,
                                           height: 45))
        titleLabel.text = getAnimeData.title
        titleLabel.textColor = Theme.baseLetterColor
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        
        popupView.addSubview(titleLabel)
    }
    
    func setupMBCPBView() {
        MBCPBView = MBCircularProgressBarView(frame: CGRect(x: (popupView.frame.width - 200) / 2,
                                                            y: titleLabel.frame.maxY + 10,
                                                            width: 200,
                                                            height: 200))
        MBCPBView.showValueString = false
        MBCPBView.value = 0
        MBCPBView.maxValue = CGFloat(getAnimeData.fullEp)
        MBCPBView.progressRotationAngle = 0
        MBCPBView.progressAngle = 100
        MBCPBView.progressLineWidth = 5
        MBCPBView.progressColor = Theme.accentColor
        MBCPBView.progressStrokeColor = Theme.accentColor
        MBCPBView.emptyLineColor = Theme.baseLetterColor
        MBCPBView.backgroundColor = Theme.baseColor
        
        popupView.addSubview(MBCPBView)
    }
    
    func setupNowEpLabel() {
        nowEpLabel = UILabel(frame: CGRect(x: (MBCPBView.frame.width - 45) / 2,
                                           y: (MBCPBView.frame.height - 25) / 2,
                                           width: 45,
                                           height: 25))
        nowEpLabel.text = "\(Int(MBCPBView.value))"
        nowEpLabel.textColor = Theme.baseLetterColor
        nowEpLabel.font = .systemFont(ofSize: 17)
        nowEpLabel.textAlignment = .center
        
        MBCPBView.addSubview(nowEpLabel)
    }
    
    func setupFullEpLabel() {
        fullEpLabel = UILabel(frame: CGRect(x: (MBCPBView.frame.width - 40) / 2,
                                            y: nowEpLabel.frame.maxX + 20,
                                            width: 40,
                                            height: 20))
        fullEpLabel.text = "/ " + "\(Int(MBCPBView.maxValue))"
        fullEpLabel.textColor = Theme.baseLetterColor
        fullEpLabel.font = .systemFont(ofSize: 15)
        fullEpLabel.textAlignment = .center
        
        MBCPBView.addSubview(fullEpLabel)
    }
    
    func setupMinusBtn() {
        minusBtn = FABButton(type: .custom)
        minusBtn.frame = CGRect(x: 25,
                                y: titleLabel.frame.maxY + 185,
                                width: 60,
                                height: 60)
        minusBtn.setImage(UIImage(named: "icon_minus"), for: .normal)
        minusBtn.tintColor = Theme.tintColor
        minusBtn.backgroundColor = Theme.mainColor
        minusBtn.addTarget(self, action: #selector(minusBtnEvent(_:)), for: .touchUpInside)
        
        if getAnimeData.nowEp == 0 {
            minusBtn.isEnabled = false
        }
        
        popupView.addSubview(minusBtn)
    }
    
    func setupPlusBtn() {
        plusBtn = FABButton(type: .custom)
        plusBtn.frame = CGRect(x: 215,
                               y: minusBtn.frame.minY,
                               width: 60,
                               height: 60)
        plusBtn.setImage(UIImage(named: "icon_plus"), for: .normal)
        plusBtn.tintColor = Theme.tintColor
        plusBtn.backgroundColor = Theme.mainColor
        plusBtn.addTarget(self, action: #selector(plusBtnEvent(_:)), for: .touchUpInside)
        
        if getAnimeData.nowEp == getAnimeData.fullEp {
            plusBtn.isEnabled = false
        }
        
        popupView.addSubview(plusBtn)
    }
    
    func setupOkBtn() {
        okBtn = UIButton(type: .system)
        okBtn.frame = CGRect(x: (popupView.frame.width - 100) / 2,
                             y: 320,
                             width: 100,
                             height: 60)
        okBtn.setTitle("OK", for: .normal)
        okBtn.tintColor = Theme.tintColor
        okBtn.backgroundColor = Theme.mainColor
        okBtn.layer.cornerRadius = 10.0
        okBtn.addTarget(self, action: #selector(okBtnEvent(_:)), for: .touchUpInside)
        
        popupView.addSubview(okBtn)
    }
    
    func checkPlusMinusBtnIsEnable() {
        switch Int(MBCPBView.value) {
            case 0:
                minusBtn.isEnabled = false
            case Int(MBCPBView.maxValue):
                plusBtn.isEnabled = false
            default:
                plusBtn.isEnabled = true
                minusBtn.isEnabled = true
        }
    }
    
    @objc func minusBtnEvent(_ sender: Any) {
        let tmpValue = MBCPBView.value
        MBCPBView.value = tmpValue - 1
        nowEpLabel.text = "\(Int(MBCPBView.value))"
        
        checkPlusMinusBtnIsEnable()
    }
    
    @objc func plusBtnEvent(_ sender: Any) {
        let tmpValue = MBCPBView.value
        MBCPBView.value = tmpValue + 1
        nowEpLabel.text = "\(Int(MBCPBView.value))"
        
        checkPlusMinusBtnIsEnable()
    }
    
    @objc func okBtnEvent(_ sender: Any) {
        let realm = try! Realm()
        
        let animeData = realm.objects(AnimeData.self).filter("registeredTime == %@", getAnimeData.registeredTime).first
        
        try! realm.write() {
            animeData?.nowEp = Int(MBCPBView.value)
        }
        
        WatchingPastView.watchingPastCV.reloadData()
        
        dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.MBCPBView.value = CGFloat(self.getAnimeData.nowEp)
            self.nowEpLabel.text = "\(Int(self.MBCPBView.value))"
        }
    }
}
