//  InputFormViewController.swift

import CropViewController
import RealmSwift
import TextFieldEffects
import UIKit

class InputFormBaseViewController: UIViewController {
    
    var imgView: UIImageView!
    var resetImgBtn: UIButton!
    var setImgBtn: UIButton!
    var titleTF: HoshiTextField!
    var startTF: HoshiTextField!
    var endTF: HoshiTextField!
    var fullEpTF: HoshiTextField!
    var dayOfTheWeekTF: HoshiTextField!
    var startTimeTF: HoshiTextField!
    var broadcasterTF: HoshiTextField!
    var genreTF: HoshiTextField!
    var okBtn: UIButton!
    var selectStartPV: UIPickerView!
    var selectEndPV: UIPickerView!
    var selectDayOfTheWeekPV: UIPickerView!
    var selectStartTimePV: UIPickerView!
    var selectGenrePV: UIPickerView!
    var yearList: [String]!
    let monthList = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var startTimeList: [[String]]!
    
    func setupYearList() {
        var tmp: [String] = []
        let oldestYear = 1970
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        let nowYear = Int(formatter.string(from: NSDate() as Date))!
        
        for i in 0 ... (nowYear - oldestYear) {
            tmp.append("\(nowYear - i)")
        }
        
        yearList = tmp
    }
    
    func setupStartTimeList() {
        var hours: [String] = []
        var minutes: [String] = []
        
        for i in 0 ... 23 {
            if i < 10 {
                hours.append("0\(i)")
            } else {
                hours.append("\(i)")
            }
        }
        
        for i in 0 ... 59 {
            if i < 10 {
                minutes.append("0\(i)")
            } else {
                minutes.append("\(i)")
            }
        }
        
        startTimeList = [hours, minutes]
    }
    
