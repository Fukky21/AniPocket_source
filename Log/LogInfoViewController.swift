//  LogInfoViewController.swift

import Material
import UIKit

class LogInfoViewController: UIViewController {

    var popupView: UIView!
    var titleLabel: UILabel!
    var imgView: UIImageView!
    var upperSubLabel: UILabel!
    var middleSubLabel: UILabel!
    var lowerSubLabel: UILabel!
    var editBtn: IconButton!
    var okBtn: UIButton!
    var getAnimeData: SendAnimeData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.6)
        setupPopupView()
        setupTitleLabel()
        setupImgView()
        setupUpperSubLabel()
        setupMiddleSubLabel()
        setupLowerSubLabel()
        setupEditBtn()
        setupOkBtn()
    }
    
    func setupPopupView() {
        popupView = UIView(frame: CGRect(x: (view.frame.width - 300) / 2,
                                         y: (view.frame.height - 470) / 2,
                                         width: 300,
                                         height: 470))
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
    
    func setupImgView() {
        imgView = UIImageView(frame: CGRect(x: (popupView.frame.width - 220) / 2,
                                            y: 70,
                                            width: 220,
                                            height: 220))
        
        if getAnimeData.imgName == "" {
            imgView.image = UIImage(named: "default")
        } else {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filePath = path.appendingPathComponent(getAnimeData.imgName)
            
            let image = UIImage(contentsOfFile: filePath.path)
            imgView.image = image
        }
        
        imgView.backgroundColor = .black
        imgView.contentMode = .scaleAspectFit
        
        popupView.addSubview(imgView)
    }
    
    func setupUpperSubLabel() {
        var start: String
        var end: String
        
        upperSubLabel = UILabel(frame: CGRect(x: (popupView.frame.width - 200) / 2,
                                              y: 300,
                                              width: 200,
                                              height: 20))
        
        if getAnimeData.startYear == 0 {
            start = "----.--"
        } else {
            if getAnimeData.startMonth < 10 {
                start = "\(getAnimeData.startYear).0\(getAnimeData.startMonth)"
            } else {
                start = "\(getAnimeData.startYear).\(getAnimeData.startMonth)"
            }
        }
        
        if getAnimeData.endYear == 0 {
            end = "----.--"
        } else {
            if getAnimeData.endMonth < 10 {
                end = "\(getAnimeData.endYear).0\(getAnimeData.endMonth)"
            } else {
                end = "\(getAnimeData.endYear).\(getAnimeData.endMonth)"
            }
        }
        
        upperSubLabel.text = "\(start)   ~   \(end)"
        upperSubLabel.textColor = Theme.baseLetterColor
        upperSubLabel.font = .systemFont(ofSize: 15)
        upperSubLabel.adjustsFontSizeToFitWidth = true
        upperSubLabel.textAlignment = .center
        
        popupView.addSubview(upperSubLabel)
    }
    
    func setupMiddleSubLabel() {
        middleSubLabel = UILabel(frame: CGRect(x: (popupView.frame.width - 200) / 2,
                                               y: upperSubLabel.frame.maxY + 5,
                                               width: 200,
                                               height: 20))
        
        if getAnimeData.fullEp == 0 {
            middleSubLabel.text = "---"
        } else {
            middleSubLabel.text = Language.writeFullEpText(langName: Language.langName, fullEp: getAnimeData.fullEp)
        }
        
        middleSubLabel.textColor = Theme.baseLetterColor
        middleSubLabel.font = .systemFont(ofSize: 15)
        middleSubLabel.adjustsFontSizeToFitWidth = true
        middleSubLabel.textAlignment = .center
        
        popupView.addSubview(middleSubLabel)
    }
    
    func setupLowerSubLabel() {
        lowerSubLabel = UILabel(frame: CGRect(x: (popupView.frame.width - 200) / 2,
                                              y: middleSubLabel.frame.maxY + 5,
                                              width: 200,
                                              height: 20))
        
        if getAnimeData.genre == 0 {
            lowerSubLabel.text = "---"
        } else {
            lowerSubLabel.text = Language.genreList[getAnimeData.genre - 1]
        }
        
        lowerSubLabel.textColor = Theme.baseLetterColor
        lowerSubLabel.font = .systemFont(ofSize: 15)
        lowerSubLabel.adjustsFontSizeToFitWidth = true
        lowerSubLabel.textAlignment = .center
        
        popupView.addSubview(lowerSubLabel)
    }
    
    func setupEditBtn() {
        editBtn = IconButton(frame: CGRect(x: 20,
                                           y: 390,
                                           width: 60,
                                           height: 60))
        editBtn.image = Icon.pen
        editBtn.tintColor = Theme.tintColor
        editBtn.addTarget(self, action: #selector(editBtnEvent(_:)), for: .touchUpInside)
        
        popupView.addSubview(editBtn)
    }
    
    func setupOkBtn() {
        okBtn = UIButton(type: .system)
        okBtn.frame = CGRect(x: (popupView.frame.width - 100) / 2,
                             y: 390,
                             width: 100,
                             height: 60)
        okBtn.setTitle("OK", for: .normal)
        okBtn.tintColor = Theme.tintColor
        okBtn.backgroundColor = Theme.mainColor
        okBtn.layer.cornerRadius = 10.0
        okBtn.addTarget(self, action: #selector(okBtnEvent(_:)), for: .touchUpInside)
        
        popupView.addSubview(okBtn)
    }
    
    @objc func editBtnEvent(_ sender: IconButton) {
        let logEditVC = LogEditViewController()
        logEditVC.getRegisteredTime = getAnimeData.registeredTime
        logEditVC.modalPresentationStyle = .fullScreen
        
        self.present(logEditVC, animated: true)
    }
    
    @objc func okBtnEvent(_ sender: Any) {
        dismiss(animated: true)
    }
}
