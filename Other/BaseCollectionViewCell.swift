//  CVCell.swift

import Material
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var titleLabel: UILabel!
    var upperSubLabel: UILabel!
    var middleSubLabel: UILabel!
    var lowerSubLabel: UILabel!
    var editBtn: IconButton!
    var moveBtn: UIButton!
    var unit: CGFloat!
    
    func determineUnit() {
        unit = contentView.frame.width / 100
    }
    
    func setupImgView(imgName: String?) {
        imgView = UIImageView(frame: CGRect(x: unit * 3,
                                            y: unit * 3,
                                            width: unit * 24,
                                            height: unit * 24))
        
        if imgName == "" {
            imgView.image = UIImage(named: "default")
        } else {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filePath = path.appendingPathComponent(imgName!)
            
            let image = UIImage(contentsOfFile: filePath.path)
            imgView.image = image
        }
        
        imgView.backgroundColor = .black
        imgView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imgView)
    }
    
    func setupTitleLabel(title: String?) {
        titleLabel = UILabel(frame: CGRect(x: unit * 30,
                                           y: unit * 3,
                                           width: unit * 67,
                                           height: unit * 17))
        
        if title == "" {
            titleLabel.text = "---"
        } else {
            titleLabel.text = title!
        }
        
        titleLabel.textColor = Theme.mainLetterColor
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(titleLabel)
    }
    
    func setupUpperSubLabel(text: String) {
        upperSubLabel = UILabel(frame: CGRect(x: unit * 37,
                                              y: unit * 23,
                                              width: unit * 60,
                                              height: unit * 6))
        upperSubLabel.text = text
        upperSubLabel.textColor = Theme.mainLetterColor
        upperSubLabel.font = .systemFont(ofSize: 15)
        upperSubLabel.adjustsFontSizeToFitWidth = true
        upperSubLabel.textAlignment = .center
        
        contentView.addSubview(upperSubLabel)
    }
    
    func setupMiddleSubLabel(text: String) {
        middleSubLabel = UILabel(frame: CGRect(x: unit * 37,
                                               y: unit * 32,
                                               width: unit * 60,
                                               height: unit * 6))
        middleSubLabel.text = text
        middleSubLabel.textColor = Theme.mainLetterColor
        middleSubLabel.font = .systemFont(ofSize: 15)
        middleSubLabel.adjustsFontSizeToFitWidth = true
        middleSubLabel.textAlignment = .center
        
        contentView.addSubview(middleSubLabel)
    }
    
    func setupLowerSubLabel(text: String) {
        lowerSubLabel = UILabel(frame: CGRect(x: unit * 37,
                                              y: unit * 41,
                                              width: unit * 60,
                                              height: unit * 6))
        lowerSubLabel.text = text
        lowerSubLabel.textColor = Theme.mainLetterColor
        lowerSubLabel.font = .systemFont(ofSize: 15)
        lowerSubLabel.adjustsFontSizeToFitWidth = true
        lowerSubLabel.textAlignment = .center
        
        contentView.addSubview(lowerSubLabel)
    }
    
    func setupEditBtn(indexPath: IndexPath) {
        editBtn = IconButton(frame: CGRect(x: unit * 3,
                                           y: unit * 33,
                                           width: unit * 14,
                                           height: unit * 14))
        editBtn.image = Icon.pen
        editBtn.tintColor = Theme.tintColor
        editBtn.accessibilityIdentifier = "\(indexPath)"
        
        contentView.addSubview(editBtn)
    }
    
    func setupMoveBtn(indexPath: IndexPath) {
        moveBtn = UIButton(type: .custom)
        moveBtn.frame = CGRect(x: (self.frame.width * 20) / 100,
                               y: (self.frame.width * 33) / 100,
                               width: (self.frame.width * 14) / 100,
                               height: (self.frame.width * 14) / 100)
        moveBtn.setImage(UIImage(named: "icon_move"), for: .normal)
        moveBtn.tintColor = Theme.tintColor
        moveBtn.accessibilityIdentifier = "\(indexPath)"
        
        contentView.addSubview(moveBtn)
    }
}