    func setupImgView(contentView: UIView, minY: CGFloat) {
        imgView = UIImageView(frame: CGRect(x: (contentView.frame.width - 270) / 2,
                                            y: minY,
                                            width: 270,
                                            height: 270))
        imgView.image = UIImage(named: "default")
        imgView.backgroundColor = .black
        imgView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imgView)
    }
    
    func setupResetImgBtn(contentView: UIView) {
        resetImgBtn = UIButton(type: .system)
        resetImgBtn.frame = CGRect(x: imgView.frame.minX,
                                   y: imgView.frame.maxY + 10,
                                   width: 70,
                                   height: 60)
        resetImgBtn.setTitle("Reset", for: .normal)
        resetImgBtn.tintColor = Theme.tintColor
        resetImgBtn.backgroundColor = Theme.mainColor
        resetImgBtn.layer.cornerRadius = 10.0
        resetImgBtn.addTarget(self, action: #selector(resetImg(_:)), for: .touchUpInside)
        
        contentView.addSubview(resetImgBtn)
    }
    
    func setupSetImgBtn(contentView: UIView) {
        setImgBtn = UIButton(type: .system)
        setImgBtn.frame = CGRect(x: imgView.frame.maxX - 70,
                                 y: resetImgBtn.frame.minY,
                                 width: 70,
                                 height: 60)
        setImgBtn.setTitle("Set", for: .normal)
        setImgBtn.tintColor = Theme.tintColor
        setImgBtn.backgroundColor = Theme.mainColor
        setImgBtn.layer.cornerRadius = 10.0
        setImgBtn.addTarget(self, action: #selector(setImg(_:)), for: .touchUpInside)
        
        contentView.addSubview(setImgBtn)
    }
    
    func setupTitleTF(contentView: UIView) {
        titleTF = HoshiTextField(frame: CGRect(x: (contentView.frame.width - 270) / 2,
                                               y: resetImgBtn.frame.maxY + 20,
                                               width: 270,
                                               height: 50))
        titleTF.setupHoshiTF(placeholder: Language.title)
        titleTF.delegate = self
        titleTF.returnKeyType = .done
        
        contentView.addSubview(titleTF)
    }
    
    func setupStartTF(contentView: UIView) {
        startTF = HoshiTextField(frame: CGRect(x: imgView.frame.minX,
                                               y: titleTF.frame.maxY + 40,
                                               width: 120,
                                               height: 50))
        startTF.setupHoshiTF(placeholder: Language.start)
        startTF.delegate = self
        startTF.tintColor = .clear
        
        contentView.addSubview(startTF)
    }
    
    func setupEndTF(contentView: UIView) {
        endTF = HoshiTextField(frame: CGRect(x: imgView.frame.maxX - 120,
                                             y: startTF.frame.minY,
                                             width: 120,
                                             height: 50))
        endTF.setupHoshiTF(placeholder: Language.end)
        endTF.delegate = self
        endTF.tintColor = .clear
        
        contentView.addSubview(endTF)
    }
    
    func setupFullEpTF(contentView: UIView) {
        fullEpTF = HoshiTextField(frame: CGRect(x: imgView.frame.minX,
                                                y: startTF.frame.maxY + 85,
                                                width: 120,
                                                height: 50))
        fullEpTF.setupHoshiTF(placeholder: Language.fullEp)
        fullEpTF.delegate = self
        fullEpTF.keyboardType = .numberPad
        
        contentView.addSubview(fullEpTF)
    }
    
    func setupDayOfTheWeekTF(contentView: UIView) {
        dayOfTheWeekTF = HoshiTextField(frame: CGRect(x: imgView.frame.minX,
                                                      y: startTF.frame.maxY + 40,
                                                      width: 120,
                                                      height: 50))
        dayOfTheWeekTF.setupHoshiTF(placeholder: Language.dayOfTheWeek)
        dayOfTheWeekTF.delegate = self
        dayOfTheWeekTF.tintColor = .clear
        
        contentView.addSubview(dayOfTheWeekTF)
    }
    
    func setupStartTimeTF(contentView: UIView) {
        startTimeTF = HoshiTextField(frame: CGRect(x: imgView.frame.maxX - 120,
                                                   y: dayOfTheWeekTF.frame.minY,
                                                   width: 120,
                                                   height: 50))
        startTimeTF.setupHoshiTF(placeholder: Language.startTime)
        startTimeTF.delegate = self
        startTimeTF.tintColor = .clear
        
        contentView.addSubview(startTimeTF)
    }
    
    func setupBroadcasterTF(contentView: UIView) {
        broadcasterTF = HoshiTextField(frame: CGRect(x: imgView.frame.minX,
                                                     y: dayOfTheWeekTF.frame.maxY + 40,
                                                     width: 150,
                                                     height: 50))
        broadcasterTF.setupHoshiTF(placeholder: Language.broadcaster)
        broadcasterTF.delegate = self
        broadcasterTF.returnKeyType = .done
        
        contentView.addSubview(broadcasterTF)
    }
    
    func setupGenreTF(contentView: UIView) {
        genreTF = HoshiTextField(frame: CGRect(x: imgView.frame.minX,
                                               y: startTF.frame.maxY + 220,
                                               width: 250,
                                               height: 50))
        genreTF.setupHoshiTF(placeholder: Language.genre)
        genreTF.delegate = self
        genreTF.tintColor = .clear
        
        contentView.addSubview(genreTF)
    }
    
    func setupOkBtn(contentView: UIView) {
        okBtn = UIButton(type: .system)
        okBtn.frame = CGRect(x: (contentView.frame.width - 100) / 2,
                             y: genreTF.frame.maxY + 50,
                             width: 100,
                             height: 60)
        okBtn.setTitle("OK", for: .normal)
        okBtn.tintColor = Theme.tintColor
        okBtn.backgroundColor = Theme.mainColor
        okBtn.layer.cornerRadius = 10.0
        okBtn.addTarget(self, action: #selector(okBtnEvent(_:)), for: .touchUpInside)
        
        contentView.addSubview(okBtn)
    }
    
    func setupSelectStartPV() {
        selectStartPV = UIPickerView()
        selectStartPV.delegate = self
        selectStartPV.dataSource = self
        selectStartPV.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectStartPVCancelBtnEvent))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectStartPVDoneBtnEvent))
        toolbar.setItems([cancelItem, flexSpaceItem, doneItem], animated: true)
        
        startTF.inputView = selectStartPV
        startTF.inputAccessoryView = toolbar
    }
    
    func setupSelectEndPV() {
        selectEndPV = UIPickerView()
        selectEndPV.delegate = self
        selectEndPV.dataSource = self
        selectEndPV.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectEndPVCancelBtnEvent))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectEndPVDoneBtnEvent))
        toolbar.setItems([cancelItem, flexSpaceItem, doneItem], animated: true)
        
        endTF.inputView = selectEndPV
        endTF.inputAccessoryView = toolbar
    }
    
    func setupSelectDayOfTheWeekPV() {
        selectDayOfTheWeekPV = UIPickerView()
        selectDayOfTheWeekPV.delegate = self
        selectDayOfTheWeekPV.dataSource = self
        selectDayOfTheWeekPV.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectDayOfTheWeekPVCancelBtnEvent))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectDayOfTheWeekPVDoneBtnEvent))
        toolbar.setItems([cancelItem, flexSpaceItem, doneItem], animated: true)
        
        dayOfTheWeekTF.inputView = selectDayOfTheWeekPV
        dayOfTheWeekTF.inputAccessoryView = toolbar
    }
    
    func setupSelectStartTimePV() {
        selectStartTimePV = UIPickerView()
        selectStartTimePV.delegate = self
        selectStartTimePV.dataSource = self
        selectStartTimePV.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectStartTimePVCancelBtnEvent))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectStartTimePVDoneBtnEvent))
        toolbar.setItems([cancelItem, flexSpaceItem, doneItem], animated: true)
        
        startTimeTF.inputView = selectStartTimePV
        startTimeTF.inputAccessoryView = toolbar
    }
    
    func setupSelectGenrePV() {
        selectGenrePV = UIPickerView()
        selectGenrePV.delegate = self
        selectGenrePV.dataSource = self
        selectGenrePV.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectGenrePVCancelBtnEvent))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectGenrePVDoneBtnEvent))
        toolbar.setItems([cancelItem, flexSpaceItem, doneItem], animated: true)
        
        genreTF.inputView = selectGenrePV
        genreTF.inputAccessoryView = toolbar
    }
    
    func checkCharacterLimit(titleTF: HoshiTextField, fullEpTF: HoshiTextField?, broadcasterTF: HoshiTextField?)  -> Bool{
        if titleTF.text!.count > 50 {
            let alert = UIAlertController(title: Language.writeCharacterLimitMessage(langName: Language.langName,
                                                                                     exceedingLimitItem: Language.title,
                                                                                     charLimit: 50),
                                          message: "",
                                          preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            present(alert, animated: true, completion: nil)
            
            return false
        } else if fullEpTF != nil {
            if fullEpTF!.text!.count > 4 {
                let alert = UIAlertController(title: Language.writeCharacterLimitMessage(langName: Language.langName,
                                                                                         exceedingLimitItem: Language.fullEp,
                                                                                         charLimit: 4),
                                              message: "",
                                              preferredStyle: .alert)
                
                let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(okBtn)
                
                present(alert, animated: true, completion: nil)
                
                return false
            }
        } else if broadcasterTF != nil {
            if broadcasterTF!.text!.count > 40 {
                let alert = UIAlertController(title: Language.writeCharacterLimitMessage(langName: Language.langName,
                                                                                         exceedingLimitItem: Language.broadcaster,
                                                                                         charLimit: 40),
                                              message: "",
                                              preferredStyle: .alert)
                
                let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(okBtn)
                
                present(alert, animated: true, completion: nil)
                
                return false
            }
        }
        
        return true
    }
    
    func checkTitleAndDayOfTheWeek(titleTF: HoshiTextField, dayOfTheWeekTF: HoshiTextField) -> Bool {
        if (titleTF.text != "") && (dayOfTheWeekTF.text != "") {
            return true
        } else {
            let alert = UIAlertController(title: Language.writeRequiredMessage2(langName: Language.langName,
                                                                                req1: Language.title,
                                                                                req2: Language.dayOfTheWeek),
                                          message: "",
                                          preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    func checkTitleAndStart(titleTF: HoshiTextField, startTF: HoshiTextField) -> Bool {
        if (titleTF.text != "") && (startTF.text != "") {
            return true
        } else {
            let alert = UIAlertController(title: Language.writeRequiredMessage2(langName: Language.langName,
                                                                                req1: Language.title,
                                                                                req2: Language.start),
                                          message: "",
                                          preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    func checkStartAndEnd(startTF: HoshiTextField, endTF: HoshiTextField) -> Bool {
        if (startTF.text != "") && (endTF.text != "") {
            if startTF.text! <= endTF.text! {
                return true
            } else {
                let alert = UIAlertController(title: Language.writeInvalidMessage(langName: Language.langName),
                                              message: "",
                                              preferredStyle: .alert)
                
                let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(okBtn)
                
                present(alert, animated: true, completion: nil)
                
                return false
            }
        } else {
            return true
        }
    }
    
    func checkTitle(titleTF: HoshiTextField) -> Bool {
        if titleTF.text != "" {
            return true
        } else {
            let alert = UIAlertController(title: Language.writeRequiredMessage(langName: Language.langName,
                                                                               req: Language.title),
                                          message: "",
                                          preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    func readyImg(imgName: String) {
        if imgName == "" {
            resetImgBtn.isEnabled = false
        } else {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filePath = path.appendingPathComponent(imgName)
            
            let image = UIImage(contentsOfFile: filePath.path)
            imgView.image = image
        }
    }
    
    func readyStart(startYear: Int, startMonth: Int) {
        if startYear != 0 {
            if startMonth < 10 {
                startTF.text = "\(startYear).0\(startMonth)"
            } else {
                startTF.text = "\(startYear).\(startMonth)"
            }
            
            for i in 0 ..< yearList.count {
                if startYear == Int(yearList[i]) {
                    selectStartPV.selectRow(i, inComponent: 0, animated: false)
                    break
                }
            }
            
            selectStartPV.selectRow(startMonth - 1, inComponent: 1, animated: false)
        }
    }
    
    func readyEnd(endYear: Int, endMonth: Int) {
        if endYear != 0 {
            if endMonth < 10 {
                endTF.text = "\(endYear).0\(endMonth)"
            } else {
                endTF.text = "\(endYear).\(endMonth)"
            }
            
            for i in 0 ..< yearList.count {
                if endYear == Int(yearList[i]) {
                    selectEndPV.selectRow(i, inComponent: 0, animated: false)
                    break
                }
            }
            
            selectEndPV.selectRow(endMonth - 1, inComponent: 1, animated: false)
        }
    }
    
    func readyDayOfTheWeek(dayOfTheWeek: String) {
        for i in 0 ..< dayOfTheWeekList.count {
            if dayOfTheWeek == dayOfTheWeekList[i] {
                dayOfTheWeekTF.text = Language.dayOfTheWeekList[i]
            }
        }
        
        for i in 0 ..< dayOfTheWeekList.count {
            if dayOfTheWeek == dayOfTheWeekList[i] {
                selectDayOfTheWeekPV.selectRow(i, inComponent: 0, animated: false)
            }
        }
    }
    
    func readyStartTime(startTime: String) {
        if startTime != "" {
            startTimeTF.text = startTime
            
            for i in 0 ..< startTimeList[0].count {
                if startTime.components(separatedBy: ":")[0] == startTimeList[0][i] {
                    selectStartTimePV.selectRow(i, inComponent: 0, animated: false)
                }
            }
            
            for i in 0 ..< startTimeList[1].count {
                if startTime.components(separatedBy: ":")[1] == startTimeList[1][i] {
                    selectStartTimePV.selectRow(i, inComponent: 1, animated: false)
                }
            }
        }
    }
    
    func readyGenre(genre: Int) {
        if genre != 0 {
            genreTF.text = Language.genreList[genre - 1]
            
            for i in 0 ..< Language.genreList.count {
                if genre == i + 1 {
                    selectGenrePV.selectRow(i, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    func saveImg(imgName: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = path.appendingPathComponent(imgName)
        let pngImgData = (imgView.image)!.pngData()
        
        do {
            try pngImgData?.write(to: filePath)
        } catch {
            print("Can't save image!")
        }
    }
    
    func removeImg(imgName: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = path.appendingPathComponent(imgName)
        
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print("Can't remove image!")
        }
    }
    
    func renameImg(currentImgName: String, newImgName: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let currentFilePath = path.appendingPathComponent(currentImgName)
        let newFilePath = path.appendingPathComponent(newImgName)
        
        do {
            try FileManager.default.moveItem(atPath: currentFilePath.path, toPath: newFilePath.path)
        } catch {
            print("Can't rename image!")
        }
    }
    
    @objc func okBtnEvent(_ sender: UIButton) {}
}

extension InputFormBaseViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let cropVC = CropViewController(image: img)
        cropVC.delegate = self
        
        picker.dismiss(animated: true, completion: {
            cropVC.modalPresentationStyle = .fullScreen
            
            self.present(cropVC, animated: true, completion: nil)
        })
    }
    
    @objc func setImg(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            
            self.present(pickerView, animated: true)
        }
    }
    
    @objc func resetImg(_ sender: UIButton) {
        let alert = UIAlertController(title: Language.resetImgAlertTitle, message: "", preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            self.imgView.image = UIImage(named: "default")
            self.resetImgBtn.isEnabled = false
        })
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        present(alert, animated: true, completion: nil)
    }
}

extension InputFormBaseViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        imgView.image = image
        
        cropViewController.dismiss(animated: true)
        
        resetImgBtn.isEnabled = true
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
    }
}

extension InputFormBaseViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension InputFormBaseViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
            case selectStartPV:
                return 2
            case selectEndPV:
                return 2
            case selectStartTimePV:
                return 2
            default:
                return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case selectStartPV:
                return [yearList, monthList][component].count
            case selectEndPV:
                return [yearList, monthList][component].count
            case selectDayOfTheWeekPV:
                return Language.dayOfTheWeekList.count
            case selectStartTimePV:
                return startTimeList[component].count
            default:
                return Language.genreList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case selectStartPV:
                return [yearList, monthList][component][row]
            case selectEndPV:
                return [yearList, monthList][component][row]
            case selectDayOfTheWeekPV:
                return Language.dayOfTheWeekList[row]
            case selectStartTimePV:
                return startTimeList[component][row]
            default:
                return Language.genreList[row]
        }
    }
    
    @objc func selectStartPVCancelBtnEvent() {
        startTF.text = ""
        startTF.endEditing(true)
        
        selectStartPV.selectRow(0, inComponent: 0, animated: false)
        selectStartPV.selectRow(0, inComponent: 1, animated: false)
    }
    
    @objc func selectStartPVDoneBtnEvent() {
        startTF.text = "\(yearList[selectStartPV.selectedRow(inComponent: 0)]).\(monthList[selectStartPV.selectedRow(inComponent: 1)])"
        startTF.endEditing(true)
        
        selectStartPV.selectRow(selectStartPV.selectedRow(inComponent: 0), inComponent: 0, animated: false)
        selectStartPV.selectRow(selectStartPV.selectedRow(inComponent: 1), inComponent: 1, animated: false)
    }
    
    @objc func selectEndPVCancelBtnEvent() {
        endTF.text = ""
        endTF.endEditing(true)
        
        selectEndPV.selectRow(0, inComponent: 0, animated: false)
        selectEndPV.selectRow(0, inComponent: 1, animated: false)
    }
    
    @objc func selectEndPVDoneBtnEvent() {
        endTF.text = "\(yearList[selectEndPV.selectedRow(inComponent: 0)]).\(monthList[selectEndPV.selectedRow(inComponent: 1)])"
        endTF.endEditing(true)
        
        selectEndPV.selectRow(selectEndPV.selectedRow(inComponent: 0), inComponent: 0, animated: false)
        selectEndPV.selectRow(selectEndPV.selectedRow(inComponent: 1), inComponent: 1, animated: false)
    }
    
    @objc func selectDayOfTheWeekPVCancelBtnEvent() {
        dayOfTheWeekTF.text = ""
        dayOfTheWeekTF.endEditing(true)
        
        selectDayOfTheWeekPV.selectRow(0, inComponent: 0, animated: false)
    }
    
    @objc func selectDayOfTheWeekPVDoneBtnEvent() {
        dayOfTheWeekTF.text = Language.dayOfTheWeekList[selectDayOfTheWeekPV.selectedRow(inComponent: 0)]
        dayOfTheWeekTF.endEditing(true)
        
        selectDayOfTheWeekPV.selectRow(selectDayOfTheWeekPV.selectedRow(inComponent: 0), inComponent: 0, animated: false)
    }
    
    @objc func selectStartTimePVCancelBtnEvent() {
        startTimeTF.text = ""
        startTimeTF.endEditing(true)
        
        selectStartTimePV.selectRow(0, inComponent: 0, animated: false)
        selectStartTimePV.selectRow(0, inComponent: 1, animated: false)
    }
    
    @objc func selectStartTimePVDoneBtnEvent() {
        startTimeTF.text = "\(startTimeList[0][selectStartTimePV.selectedRow(inComponent: 0)]):\(startTimeList[1][selectStartTimePV.selectedRow(inComponent: 1)])"
        startTimeTF.endEditing(true)
        
        selectStartTimePV.selectRow(selectStartTimePV.selectedRow(inComponent: 0), inComponent: 0, animated: false)
        selectStartTimePV.selectRow(selectStartTimePV.selectedRow(inComponent: 1), inComponent: 1, animated: false)
    }
    
    @objc func selectGenrePVCancelBtnEvent() {
        genreTF.text = ""
        genreTF.endEditing(true)
        
        selectGenrePV.selectRow(0, inComponent: 0, animated: false)
    }
    
    @objc func selectGenrePVDoneBtnEvent() {
        genreTF.text = Language.genreList[selectGenrePV.selectedRow(inComponent: 0)]
        genreTF.endEditing(true)
        
        selectGenrePV.selectRow(selectGenrePV.selectedRow(inComponent: 0), inComponent: 0, animated: false)
    }
}
