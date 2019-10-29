//  UsageView.swift

import UIKit

class UsageView: UIView {

    var imgView: UIImageView!
    var explainLabel: UILabel!
    
    func setup(imgName: String, japaneseText: String, englishText: String) {
        self.backgroundColor = .white
        setupImgView(imgName: imgName)
        setupExplainLabel(japaneseText: japaneseText, englishText: englishText)
    }
    
    func setupImgView(imgName: String) {
        imgView = UIImageView()
        
        if (self.frame.height * 9) / 16 < self.frame.width {
            let width = (self.frame.height * 9) / 16
            let height = (self.frame.height * 3) / 4
            
            imgView.frame = CGRect(x: (self.frame.width - width) / 2,
                                   y: 0,
                                   width: width,
                                   height: height)
        } else {
            let width = self.frame.width - 10
            let height = ((self.frame.width - 10) * 4) / 3
            
            imgView.frame = CGRect(x: 5,
                                   y: ((self.frame.height * 3) / 4 - height) / 2,
                                   width: width,
                                   height: height)
        }
        
        imgView.image = UIImage(named: imgName)
        
        self.addSubview(imgView)
    }
    
    func setupExplainLabel(japaneseText: String, englishText: String) {
        explainLabel = UILabel(frame: CGRect(x: 5,
                                             y: (self.frame.height * 3) / 4,
                                             width: self.frame.width - 10,
                                             height: self.frame.height / 4))
        explainLabel.text = japaneseText + "\n\n" + englishText
        explainLabel.textColor = .black
        explainLabel.adjustsFontSizeToFitWidth = true
        explainLabel.textAlignment = .center
        explainLabel.numberOfLines = 0
        explainLabel.lineBreakMode = .byTruncatingTail
        
        self.addSubview(explainLabel)
    }
}
