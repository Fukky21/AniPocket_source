//  WatchingPresentCRV.swift

import UIKit

class WatchingPresentCRV: UICollectionReusableView {
    
    var headerLabel: UILabel!
    
    func setupHeader(headerText: String) {
        headerLabel = UILabel(frame: CGRect(x: 20,
                                            y: 0,
                                            width: 50,
                                            height: self.frame.height))
        headerLabel.text = headerText
        headerLabel.textColor = Theme.mainLetterColor
        headerLabel.font = .systemFont(ofSize: 17)
        headerLabel.textAlignment = .center
        headerLabel.backgroundColor = Theme.mainColor
        headerLabel.layer.cornerRadius = 10.0
        headerLabel.layer.masksToBounds = true
        
        addSubview(headerLabel)
    }
}
