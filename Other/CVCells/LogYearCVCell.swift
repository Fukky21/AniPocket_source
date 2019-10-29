//  LogYearCVCell.swift

import UIKit

class LogYearCVCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var titleLabel: UILabel!
    
    func setupCell(imgName: String?, title: String?) {
        setupImgView(imgName: imgName)
        setupTitleLabel(title: title)
    }
    
    func setupImgView(imgName: String?) {
        imgView = UIImageView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: contentView.frame.width,
                                            height: contentView.frame.height))
        
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
        titleLabel = UILabel(frame: CGRect(x: 0,
                                           y: (contentView.frame.height * 4) / 5,
                                           width: contentView.frame.width,
                                           height: contentView.frame.height / 5))
        
        if title == "" {
            titleLabel.text = "---"
        } else {
            titleLabel.text = title
        }
        
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        contentView.addSubview(titleLabel)
    }
}
